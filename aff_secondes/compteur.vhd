library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity compteur is port(
	reset , enable , clk : in std_logic;
	out_units,out_tens:out std_logic_vector(3 downto 0));
end entity;
architecture arch_segment of compteur is
signal tmp1 :std_logic_vector(3 downto 0);
signal tmp2 :std_logic_vector(3 downto 0);
begin
	process(reset,clk,enable)
			begin
			if(reset='1') then
				out_units<="0000" ;
				out_tens <= "0000";
				tmp1<="0000";
				tmp2<="0000";
			elsif(clk'event and clk='1') then
				if enable = '1' then 
					if tmp1 = "1001" then 
						tmp1 <= "0000";
						if tmp2 = "0101" then
							tmp2 <= "0000";
						else 
							tmp2 <= std_logic_vector( unsigned(tmp2) + 1 );
						end if  ;
					else 
						tmp1 <= std_logic_vector( unsigned(tmp1) + 1 ); 
					end if ;
				end if ;
			end if;
			out_units<= tmp1 ; 
			out_tens <= tmp2;
		end process;	
end architecture;