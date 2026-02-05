LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY mips IS
  PORT (
    clock, reset : IN std_logic;
    instr_debug  : OUT std_logic_vector(31 downto 0)
  );
END mips;

ARCHITECTURE structural OF mips IS

	component datapath 
	  PORT (
		 clock, reset : IN std_logic;

		 -- sinais de controle
		 RegDst, RegWrite, ALUSrc : IN std_logic;
		 MemWrite, MemToReg      : IN std_logic;
		 ALUCtrl                 : IN std_logic_vector(2 downto 0);
		 Jump                    : IN std_logic;
		 PC_jump                 : IN std_logic_vector(9 downto 0);
		 -- instrução (para PC)
		 instruction_out         : OUT std_logic_vector(31 downto 0)
	  );
	END component;

  SIGNAL instr   : std_logic_vector(31 downto 0);
  SIGNAL RegDst, RegWrite, ALUSrc, jump : std_logic;
  SIGNAL MemWrite, MemToReg      : std_logic;
  SIGNAL ALUCtrl                 : std_logic_vector(2 downto 0);
  SIGNAL PC_jump                : STD_logic_vector(9 downto 0);

BEGIN

  PO: datapath
    PORT MAP (
      clock => clock,
      reset => reset,
      RegDst => RegDst,
		jump => jump,
		PC_jump => instr(9 downto 0),
      RegWrite => RegWrite,
      ALUSrc => ALUSrc,
      MemWrite => MemWrite,
      MemToReg => MemToReg,
      ALUCtrl => ALUCtrl,
      instruction_out => instr
    );

  PCU: entity work.control_unit
    PORT MAP (
      opcode => instr(31 downto 26),
      funct  => instr(5 downto 0),
      RegDst => RegDst,
      RegWrite => RegWrite,
      ALUSrc => ALUSrc,
      MemWrite => MemWrite,
      MemToReg => MemToReg,
      ALUCtrl => ALUCtrl,
		jump => jump
    );

  instr_debug <= instr;

END structural;
