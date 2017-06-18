library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all ;
entity cpu is port(
	clk , reset: in std_logic;
	D: in std_logic_vector(7 downto 0);
	ADR , A : out std_logic_vector(7 downto 0);
	wr , BZ : out std_logic
	);
end entity;
architecture cpu_arch of cpu is
component register_gen is 
	generic(t: natural range 1 to 16 :=8);
	port(
		clk ,load , reset: in std_logic;
		e: in std_logic_vector(t-1 downto 0);
		o: out std_logic_vector(t-1 downto 0)
		);
end component;
component register_inc port (
	clk ,load , reset ,inc: in std_logic;
	e: in std_logic_vector(7 downto 0);
	o: out std_logic_vector(7 downto 0)
);
end component;
component ctr port (
	clk , C , Z ,reset: in std_logic;
	I: in std_logic_vector(7 downto 0);
	LOAD_AD , LOAD_BZ , LOAD_PC ,INC_CO ,SEL_ADR,SEL_ACC ,LOAD_ACC,LOAD_I ,wr: out std_logic 
);
end component;

component ual port (
	I  : in std_logic_vector(3 downto 0);
	Op1 , Op2 : in std_logic_vector(7 downto 0);
	C_in : in std_logic ; -- bit de retenue
	Res:out std_logic_vector(7 downto 0);
	C, Z  :out std_logic
);
end component;
-- les liens
signal LOAD_AD , LOAD_BZ , LOAD_PC ,INC_CO ,SEL_ADR,SEL_ACC ,LOAD_ACC,LOAD_I,Z_in,C_in,Z_reg,C_reg,Z_out,C_out: std_logic ;
signal I ,PC , AD,ACC,ACC_ADR ,result: std_logic_vector(7 downto 0);
signal tmp_bz  : std_logic_vector(0 downto 0);

begin
	process(clk)
	begin 
		if rising_edge(clk) then
			Z_reg <= Z_in;
			C_reg <= C_in;
		end if;
	end process ;
	Z_out <= Z_reg;
	C_out <= C_reg;
	BZ <= tmp_bz(0);
	ADR <= AD when SEL_ADR = '1' else 
			 PC when SEL_ADR = '0' ;
	-- mux 
	ACC_ADR <= result when SEL_ACC = '0' else
				  D when SEL_ACC = '1' ;
	A <= ACC ;
	-- buzzer register
	BZ_reg:register_gen generic map(t=>1) 
						 port map(clk =>clk ,load =>LOAD_BZ , reset=>reset ,e=>D(0 downto 0),
						 o=>tmp_bz);
	-- unite de controle
   seq:ctr port map (clk =>clk, reset=>reset ,I=>I ,C=>C_out,Z=>Z_out,LOAD_AD=> LOAD_AD, 
							LOAD_BZ=>LOAD_BZ , LOAD_PC=> LOAD_PC,INC_CO =>INC_CO,SEL_ADR=>SEL_ADR,SEL_ACC=>SEL_ACC ,
							LOAD_ACC=>LOAD_ACC,LOAD_I=>LOAD_I ,wr=>wr);
	-- register des instruction
	I_reg: register_gen generic map(t=>8) 
						 port map(clk =>clk ,load =>LOAD_I , reset=>reset ,e=>D,o=>I);
	-- register de compteur ordinal
	PC_reg: register_Inc port map(clk =>clk ,load =>LOAD_PC ,inc =>INC_CO, reset=>reset ,e=>D,o=>PC);
	-- register d'addresse 
	ADDR_reg: register_gen generic map(t=>8) 
						 port map(clk =>clk ,load =>LOAD_AD , reset=>reset ,e=>D,o=>AD);
   -- register d'accumulation
	ACC_reg: register_gen generic map(t=>8) 
						 port map(clk =>clk ,load =>LOAD_ACC , reset=>reset ,e=>ACC_ADR,o=>ACC);
	-- UAL
	alu : ual port map (Op1=>D , Op2=>ACC,Res=>result,I=>I(3 downto 0),C_in =>C_out, C=>C_in, Z=>Z_in );
	
end architecture;