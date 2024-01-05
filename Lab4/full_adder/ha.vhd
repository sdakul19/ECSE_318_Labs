entity ha is
        port (
                a, b: in bit;
                cout, sum : out bit);
end ha;

architecture behavioral of ha is
        begin
                cout <= a and b;
                sum <= a xor b;
end behavioral;
