library IEEE;
  use IEEE.std_logic_1164.all;
  use IEEE.numeric_std.all;

entity register_file is
  port (
    load_enable, clock, reset                      : in  std_logic;
    data                                           : in  std_logic_vector(31 downto 0);
    destination_select                             : in  std_logic_vector(4 downto 0);
    A_select, B_select                             : in  std_logic_vector(4 downto 0);
    A_data, B_data                                 : out std_logic_vector(31 downto 0);
    -- portas de debug
    reg1_debug, reg2_debug, reg3_debug, reg4_debug : out std_logic_vector(31 downto 0);
    reg5_debug, reg6_debug, reg7_debug, reg8_debug : out std_logic_vector(31 downto 0)
  );
end entity;

architecture behavioral of register_file is
  type reg_array is array (0 to 31) of std_logic_vector(31 downto 0);
  signal regs : reg_array := (others => (others => '0'));
begin

  -- Escrita síncrona nos registradores
  process (clock, reset)
  begin
    if reset = '1' then
      regs <= (others => (others => '0'));
    elsif rising_edge(clock) then
      if load_enable = '1' and destination_select /= "00000" then
        regs(to_integer(unsigned(destination_select))) <= data;
      end if;
    end if;
  end process;

  -- Leituras combinacionais (MUX comportamental)
  -- $0 sempre retorna 0
  A_data <= (others => '0') when A_select = "00000" else
           regs(to_integer(unsigned(A_select)));

  B_data <= (others => '0') when B_select = "00000" else
           regs(to_integer(unsigned(B_select)));

  -- Debug: expor registradores 1-8
  reg1_debug <= regs(1);
  reg2_debug <= regs(2);
  reg3_debug <= regs(3);
  reg4_debug <= regs(4);
  reg5_debug <= regs(5);
  reg6_debug <= regs(6);
  reg7_debug <= regs(7);
  reg8_debug <= regs(8);

end architecture;
