library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity q6_structural is
        port(
                E, W : in bit;
                CLK : in std_logic;
                O: out bit
        );
end q6_structural;

architecture structural of q6_structural is

        component dff
                port(
                        d : in bit;
                        clk : in std_logic;
                        q : out bit
                );
        end component;

        signal g1, g2, g3, g4, g5, g6, QA, QB, nQA, nQB : bit;

        begin
                dff_A : dff port map(g3, CLK, QA);
                dff_B : dff port map(g6, CLK, QB);

                nQA <= not QA;
                nQB <= not QB;

                g1 <= QA and nQB;
                g2 <= QA and W;
                g3 <= E or g1 or g2;

                g4 <= QB and nQA;
                g5 <= QB and E;
                g6 <= W or g4 or g5;

                O <= nQA and nQB;

end structural;