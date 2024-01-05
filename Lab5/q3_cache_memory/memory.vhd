library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
entity memory is
        port(
                strobe, rw_en, clk : in STD_LOGIC;
                mem_adrs : in STD_LOGIC_VECTOR(15 downto 0);
                reset : in STD_LOGIC;
		data_in : in STD_LOGIC_VECTOR(7 downto 0);
                data_out: out STD_LOGIC_VECTOR(7 downto 0) := (others => '0')
        );
end memory;

architecture behavioral of memory is
	type memory is array (0 to 65535) of STD_LOGIC_VECTOR(7 downto 0);
        signal mem : memory := (others => (others => '0'));
        begin
                process(clk, reset) begin
			if reset = '1' then
				--assign data for 2'h10 == 16'b00000_0001_0000_00 to four consecutive spots in memory
				mem(64)	<= "00000001";
				mem(65) <= "00000001";
				mem(66) <= "00000001";
				mem(67) <= "00000001";

				--assign data for 2'h20 == 16'b00000_0010_0000_00 to four consecutive spots in memory
				mem(128) <= "00000010";
				mem(129) <= "00000010";
				mem(130) <= "00000010";
				mem(131) <= "00000010";
		
				--assign data for 2'h31 == 16'b00000_0011_0000_00 to four consecutive spots in memory
				mem(196) <= "00000100";
				mem(197) <= "00000100";
				mem(198) <= "00000100";
				mem(199) <= "00000100";

				--assign data for 2'h80 == 16'b00000_1000_0000_00 to four consecutive spots in memory
				mem(512) <= "00001000";
				mem(513) <= "00001000";
				mem(514) <= "00001000";
				mem(515) <= "00001000";

				--assign data for 2'h51 == 16'b00000_0101_0001_00 to four consecutive spots in memory
				mem(324) <= "00010000";
				mem(325) <= "00010000";
				mem(326) <= "00010000";
				mem(327) <= "00010000";
				
				--assign data for 2'h57 == 16'b00000_0101_0111_00 to four consecutive spots in memory
				mem(348) <= "00100000";
				mem(349) <= "00100000";
				mem(350) <= "00100000";
				mem(351) <= "00100000";

				--assign data for 2'h58 == 16'b00000_0101_1000_00 to four consecutive spots in memory
				mem(352) <= "01000000";
				mem(353) <= "01000000";			
				mem(354) <= "01000000";
				mem(355) <= "01000000";
				
				--assign data for 2'h59 == 16'b00000_0101_1001_00 to four consecutive spots in memory
				mem(356) <= "10000000";
				mem(357) <= "10000000";
				mem(358) <= "10000000";
				mem(359) <= "10000000";

          		elsif rising_edge(clk) then
                                if (strobe = '1') then --cache is sending address
                                        if (rw_en = '1') then  --read
                                                data_out <= mem(to_integer(unsigned(mem_adrs)));
					else
						mem(to_integer(unsigned(mem_adrs))) <= data_in;
                                        end if;
                                end if;
                        end if;
		end process;
end behavioral;