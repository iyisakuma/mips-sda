LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY regis is
	port (
		clock, reset, load: in std_logic;
		D: in std_logic_vector(31 downto 0);
		Q: out std_logic_vector(31 downto 0)
	);
end regis;

ARCHITECTURE behavioral OF regis IS
begin
	process(clock, reset)
	begin
		if reset = '1' then
			Q <= (others => '0');
		elsif rising_edge(clock) then 
			if load = '1' then
				Q <= D;
			end if;
		end if;
	end process;
end behavioral;