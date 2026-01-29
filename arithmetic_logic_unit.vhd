LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_signed.all;

ENTITY arithmetic_logic_unit is
	port (
		sel: in std_logic_vector(2 downto 0);
		A, B: in std_logic_vector(31 downto 0);
		F: out std_logic_vector(31 downto 0)
	);
end arithmetic_logic_unit;

ARCHITECTURE arc OF arithmetic_logic_unit IS

signal temp, temp_A, temp_B: std_logic_vector(32 downto 0);

begin
	
	process(A, B, sel)
		begin
			temp_A(31 downto 0) <= A;
			temp_B(31 downto 0) <= B;
			temp_A(32) <= A(31);
			temp_B(32) <= B(31);
			
			case sel is
				when "000" => temp <= temp_A;
				when "001" => temp <= temp_B;
				when "010" => temp <= temp_A + temp_B;
				when "011" => temp <= temp_A - temp_B;
				when "100" => temp <= temp_A and temp_B;
				when "101" => temp <= temp_A or temp_B;
				when "110" => temp <= not(temp_A);
				when "111" => temp <= not(temp_B);
			end case;
			
		end process;
		
		F <= temp(31 downto 0);
end arc;