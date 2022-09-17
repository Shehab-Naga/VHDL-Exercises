LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE ieee.std_logic_signed.all;

ENTITY Full_Adder IS
    GENERIC ( n : NATURAL := 8);
    PORT (  A, B: IN STD_LOGIC_VECTOR(n-1 DOWNTO 0);
            carry_in, add_sub: IN STD_LOGIC;
            sum: OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0);
            carry:OUT STD_LOGIC
        );
END Full_Adder;

ARCHITECTURE Behavior OF Full_Adder IS
    SIGNAL carry_sum : STD_LOGIC_VECTOR(n DOWNTO 0);
BEGIN
    process (A, B, carry_in, add_sub)
    BEGIN
        IF add_sub = '0' THEN 
            carry_sum <= ('0' & A) + ('0' & B) + (0 => carry_in, 8 downto 1 => '0');
            sum <= carry_sum (n-1 DOWNTO 0);
            carry <= carry_sum (n);
        ELSE 
            carry_sum <= ('0' & A) - ('0' & B) - (0 => carry_in, 8 downto 1 => '0');
            sum <= carry_sum (n-1 DOWNTO 0);
            carry <= carry_sum (n);
        END IF;
    END PROCESS;
END Behavior;
---------------------------------------------------------------------------------
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
    else "0000000" when SW0 = "1011"
    else "1000110" when SW0 = "1100"
    else "1000000" when SW0 = "1101"
    else "1000110" when SW0 = "1110"
    else "1001110" when SW0 = "1111"
    else (Others => '1');    


end architecture rtl;
-----------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE ieee.std_logic_signed.all;

ENTITY part2 IS
    GENERIC ( n : NATURAL := 8);
    PORT (  A: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            Clock, reset_n, add_sub: IN STD_LOGIC;
            S, adder: OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
            carry, overflow: OUT STD_LOGIC;
            HEX0, HEX1, HEX2, HEX3: OUT std_logic_vector(6 downto 0)
        );
END part2;

ARCHITECTURE Behavior OF part2 IS
    COMPONENT Full_Adder
        GENERIC ( n : NATURAL := 8);
        PORT (  A, B: IN STD_LOGIC_VECTOR(n-1 DOWNTO 0);
                carry_in, add_sub: IN STD_LOGIC;
                sum: OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0);
                carry:OUT STD_LOGIC
            );
    END COMPONENT;
    COMPONENT Displaying 
        port (
            SW0   : IN std_logic_vector(3 downto 0);
            HEX0  : OUT std_logic_vector(6 downto 0)
        );
    END COMPONENT;
    SIGNAL A_reg, adder_output, S_reg: STD_LOGIC_VECTOR (7 DOWNTO 0);
    SIGNAL adder_carry: STD_LOGIC;
BEGIN

    Full_Adder0: Full_Adder GENERIC MAP ( n => 8) PORT MAP(A => A_reg, B => S_reg, add_sub=> add_sub, sum => adder_output, carry_in => '0', carry => adder_carry);
    adder <= adder_output;
    PROCESS (Clock, reset_n)
    BEGIN
        IF (reset_n = '0') THEN
            A_reg           <= (others =>'0');
            S_reg           <= (others =>'0');
        ELSIF rising_edge(Clock) THEN
            A_reg <= A;
            S_reg <= adder_output;
            carry <= adder_carry;
            IF (A_reg(7) = '0' AND S_reg(7) = '0' AND adder_output(7) = '1') OR (A_reg(7) = '1' AND S_reg(7) = '1' AND adder_output(7) = '0') THEN
                    overflow <= '1'; 
            ELSE    overflow <= '0';
            END IF; 
        END IF;
    END PROCESS;
    S <= S_reg;

    Displaying_0: Displaying port map (SW0=> A (3 downto 0), HEX0=> HEX0);
    Displaying_1: Displaying port map (SW0=> A (7 downto 4), HEX0=> HEX1);
    Displaying_2: Displaying port map (SW0=> S_reg (3 downto 0), HEX0=> HEX2);
    Displaying_3: Displaying port map (SW0=> S_reg (7 downto 4), HEX0=> HEX3);

END Behavior;