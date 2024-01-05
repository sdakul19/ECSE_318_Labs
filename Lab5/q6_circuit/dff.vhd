library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity dff is
        port(
                d : in bit;
                clk : in std_logic;
                q : out bit);
end dff;

architecture behavioral of dff is
        begin
                process(clk)begin
                        if rising_edge(clk) then
                                q <= d;
                        end if;
                end process;
end behavioral;