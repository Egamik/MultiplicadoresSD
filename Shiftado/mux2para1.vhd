LIBRARY ieee;
USE ieee.std_logic_1164.all;
use IEEE.numeric_std.all;

ENTITY mux2para1 IS
generic(N: natural:= 4);
  PORT ( a, b : IN unsigned(N-1 DOWNTO 0);
         sel: IN std_logic;
         y : OUT unsigned(N-1 DOWNTO 0));
  END mux2para1 ;

ARCHITECTURE comportamento OF mux2para1 IS
BEGIN
     WITH sel SELECT
         y <= a WHEN '0',
              b WHEN OTHERS;
END comportamento;