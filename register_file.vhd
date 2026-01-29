LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY register_file is	
	port (
		load_enable, clock, reset: in std_logic;
		data: in std_logic_vector(31 downto 0);		
		destination_select: in std_logic_vector(3 downto 0);
		A_select, B_select: in std_logic_vector(3 downto 0);
		A_data, B_data: out std_logic_vector(31 downto 0)
	);
end register_file;

ARCHITECTURE arc OF register_file is

component decoder
	port (
		enable: in std_logic;
		X: in std_logic_vector(3 downto 0);
		out_decoder: out std_logic_vector(15 downto 0)
	);
end component;

component regis
	port (
		clock, reset, load: in std_logic;
		D: in std_logic_vector(31 downto 0);
		Q: out std_logic_vector(31 downto 0)
	);
end component;

component mux16_1
	port (
		sel: in std_logic_vector(3 downto 0);
		X0, X1, X2, X3, X4, X5, X6, X7, X8, X9, X10, X11, X12, X13, X14, X15: in std_logic_vector(31 downto 0);
		out_mux: out std_logic_vector(31 downto 0)
	);
end component;

type vector_array is array (0 to 15) of std_logic_vector(31 downto 0);

signal load_temp: std_logic_vector(15 downto 0);
signal regis_out: vector_array;

begin

	DECO: decoder port map(load_enable, destination_select, load_temp);
	
	R0: regis port map(clock, reset, load_temp(0), data, regis_out(0));
	R1: regis port map(clock, reset, load_temp(1), data, regis_out(1));
	R2: regis port map(clock, reset, load_temp(2), data, regis_out(2));
	R3: regis port map(clock, reset, load_temp(3), data, regis_out(3));
	R4: regis port map(clock, reset, load_temp(4), data, regis_out(4));
	R5: regis port map(clock, reset, load_temp(5), data, regis_out(5));
	R6: regis port map(clock, reset, load_temp(6), data, regis_out(6));
	R7: regis port map(clock, reset, load_temp(7), data, regis_out(7));
	R8: regis port map(clock, reset, load_temp(8), data, regis_out(8));
	R9: regis port map(clock, reset, load_temp(9), data, regis_out(9));
	R10: regis port map(clock, reset, load_temp(10), data, regis_out(10));
	R11: regis port map(clock, reset, load_temp(11), data, regis_out(11));
	R12: regis port map(clock, reset, load_temp(12), data, regis_out(12));
	R13: regis port map(clock, reset, load_temp(13), data, regis_out(13));
	R14: regis port map(clock, reset, load_temp(14), data, regis_out(14));
	R15: regis port map(clock, reset, load_temp(15), data, regis_out(15));

	MUX_A: mux16_1 port map(sel => A_select,              
									X0 => regis_out(0),
									X1 => regis_out(1),
									X2 => regis_out(2),
									X3 => regis_out(3),
									X4 => regis_out(4),
									X5 => regis_out(5),
									X6 => regis_out(6),
									X7 => regis_out(7),
									X8 => regis_out(8),
									X9 => regis_out(9),
									X10 => regis_out(10),
									X11 => regis_out(11),
									X12 => regis_out(12),
									X13 => regis_out(13),
									X14 => regis_out(14),
									X15 => regis_out(15),
									out_mux => A_data);
	
		MUX_B: mux16_1 port map(sel => B_select,              
									X0 => regis_out(0),
									X1 => regis_out(1),
									X2 => regis_out(2),
									X3 => regis_out(3),
									X4 => regis_out(4),
									X5 => regis_out(5),
									X6 => regis_out(6),
									X7 => regis_out(7),
									X8 => regis_out(8),
									X9 => regis_out(9),
									X10 => regis_out(10),
									X11 => regis_out(11),
									X12 => regis_out(12),
									X13 => regis_out(13),
									X14 => regis_out(14),
									X15 => regis_out(15),
									out_mux => B_data);
	
end arc;