LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY mux32_1 IS
  PORT (
    sel : IN std_logic_vector(4 downto 0);
    X0, X1, X2, X3, X4, X5, X6, X7,
    X8, X9, X10, X11, X12, X13, X14, X15,
    X16, X17, X18, X19, X20, X21, X22, X23,
    X24, X25, X26, X27, X28, X29, X30, X31 : IN std_logic_vector(31 downto 0);
    out_mux : OUT std_logic_vector(31 downto 0)
  );
END mux32_1;

ARCHITECTURE rtl OF mux32_1 IS
BEGIN
  PROCESS(sel, X0, X1, X2, X3, X4, X5, X6, X7,
                X8, X9, X10, X11, X12, X13, X14, X15,
                X16, X17, X18, X19, X20, X21, X22, X23,
                X24, X25, X26, X27, X28, X29, X30, X31)
  BEGIN
    CASE sel IS
      WHEN "00000" => out_mux <= X0;
      WHEN "00001" => out_mux <= X1;
      WHEN "00010" => out_mux <= X2;
      WHEN "00011" => out_mux <= X3;
      WHEN "00100" => out_mux <= X4;
      WHEN "00101" => out_mux <= X5;
      WHEN "00110" => out_mux <= X6;
      WHEN "00111" => out_mux <= X7;
      WHEN "01000" => out_mux <= X8;
      WHEN "01001" => out_mux <= X9;
      WHEN "01010" => out_mux <= X10;
      WHEN "01011" => out_mux <= X11;
      WHEN "01100" => out_mux <= X12;
      WHEN "01101" => out_mux <= X13;
      WHEN "01110" => out_mux <= X14;
      WHEN "01111" => out_mux <= X15;
      WHEN "10000" => out_mux <= X16;
      WHEN "10001" => out_mux <= X17;
      WHEN "10010" => out_mux <= X18;
      WHEN "10011" => out_mux <= X19;
      WHEN "10100" => out_mux <= X20;
      WHEN "10101" => out_mux <= X21;
      WHEN "10110" => out_mux <= X22;
      WHEN "10111" => out_mux <= X23;
      WHEN "11000" => out_mux <= X24;
      WHEN "11001" => out_mux <= X25;
      WHEN "11010" => out_mux <= X26;
      WHEN "11011" => out_mux <= X27;
      WHEN "11100" => out_mux <= X28;
      WHEN "11101" => out_mux <= X29;
      WHEN "11110" => out_mux <= X30;
      WHEN "11111" => out_mux <= X31;
      WHEN OTHERS  => out_mux <= (others => '0');
    END CASE;
  END PROCESS;
END rtl;
