entity mux is 
	port(
		x, y, sel : in bit;
		z : out bit
	);
end mux;

architecture behavioral of mux is

	begin
		process(x, y, sel) begin			
			if(sel = '1') then			--y is the sum calculated assuming the carry in is '1'
				z <= y;
			else 
				z <= x;				--x is the sum calculated assuming the carry in is '0'
			end if;
		end process;
end behavioral;