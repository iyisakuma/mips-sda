library IEEE;
  use IEEE.std_logic_1164.all;

entity control_unit is
  port (
    opcode   : in  std_logic_vector(5 downto 0);
    funct    : in  std_logic_vector(5 downto 0);
    jump     : out std_logic;
    RegDst   : out std_logic;
    RegWrite : out std_logic;
    ALUSrc   : out std_logic;
    MemWrite : out std_logic;
    MemToReg : out std_logic;
    Branch   : out std_logic;
    BranchNE : out std_logic;
    ALUCtrl  : out std_logic_vector(2 downto 0)
  );
end entity;

architecture beh of control_unit is
begin
  process (opcode, funct)
  begin
    -- defaults
    RegDst <= '0';
    RegWrite <= '0';
    ALUSrc <= '0';
    MemWrite <= '0';
    MemToReg <= '0';
    jump <= '0';
    Branch <= '0';
    BranchNE <= '0';
    ALUCtrl <= "000";

    case opcode is

      when "000000" => -- Tipo R
        RegDst <= '1';
        RegWrite <= '1';
        case funct is
          when "100000" => ALUCtrl <= "010"; -- ADD
          when "100010" => ALUCtrl <= "011"; -- SUB
          when "100100" => ALUCtrl <= "100"; -- AND
          when "100101" => ALUCtrl <= "101"; -- OR
          when "101010" => ALUCtrl <= "110"; -- SLT
          when others => ALUCtrl <= "000";
        end case;

      when "100011" => -- LW
        RegWrite <= '1';
        ALUSrc <= '1';
        MemToReg <= '1';
        ALUCtrl <= "010";

      when "101011" => -- SW
        ALUSrc <= '1';
        MemWrite <= '1';
        ALUCtrl <= "010";

      when "000010" => -- J (jump)
        jump <= '1';

      when "000100" => -- BEQ
        Branch <= '1';
        ALUCtrl <= "011"; -- SUB to compare

      when "000101" => -- BNE
        BranchNE <= '1';
        ALUCtrl <= "011"; -- SUB to compare

      when others =>
        null;

    end case;
  end process;
end architecture;
