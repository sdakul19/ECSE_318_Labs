entity inv is
        port (
                A : in bit;
                nA : out bit);
end inv;

architecture behavioral of inv is
begin
        nA <= not A;
end behavioral;