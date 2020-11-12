library IEEE;
use IEEE.std_logic_1164.all;

entity registrador_sh is
generic(N: natural := 8);
port (clk, carga, darshift , in_sh: in std_logic;
      d: in std_logic_vector (N-1 downto 0);
      q: out std_logic_vector(N-1 downto 0));
end registrador_sh;

architecture comportamento of registrador_sh is
signal e: std_logic_vector(N-1 downto 0);
begin
 q <= e;
 process (clk)
 begin
    if (clk'event and clk = '1' and carga = '1') then
        e <= d;
    elsif (clk'event and clk = '1' and darshift = '1' and carga = '0') THEN
        e <= in_sh & e (7 downto 1); -- é o mesmo q deslocar ele para direita pois concatena com os
                                     -- 6 mais significativos e in_sh é '0' para ph e PH(0) para PL.
    end if;
  end process;
end comportamento;
