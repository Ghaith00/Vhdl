library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all ;
entity register_inc is 
	port(
		clk ,load , reset ,inc: in std_logic;
		e: in std_logic_vector(7 downto 0);
		o: out std_logic_vector(7 downto 0)
		);
end entity;
architecture register_inc_arch of register_inc is
signal tmp : unsigned(7 downto 0) ;
begin
	o <= std_logic_vector(tmp);
	process(clk, reset )
	begin
		if reset = '1' then 
			tmp <= (others=>'0');
		elsif rising_edge(clk) then 
			if load = '1' then 
				tmp <= unsigned(e) ;
			elsif inc = '1' then 
				tmp <= tmp + 1 ;
			end if ;
		end if ;
	end process;	
end architecture;