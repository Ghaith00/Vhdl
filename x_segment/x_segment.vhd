library ieee;
use ieee.std_logic_1164.all;
entity x_segment is port(
h0,h1,h2,h3:out std_logic_vector(6 downto 0));
end entity;
architecture arch_segment of x_segment is
component mux_segment
	port (
	a:in std_logic_vector(3 downto 0) ; 
	b:out std_logic_vector(6 downto 0));
end component;
begin
	inst1 : mux_segment port map (a=>"0011", b=>h0);
	inst2 : mux_segment port map (a=>"1001", b=>h1);
	inst3 : mux_segment port map (a=>"1001", b=>h2);
	inst4 : mux_segment port map (a=>"0001", b=>h3);
	
end architecture;