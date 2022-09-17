LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY part2 IS
    PORT (  Clock, reset_n, w : IN std_logic;
            state: OUT STD_LOGIC_VECTOR (3 downto 0);
            z : OUT std_logic);
END part2;

ARCHITECTURE Behavior OF part2 IS
    TYPE State_type IS (A, B, C, D, E, F, G, H, I);
    -- Attribute to declare a specific encoding for the states
    attribute syn_encoding : string;
    attribute syn_encoding of State_type : type is "0000 0001 0010 0011 0100 0101 0110 0111 1000";
    SIGNAL y_Q, Y_D : State_type; -- y_Q is present state, y_D is next state
BEGIN
    PROCESS (w, y_Q) -- state table
    BEGIN
        case y_Q IS
            WHEN A =>
                state <= "0000"; 
                IF (w = '0') THEN Y_D <= B;
                ELSE Y_D <= F;
                END IF;

            WHEN B => 
            state <= "0001"; 
            IF (w = '0') THEN Y_D <= C;
            ELSE Y_D <= F;
            END IF;

            WHEN C => 
            state <= "0010"; 
            IF (w = '0') THEN Y_D <= D;
            ELSE Y_D <= F;
            END IF;
            
            WHEN D => 
            state <= "0011"; 
            IF (w = '0') THEN Y_D <= E;
            ELSE Y_D <= F;
            END IF;

            WHEN E => 
            state <= "0100"; 
            IF (w = '0') THEN Y_D <= E;
            ELSE Y_D <= F;
            END IF;

            WHEN F => 
            state <= "0101"; 
            IF (w = '1') THEN Y_D <= G;
            ELSE Y_D <= B;
            END IF;
            
            WHEN G => 
            state <= "0110"; 
            IF (w = '1') THEN Y_D <= H;
            ELSE Y_D <= B;
            END IF;
            
            WHEN H => 
            state <= "0111"; 
            IF (w = '1') THEN Y_D <= I;
            ELSE Y_D <= B;
            END IF;

            WHEN I => 
            state <= "1000"; 
            IF (w = '1') THEN Y_D <= I;
            ELSE Y_D <= B;
            END IF;
        END CASE;
    END PROCESS; -- state table

    PROCESS (Clock) -- state flip-flops
   
	BEGIN
	if rising_edge (clock) THEN

        if (reset_n = '0') THEN 
            y_Q <=A;
        ELSe 
            y_Q <= y_D;
        END IF;
		  END IF;
    END PROCESS;
    z <= '1' when y_Q = E OR y_Q = I
    else '0';
END Behavior;