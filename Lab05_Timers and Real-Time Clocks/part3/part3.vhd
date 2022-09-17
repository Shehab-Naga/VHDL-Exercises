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
    PORT (  clock, En, Load : IN STD_LOGIC;
            data_in: IN STD_LOGIC_VECTOR(n-1 downto 0);
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
            IF (Load = '1') THEN
                value <= data_in;
            ELSIF ((value < k-1) AND (En = '1')) THEN
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

ENTITY part3 IS
    PORT (  clock, reset_n, KEY0, KEY1          : IN STD_LOGIC;
            preset_SW                           : IN STD_LOGIC_VECTOR(7 downto 0);
            HEX0, HEX1, HEX2, HEX3, HEX4, HEX5  : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
        );
END part3;

ARCHITECTURE Behavior OF part3 IS
    COMPONENT counter
        GENERIC ( n : NATURAL := 4 ; k: NATURAL := 16);
        PORT (  clock, En, Load : IN STD_LOGIC;
            data_in: IN STD_LOGIC_VECTOR(n-1 downto 0);
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
    SIGNAL En0, En1, En2, En3, En4, En5, En6: STD_LOGIC;
    SIGNAL rollover_counter0, rollover_counter1, rollover_counter2, rollover_counter3, rollover_counter4, rollover_counter5: STD_LOGIC;
    SIGNAL Q1, Q2, Q3, Q4, Q5, Q6: std_logic_vector(3 downto 0);
BEGIN
    -- one hundredth of second counter
    Counter_0: counter GENERIC MAP ( n => 26 , k => 500000) PORT MAP(clock => clock, En => En0, Load => '0', data_in => (others => '0'), reset_n => reset_n,           rollover => rollover_counter0);
    En0 <= NOT(KEY0);
    -- hundredth
    Counter_1: counter GENERIC MAP ( n => 4 , k => 10)      PORT MAP(clock => clock, En => En1, Load => '0', data_in => (others => '0'), reset_n => reset_n, Q=> Q1,   rollover => rollover_counter1);
    En1 <= NOT(KEY0) AND rollover_counter0;
    Counter_2: counter GENERIC MAP ( n => 4 , k => 10)      PORT MAP(clock => clock, En => En2, Load => '0', data_in => (others => '0'), reset_n => reset_n, Q => Q2,  rollover => rollover_counter2);
    En2 <= NOT(KEY0) AND rollover_counter0 AND rollover_counter1;
    -- second
    Counter_3: counter GENERIC MAP ( n => 4 , k => 10)      PORT MAP(clock => clock, En => En3, Load => '0', data_in => (others => '0'), reset_n => reset_n, Q=> Q3,   rollover => rollover_counter3);
    Counter_4: counter GENERIC MAP ( n => 4 , k => 6)       PORT MAP(clock => clock, En => En4, Load => '0', data_in => (others => '0'), reset_n => reset_n, Q => Q4,  rollover => rollover_counter4);
    En3 <= NOT(KEY0) AND rollover_counter0 AND rollover_counter1 AND rollover_counter2;
    En4 <= NOT(KEY0) AND rollover_counter0 AND rollover_counter1 AND rollover_counter2 AND rollover_counter3;
    -- minutes
    Counter_5: counter GENERIC MAP ( n => 4 , k => 10)      PORT MAP(clock => clock, En => En5, Load => KEY1, data_in => preset_SW (3 downto 0), reset_n => reset_n, Q=> Q5,   rollover => rollover_counter5);
    Counter_6: counter GENERIC MAP ( n => 4 , k => 6)       PORT MAP(clock => clock, En => En6, Load => KEY1, data_in => preset_SW (7 downto 4), reset_n => reset_n, Q => Q6);
    En5 <= NOT(KEY0) AND rollover_counter0 AND rollover_counter1 AND rollover_counter2 AND rollover_counter3 AND rollover_counter4;
    En6 <= NOT(KEY0) AND rollover_counter0 AND rollover_counter1 AND rollover_counter2 AND rollover_counter3 AND rollover_counter4 AND rollover_counter5;

    Displaying_0: Displaying port map (SW0=> Q1, HEX0=> HEX0);
    Displaying_1: Displaying port map (SW0=> Q2, HEX0=> HEX1);

    Displaying_2: Displaying port map (SW0=> Q3, HEX0=> HEX2);
    Displaying_3: Displaying port map (SW0=> Q4, HEX0=> HEX3);

    Displaying_4: Displaying port map (SW0=> Q5, HEX0=> HEX4);
    Displaying_5: Displaying port map (SW0=> Q6, HEX0=> HEX5);
END Behavior;