entity q3_csa is
        port(
                n1, n2, n3, n4, n5, n6, n7, n8, n9, n10 : in bit_vector (7 downto 0);
                sum : out bit_vector (15 downto 0)
        );
end q3_csa;

architecture structural of q3_csa is

        component csa is
                generic(N : integer := 8);
                port (
                        a, b, Cin : in bit_vector (N - 1 downto 0);
                        Cout, sum : out bit_vector(N - 1 downto 0)
                );

        end component;

        component fa is
                port (
                        a, b, Cin : in bit;
                        Cout, sum : out bit
                );
        end component;

        signal sf : bit_vector(14 downto 0);
        signal co : bit_vector(14 downto 0);
        signal s1, c1 : bit_vector(7 downto 0);
        signal s2, c2, s1cat, c1cat : bit_vector(8 downto 0);
        signal s3, c3, s2cat, c2cat : bit_vector(9 downto 0);
        signal s4, c4, s3cat, c3cat : bit_vector(10 downto 0);
        signal s5, c5, s4cat, c4cat : bit_vector(11 downto 0);
        signal s6, c6, s5cat, c5cat : bit_vector(12 downto 0);
        signal s7, c7, s6cat, c6cat : bit_vector(13 downto 0);
        signal s8, c8, s7cat, c7cat : bit_vector(14 downto 0);

        signal n4cat : bit_vector(8 downto 0);
        signal n5cat : bit_vector(9 downto 0);
        signal n6cat : bit_vector(10 downto 0);
        signal n7cat : bit_vector(11 downto 0);
        signal n8cat : bit_vector(12 downto 0);
        signal n9cat : bit_vector(13 downto 0);
        signal n10cat : bit_vector(14 downto 0);

        begin
                csa1 : csa generic map(8) port map(n1, n2, n3, c1, s1);

                c1cat <= c1 & '0';
                n4cat <= '0' & n4;
                s1cat <= '0' & s1;
                csa2 : csa generic map(9) port map(c1cat, n4cat, s1cat, c2, s2);

                c2cat <= c2 & '0';
                n5cat <= "00" & n5;
                s2cat <= '0' & s2;
                csa3 : csa generic map(10) port map(c2cat, n5cat, s2cat, c3, s3);

                c3cat <= c3 & '0';
                n6cat <= "000" & n6;
                s3cat <= '0' & s3;
                csa4: csa generic map(11) port map(c3cat, n6cat, s3cat, c4, s4);

                c4cat <= c4 & '0';
                n7cat <= "0000" & n7;
                s4cat <= '0' & s4;
                csa5: csa generic map(12) port map(c4cat, n7cat, s4cat, c5, s5);

                c5cat <= c5 & '0';
                n8cat <= "00000" & n8;
                s5cat <= '0' & s5;
                csa6: csa generic map(13) port map(c5cat, n8cat, s5cat, c6, s6);

                c6cat <= c6 & '0';
                n9cat <= "000000" & n9;
                s6cat <= '0' & s6;
                csa7: csa generic map(14) port map(c6cat, n9cat, s6cat, c7, s7);

                c7cat <= c7 & '0';
                n10cat <= "0000000" & n10;
                s7cat <= '0' & s7;
                csa8: csa generic map(15) port map(c7cat, n10cat, s7cat, c8, s8);

                fa0 : fa port map('0','0',s8(0),co(0),sf(0));
                fa1 : fa port map(co(0), c8(0), s8(1), co(1), sf(1));
                fa2 : fa port map(co(1), c8(1), s8(2), co(2), sf(2));
                fa3 : fa port map(co(2), c8(2), s8(3), co(3), sf(3));
                fa4 : fa port map(co(3), c8(3), s8(4), co(4), sf(4));
                fa5 : fa port map(co(4), c8(4), s8(5), co(5), sf(5));
                fa6 : fa port map(co(5), c8(5), s8(6), co(6), sf(6));
                fa7 : fa port map(co(6), c8(6), s8(7), co(7), sf(7));
                fa8 : fa port map(co(7), c8(7), s8(8), co(8), sf(8));
                fa9 : fa port map(co(8), c8(8), s8(9), co(9), sf(9));
                fa10 : fa port map(co(9), c8(9), s8(10), co(10), sf(10));
                fa11 : fa port map(co(10), c8(10), s8(11), co(11), sf(11));
                fa12 : fa port map(co(11), c8(11), s8(12), co(12), sf(12));
                fa13 : fa port map(co(12), c8(12), s8(13), co(13), sf(13));
                fa14 : fa port map(co(13), c8(13), s8(14), co(14), sf(14));

                sum <= co(14) & sf;

end structural;