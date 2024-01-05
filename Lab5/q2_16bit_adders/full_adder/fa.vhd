entity fa is
        port (
                a, b, cin : in bit;
                cout, sum : out bit);
end fa;

architecture structural of fa is
        component ha port (
                a, b : in bit;
                cout, sum : out bit);
        end component;

        signal s1, s2, s3 : bit;

        begin
                ha1: ha port map(a, b, s1, s2);
                ha2: ha port map(s2, cin, s3, sum);
                or_gate: cout <= s1 or s3;
end structural;


