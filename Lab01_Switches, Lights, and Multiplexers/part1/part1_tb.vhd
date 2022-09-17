LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE IEEE.numeric_std.all;

entity lab1_part1_tb is
end entity lab1_part1_tb;

architecture test of lab1_part1_tb is
    COMPONENT part1
        PORT (  SW : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
                LEDR : OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
    END COMPONENT;
    signal test_SW, test_LEDR  : STD_LOGIC_VECTOR(3 DOWNTO 0);
begin
    -- Instantiate the design under test
    dut: part1 port map (SW => test_SW, LEDR => test_LEDR);
      -- Generate the test stimulus
    process begin

        For i in 0 to 15 LOOP
            test_SW <= std_logic_vector(to_unsigned(i,4));
            report (to_string(now, ns) & "  test_LEDR = " & to_string(test_LEDR) & LF);
            WAIT FOR 10ns;
            ASSERT(test_LEDR = std_logic_vector(to_unsigned(i,4))) REPORT (
                " Error: Expected Val /= Actual Val." &
                " Expected = " & to_string(std_logic_vector(to_unsigned(i,4))) &" Actual = " & to_string(test_LEDR)
                )
            SEVERITY ERROR; 
        End loop;
        -- Testing complete
        wait;
        
    end process;
end test;