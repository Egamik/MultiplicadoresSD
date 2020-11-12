LIBRARY ieee;
USE ieee.std_logic_1164.all;
use IEEE.numeric_std.all;

ENTITY mux2para1_1 IS
generic(N: natural:= 3);
  PORT ( a, b : IN std_logic_vector(N-1 DOWNTO 0);
         sel: IN std_logic;
         y : OUT std_logic_vector(N-1 DOWNTO 0));
  END mux2para1_1 ;

ARCHITECTURE comportamento OF mux2para1_1 IS
BEGIN
     WITH sel SELECT
         y <= a WHEN '0',
              b WHEN OTHERS;
END comportamento;