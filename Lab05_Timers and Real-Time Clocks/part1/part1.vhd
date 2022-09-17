LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

ENTITY counter IS
    GENERIC ( n : NATURAL := 4 ; k: NATURAL := 16);
    PORT ( clock : IN STD_LOGIC;
            reset_n : IN STD_LOGIC;
            Q : OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0);
            rollover: OUT STD_LOGIC );
END ENTITY;

ARCHITECTURE Behavior OF counter IS
    SIGNAL value : STD_LOGIC_VECTOR(n-1 DOWNTO 0);
BEGIN
    PROCESS (clock, reset_n)
    BEGIN
        IF (reset_n = '0') THEN
            value <= (OTHERS => '0');
        ELSIF ((clock'EVENT) AND (clock = '1' )) THEN
            IF (value < k-1) THEN
                value <= value + '1';
            ELSE value <= (others =>'0');
        END IF;
        END IF;
    END PROCESS;
    Q <= value;
    rollover <= '1' when value = k-1 
                else '0';
END Behavior;

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

ENTITY part1 IS
    PORT ( clock : IN STD_LOGIC;
            reset_n : IN STD_LOGIC;
            Q : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
            rollover: OUT STD_LOGIC );
END part1;

ARCHITECTURE Behavior OF part1 IS
    COMPONENT counter
        GENERIC ( n : NATURAL := 4 ; k: NATURAL := 16);
        PORT ( clock : IN STD_LOGIC;
                reset_n : IN STD_LOGIC;
                Q : OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0);
                rollover: OUT STD_LOGIC );
    END COMPONENT;
BEGIN
    five_bit: counter GENERIC MAP ( n => 5 , k => 20) PORT MAP(clock, reset_n, Q, rollover);
END Behavior;