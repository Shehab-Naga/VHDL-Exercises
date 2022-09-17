----------------------------------------------------
--             Lab2 Part 4: BCD_adder             --
----------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all, ieee.numeric_std.all;
ENTITY BCD_adder IS
    PORT (
        X, Y   : IN std_logic_vector(3 downto 0);
        c_in   : IN std_logic;
        d0, d1 : OUT std_logic_vector(6 downto 0)
    );
END BCD_adder;

ARCHITECTURE behavior OF BCD_adder IS
    COMPONENT ripple_carry_adder
        PORT (
            a, b     : IN std_logic_vector(3 downto 0);
            c_in     : IN std_logic;
            s        : OUT std_logic_vector(3 downto 0);
            c_out    : OUT std_logic
        );
    END COMPONENT; 
    COMPONENT binary_to_decimal_coverter
        port (
            V   : IN std_logic_vector(3 downto 0);
            d0, d1 : OUT std_logic_vector(6 downto 0)
        );
    END COMPONENT;
    SIGNAL s, V: std_logic_vector(3 downto 0);
    SIGNAL d1_intermediate : std_logic_vector(6 downto 0);
    SIGNAL c_out: std_logic;
BEGIN
    ripple_carry_adder1         : ripple_carry_adder            port map(a=> X, b=> Y, c_in=> c_in, s=> s, c_out=> c_out);
    binary_to_decimal_coverter1 : binary_to_decimal_coverter    port map(V => V, d0=> d0, d1=> d1_intermediate);
    -------------------------------------------------------------------------------------------------
    -- when the sum is > 15 then the input to the converter is modified by adding "0110" such that
    ------ 10_000 (the binary form of 16)  is converted into 011_0 (the binary form of 06)
    ------ 10_001 (the binary form of 17)  is converted into 011_1 (the binary form of 07)
    ------ 10_010 (the binary form of 18)  is converted into 100_0 (the binary form of 08)
    ------ 10_011 (the binary form of 19)  is converted into 100_1 (the binary form of 09)
    -- then the output of the converter for d1 is overriden to be one in case of sum > 15 
    -------------------------------------------------------------------------------------------------
    V   <=  std_logic_vector(unsigned(s) + "0110")   when c_out= '1' else    
            s;
    d1  <=  "1111001"   when c_out = '1' else
            d1_intermediate;

END behavior;
