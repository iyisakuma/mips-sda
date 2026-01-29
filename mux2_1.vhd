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

ARCHITECTURE arc OF mux2_1 IS
BEGIN
    process (sel, X0, X1)
    begin
        if sel = '0' then
            out_mux <= X0;
        else
            out_mux <= X1;
        end if;
    end process;
END arc;