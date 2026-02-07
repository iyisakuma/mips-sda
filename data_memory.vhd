library IEEE;
  use IEEE.std_logic_1164.all;
  use IEEE.numeric_std.all;

entity data_memory is
  port (
    clock                                          : in  std_logic;
    data_in                                        : in  std_logic_vector(31 downto 0);
    write_address, read_address                    : in  std_logic_vector(9 downto 0);
    write_enable                                   : in  std_logic;
    data_out                                       : out std_logic_vector(31 downto 0);
    -- portas de debug
    mem0_debug, mem1_debug, mem2_debug, mem3_debug : out std_logic_vector(31 downto 0)
  );
end entity;

architecture arc of data_memory is
  type mem_array is array (0 to 1023) of std_logic_vector(31 downto 0);
  signal mem : mem_array := (
    0      => X"00000005", -- valor 5
    1      => X"00000003", -- valor 3
    others => (others => '0')
  );
begin
  -- Escrita sincrona
  process (clock)
  begin
    if rising_edge(clock) then
      if write_enable = '1' then
        mem(to_integer(unsigned(write_address))) <= data_in;
      end if;
    end if;
  end process;

  -- Leitura combinacional
  data_out <= mem(to_integer(unsigned(read_address)));

  -- Expor valores da memória para debug
  mem0_debug <= mem(0);
  mem1_debug <= mem(1);
  mem2_debug <= mem(2);
  mem3_debug <= mem(3);

end architecture;
