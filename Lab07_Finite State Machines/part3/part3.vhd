LIBRARY ieee;
USE ieee.std_logic_1164.all;
ENTITY SIPO IS
    port (   
        Clock, reset_n, D_in : IN STD_LOGIC; 
        D_out                : OUT STD_LOGIC_VECTOR (3 downto 0)
    );
END SIPO;

ARCHITECTURE behavior OF SIPO IS 
    SIGNAL D_out_reg: STD_LOGIC_VECTOR (3 downto 0);
BEGIN
    process(Clock)
    begin
        IF rising_edge(Clock) THEN
            IF (reset_n = '0') THEN
                D_out_reg <= (others => '0');
            ELSE
                D_out_reg (3 downto 1) <= D_out_reg (2 downto 0);
                D_out_reg (0) <= D_in;
            END IF;
        END IF;
    END PROCESS;
    D_out <= D_out_reg;
END behavior;
---------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY part3 IS
    PORT (  Clock, reset_n, w : IN std_logic;
            z : OUT std_logic;
            LED0, LED1: OUT STD_LOGIC_VECTOR (3 downto 0)
            );
END part3;

ARCHITECTURE Behavior OF part3 IS
    COMPONENT SIPO
        port (   
            Clock, reset_n, D_in : IN STD_LOGIC; 
            D_out                : OUT STD_LOGIC_VECTOR (3 downto 0)
        );
    END COMPONENT SIPO;
    SIGNAL sipo_out_0, sipo_out_1: STD_LOGIC_VECTOR (3 downto 0);
    SIGNAL four_zeros, four_ones: STD_LOGIC;
BEGIN
    SIPO_zeros: SIPO port map (Clock => Clock, reset_n => reset_n, D_in => w, D_out => sipo_out_0);
    SIPO_ones: SIPO port map (Clock => Clock, reset_n => reset_n, D_in => w, D_out => sipo_out_1);
    
    LED0 <= sipo_out_0;
    LED1 <= sipo_out_1;

    four_zeros <= NOT( sipo_out_0(0) OR sipo_out_0(1) OR sipo_out_0(2) OR sipo_out_0(3));
    four_ones <= sipo_out_1(0) AND sipo_out_1(1) AND sipo_out_1(2) AND sipo_out_1(3);

    z <= '1' when four_zeros = '1' or four_ones = '1' 
        else '0';
END Behavior;