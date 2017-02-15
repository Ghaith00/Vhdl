library ieee;
use ieee.std_logic_1164.all;
entity van is port(x1,x2:in std_logic ; f:out std_logic);
end entity;
architecture arch_sec of van is
begin
f<= (((x2 and not x1)or (not x2 and x1)));
end architecture;