LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY register_file is	
	port (
		load_enable, clock, reset: in std_logic;
		data: in std_logic_vector(31 downto 0);		
		destination_select: in std_logic_vector(4 downto 0);
		A_select, B_select: in std_logic_vector(4 downto 0);
		A_data, B_data: out std_logic_vector(31 downto 0)
	);
end register_file;

ARCHITECTURE arc OF register_file is

COMPONENT decoder5_32
  PORT (
    enable      : IN  std_logic;
    X           : IN  std_logic_vector(4 downto 0);
    out_decoder : OUT std_logic_vector(31 downto 0)
  );
END COMPONENT;


component regis
	port (
		clock, reset, load: in std_logic;
		D: in std_logic_vector(31 downto 0);
		Q: out std_logic_vector(31 downto 0)
	);
end component;

COMPONENT mux32_1
  PORT (
    sel : IN std_logic_vector(4 downto 0);
    X0, X1, X2, X3, X4, X5, X6, X7,
    X8, X9, X10, X11, X12, X13, X14, X15,
    X16, X17, X18, X19, X20, X21, X22, X23,
    X24, X25, X26, X27, X28, X29, X30, X31 : IN std_logic_vector(31 downto 0);
    out_mux : OUT std_logic_vector(31 downto 0)
  );
END COMPONENT;

  TYPE vector_array IS ARRAY (0 TO 31) OF std_logic_vector(31 downto 0);

  SIGNAL load_temp : std_logic_vector(31 downto 0);
  SIGNAL regis_out : vector_array;

BEGIN

  -- Decoder 5 -> 32
  DECO: decoder5_32
    PORT MAP (
      enable      => load_enable,
      X           => destination_select,
      out_decoder => load_temp
    );

  -- 32 registradores
  R0  : regis PORT MAP(clock, reset, load_temp(0),  data, regis_out(0));
  R1  : regis PORT MAP(clock, reset, load_temp(1),  data, regis_out(1));
  R2  : regis PORT MAP(clock, reset, load_temp(2),  data, regis_out(2));
  R3  : regis PORT MAP(clock, reset, load_temp(3),  data, regis_out(3));
  R4  : regis PORT MAP(clock, reset, load_temp(4),  data, regis_out(4));
  R5  : regis PORT MAP(clock, reset, load_temp(5),  data, regis_out(5));
  R6  : regis PORT MAP(clock, reset, load_temp(6),  data, regis_out(6));
  R7  : regis PORT MAP(clock, reset, load_temp(7),  data, regis_out(7));
  R8  : regis PORT MAP(clock, reset, load_temp(8),  data, regis_out(8));
  R9  : regis PORT MAP(clock, reset, load_temp(9),  data, regis_out(9));
  R10 : regis PORT MAP(clock, reset, load_temp(10), data, regis_out(10));
  R11 : regis PORT MAP(clock, reset, load_temp(11), data, regis_out(11));
  R12 : regis PORT MAP(clock, reset, load_temp(12), data, regis_out(12));
  R13 : regis PORT MAP(clock, reset, load_temp(13), data, regis_out(13));
  R14 : regis PORT MAP(clock, reset, load_temp(14), data, regis_out(14));
  R15 : regis PORT MAP(clock, reset, load_temp(15), data, regis_out(15));
  R16 : regis PORT MAP(clock, reset, load_temp(16), data, regis_out(16));
  R17 : regis PORT MAP(clock, reset, load_temp(17), data, regis_out(17));
  R18 : regis PORT MAP(clock, reset, load_temp(18), data, regis_out(18));
  R19 : regis PORT MAP(clock, reset, load_temp(19), data, regis_out(19));
  R20 : regis PORT MAP(clock, reset, load_temp(20), data, regis_out(20));
  R21 : regis PORT MAP(clock, reset, load_temp(21), data, regis_out(21));
  R22 : regis PORT MAP(clock, reset, load_temp(22), data, regis_out(22));
  R23 : regis PORT MAP(clock, reset, load_temp(23), data, regis_out(23));
  R24 : regis PORT MAP(clock, reset, load_temp(24), data, regis_out(24));
  R25 : regis PORT MAP(clock, reset, load_temp(25), data, regis_out(25));
  R26 : regis PORT MAP(clock, reset, load_temp(26), data, regis_out(26));
  R27 : regis PORT MAP(clock, reset, load_temp(27), data, regis_out(27));
  R28 : regis PORT MAP(clock, reset, load_temp(28), data, regis_out(28));
  R29 : regis PORT MAP(clock, reset, load_temp(29), data, regis_out(29));
  R30 : regis PORT MAP(clock, reset, load_temp(30), data, regis_out(30));
  R31 : regis PORT MAP(clock, reset, load_temp(31), data, regis_out(31));

  -- MUX A
  MUX_A: mux32_1
    PORT MAP (
      sel => A_select,
      X0 => regis_out(0),   X1 => regis_out(1),
      X2 => regis_out(2),   X3 => regis_out(3),
      X4 => regis_out(4),   X5 => regis_out(5),
      X6 => regis_out(6),   X7 => regis_out(7),
      X8 => regis_out(8),   X9 => regis_out(9),
      X10 => regis_out(10), X11 => regis_out(11),
      X12 => regis_out(12), X13 => regis_out(13),
      X14 => regis_out(14), X15 => regis_out(15),
      X16 => regis_out(16), X17 => regis_out(17),
      X18 => regis_out(18), X19 => regis_out(19),
      X20 => regis_out(20), X21 => regis_out(21),
      X22 => regis_out(22), X23 => regis_out(23),
      X24 => regis_out(24), X25 => regis_out(25),
      X26 => regis_out(26), X27 => regis_out(27),
      X28 => regis_out(28), X29 => regis_out(29),
      X30 => regis_out(30), X31 => regis_out(31),
      out_mux => A_data
    );

  -- MUX B
  MUX_B: mux32_1
    PORT MAP (
      sel => B_select,
      X0 => regis_out(0),   X1 => regis_out(1),
      X2 => regis_out(2),   X3 => regis_out(3),
      X4 => regis_out(4),   X5 => regis_out(5),
      X6 => regis_out(6),   X7 => regis_out(7),
      X8 => regis_out(8),   X9 => regis_out(9),
      X10 => regis_out(10), X11 => regis_out(11),
      X12 => regis_out(12), X13 => regis_out(13),
      X14 => regis_out(14), X15 => regis_out(15),
      X16 => regis_out(16), X17 => regis_out(17),
      X18 => regis_out(18), X19 => regis_out(19),
      X20 => regis_out(20), X21 => regis_out(21),
      X22 => regis_out(22), X23 => regis_out(23),
      X24 => regis_out(24), X25 => regis_out(25),
      X26 => regis_out(26), X27 => regis_out(27),
      X28 => regis_out(28), X29 => regis_out(29),
      X30 => regis_out(30), X31 => regis_out(31),
      out_mux => B_data
    );

END arc;
