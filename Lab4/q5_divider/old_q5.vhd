library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity q5_divider is
    Port (
        start : in STD_LOGIC;
        clk : in STD_LOGIC;
        divisor : in STD_LOGIC_VECTOR(3 downto 0);
        dividend : in STD_LOGIC_VECTOR(3 downto 0);
        remainder : out STD_LOGIC_VECTOR(3 downto 0);
        quotient : out STD_LOGIC_VECTOR(3 downto 0)
    );
end q5_divider;

architecture Behavioral of q5_divider is
    constant N : integer := 4;

    signal rega, regm, regq : STD_LOGIC_VECTOR(N-1 downto 0);
    signal q3 : STD_LOGIC;
    signal state : STD_LOGIC_VECTOR(1 downto 0);
    signal count : integer := 0;

begin
    process(clk)
    begin
        if rising_edge(clk) then
            case state is
                when "00" =>
                    if start = '1' then
                        rega <= "0000";
                        regm <= divisor;
                        regq <= dividend;
                        state <= "01";
                    end if;

                when "01" =>
                    for count in N downto 1 loop
                        q3 <= regq(3);
                        rega <= rega(N-2 downto 0) & q3;
                        regq <= regq(N-2 downto 0) & '0';
                        rega <= rega - regm;

                        if rega(N-1) = '1' then
                            regq(0) <= '0';
                            rega <= rega + regm;
                        elsif rega(N-1) = '0' then
                            regq(0) <= '1';
                        end if;
                    end loop;

                    state <= "10";

                when others =>
                    null; -- Do nothing for other states
            end case;
        end if;
    end process;

    quotient <= regq;
    remainder <= rega;

end Behavioral;