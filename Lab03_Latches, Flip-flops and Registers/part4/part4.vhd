LIBRARY ieee;
USE ieee.std_logic_1164.all;
ENTITY part4 IS
    PORT (
        D, Clk      : IN std_logic;
        Qa, Qb, Qc  : OUT std_logic
    );
END part4;

ARCHITECTURE structure OF part4 IS
    COMPONENT part2
    PORT (  D, Clk : IN STD_LOGIC ;
            Q : OUT STD_LOGIC);
    END COMPONENT;
    COMPONENT part3
        PORT (  D, Clk : IN STD_LOGIC ;
                Q : OUT STD_LOGIC) ;
    END COMPONENT;
    SIGNAL Clk_bar: std_logic;
BEGIN
    latch   : part2 port map (D => D, Clk => Clk,       Q => Qa);
    pos_ff  : part3 port map (D => D, Clk => Clk,       Q => Qb);
    neg_ff  : part3 port map (D => D, Clk => Clk_bar,   Q => Qc);
    Clk_bar <= NOT Clk;
END structure;