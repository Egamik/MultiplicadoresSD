LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
use IEEE.numeric_std.all;

ENTITY subtrator IS
generic(N: natural:= 3);
PORT (a, b : IN unsigned(N-1 DOWNTO 0);
      s : OUT unsigned(N-1 DOWNTO 0));
END subtrator;

ARCHITECTURE estrutura OF subtrator IS
BEGIN
         s <= a - b;
END estrutura;