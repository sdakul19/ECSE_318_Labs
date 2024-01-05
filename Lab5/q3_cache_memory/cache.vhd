library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity cache is
	port(
		pstrobe, clk, prw : in STD_LOGIC;
		paddress : in STD_LOGIC_VECTOR(15 downto 0);
		sysdata : in STD_LOGIC_VECTOR(7 downto 0);
		pready, sysstrobe, sysrw : out STD_LOGIC := '0';
		pdata : out STD_LOGIC_VECTOR(31 downto 0);
		sysaddress : out STD_LOGIC_VECTOR(15 downto 0)
	);
end cache;

architecture behavioral of cache is

	type RAM256x32 is array (0 to 255) of STD_LOGIC_VECTOR(31 downto 0);
	type RAM256x6 is array (0 to 255) of STD_LOGIC_VECTOR(5 downto 0);
	type stateType is (S0, S1, S2, S3, S4, S5, S6);
	signal STATE : stateType := S0;

	signal data_ram : RAM256x32 := (others => (others => '0'));
	signal tag_ram : RAM256x6;
	signal address : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
	signal index : INTEGER := 0;
	begin
		process(clk)
		begin
			if rising_edge(clk) then
				case STATE is
		
					WHEN S0 =>				--Receive address
						pready <= '0';
						sysstrobe <= '0';
						sysrw <= '0';
						pdata <= (others => '0');
						sysaddress <= (others => '0');
						if pstrobe = '1' then
							address <= paddress;
							index <= to_integer(unsigned(paddress(9 downto 2)));
							STATE <= S1;
						else
							STATE <= S0;
						end if;
					WHEN S1 =>				--Check tag
						if address(15 downto 10) = tag_ram(index) then		--Tag hit, send fetched data
							pready <= '1';
							pdata <= data_ram(index);
							STATE <= S0;
						else 
							STATE <= S2;										--Tag miss
							sysstrobe <= '1';
							sysrw <= '1';	
							sysaddress <= address;		
							address <= STD_LOGIC_VECTOR(to_unsigned(to_integer(unsigned(address)) + 1, 16));				
						end if;

					WHEN S2 =>												--Send address for 1st byte
						sysaddress <= address;
						
						address <= STD_LOGIC_VECTOR(to_unsigned(to_integer(unsigned(address)) + 1, 16));
						STATE <= S3;

					WHEN S3 =>												--Send address for 2nd byte
						sysaddress <= address;
						data_ram(index) <= data_ram(index)(31 downto 8) & sysdata;
						address <= STD_LOGIC_VECTOR(to_unsigned(to_integer(unsigned(address)) + 1, 16));
						STATE <= S4;
					WHEN S4 =>												--Send address for 3rd byte
						sysaddress <= address;
						data_ram(index) <= data_ram(index)(31 downto 16) & sysdata & data_ram(index)(7 downto 0);
						STATE <= S5;
					
					WHEN S5 =>
						sysstrobe <= '0';
						sysaddress <= (others => '0');
						data_ram(index) <= data_ram(index)(31 downto 24) & sysdata & data_ram(index)(15 downto 0);
						STATE <= S6;

					WHEN S6 =>
						tag_ram(index) <= address(15 downto 10);
						data_ram(index) <= sysdata & data_ram(index)(23 downto 0);

						pready <= '1';
						pdata <= sysdata & data_ram(index)(23 downto 0);
						STATE <= S0;
					WHEN others =>
						STATE <= S0;
						pready <= '0';
				end case;
			
			end if;
		end process;
end behavioral;