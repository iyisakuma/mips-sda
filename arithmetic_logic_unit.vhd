library IEEE;
  use IEEE.std_logic_1164.all;
  use IEEE.numeric_std.all;

entity arithmetic_logic_unit is
  port (
    sel  : in  std_logic_vector(2 downto 0);
    A, B : in  std_logic_vector(31 downto 0);
    F    : out std_logic_vector(31 downto 0);
    Zero : out std_logic
  );
end entity;

architecture behavioral of arithmetic_logic_unit is
  signal result             : std_logic_vector(31 downto 0);
  signal A_signed, B_signed : signed(31 downto 0);
begin

  A_signed <= signed(A);
  B_signed <= signed(B);

  process (sel, A, B, A_signed, B_signed)
  begin
    case sel is
      when "000" => result <= A;
      when "001" => result <= B;
      when "010" => result <= std_logic_vector(A_signed + B_signed); -- ADD
      when "011" => result <= std_logic_vector(A_signed - B_signed); -- SUB
      when "100" => result <= A and B; -- AND
      when "101" => result <= A or B; -- OR
      when "110" => -- SLT (set less than)
        if A_signed < B_signed then
          result <= X"00000001";
        else
          result <= X"00000000";
        end if;
      when "111" => result <= not B;
      when others => result <= (others => '0');
    end case;
  end process;

  F    <= result;
  Zero <= '1' when result = X"00000000" else '0';

end architecture;
