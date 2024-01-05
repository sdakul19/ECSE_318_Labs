entity csa is
        generic(N : integer := 8);
        port(
                a, b, Cin : in bit_vector (N - 1 downto 0);
                Cout, sum : out bit_vector (N - 1 downto 0)
        );
end csa;

architecture behavioral of csa is
        begin
                Cout <= (a and b) or (a and Cin) or (b and Cin);
                sum <= a xor b xor Cin;
end behavioral;