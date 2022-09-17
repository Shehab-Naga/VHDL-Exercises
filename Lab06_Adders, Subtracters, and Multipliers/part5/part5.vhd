LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE ieee.std_logic_signed.all;

ENTITY multiplier_8x8 IS
    PORT (  OPERAND1, OPERAND2: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            P: OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
        );
END multiplier_8x8;

ARCHITECTURE Behavior OF multiplier_8x8 IS
    SIGNAL OPERAND2_bit_reapeted : STD_LOGIC_VECTOR (8*8-1 DOWNTO 0);
    SIGNAL A, B, C, D, E, F, G, H, AB, CD, EF, GH, ABCD, EFGH: STD_LOGIC_VECTOR(15 DOWNTO 0);
BEGIN
    ANDING: for i in 0 to 7 generate
        OPERAND2_bit_reapeted(8 + 8*i - 1 downto 0 + i*8) <= (others => OPERAND2(i));
    end generate;

    A <= "00000000" & (OPERAND2_bit_reapeted(8 + 0*8 - 1 downto 0 + 0*8) AND OPERAND1);
    B <= "0000000" & (OPERAND2_bit_reapeted(8 + 1*8 - 1 downto 0 + 1*8) AND OPERAND1) & '0';
    C <= "000000" & (OPERAND2_bit_reapeted(8 + 2*8 - 1 downto 0 + 2*8) AND OPERAND1) & "00";
    D <= "00000" & (OPERAND2_bit_reapeted(8 + 3*8 - 1 downto 0 + 3*8) AND OPERAND1) & "000";
    E <= "0000" & (OPERAND2_bit_reapeted(8 + 4*8 - 1 downto 0 + 4*8) AND OPERAND1) & "0000";
    F <= "000" & (OPERAND2_bit_reapeted(8 + 5*8 - 1 downto 0 + 5*8) AND OPERAND1) & "00000";
    G <= "00" & (OPERAND2_bit_reapeted(8 + 6*8 - 1 downto 0 + 6*8) AND OPERAND1) & "000000";
    H <= '0' & (OPERAND2_bit_reapeted(8 + 7*8 - 1 downto 0 + 7*8) AND OPERAND1) & "0000000";

    AB <= A + B;
    CD <= C + D;
    EF <= E + F;
    GH <= G + H;
    ABCD <= AB + CD;
    EFGH <= EF + GH;
    P <= ABCD + EFGH;
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
ENTITY part5 IS
    PORT (  D_in: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            Clock, reset_n, EA, EB: IN STD_LOGIC;
            P: OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
            HEX0, HEX1, HEX2, HEX3: OUT std_logic_vector(6 downto 0);
            LEDR: OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
        );
END part5;

ARCHITECTURE Behavior OF part5 IS
    COMPONENT multiplier_8x8
        PORT (  OPERAND1, OPERAND2: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
                P: OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
            );
    END COMPONENT;
    COMPONENT Displaying 
        port (
            SW0   : IN std_logic_vector(3 downto 0);
            HEX0  : OUT std_logic_vector(6 downto 0)
        );
    END COMPONENT;
    SIGNAL A, B: STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL multiplier_out, P_reg: STD_LOGIC_VECTOR(15 DOWNTO 0);
BEGIN
    PROCESS (Clock, reset_n)
    BEGIN
        IF rising_edge(Clock) THEN
            IF (reset_n = '0') THEN
                A <= (others =>'0');
                B <= (others =>'0');
                P_reg <= (others =>'0');
            ELSE
                P_reg <= multiplier_out;
                IF (EA = '1') THEN
                    A <= D_in; 
                END IF; 
                IF (EB = '1') THEN
                    B <= D_in; 
                END IF; 
            END IF;
        END IF;
    END PROCESS;

    PROCESS (EA, EB)
    begin
        IF (EA = '1' AND EB = '0') THEN 
            LEDR <= A;
        ELSIF (EA = '0' AND EB = '1') THEN
            LEDR <= B;
        ELSE LEDR <= (others => '0');
        END IF;
    END PROCESS;

    P <= P_reg;
    multiplier_8x8_inst: multiplier_8x8 port map (OPERAND1 => A, OPERAND2 => B, P => multiplier_out);

    Displaying_0: Displaying port map (SW0=> P_reg (3 downto 0), HEX0=> HEX0);
    Displaying_1: Displaying port map (SW0=> P_reg (7 downto 4), HEX0=> HEX1);
    Displaying_2: Displaying port map (SW0=> P_reg (11 downto 8), HEX0=> HEX2);
    Displaying_3: Displaying port map (SW0=> P_reg (15 downto 12), HEX0=> HEX3);

END Behavior;