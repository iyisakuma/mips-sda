LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY control_unit IS
  PORT (
    opcode    : IN  std_logic_vector(5 downto 0);
    funct     : IN  std_logic_vector(5 downto 0);
	 jump      : OUT std_logic;	
    RegDst    : OUT std_logic;
    RegWrite  : OUT std_logic;
    ALUSrc    : OUT std_logic;
    MemWrite  : OUT std_logic;
    MemToReg  : OUT std_logic;
    ALUCtrl   : OUT std_logic_vector(2 downto 0)
  );
END control_unit;

ARCHITECTURE beh OF control_unit IS
BEGIN
  PROCESS(opcode, funct)
  BEGIN
    -- defaults
    RegDst   <= '0';
    RegWrite <= '0';
    ALUSrc   <= '0';
    MemWrite <= '0';
    MemToReg <= '0';
	 jump     <= '0';
    ALUCtrl  <= "000";

    CASE opcode IS

      WHEN "000000" =>  -- Tipo R
        RegDst   <= '1';
        RegWrite <= '1';
        CASE funct IS
          WHEN "100000" => ALUCtrl <= "010"; -- ADD
          WHEN "100010" => ALUCtrl <= "011"; -- SUB
          WHEN OTHERS   => ALUCtrl <= "000";
        END CASE;

      WHEN "100011" =>  -- LW
        RegWrite <= '1';
        ALUSrc   <= '1';
        MemToReg <= '1';
        ALUCtrl  <= "010";

      WHEN "101011" =>  -- SW
        ALUSrc   <= '1';
        MemWrite <= '1';
        ALUCtrl  <= "010";

		WHEN "000010" => jump <= '1';
			
      WHEN OTHERS =>
        NULL;

    END CASE;
  END PROCESS;
END beh;
