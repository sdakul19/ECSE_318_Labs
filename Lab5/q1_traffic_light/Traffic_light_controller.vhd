library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity traffic_light is
	port(
		clk : in STD_LOGIC;				--Clock Signal
		sa, sb : in STD_LOGIC;				--Street A and Street B signals that turn to '1' when there is a car on the respective street
		ga, ya, ra, gb, yb, rb : out STD_LOGIC		--Green, Yellow, Red signals for street A and street B
	);

end traffic_light;

architecture behavior of traffic_light is
	type StateType is (S0, S1, S2, S3, S4, S5, S6, S7, S8, S9, S10, S11, S12);
	signal STATE : StateType;
	begin
		process(clk) begin
			if rising_edge(clk) then
				case STATE is

					WHEN S0 =>				--Initial state when there are no cars or when there is a car on street A, street A has a green light
						ga <= '1';
						ya <= '0';
						ra <= '0';
						gb <= '0';
						yb <= '0';
						rb <= '1';
						STATE <= S1;

					WHEN S1 =>				--Street A stays green
						ga <= '1';
						ya <= '0';
						ra <= '0';
						gb <= '0';
						yb <= '0';
						rb <= '1';
						STATE <= S2;
					WHEN S2 =>				--Street A stays green
						ga <= '1';
						ya <= '0';
						ra <= '0';
						gb <= '0';
						yb <= '0';
						rb <= '1';
						STATE <= S3;
					WHEN S3 =>				--Street A stays green
						ga <= '1';	
						ya <= '0';
						ra <= '0';
						gb <= '0';
						yb <= '0';
						rb <= '1';
						STATE <= S4;
					WHEN S4 =>				--Street A stays green
						ga <= '1';
						ya <= '0';
						ra <= '0';
						gb <= '0';
						yb <= '0';
						rb <= '1';
						STATE <= S5;
					WHEN S5 =>				--Street A stays green if there is no car on street B
						ga <= '1';
						ya <= '0';
						ra <= '0';
						gb <= '0';
						yb <= '0';
						rb <= '1';
						if(sb = '1') then
							STATE <= S6;
						else
							STATE <= S5;
						end if;
					WHEN S6 =>				--Street A light turns yellow
						ga <= '0';
						ya <= '1';
						ra <= '0';
						gb <= '0';
						yb <= '0';
						rb <= '1';
						STATE <= S7;
					WHEN S7 =>
						ga <= '0';
						ya <= '0';
						ra <= '1';
						gb <= '1';
						yb <= '0';
						rb <= '0';
						STATE <= S8;
					WHEN S8 =>				--Street A turns red and street B turns green
						ga <= '0';
						ya <= '0';
						ra <= '1';
						gb <= '1';
						yb <= '0';
						rb <= '0';
						STATE <= S9;
					WHEN S9 =>				--Street B stays green
						ga <= '0';
						ya <= '0';
						ra <= '1';
						gb <= '1';
						yb <= '0';
						rb <= '0';
						STATE <= S10;
					WHEN S10 =>				--Street B stays green
						ga <= '0';
						ya <= '0';
						ra <= '1';
						gb <= '1';
						yb <= '0';
						rb <= '0';
						STATE <= S11;
					WHEN S11 =>				--Street B stays green if they are no cars on street A and there are cars on street B
						ga <= '0';
						ya <= '0';
						ra <= '1';
						gb <= '1';
						yb <= '0';
						rb <= '0';
						if((sa or (not sb)) = '1') then
							STATE <= S12;
						elsif(((not sa) and sb) = '1') then
							STATE <= S11;
						end if;
					WHEN S12 =>				--Street B light turns yellow
						ga <= '0';
						ya <= '0';
						ra <= '1';
						gb <= '0';
						yb <= '1';
						rb <= '0';
						STATE <= S0;
					WHEN others =>
						STATE <= S0;
				end case;
			end if;
		end process;
end behavior;
