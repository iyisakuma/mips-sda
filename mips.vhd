ENTITY mips IS
  PORT (
    clock, reset : IN std_logic;
    instr_debug  : OUT std_logic_vector(31 downto 0)
  );
END mips;

ARCHITECTURE structural OF mips IS

  SIGNAL instr   : std_logic_vector(31 downto 0);
  SIGNAL RegDst, RegWrite, ALUSrc, jump : std_logic;
  SIGNAL MemWrite, MemToReg      : std_logic;
  SIGNAL ALUCtrl                 : std_logic_vector(2 downto 0);

BEGIN

  PO: entity datapath
    PORT MAP (
      clock => clock,
      reset => reset,
      RegDst => RegDst,
		jump => jump,
		PC_jump <= instr(9 downto 0),
      RegWrite => RegWrite,
      ALUSrc => ALUSrc,
      MemWrite => MemWrite,
      MemToReg => MemToReg,
      ALUCtrl => ALUCtrl,
      instruction_out => instr
    );

  PCU: entity control_unit
    PORT MAP (
      opcode => instr(31 downto 26),
      funct  => instr(5 downto 0),
      RegDst => RegDst,
      RegWrite => RegWrite,
      ALUSrc => ALUSrc,
      MemWrite => MemWrite,
      MemToReg => MemToReg,
      ALUCtrl => ALUCtrl,
		jump => jump,
    );

  instr_debug <= instr;

END structural;
