entity ctrl_addsub is
        port (
                a,b,cin,ctrl : in bit;
                s,cout : out bit);
end ctrl_addsub;

architecture structural of ctrl_addsub is
        component XOR_gate
                port (
                        i1, i2 : in bit;
                        o1: out bit);
        end component;
        component fa
                port (
                        a,b,cin : in bit;
                        cout, sum : out bit);
        end component;

        signal control : bit;

        begin
                ctrl0 : XOR_gate port map (a,ctrl,control);
                casout : fa port map (control, b, cin, cout, s);
end structural;