LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity lab2_part1_tb is
end entity lab2_part1_tb;

architecture test of lab2_part1_tb is
    COMPONENT part1
        port (
            SW0, SW1   : IN std_logic_vector(3 downto 0);
            HEX0, HEX1 : OUT std_logic_vector(6 downto 0)
        );
    end COMPONENT;
    signal test_SW0, test_SW1  : STD_LOGIC_VECTOR(3 DOWNTO 0);
    signal test_HEX0, test_HEX1 : std_logic_vector(6 downto 0);
begin
    -- Instantiate the design under test
    dut: part1 port map (SW0 =>test_SW0, SW1 =>test_SW1, HEX0 =>test_HEX0, HEX1 =>test_HEX1);
    -- Generate the test stimulus
    process begin
        test_SW0 <= "0000";
        test_SW1 <= "0001";
        WAIT FOR 10ns;
        ASSERT(test_HEX0 = "1000000") REPORT "TEST FAILED"
        SEVERITY ERROR; 
        ASSERT(test_HEX1 = "1111001") REPORT "TEST FAILED"
        SEVERITY ERROR; 
        report (to_string(now, ns) & "  test values = " & to_string(test_SW0)& "    and     " &to_string(test_SW1) & LF);

        test_SW0 <= "0010";
        test_SW1 <= "0011";
        WAIT FOR 10ns;
        ASSERT(test_HEX0 = "0100100") REPORT "TEST FAILED"
        SEVERITY ERROR; 
        ASSERT(test_HEX1 = "0110000") REPORT "TEST FAILED"
        SEVERITY ERROR;  
        report (to_string(now, ns) & "  test values = " & to_string(test_SW0)& "    and     " &to_string(test_SW1) & LF);

        test_SW0 <= "0100";
        test_SW1 <= "0101";
        WAIT FOR 10ns;
        ASSERT(test_HEX0 = "0011001") REPORT "TEST FAILED"
        SEVERITY ERROR; 
        ASSERT(test_HEX1 = "0010010") REPORT "TEST FAILED"
        SEVERITY ERROR;  
        report (to_string(now, ns) & "  test values = " & to_string(test_SW0)& "    and     " &to_string(test_SW1) & LF);

        test_SW0 <= "0110";
        test_SW1 <= "0111";
        WAIT FOR 10ns;
        ASSERT(test_HEX0 = "0000010") REPORT "TEST FAILED"
        SEVERITY ERROR; 
        ASSERT(test_HEX1 = "1111000") REPORT "TEST FAILED"
        SEVERITY ERROR; 
        report (to_string(now, ns) & "  test values = " & to_string(test_SW0)& "    and     " &to_string(test_SW1) & LF);

        test_SW0 <= "1000";
        test_SW1 <= "1001";
        WAIT FOR 10ns;
        ASSERT(test_HEX0 = "0000000") REPORT "TEST FAILED"
        SEVERITY ERROR; 
        ASSERT(test_HEX1 = "0010000") REPORT "TEST FAILED"
        SEVERITY ERROR;
        report (to_string(now, ns) & "  test values = " & to_string(test_SW0)& "    and     " &to_string(test_SW1) & LF);
        -- Testing complete
        wait;
    end process;
end test;