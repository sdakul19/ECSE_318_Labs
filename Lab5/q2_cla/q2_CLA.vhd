entity cla is
        generic (N : integer := 4);
        port (
        a, b : in bit_vector(N - 1 downto 0);
        Cin  : in bit;
        Cout : out bit;
        sum  : out bit_vector(N - 1 downto 0)
    );
end cla;

architecture structural of cla is
        component XOR_gate is
                port (
                        i1, i2: in bit;
                        o1: out bit
                );
        end component;

        component AND_gate is
                port (
                        i1, i2: in bit;
                        o1: out bit
                );
        end component;

        component OR_gate is
                port (
                        i1, i2: in bit;
                        o1: out bit
                );
        end component;

        signal g, p, c: bit_vector(3 downto 0);

        begin
                c(0) <= Cin;

                -- bit 0
                and0: AND_gate port map(a(0), b(0), g(0));
                xor0: XOR_gate port map(a(0), b(0), p(0));
                xor1: XOR_gate port map(c(0), p(0), sum(0));

                -- bit 1
                and1: AND_gate port map(a(1), b(1), g(1));
                xor2: XOR_gate port map(a(1), b(1), p(1));
                carry1: c(1) <= g(0) or (p(0) and c(0));
                xor3: XOR_gate port map(c(1), p(1), sum(1));

                -- bit 2
                and2: AND_gate port map(a(2), b(2), g(2));
                xor4: XOR_gate port map(a(2), b(2), p(2));
                carry2: c(2) <= g(1) or (p(1) and c(1));
                xor5: XOR_gate port map(c(2), p(2), sum(2));

                -- bit 3
                and3: AND_gate port map(a(3), b(3), g(3));
                xor6: XOR_gate port map(a(3), b(3), p(3));
                carry3: c(3) <= g(2) or (p(2) and c(2));
                xor7: XOR_gate port map(c(3), p(3), sum(3));

                Cout <= g(3) or (p(3) and c(3));
end structural;