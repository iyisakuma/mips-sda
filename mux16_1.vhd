LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY mux16_1 is	
	port (
		sel: in std_logic_vector(3 downto 0);
		X0, X1, X2, X3, X4, X5, X6, X7, X8, X9, X10, X11, X12, X13, X14, X15: in std_logic_vector(31 downto 0);
		out_mux: out std_logic_vector(31 downto 0)
	);
end mux16_1;

ARCHITECTURE arc OF mux16_1 is

begin

	with sel select
		out_mux <= X0 when "0000",
					  X1 when "0001",
					  X2 when "0010",
					  X3 when "0011",
					  X4 when "0100",
					  X5 when "0101",
					  X6 when "0110",
					  X7 when "0111",
					  X8 when "1000",
					  X9 when "1001",
					  X10 when "1010",
					  X11 when "1011",
					  X12 when "1100",
					  X13 when "1101",
					  X14 when "1110",
					  X15 when "1111";

end arc;