library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all ;
entity ctr is 
	port(
		clk , C , Z ,reset: in std_logic;
		I: in std_logic_vector(7 downto 0);
		LOAD_AD , LOAD_BZ , LOAD_PC ,INC_CO ,SEL_ADR,SEL_ACC ,LOAD_ACC,LOAD_I ,wr: out std_logic 
		);
end entity;
architecture ctr_arch of ctr is
-- Tout les etats de l'automate (machine de moore)
type Etat is (
	start ,
	fetch , 
	fetch2 , 
	decode ,
	inc_pc ,
	exec_alu1,
	exec_alu2,
	exec_lda1,
	exec_lda2,
	exec_sta1,
	exec_sta2,
	exec_out,
	exec_jmp ,
	exec_jnc,
	exec_jnz,
	exec_nop
	);
 --   operations code
  constant NOP : std_logic_vector(7 downto 0) := "00000000";
  constant XOR1 : std_logic_vector(7 downto 0) := "00000001";
  constant AND1 : std_logic_vector(7 downto 0) := "00000010";
  constant OR1 : std_logic_vector(7 downto 0) := "00000011";
  constant ADD : std_logic_vector(7 downto 0) := "00000100";
  constant ADC : std_logic_vector(7 downto 0) := "00000101";
  constant SUB : std_logic_vector(7 downto 0) := "00000110";
  constant SBC : std_logic_vector(7 downto 0) := "00000111";
  constant ROL1 : std_logic_vector(7 downto 0) := "00001000";
  constant ROR1 : std_logic_vector(7 downto 0) := "00001001";
  constant LDA : std_logic_vector(7 downto 0) := "00001010";
  constant STA : std_logic_vector(7 downto 0) := "00001011";
  constant OUT1 : std_logic_vector(7 downto 0) := "00001100";
  constant JMP : std_logic_vector(7 downto 0) := "00001101";
  constant JNC : std_logic_vector(7 downto 0) := "00001110";
  constant JNZ : std_logic_vector(7 downto 0) := "00001111";

  
  
-- Sauvegade de l'etat
Signal etat_present , etat_futur : Etat := start ;

begin
	-- Combinatoire des etats
	combi_etats : process(etat_present,I)
	begin 
		case etat_present is
			when start =>
				etat_futur <= fetch ;
			when fetch =>
				etat_futur <= fetch2 ;
			when fetch2 =>
				etat_futur <= decode ;
			when decode =>
				case I is
					when ADD | ADC | SUB | SBC | ROL1 | ROR1 |  XOR1 | AND1 | OR1=>
						etat_futur <= exec_alu1;
					when LDA =>
						etat_futur <= exec_lda1 ;
					when STA =>
						etat_futur <= exec_sta1 ;
					when OUT1 =>
						etat_futur <= exec_out ;
					when JMP =>
						etat_futur <= exec_jmp ;
					when JNC =>
						etat_futur <= exec_jnc ;
					when JNZ =>
						etat_futur <= exec_jnz ;	
					when 	NOP =>
						etat_futur <= start ;
					when others =>
						etat_futur <=start ;
				end case ;
			-- jmp
			when exec_jmp =>
				etat_futur <= inc_pc ;
			-- jnc
			when exec_jnc =>
				if C = '0' then 
					etat_futur <= exec_jmp ;
				else 
					etat_futur <= inc_pc;
				end if ;
			-- jnz
			when exec_jnz =>
				if Z = '0' then 
					etat_futur <= exec_jmp ;
				else 
					etat_futur <= inc_pc;
				end if ;
			-- alu
			when exec_alu1 =>
				etat_futur <= exec_alu2 ;
			when exec_alu2 =>
				etat_futur <= inc_pc ;
			-- lda
			when exec_lda1 =>
				etat_futur <= exec_lda2 ;
			when exec_lda2 =>
				etat_futur <= inc_pc ;
			-- sta
			when exec_sta1 =>
				etat_futur <= exec_sta2 ;
			when exec_sta2 =>
				etat_futur <= inc_pc ;
			-- out
			when exec_out =>
				etat_futur <= inc_pc ;
			-- increment
			when inc_pc =>
				etat_futur <= fetch2 ;
			when others =>
				etat_futur <=start ;
		end case ;
	end process ;
	
	-- Memorisation de l'etat
	Seq_etat : process(clk ,reset)
	begin 
		if reset = '0' then 
			etat_present <= start ;
		elsif rising_edge(clk) then 
			etat_present <= etat_futur ;
		end if ;
	end process ;
	
	-- combinatoire des sorties
	comb_sorties:process(etat_present)
	begin
		case etat_present is
			when start => 
				LOAD_AD <= '0' ; 
				LOAD_BZ <= '0' ; 
				LOAD_PC <= '0' ;
				INC_CO <= '0' ;
				SEL_ADR <= '0' ;
				SEL_ACC <= '0' ;
				LOAD_ACC <= '0' ;
				LOAD_I <= '0' ;
				wr <= '0' ;
			when fetch =>
				INC_CO <= '1' ;
				LOAD_I <= '1' ;
			when fetch2 => 
				LOAD_I <= '0' ;
				LOAD_AD <= '1' ;
			when decode =>
				INC_CO <= '0' ;
				LOAD_AD <= '0' ;
			when inc_pc =>
				INC_CO<='1';
				LOAD_PC<='0';
				lOAD_I<='1';
				SEL_ADR<='0';
				LOAD_ACC<='0';
				SEL_ACC<='0';
			when exec_alu1 => SEL_ADR<='1';
			when exec_alu2 => LOAD_ACC<='1';	
			when exec_jmp => LOAD_PC<='1';
			when exec_sta1 => SEL_ADR <='1';
			when exec_sta2 => wr<='1';
			when exec_lda1 => SEL_ADR <='1';
			when exec_lda2 => LOAD_ACC<='1';SEL_ACC<='1';
			when exec_out => LOAD_BZ<='1';
			when exec_jnc => 
			when exec_jnz => 
			when others =>
				LOAD_AD <= '0' ; 
				LOAD_BZ <= '0' ; 
				LOAD_PC <= '0' ;
				INC_CO <= '0' ;
				SEL_ADR <= '0' ;
				SEL_ACC <= '0' ;
				LOAD_ACC <= '0' ;
				LOAD_I <= '0' ;
				wr <= '0' ;
		end case ;
	end process ;
end architecture;