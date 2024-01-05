entity ripple_carry is 
	port(
		a, b : in bit_vector(15 downto 0);
		sum : out bit_vector(15 downto 0);
		carry : out bit
	);
	
	
end ripple_carry;

architecture gate_level of ripple_carry is
	component fa port(
		a, b, cin : in bit;
		cout, sum : out bit
	);
	end component;

	signal c : bit_vector(15 downto 0);

	begin
		--Bits [3:0]
		fa0 : fa port map(a(0), b(0), '0', c(0), sum(0));
		fa1 : fa port map(a(1), b(1), c(0), c(1), sum(1));
		fa2 : fa port map(a(2), b(2), c(1), c(2), sum(2));
		fa3 : fa port map(a(3), b(3), c(2), c(3), sum(3));

		--Bits {7:4]
		fa4 : fa port map(a(4), b(4), c(3), c(4), sum(4));
		fa5 : fa port map(a(5), b(5), c(4), c(5), sum(5));
		fa6 : fa port map(a(6), b(6), c(5), c(6), sum(6));
		fa7 : fa port map(a(7), b(7), c(6), c(7), sum(7));

		--Bits [11:8]
		fa8 : fa port map(a(8), b(8), c(7), c(8), sum(8));
		fa9 : fa port map(a(9), b(9), c(8), c(9), sum(9));
		fa10 : fa port map(a(10), b(10), c(9), c(10), sum(10));
		fa11 : fa port map(a(11), b(11), c(10), c(11), sum(11));

		--Bits [15:12]
		fa12 : fa port map(a(12), b(12), c(11), c(12), sum(12));
		fa13 : fa port map(a(13), b(13), c(12), c(13), sum(13));
		fa14 : fa port map(a(14), b(14), c(13), c(14), sum(14));
		fa15 : fa port map(a(15), b(15), c(14), c(15), sum(15));

		carry <= c(15);
end gate_level;
