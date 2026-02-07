library IEEE;
  use IEEE.std_logic_1164.all;
  use IEEE.numeric_std.all;

entity datapath is
  port (
    clock, reset                                   : in  std_logic;

    -- sinais de controle
    RegDst, RegWrite, ALUSrc                       : in  std_logic;
    MemWrite, MemToReg                             : in  std_logic;
    ALUCtrl                                        : in  std_logic_vector(2 downto 0);
    Jump                                           : in  std_logic;
    Branch                                         : in  std_logic;
    BranchNE                                       : in  std_logic;
    PC_jump                                        : in  std_logic_vector(9 downto 0);
    -- instrução (para PC)
    instruction_out                                : out std_logic_vector(31 downto 0);
    -- portas de debug
    reg1_debug, reg2_debug, reg3_debug, reg4_debug : out std_logic_vector(31 downto 0);
    reg5_debug, reg6_debug, reg7_debug, reg8_debug : out std_logic_vector(31 downto 0);
    mem0_debug, mem1_debug, mem2_debug, mem3_debug : out std_logic_vector(31 downto 0)
  );
end entity;

architecture arc of datapath is

  component arithmetic_logic_unit
    port (
      sel  : in  std_logic_vector(2 downto 0);
      A, B : in  std_logic_vector(31 downto 0);
      F    : out std_logic_vector(31 downto 0);
      Zero : out std_logic
    );
  end component;

  component register_file
    port (
      load_enable, clock, reset                      : in  std_logic;
      data                                           : in  std_logic_vector(31 downto 0);
      destination_select                             : in  std_logic_vector(4 downto 0);
      A_select, B_select                             : in  std_logic_vector(4 downto 0);
      A_data, B_data                                 : out std_logic_vector(31 downto 0);
      reg1_debug, reg2_debug, reg3_debug, reg4_debug : out std_logic_vector(31 downto 0);
      reg5_debug, reg6_debug, reg7_debug, reg8_debug : out std_logic_vector(31 downto 0)
    );
  end component;

  component instructions_memory
    port (
      clock         : in  std_logic;
      write_enable  : in  std_logic;
      write_address : in  std_logic_vector(9 downto 0);
      read_address  : in  std_logic_vector(9 downto 0);
      data_in       : in  std_logic_vector(31 downto 0);
      data_out      : out std_logic_vector(31 downto 0)
    );
  end component;

  component data_memory
    port (
      clock                                          : in  std_logic;
      write_enable                                   : in  std_logic;
      write_address                                  : in  std_logic_vector(9 downto 0);
      read_address                                   : in  std_logic_vector(9 downto 0);
      data_in                                        : in  std_logic_vector(31 downto 0);
      data_out                                       : out std_logic_vector(31 downto 0);
      mem0_debug, mem1_debug, mem2_debug, mem3_debug : out std_logic_vector(31 downto 0)
    );
  end component;

  component mux2_1
    generic (N : INTEGER := 32);
    port (
      sel     : in  std_logic;
      X0, X1  : in  std_logic_vector(N - 1 downto 0);
      out_mux : out std_logic_vector(N - 1 downto 0)
    );
  end component;

  -- sinais internos
  signal PC             : std_logic_vector(9 downto 0) := (others => '0');
  signal PC_plus1       : std_logic_vector(9 downto 0);
  signal branch_target  : std_logic_vector(9 downto 0);
  signal PCSrc          : std_logic;
  signal ALU_Zero       : std_logic;
  signal instr          : std_logic_vector(31 downto 0);
  signal regA, regB     : std_logic_vector(31 downto 0);
  signal aluB, aluOut   : std_logic_vector(31 downto 0);
  signal memOut, wbData : std_logic_vector(31 downto 0);
  signal destReg        : std_logic_vector(4 downto 0);
  signal imm_ext        : std_logic_vector(31 downto 0);

begin

  -- Next PC computation
  PC_plus1      <= std_logic_vector(unsigned(PC) + 1);
  branch_target <= std_logic_vector(unsigned(PC_plus1) + unsigned(imm_ext(9 downto 0)));
  PCSrc         <= (Branch and ALU_Zero) or (BranchNE and (not ALU_Zero));

  -- PC register
  process (clock, reset)
  begin
    if reset = '1' then
      PC <= (others => '0');
    elsif rising_edge(clock) then
      if Jump = '1' then
        PC <= PC_jump;
      elsif PCSrc = '1' then
        PC <= branch_target;
      else
        PC <= PC_plus1;
      end if;
    end if;
  end process;

  -- Instruction memory
  imem: instructions_memory
    port map (
      clock         => clock,
      write_enable  => '0',
      write_address => (others => '0'),
      read_address  => PC,
      data_in       => (others => '0'),
      data_out      => instr
    );

  instruction_out <= instr;

  -- Sign extend imediato
  imm_ext <= (31 downto 16 => instr(15)) & instr(15 downto 0);

  -- RegDst MUX
  mux_rd: mux2_1
    generic map (N => 5)
    port map (
      sel     => RegDst,
      X0      => instr(20 downto 16),
      X1      => instr(15 downto 11),
      out_mux => destReg
    );

  -- Register File
  regs: register_file
    port map (
      load_enable        => RegWrite,
      clock              => clock,
      reset              => reset,
      data               => wbData,
      destination_select => destReg,
      A_select           => instr(25 downto 21),
      B_select           => instr(20 downto 16),
      A_data             => regA,
      B_data             => regB,
      reg1_debug         => reg1_debug,
      reg2_debug         => reg2_debug,
      reg3_debug         => reg3_debug,
      reg4_debug         => reg4_debug,
      reg5_debug         => reg5_debug,
      reg6_debug         => reg6_debug,
      reg7_debug         => reg7_debug,
      reg8_debug         => reg8_debug
    );

  -- ALUSrc MUX
  mux_alu: mux2_1
    port map (
      sel     => ALUSrc,
      X0      => regB,
      X1      => imm_ext,
      out_mux => aluB
    );

  -- ALU
  alu: arithmetic_logic_unit
    port map (
      sel  => ALUCtrl,
      A    => regA,
      B    => aluB,
      F    => aluOut,
      Zero => ALU_Zero
    );

  -- Data memory
  dmem: data_memory
    port map (
      clock         => clock,
      write_enable  => MemWrite,
      write_address => aluOut(9 downto 0),
      read_address  => aluOut(9 downto 0),
      data_in       => regB,
      data_out      => memOut,
      mem0_debug    => mem0_debug,
      mem1_debug    => mem1_debug,
      mem2_debug    => mem2_debug,
      mem3_debug    => mem3_debug
    );

  -- MemToReg MUX
  mux_wb: mux2_1
    port map (
      sel     => MemToReg,
      X0      => aluOut,
      X1      => memOut,
      out_mux => wbData
    );

end architecture;
