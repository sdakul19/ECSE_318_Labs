entity div is
        port(   
                dr, dd : in bit_vector( 3 downto 0);
                q, r : out bit_vector(3 downto 0));
end div;

architecture structural of div is

        component ctrl_addsub
                port (
                        A,B,Cin,Ctrl : in bit;
                        S,Cout : out bit);
        end component;
        component inv
                port (
                        A : in bit;
                        nA : out bit);
        end component;

        signal ctrl3, ctrl2, ctrl1, out36, out35, out34, out33, out25, out24, out23, out22, out14, out13, out12, out11, co36, co35, co34, co33, co25, co24, co23, co22, co14, co13, co12, co11, co03, co02, co01, co00, out00, out01, out02, out03 : bit;

        begin

                -- Quotient(3)
                cas33 : ctrl_addsub port map('1', dd(3), '1', dr(0), out33, co33);
                cas34 : ctrl_addsub port map('1', '0', co33, dr(1), out34, co34);
                cas35 : ctrl_addsub port map('1', '0', co34, dr(2), out35, co35);
                cas36 : ctrl_addsub port map('1', '0', co35, dr(3), out36, co36);
                inv3: inv port map(out36, q(3));
                inv30: inv port map(out36, ctrl3);

                -- Quotient(2)
                cas25 : ctrl_addsub port map(ctrl3, out35, co24, dr(3), out25, co25);
                cas24 : ctrl_addsub port map(ctrl3, out34, co23, dr(2), out24, co24);
                cas23 : ctrl_addsub port map(ctrl3, out33, co22, dr(1), out23, co23);
                cas22 : ctrl_addsub port map(ctrl3, dd(2), ctrl3, dr(0), out22, co22);
                inv2: inv port map(out25, q(2));
                inv20: inv port map(out25, ctrl2);

                -- Quotient(1)
                cas14 : ctrl_addsub port map(ctrl2, out24, co13, dr(3), out14, co14);
                cas13 : ctrl_addsub port map(ctrl2, out23, co12, dr(2), out13, co13);
                cas12 : ctrl_addsub port map(ctrl2, out22, co11, dr(1), out12, co12);
                cas11 : ctrl_addsub port map(ctrl2, dd(1), ctrl2, dr(0), out11, co11);
                inv1: inv port map(out14, q(1));
                inv10: inv port map(out14, ctrl1);

                -- Quotient(0)
                cas03 : ctrl_addsub port map(ctrl1, out13, co02, dr(3), out03, co03);
                cas02 : ctrl_addsub port map(ctrl1, out12, co01, dr(2), out02, co02);
                cas01 : ctrl_addsub port map(ctrl1, out11, co00, dr(1), out01, co01);
                cas00 : ctrl_addsub port map(ctrl1, dd(0), ctrl1, dr(0), out00, co00);
                inv0: inv port map(out03, q(0));

                --Remainder(3 downto 0)
                r(3) <= out03;
                r(2) <= out02;
                r(1) <= out01;
                r(0) <= out00;

end structural;