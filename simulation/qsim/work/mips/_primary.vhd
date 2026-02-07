library verilog;
use verilog.vl_types.all;
entity mips is
    port(
        clock           : in     vl_logic;
        reset           : in     vl_logic;
        instr_debug     : out    vl_logic_vector(31 downto 0);
        reg1_debug      : out    vl_logic_vector(31 downto 0);
        reg2_debug      : out    vl_logic_vector(31 downto 0);
        reg3_debug      : out    vl_logic_vector(31 downto 0);
        reg4_debug      : out    vl_logic_vector(31 downto 0);
        reg5_debug      : out    vl_logic_vector(31 downto 0);
        reg6_debug      : out    vl_logic_vector(31 downto 0);
        reg7_debug      : out    vl_logic_vector(31 downto 0);
        reg8_debug      : out    vl_logic_vector(31 downto 0);
        mem0_debug      : out    vl_logic_vector(31 downto 0);
        mem1_debug      : out    vl_logic_vector(31 downto 0);
        mem2_debug      : out    vl_logic_vector(31 downto 0);
        mem3_debug      : out    vl_logic_vector(31 downto 0)
    );
end mips;
