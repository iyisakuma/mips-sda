LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_signed.all;

ENTITY mips is
	port (
		clock, reset: in std_logic;
		word_control_out: out std_logic_vector(31 downto 0)
	);
end mips;

ARCHITECTURE arc OF mips IS

	component arithmetic_logic_unit
	port (
		sel: in std_logic_vector(2 downto 0);
		A, B: in std_logic_vector(31 downto 0);
		F: out std_logic_vector(31 downto 0)
	);
	end component;

	
	component register_file
	port (
		load_enable, clock, reset: in std_logic;
		data: in std_logic_vector(31 downto 0);		
		destination_select: in std_logic_vector(3 downto 0);
		A_select, B_select: in std_logic_vector(3 downto 0);
		A_data, B_data: out std_logic_vector(31 downto 0)
	);
	end component;
	
	component instructions_memory
	port (
		clock: in std_logic;
		data_in: in std_logic_vector(31 downto 0);
		write_address, read_address: in std_logic_vector(9 downto 0);
		write_enable: in std_logic;
		data_out: out std_logic_vector(31 downto 0)
	);
	end component;
	
	component data_memory
	port (
		clock: in std_logic;
		data_in: in std_logic_vector(31 downto 0);
		write_address, read_address: in std_logic_vector(9 downto 0);
		write_enable: in std_logic;
		data_out: out std_logic_vector(31 downto 0)
	);
	end component;
	
	component mux2_1
	generic(N: integer := 32);
	port (
		sel: in std_logic;
		X0, X1: in std_logic_vector(N-1 downto 0);
		out_mux: out std_logic_vector(N-1 downto 0)
	);
	end component;

	signal sig_instruction_address: std_logic_vector(9 downto 0) := "0000000000";
	signal sig_instruction: std_logic_vector(31 downto 0);
	signal sig_control: std_logic_vector(15 downto 0);
	signal sig_write_register: std_logic_vector (4 downto 0);
	signal sig_write_data_register, sig_out_B_reg_file, sig_in_B_alu: std_logic_vector(31 downto 0);
	signal sig_a_data_alu, sig_b_data_alu, sig_out_alu, sig_out_datamemory: std_logic_vector(31 downto 0);
	
begin
	
	process(clock)
	begin
		
		if rising_edge(clock) then
			sig_instruction_address <= sig_instruction_address + 1;
		end if;
	
	end process;
	
	inst_mem: instructions_memory port map (
		clock => clock,
		data_in => "00000000000000000000000000000000",
		write_address => "0000000000",
		read_address => sig_instruction_address,
		write_enable => '0',
		data_out => sig_instruction
	);	

	sig_control <= sig_instruction(31 downto 26) & sig_instruction(9 downto 0);
	word_control_out <= sig_instruction;
	
	
	MUX1: mux2_1 generic map (N => 5) port map (
		sel => sig_control(5),
		X0 => sig_instruction(20 downto 16),
		X1 => sig_instruction(15 downto 11),
		out_mux => sig_write_register
	);
	
	reg_file: register_file port map (
		load_enable => sig_control(0),
		clock => clock,
		reset => reset,
		data => sig_write_data_register,
		destination_select => sig_write_register(3 downto 0),
		A_select => sig_instruction(24 downto 21),
		B_select => sig_instruction(19 downto 16),
		A_data => sig_a_data_alu,
		B_data => sig_out_B_reg_file
	);

	MUX3: mux2_1 generic map (N => 32) port map (
		sel => sig_control(6),
		X0 => sig_out_B_reg_file,
		X1 => "00000000000000000000000000" & sig_instruction(31 downto 26),
		out_mux => sig_in_B_alu
	);	
	
	alu: arithmetic_logic_unit port map (
		sel => sig_control(10 downto 8),
		A => sig_a_data_alu,
		B => sig_in_B_alu,
		F => sig_out_alu
	);
	
	data_mem: data_memory port map (
		clock => clock,
		data_in => sig_out_B_reg_file,
		write_address => sig_out_alu(9 downto 0),
		read_address => sig_out_alu(9 downto 0),
		write_enable => sig_control(7),
		data_out => sig_out_datamemory
	);	
	
	MUX2: mux2_1 generic map (N => 32) port map (
		sel => sig_control(11),
		X0 => sig_out_datamemory,
		X1 => sig_out_alu,
		out_mux => sig_write_data_register
	);
	
end arc;