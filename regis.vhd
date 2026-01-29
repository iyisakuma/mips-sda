LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY regis is
	port (
		clock, reset, load: in std_logic;
		D: in std_logic_vector(31 downto 0);
		Q: out std_logic_vector(31 downto 0)
	);
end regis;

ARCHITECTURE arc OF regis IS

begin

	process(D, clock, reset, load)
		begin
			if reset = '1' then
				Q <= "00000000000000000000000000000000";
			elsif rising_edge(clock) then 
				if load = '1' then
					Q <= D;
				end if;
			end if;
		end process;
		
end arc;