LIBRARY ieee;
USE ieee.std_logic_1164.all;
use IEEE.numeric_std.all;

ENTITY mux2para1_bit IS
  PORT ( a, b : IN std_logic;
         sel: IN std_logic;
         y : OUT std_logic);
  END mux2para1_bit ;

ARCHITECTURE comportamento OF mux2para1_bit IS
BEGIN
     WITH sel SELECT
         y <= a WHEN '0',
              b WHEN OTHERS;
END comportamento;