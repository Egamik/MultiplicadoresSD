library IEEE;
use IEEE.std_logic_1164.all;

entity registrador_r is
generic(N: natural:= 4);
port (clk, carga, sh, in_sh: in std_logic;
      d: in std_logic_vector (N-1 downto 0);
      q: out std_logic_vector(N-1 downto 0));
end registrador_r;

architecture comportamento of registrador_r is
signal e: std_logic_vector(N-1 downto 0);
begin

 process (clk)
 begin
    if (clk'event and clk = '1' and carga = '1') then
        e <= d;
    elsif (clk'event and clk = '1' and sh = '1' and carga = '0') THEN
        e <= in_sh & e (N-1 downto 1);

    end if;
	         q <= e;
  end process;
end comportamento;