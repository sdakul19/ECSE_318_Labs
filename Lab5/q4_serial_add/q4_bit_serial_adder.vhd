library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity serial_adder is
        generic(N : integer := 8);
        port(
                a, b : in bit_vector(N - 1 downto 0);
                clk : in std_logic;
                set, clear: in bit;
                result : out bit_vector(N - 1 downto 0);
                carry : out bit
        );

end serial_adder;

architecture mixed of serial_adder is
        component fa is
                port(
                        a, b, cin : in bit;
                        cout, sum : out bit
                );
        end component;

        signal addend, augand, shift_result : bit_vector(N downto 0);
        signal cin, co, s : bit;
        signal count : integer := 0;

        begin
                adder : fa port map(addend(0), augand(0), cin, co, s);
                process(clk) begin
                        if rising_edge(clk) then
                                if(clear = '0') then
                                        cin <= '0';
                                        result <= "00000000";
                                        count <= N + 1;
                                else
                                        cin <= co;
                                end if;

                                if(set = '0') then
                                        addend <= '0' & a;
                                        augand <= '0' & b;
                                end if;

                                if(count > 0) then
                                        addend(N - 1 downto 0) <= addend(N downto 1);
                                        augand(N - 1 downto 0) <= augand(N downto 1);
                                        shift_result <= s & shift_result(N downto 1);
                                        count <= count - 1;
                                else
                                        result <= shift_result(N -1 downto 0);
                                        carry <= shift_result(N);
                                end if;
                        end if;
                end process;
end mixed;