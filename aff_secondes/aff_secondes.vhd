library ieee;
use ieee.std_logic_1164.all;
entity aff_secondes is port(
	in_reset , in_enable , in_clk : in std_logic;
	out_units,out_tens:out std_logic_vector(6 downto 0));
end entity;
architecture arch_segment of aff_secondes is

component trans is
	port (
	in_bcd:in std_logic_vector(3 downto 0) ; 
	out_digits:out std_logic_vector(6 downto 0));
end component;
component div_clk  is
	port (
	in_reset , in_clk : in std_logic;
	out_clk:out std_logic);
end component;
component compteur is
	port (
	reset , enable , clk : in std_logic;
	out_units,out_tens:out std_logic_vector(3 downto 0));
end component;
signal tmp1 : std_logic ;
signal tmp2 : std_logic_vector(3 downto 0) ;
signal tmp3 : std_logic_vector(3 downto 0) ;
begin
		diviseur : div_clk port map (in_reset=>not in_reset, in_clk=>in_clk,out_clk=>tmp1);
		ins_compt : compteur port map (clk=>tmp1,enable=>not in_enable, reset=>not in_reset,out_units=>tmp3,out_tens=>tmp2);
		ins_trans1 : trans port map (in_bcd=>tmp3, out_digits=>out_units);
		ins_trans2 : trans port map (in_bcd=>tmp2, out_digits=>out_tens);
		
end architecture;