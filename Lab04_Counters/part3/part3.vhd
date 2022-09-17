LIBRARY ieee;
USE ieee.std_logic_1164.all;
ENTITY part3 IS
    PORT (
        Clk, Clear      : IN std_logic;
        HEX0     : OUT std_logic_vector (6 downto 0)
    );
END part3;

ARCHITECTURE structure OF part3 IS
    COMPONENT part1 IS
        GENERIC (N: integer := 8);
        PORT (
            En, Clk, Clear  : IN std_logic;
            Q     : OUT std_logic_vector (N-1 downto 0)
        );
    END COMPONENT;
    COMPONENT Displaying
        port (
            SW0   : IN std_logic_vector(3 downto 0);
            HEX0  : OUT std_logic_vector(6 downto 0)
        );
    END COMPONENT;
    SIGNAL timer        : std_logic_vector (25 downto 0);
    SIGNAL counter_en   : std_logic;
    SIGNAL count        : std_logic_vector (3 downto 0);
BEGIN
    clock_divider   : part1         GENERIC map (N => 26)   port map (En=> '1'          , Clk => Clk    , Clear=> Clear, Q=> timer);
    counter         : part1         GENERIC map (N => 4)    port map (En=> counter_en   , Clk=> Clk     , Clear=> Clear, Q=> count);
    display0        : Displaying                            port map (SW0 => count      , HEX0 => HEX0);
    counter_en <=        '1' when timer = "10111110101111000010000000"
                    else '0';
END structure;