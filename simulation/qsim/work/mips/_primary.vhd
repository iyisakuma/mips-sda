library verilog;
use verilog.vl_types.all;
entity mips is
    port(
        clock           : in     vl_logic;
        reset           : in     vl_logic;
        word_control_out: out    vl_logic_vector(31 downto 0)
    );
end mips;
