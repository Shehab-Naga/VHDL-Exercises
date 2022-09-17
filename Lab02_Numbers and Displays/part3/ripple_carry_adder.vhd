----------------------------------------------------
--         Lab2 Part 3: ripple_carry_adder        --
----------------------------------------------------
----------------------------------------------------
--             full adder subcircuit              --
----------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
ENTITY full_adder IS
    PORT (
        a, b, c_in  : IN std_logic;
        s, c_out    : OUT std_logic
    );
END full_adder;

ARCHITECTURE behavior OF full_adder IS
    signal z : std_logic;
BEGIN
    s <= a xor b xor c_in;
    z <= a xor b;
    c_out <= b      when z = '0' else
            c_in    when z = '1';

END behavior;
----------------------------------------------------
--          ripple-carry adder circuit            --
----------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
ENTITY ripple_carry_adder IS
    PORT (
        a, b     : IN std_logic_vector(3 downto 0);
        c_in     : IN std_logic;
        s        : OUT std_logic_vector(3 downto 0);
        c_out    : OUT std_logic
    );
END ripple_carry_adder;

ARCHITECTURE structure OF ripple_carry_adder IS
    COMPONENT full_adder
        PORT (
            a, b, c_in  : IN std_logic;
            s, c_out    : OUT std_logic
        );
    END COMPONENT;
    SIGNAL c1, c2, c3: std_logic;
BEGIN
    full_adder0: full_adder port map(a=>a(0), b=>b(0), c_in=>c_in,  s=>s(0), c_out=>c1);
    full_adder1: full_adder port map(a=>a(1), b=>b(1), c_in=>c1,    s=>s(1), c_out=>c2);
    full_adder2: full_adder port map(a=>a(2), b=>b(2), c_in=>c2,    s=>s(2), c_out=>c3);
    full_adder3: full_adder port map(a=>a(3), b=>b(3), c_in=>c3,    s=>s(3), c_out=>c_out);
END structure;