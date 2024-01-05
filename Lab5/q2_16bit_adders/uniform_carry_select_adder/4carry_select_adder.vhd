entity uniform_csa is
	
	port(
		a , b : in bit_vector(15 downto 0);
		cin : in bit;
		carry : out bit;
		sum : out bit_vector(15 downto 0)
	);
end uniform_csa;

architecture gate_level of uniform_csa is

	component fa port(
		a, b, cin : in bit;
		cout, sum : out bit
	);
	end component;

	component mux port(
		x, y, sel : in bit;
		z : out bit
	);
	end component;

	signal c : bit_vector(5 downto 0);		--Carry signals from initial [3:0] bits and then multiplexer select values after the 3rd bit
	signal zs : bit_vector(11 downto 0);		--Sum when carry in is implied '0'
	signal zc : bit_vector(11 downto 0);		--Carry signal between ripple carry adders when cin is implied '0'
	signal os : bit_vector(11 downto 0);		--Sum when carry in is implied '1'
	signal oc : bit_vector(11 downto 0); 		--Carry signal between ripple carry adders when cin is implied '1'
	
	begin 
	
		--Bits [3:0]
		fa0 : fa port map(a(0), b(0), cin, c(0), sum(0));
		fa1 : fa port map(a(1), b(1), c(0), c(1), sum(1));
		fa2 : fa port map(a(2), b(2), c(1), c(2), sum(2));
		fa3 : fa port map(a(3), b(3), c(2), c(3), sum(3));

		--Bits [7:4]
		fa40 : fa port map(a(4), b(4), '0', zc(0), zs(0));
		fa41 : fa port map(a(4), b(4), '1', oc(0), os(0));
		mux4 : mux port map(zs(0), os(0), c(3), sum(4));

		fa50 : fa port map(a(5), b(5), zc(0), zc(1), zs(1));
		fa51 : fa port map(a(5), b(5), oc(0), oc(1), os(1));
		mux5 : mux port map(zs(1), os(1), c(3), sum(5));

		fa60 : fa port map(a(6), b(6), zc(1), zc(2), zs(2));
		fa61 : fa port map(a(6), b(6), oc(1), oc(2), os(2));
		mux6 : mux port map(zs(2), os(2), c(3), sum(6));

		fa70 : fa port map(a(7), b(7), zc(2), zc(3), zs(3));
		fa71 : fa port map(a(7), b(7), oc(2), oc(3), os(3));
		mux7 : mux port map(zs(3), os(3), c(3), sum(7));

		carry_end0 : mux port map(zc(3), oc(3), c(3), c(4));

		--Bits [11:8]
		fa80 : fa port map(a(8), b(8), '0', zc(4), zs(4));
		fa81 : fa port map(a(8), b(8), '1', oc(4), os(4));
		mux8 : mux port map(zs(4), os(4),c(4), sum(8));

		fa90 : fa port map(a(9), b(9), zc(4), zc(5), zs(5));
		fa91 : fa port map(a(9), b(9), oc(4), oc(5), os(5));
		mux9 : mux port map(zs(5), os(5), c(4), sum(9));

		fa100 : fa port map(a(10), b(10), zc(5), zc(6), zs(6));
		fa101 : fa port map(a(10), b(10), oc(5), oc(6), os(6));
		mux10 : mux port map(zs(6), os(6), c(4), sum(10));

		fa110 : fa port map(a(11), b(11), zc(6), zc(7), zs(7));
		fa111 : fa port map(a(11), b(11), oc(6), oc(7), os(7));
		mux11 : mux port map(zs(7), os(7), c(4), sum(11));

		carry_end1 : mux port map(zc(7), oc(7), c(4), c(5));

		--Bits [15:12]
		fa120 : fa port map(a(12), b(12), '0', zc(8), zs(8));
		fa121 : fa port map(a(12), b(12), '1', oc(8), os(8));
		mux12 : mux port map(zs(8), os(8), c(5), sum(12));

		fa130 : fa port map(a(13), b(13), zc(8), zc(9), zs(9));
		fa131 : fa port map(a(13), b(13), oc(8), oc(9), os(9));
		mux13 : mux port map(zs(9), os(9), c(5), sum(13));

		fa140 : fa port map(a(14), b(14), zc(9), zc(10), zs(10));
		fa141 : fa port map(a(14), b(14), oc(9), oc(10), os(10));
		mux14 : mux port map(zs(10), os(10), c(5), sum(14));

		fa150 : fa port map(a(15), b(15), zc(10), zc(11), zs(11));
		fa151 : fa port map(a(15), b(15), oc(10), oc(11), os(11));
		mux15 : mux port map(zs(11), os(11), c(5), sum(15));

		carry_end2 : mux port map(zc(11), oc(11), c(5), carry);
end gate_level;
