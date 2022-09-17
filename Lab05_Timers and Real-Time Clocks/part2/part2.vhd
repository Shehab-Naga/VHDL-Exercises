LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity Displaying is
    port (
        SW0   : IN std_logic_vector(3 downto 0);

        HEX0  : OUT std_logic_vector(6 downto 0)
    );
end entity Displaying;

architecture rtl of Displaying is
    
begin

    HEX0 <= "1000000" when SW0 = "0000"
    else "1111001" when SW0 = "0001"
    else "0100100" when SW0 = "0010"
    else "0110000" when SW0 = "0011"
    else "0011001" when SW0 = "0100"
    else "0010010" when SW0 = "0101"
    else "0000010" when SW0 = "0110"
    else "1111000" when SW0 = "0111"
    else "0000000" when SW0 = "1000"
    else "0010000" when SW0 = "1001"
    else "0001000" when SW0 = "1010"
    else (Others => '1');    

end architecture rtl;

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

ENTITY counter IS
    GENERIC ( n : NATURAL := 4 ; k: NATURAL := 16);
    PORT ( clock, En : IN STD_LOGIC;
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
            IF ((value < k-1) AND (En = '1')) THEN
                value <= value + '1';
            ELSIF (En = '1') THEN
                value <= (others =>'0');
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

ENTITY part2 IS
    PORT ( clock : IN STD_LOGIC;
            reset_n : IN STD_LOGIC;
            HEX0, HEX1, HEX2 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
        );
END part2;

ARCHITECTURE Behavior OF part2 IS
    COMPONENT counter
        GENERIC ( n : NATURAL := 4 ; k: NATURAL := 16);
        PORT ( clock, En : IN STD_LOGIC;
                reset_n : IN STD_LOGIC;
                Q : OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0);
                rollover: OUT STD_LOGIC );
    END COMPONENT;
    COMPONENT Displaying
        port (
            SW0   : IN std_logic_vector(3 downto 0);
            HEX0  : OUT std_logic_vector(6 downto 0)
        );
    END COMPONENT;
    SIGNAL En1, En2: STD_LOGIC;
    SIGNAL rollover: STD_LOGIC_VECTOR (2 downto 0);
    SIGNAL Q0, Q1, Q2: std_logic_vector(3 downto 0);
BEGIN
    Counter_0: counter GENERIC MAP ( n => 26 , k => 50000000) PORT MAP(clock => clock, En => '1', reset_n => reset_n, rollover => rollover(0));
    Counter_1: counter GENERIC MAP ( n => 4 , k => 10) PORT MAP(clock => clock, En => rollover(0), reset_n => reset_n, Q=> Q0, rollover => rollover(1));
    Counter_2: counter GENERIC MAP ( n => 4 , k => 10) PORT MAP(clock => clock, En => En1, reset_n => reset_n, Q => Q1, rollover => rollover(2));
    Counter_3: counter GENERIC MAP ( n => 4 , k => 10) PORT MAP(clock => clock, En => En2, reset_n => reset_n, Q => Q2);
    En1 <= rollover(1) AND rollover(0);
    En2 <= rollover(2) AND rollover(0) AND rollover(1);

    Displaying_0: Displaying port map (SW0=> Q0, HEX0=> HEX0);
    Displaying_1: Displaying port map (SW0=> Q1, HEX0=> HEX1);
    Displaying_2: Displaying port map (SW0=> Q2, HEX0=> HEX2);
END Behavior;