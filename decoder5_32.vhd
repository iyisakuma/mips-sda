LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.all;

ENTITY decoder5_32 IS
  PORT (
    enable      : IN  std_logic;
    X           : IN  std_logic_vector(4 downto 0);
    out_decoder : OUT std_logic_vector(31 downto 0)
  );
END decoder5_32;

ARCHITECTURE rtl OF decoder5_32 IS
BEGIN
  PROCESS(enable, X)
    VARIABLE tmp : std_logic_vector(31 downto 0);
  BEGIN
    tmp := (others => '0');

    IF enable = '1' THEN
      tmp(to_integer(unsigned(X))) := '1';
    END IF;

    out_decoder <= tmp;
  END PROCESS;
END rtl;
