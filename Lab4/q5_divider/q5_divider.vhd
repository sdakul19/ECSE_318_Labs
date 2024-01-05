library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity divider_FSM is
    port (
        start, clk: in std_logic;
        divisor, dividend : in std_logic_vector (3 downto 0);
        quotient, remainder : out std_logic_vector (3 downto 0)
    );
end divider_FSM;

architecture structural of divider_FSM is

    signal a_reg, m_reg, q_reg : std_logic_vector (3 downto 0);
    signal a_reset, a_load, m_load, q_load, a_shift, q_shift, addsub, q_lsb : std_logic;
    signal STATE : std_logic_vector (2 downto 0);
    signal count : integer := 0;

    constant S0 : std_logic_vector (2 downto 0) := "000";
    constant S1 : std_logic_vector (2 downto 0) := "001";
    constant S2 : std_logic_vector (2 downto 0) := "010";
    constant S3 : std_logic_vector (2 downto 0) := "011";
    constant S4 : std_logic_vector (2 downto 0) := "100";
    constant S5 : std_logic_vector (2 downto 0) := "101";
    constant S6 : std_logic_vector (2 downto 0) := "110";


    begin


        a_reg <= "0000" when a_reset = '1' else
             (a_reg(2 downto 0) & q_reg(0)) when a_shift = '1' else
             (a_reg + m_reg) when a_load = '1' and addsub = '1' else
             (a_reg - m_reg) when a_load = '1' and addsub = '0' else
             a_reg;

        q_reg <= dividend when q_load = '1' else
             (q_reg(2 downto 0) & '0') when q_shift = '1' else
             q_reg;

        m_reg <= divisor when m_load = '1' else
             m_reg;

        q_reg(0) <= '0' when q_lsb = '1' and a_reg(3) = '1' else
             '1' when q_lsb = '1' and a_reg(3) = '0' else
             q_reg(0);

        process(clk) begin
            if rising_edge(clk) then
                case STATE is
                    when S0 =>
                        if start = '1' then
                                count <= 4;
                                a_reset <= '1';
                                m_load <= '1';
                                q_load <= '1';
                                q_lsb <= '0';
                                a_shift <= '0';
                                q_shift <= '0';
                                STATE <= S1;
                        end if;

                    when S1 =>
                        if count > 0 then
                                a_reset <= '0';
                                m_load <= '0';
                                q_load <= '0';
                                a_load <= '0';
                                q_lsb <= '0';
                                addsub <= '0';
                                a_shift <= '1';
                                count <= count - 1;
                                STATE <= S2;
                        else
                                STATE <= S0;
                        end if;

                    when S2 =>
                        a_shift <= '0';
                        q_shift <= '1';
                        addsub <= '0';
                        a_load <= '1';
                        STATE <= S3;

                    when S3 =>
                        a_load <= '0';
                        q_shift <= '0';
                        if a_reg(4 - 1) = '1' then
                            STATE <= S4;
                        else
                            STATE <= S6;
                        end if;

                    when S4 =>
                        q_lsb <= '1';
                        STATE <= S5;

                    when S5 =>
                        q_lsb <= '0';
                        addsub <= '1';
                        a_load <= '1';
                        STATE <= S1;

                    when S6 =>
                        q_lsb <= '1';
                        STATE <= S1;

                    when others =>
                        null;
                end case;
            end if;
        end process;

        remainder <= a_reg;
        quotient <= q_reg;

end structural;

