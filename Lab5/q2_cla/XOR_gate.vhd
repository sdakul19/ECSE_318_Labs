entity XOR_gate is
        port (
                i1, i2 : in bit;
                o1 : out bit);
end XOR_gate;

architecture behavioral of XOR_gate is
        begin
                o1 <= i1 xor i2 after 10 ns;
end behavioral;