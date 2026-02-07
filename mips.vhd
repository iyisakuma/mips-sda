library IEEE;
  use IEEE.std_logic_1164.all;

entity mips is
  port (
    clock, reset : in  std_logic;
    instr_debug  : out std_logic_vector(31 downto 0);
    -- Portas de debug para visualizar registradores
    reg1_debug   : out std_logic_vector(31 downto 0);
    reg2_debug   : out std_logic_vector(31 downto 0);
    reg3_debug   : out std_logic_vector(31 downto 0);
    reg4_debug   : out std_logic_vector(31 downto 0);
    reg5_debug   : out std_logic_vector(31 downto 0);
    reg6_debug   : out std_logic_vector(31 downto 0);
    reg7_debug   : out std_logic_vector(31 downto 0);
    reg8_debug   : out std_logic_vector(31 downto 0);
    -- Portas de debug para visualizar memória de dados
    mem0_debug   : out std_logic_vector(31 downto 0);
    mem1_debug   : out std_logic_vector(31 downto 0);
    mem2_debug   : out std_logic_vector(31 downto 0);
    mem3_debug   : out std_logic_vector(31 downto 0)
  );
end entity;

architecture structural of mips is

  component datapath
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
  end component;

  signal instr                          : std_logic_vector(31 downto 0);
  signal RegDst, RegWrite, ALUSrc, jump : std_logic;
  signal MemWrite, MemToReg             : std_logic;
  signal Branch, BranchNE               : std_logic;
  signal ALUCtrl                        : std_logic_vector(2 downto 0);
  signal PC_jump                        : STD_logic_vector(9 downto 0);
  -- sinais de debug
  signal reg1_sig, reg2_sig, reg3_sig, reg4_sig : std_logic_vector(31 downto 0);
  signal reg5_sig, reg6_sig, reg7_sig, reg8_sig : std_logic_vector(31 downto 0);
  signal mem0_sig, mem1_sig, mem2_sig, mem3_sig : std_logic_vector(31 downto 0);

begin

  PO: datapath
    port map (
      clock           => clock,
      reset           => reset,
      RegDst          => RegDst,
      jump            => jump,
      Branch          => Branch,
      BranchNE        => BranchNE,
      PC_jump         => instr(9 downto 0),
      RegWrite        => RegWrite,
      ALUSrc          => ALUSrc,
      MemWrite        => MemWrite,
      MemToReg        => MemToReg,
      ALUCtrl         => ALUCtrl,
      instruction_out => instr,
      reg1_debug      => reg1_sig,
      reg2_debug      => reg2_sig,
      reg3_debug      => reg3_sig,
      reg4_debug      => reg4_sig,
      reg5_debug      => reg5_sig,
      reg6_debug      => reg6_sig,
      reg7_debug      => reg7_sig,
      reg8_debug      => reg8_sig,
      mem0_debug      => mem0_sig,
      mem1_debug      => mem1_sig,
      mem2_debug      => mem2_sig,
      mem3_debug      => mem3_sig
    );

  PCU: entity work.control_unit
    port map (
      opcode   => instr(31 downto 26),
      funct    => instr(5 downto 0),
      RegDst   => RegDst,
      RegWrite => RegWrite,
      ALUSrc   => ALUSrc,
      MemWrite => MemWrite,
      MemToReg => MemToReg,
      Branch   => Branch,
      BranchNE => BranchNE,
      ALUCtrl  => ALUCtrl,
      jump     => jump
    );

  instr_debug <= instr;

  -- Conectar sinais de debug às portas de saída
  reg1_debug <= reg1_sig;
  reg2_debug <= reg2_sig;
  reg3_debug <= reg3_sig;
  reg4_debug <= reg4_sig;
  reg5_debug <= reg5_sig;
  reg6_debug <= reg6_sig;
  reg7_debug <= reg7_sig;
  reg8_debug <= reg8_sig;
  mem0_debug <= mem0_sig;
  mem1_debug <= mem1_sig;
  mem2_debug <= mem2_sig;
  mem3_debug <= mem3_sig;

end architecture;
