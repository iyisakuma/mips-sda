LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_signed.all;

ENTITY data_memory is
	port (
		clock: in std_logic;
		data_in: in std_logic_vector(31 downto 0);
		write_address, read_address: in std_logic_vector(9 downto 0);
		write_enable: in std_logic;
		data_out: out std_logic_vector(31 downto 0)
	);
end data_memory;

ARCHITECTURE arc OF data_memory IS

	component memory2
	port (
		clock		: IN STD_LOGIC  := '1';
		data		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		rdaddress		: IN STD_LOGIC_VECTOR (9 DOWNTO 0);
		wraddress		: IN STD_LOGIC_VECTOR (9 DOWNTO 0);
		wren		: IN STD_LOGIC  := '0';
		q		: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
	);
	
end component;

begin
	
	mem: memory2 port map (
		clock => clock,
		data => data_in,
		wraddress => write_address,
		rdaddress => read_address,
		wren => write_enable,
		q => data_out
	);
	
end arc;