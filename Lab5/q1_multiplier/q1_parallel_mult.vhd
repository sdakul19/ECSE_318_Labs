entity multiplier is
        generic (N : integer := 4);
        port (
        X, Y: in bit_VECTOR(N - 1 downto 0);
        P: out bit_VECTOR((2*N - 1) downto 0)
    );
end multiplier;

architecture Structural of multiplier is

        component ha is
                port (
                        a, b : in bit;
                        cout, sum : out bit
        );
        end component;

        component fa is
                port (
                        a, b, cin : in bit;
                        cout, sum : out bit
        );
        end component;

        signal c : bit_vector(10 downto 0);
        signal s : bit_vector(5 downto 0);
        signal xy : bit_vector(15 downto 0);

        begin
                xy(0) <= X(0) and Y(0);
                xy(1) <= X(0) and Y(1);
                xy(2) <= X(1) and Y(0);
                xy(3) <= X(1) and Y(1);
                xy(4) <= X(2) and Y(0);
                xy(5) <= X(0) and Y(2);
                xy(6) <= X(1) and Y(2);
                xy(7) <= X(2) and Y(1);
                xy(8) <= X(2) and Y(2);
                xy(9) <= X(0) and Y(3);
                xy(10) <= X(3) and Y(0);
                xy(11) <= X(1) and Y(3);
                xy(12) <= X(3) and Y(1);
                xy(13) <= X(2) and Y(3);
                xy(14) <= X(3) and Y(2);
                xy(15) <= X(3) and Y(3);

                P(0) <= xy(0);

                ha1: ha port map(xy(1), xy(2), c(0), P(1));

                ha2: ha port map(xy(3), xy(4), c(1), s(0));
                fa1: fa port map(s(0), xy(5), c(0), c(2), P(2));

                ha3: ha port map(xy(7), xy(10),c(3), s(1));
                fa2: fa port map(c(1), xy(6), s(1), c(4), s(2));
                fa3: fa port map(xy(9), c(2), s(2), c(5), P(3));

                fa4: fa port map(c(3), xy(8), xy(12), c(6), s(3));
                fa5: fa port map(xy(11), c(4), s(3), c(7), s(4));
                ha4: ha port map(c(5), s(4), c(8), P(4));

                fa6: fa port map(c(6), xy(13), xy(14), c(9), s(5));
                fa7: fa port map(c(8), c(7), s(5), c(10), P(5));

                fa8: fa port map(c(10), c(9), xy(15), P(7), P(6));

end Structural;