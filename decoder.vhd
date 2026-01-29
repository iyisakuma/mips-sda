LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY decoder is	
	port (
		enable: in std_logic;
		X: in std_logic_vector(3 downto 0);
		out_decoder: out std_logic_vector(15 downto 0)
	);
end decoder;

ARCHITECTURE arc OF decoder IS

begin
	process(X, enable)
		begin
			if enable = '1' then
				case X is
					when "0000" => out_decoder <= "0000000000000001";
					when "0001" => out_decoder <= "0000000000000010";
					when "0010" => out_decoder <= "0000000000000100";
					when "0011" => out_decoder <= "0000000000001000";
					when "0100" => out_decoder <= "0000000000010000";
					when "0101" => out_decoder <= "0000000000100000";
					when "0110" => out_decoder <= "0000000001000000";
					when "0111" => out_decoder <= "0000000010000000";
					when "1000" => out_decoder <= "0000000100000000";
					when "1001" => out_decoder <= "0000001000000000";
					when "1010" => out_decoder <= "0000010000000000";
					when "1011" => out_decoder <= "0000100000000000";
					when "1100" => out_decoder <= "0001000000000000";
					when "1101" => out_decoder <= "0010000000000000";
					when "1110" => out_decoder <= "0100000000000000";
					when "1111" => out_decoder <= "1000000000000000";
				end case;
			else
				out_decoder <= "0000000000000000";
			end if;
		end process;

end arc;