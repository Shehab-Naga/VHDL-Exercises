LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE IEEE.numeric_std.all;

entity lab7_part2_tb is
end entity lab7_part2_tb;

architecture test of lab7_part2_tb is
    COMPONENT part2
        PORT (  Clock, reset_n, w : IN std_logic;
                state: OUT STD_LOGIC_VECTOR (3 downto 0);
                z : OUT std_logic);
    END COMPONENT;
    SIGNAL Clock: std_logic := '0';
    SIGNAL reset_n: std_logic := '0';
    SIGNAL w: std_logic;
    SIGNAL state: std_logic_vector (3 downto 0);
    SIGNAL z: std_logic;

    type state_vector is array (natural range <>) of STD_LOGIC_VECTOR (3 downto 0);
    CONSTANT expected_state: state_vector (8 downto 0) := ( 0 => "0000", -- A
                                                            1 => "0001", -- B
                                                            2 => "0010", -- C
                                                            3 => "0011", -- D
                                                            4 => "0100", -- E
                                                            5 => "0101", -- F
                                                            6 => "0110", -- G
                                                            7 => "0111", -- H
                                                            8 => "1000"  -- I
                                                        );
    type output_vector is array (natural range <>) of STD_LOGIC;
    CONSTANT expected_output: output_vector (8 downto 0) := ( 0 => '0', -- A
                                                              1 => '0', -- B
                                                              2 => '0', -- C
                                                              3 => '0', -- D
                                                              4 => '1', -- E
                                                              5 => '0', -- F
                                                              6 => '0', -- G
                                                              7 => '0', -- H
                                                              8 => '1'  -- I
                                                        );

begin
    -- Instantiate the design under test
    dut: part2 port map (Clock => Clock, reset_n => reset_n, w => w, state => state, z => z);

    -- reset_n and clock
    Clock <= not Clock after 1 ns;
    reset_n <= '0', '1' after 4 ns;
    
    -- Generator
    process begin
        wait until (reset_n = '1');
        For i in 0 to 3 LOOP
            w <= '0';
            WAIT FOR 2ns;
        End loop;

        For i in 0 to 3 LOOP
            w <= '1';
            WAIT FOR 2ns;
        End loop;
        -- Testing complete
        wait;
    end process;

    -- Monitoring
    process begin
        WAIT FOR 0.1ns;
        report (to_string(now, ns) & "  state = " & to_string(state) & "  z = " & to_string(z) & LF);
        ASSERT(state = expected_state(0)) REPORT (
            " Error: Expected Val /= Actual Val." &
            " Expected state = " & to_string(expected_state(0)) &" Actual state = " & to_string(state)
            )
        SEVERITY ERROR; 
        ASSERT(z = expected_output(0)) REPORT (
            " Error: Expected Val /= Actual Val." &
            " Expected z = " & to_string(expected_output(0)) &" Actual z = " & to_string(z)
            )
        SEVERITY ERROR;

        wait until (reset_n = '1');
        WAIT FOR 1ns;
        For i in 0 to 7 LOOP
            WAIT FOR 2ns;
            report (to_string(now, ns) & "  state = " & to_string(state) & "  z = " & to_string(z) & LF);
            ASSERT(state = expected_state(i+1)) REPORT (
                " Error: Expected Val /= Actual Val." &
                " Expected state = " & to_string(expected_state(i+1)) &" Actual state = " & to_string(state)
                )
            SEVERITY ERROR; 
            ASSERT(z = expected_output(i+1)) REPORT (
                " Error: Expected Val /= Actual Val." &
                " Expected z = " & to_string(expected_output(i+1)) &" Actual z = " & to_string(z)
                )
            SEVERITY ERROR;
        End loop;

        -- Testing complete
        wait;
    end process;
end test;