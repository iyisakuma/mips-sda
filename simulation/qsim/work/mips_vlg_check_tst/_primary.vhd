library verilog;
use verilog.vl_types.all;
entity mips_vlg_check_tst is
    port(
        instr_debug     : in     vl_logic_vector(31 downto 0);
        mem0_debug      : in     vl_logic_vector(31 downto 0);
        mem1_debug      : in     vl_logic_vector(31 downto 0);
        mem2_debug      : in     vl_logic_vector(31 downto 0);
        mem3_debug      : in     vl_logic_vector(31 downto 0);
        reg1_debug      : in     vl_logic_vector(31 downto 0);
        reg2_debug      : in     vl_logic_vector(31 downto 0);
        reg3_debug      : in     vl_logic_vector(31 downto 0);
        reg4_debug      : in     vl_logic_vector(31 downto 0);
        reg5_debug      : in     vl_logic_vector(31 downto 0);
        reg6_debug      : in     vl_logic_vector(31 downto 0);
        reg7_debug      : in     vl_logic_vector(31 downto 0);
        reg8_debug      : in     vl_logic_vector(31 downto 0);
        sampler_rx      : in     vl_logic
    );
end mips_vlg_check_tst;
