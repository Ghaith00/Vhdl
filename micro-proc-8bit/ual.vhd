library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all ;
entity ual is port(
	I  : in std_logic_vector(3 downto 0);
	Op1 , Op2 : in std_logic_vector(7 downto 0);
	C_in : in std_logic ; -- bit de retenue
	Res:out std_logic_vector(7 downto 0);
	C, Z :out std_logic
	);
end entity;
architecture arch_ual of ual is
signal temp_res : unsigned(8 downto 0);

begin
	Res <= std_logic_vector(temp_res(7 downto 0));
	C <= temp_res(8) ;
	process(I, Op1 ,Op2 ,C_in,temp_res)
	Begin 
		Case I is 
			when "0001" =>
				temp_res <= "0"&(unsigned(Op1) xor unsigned(Op2)); --XOR
			when "0010" =>
				temp_res <= "0"&(unsigned(Op1) and unsigned(Op2)); -- AND
			when "0011" =>
				temp_res <= "0"&(unsigned(Op1) or unsigned(Op2)); -- OR
			when "1000" =>
				temp_res <= "0"&unsigned(Op1(6 downto 0)&Op1(7)); -- ROL
			when "1001" =>
				temp_res <= "0"&unsigned(Op1(0)&Op1(7 downto 1)); -- ROR
			when "0100" =>
				temp_res <= unsigned("0"&Op1) +unsigned("0"&Op2); -- ADD
			when "0101" =>
				temp_res <= unsigned(Op1) +unsigned(Op2)+"0000000"&C_in; -- ADC	
			when "0110" =>
				temp_res <= unsigned("0"&Op1) -unsigned("0"&Op2); -- SUB
			when "0111" =>
				temp_res <= unsigned(Op1) -unsigned(Op2)-"0000000"&C_in; -- SUC
			when OTHERS =>
				temp_res <= temp_res ;
		end case ;
		if temp_res(7 downto 0)= 00000000 then 
			Z <= '1' ;
		else 
			Z <= '0' ;
		end if ;
	end process ;
	
	
end architecture;