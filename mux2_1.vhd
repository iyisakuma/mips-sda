LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY mux2_1 is
	generic(N: integer := 32);
	port (
		sel: in std_logic;
		X0, X1: in std_logic_vector(N-1 downto 0);
		out_mux: out std_logic_vector(N-1 downto 0)
	);
end mux2_1;

ARCHITECTURE behavioral OF mux2_1 IS
BEGIN
  -- MUX combinacional simples (mais rápido que process)
  out_mux <= X1 when sel = '1' else X0;
END behavioral;