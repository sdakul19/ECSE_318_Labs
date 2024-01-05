entity AND_gate is
        port (
                i1, i2 : in bit;
                o1 : out bit);
end AND_gate;

architecture behavioral of AND_gate is
        begin
                o1 <= i1 and i2 after 10 ns;
end behavioral;