LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE IEEE.numeric_std.all;

entity lab4_part1_tb is
end entity lab4_part1_tb;

architecture test of lab4_part1_tb is
    COMPONENT part1
        GENERIC (N: integer := 8);
        PORT (
            En, Clk, Clear  : IN std_logic;
            Q     : OUT std_logic_vector (N-1 downto 0);
            HEX0, HEX1     : OUT std_logic_vector (6 downto 0)
        );
    END COMPONENT;
    SIGNAL Clk: std_logic := '0';
    SIGNAL Clear: std_logic := '0';
    SIGNAL En: std_logic;
    SIGNAL Q: std_logic_vector (7 downto 0);
begin
    -- Instantiate the design under test
    dut: part1 port map (
        En => En, Clk => Clk, Clear => Clear, Q => Q);

    -- Clear and clock
    Clk <= not Clk after 1 ns;
    Clear <= '0', '1' after 5 ns;
    
    -- Generate the test stimulus
    process begin
        wait until (Clear = '1');
        En <= '1';
        For i in 0 to 255 LOOP
            report (to_string(now, ns) & "  Q = " & to_string(Q) & LF);
            WAIT FOR 2ns;
            ASSERT(Q = std_logic_vector(to_unsigned(i,8))) REPORT (
                " Error: Expected Val /= Actual Val." &
                " Expected = " & to_string(std_logic_vector(to_unsigned(i,8))) &" Actual = " & to_string(Q)
                )
            SEVERITY ERROR; 
        End loop;

        -- Testing complete
        wait;
    end process;
end test;