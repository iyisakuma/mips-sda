library IEEE;
  use IEEE.std_logic_1164.all;
  use IEEE.numeric_std.all;

entity instructions_memory is
  port (
    clock                       : in  std_logic;
    data_in                     : in  std_logic_vector(31 downto 0);
    write_address, read_address : in  std_logic_vector(9 downto 0);
    write_enable                : in  std_logic;
    data_out                    : out std_logic_vector(31 downto 0)
  );
end entity;

architecture arc of instructions_memory is
  type rom_array is array (0 to 1023) of std_logic_vector(31 downto 0);
  constant rom : rom_array := (
    -- Programa de teste: R-type, LW, SW, BEQ, BNE, J
    -- Dados iniciais na memoria: MEM[0]=5, MEM[1]=3
    0      => X"8C010000", -- lw  $1, 0($0)       $1 = 5
    1      => X"8C020001", -- lw  $2, 1($0)       $2 = 3
    2      => X"00221820", -- add $3, $1, $2       $3 = 8
    3      => X"00222022", -- sub $4, $1, $2       $4 = 2
    4      => X"00222824", -- and $5, $1, $2       $5 = 1
    5      => X"00223025", -- or  $6, $1, $2       $6 = 7
    6      => X"0041382A", -- slt $7, $2, $1       $7 = 1
    7      => X"AC030002", -- sw  $3, 2($0)        MEM[2] = 8
    8      => X"8C080002", -- lw  $8, 2($0)        $8 = 8
    9      => X"10680001", -- beq $3, $8, +1       taken, skip 10
    10     => X"01294822", -- sub $9, $9, $9       SKIPPED
    11     => X"14220001", -- bne $1, $2, +1       taken, skip 12
    12     => X"01294822", -- sub $9, $9, $9       SKIPPED
    13     => X"0800000F", -- j   15               jump to 15
    14     => X"01294822", -- sub $9, $9, $9       SKIPPED
    15     => X"AC070003", -- sw  $7, 3($0)        MEM[3] = 1
    others => (others => '0')
  );
begin
  -- Leitura combinacional (ROM)
  data_out <= rom(to_integer(unsigned(read_address)));
end architecture;
