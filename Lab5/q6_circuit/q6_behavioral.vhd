library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity q6_behavioral is
        port(
                E, W : bit;
                CLK : in std_logic;
                O: out bit
        );
end q6_behavioral;

architecture behavioral of q6_behavioral is

        signal qa, qb : bit;

        begin
                process(clk) begin
                        if rising_edge(clk) then
                                qa <= E or (qa and (not qb)) or (qa and W);
                                qb <= W or (qb and (not qa)) or (qb and E);
                        end if;
                end process;

        O <= (not qa) and (not qb);

end behavioral;

