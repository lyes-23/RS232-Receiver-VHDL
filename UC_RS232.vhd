library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;

entity UC_RS232 is
port(
start,CE0,CE7,reset,clk: in std_logic;
Erd,Rrd,Er,E,R: out std_logic
);
end UC_RS232;


architecture behavioral of UC_RS232 is 

type state is(att,deca,MAJ);
signal etat : state := att;
signal etat_f : state;

begin

P1: process(clk,reset)
begin
if reset = '0' then 
	etat <= att;
elsif rising_edge(clk) and reset='1' then 
	etat<= etat_f;
end if ;
end process p1;

P2: process(etat)
begin

if etat = att then 
	Erd<='0';
	Rrd<='1';
	Er<='0';
	E<= '0';
	R<= '1';
	
	
	
elsif etat = deca then 

	Erd<='1';
	Rrd<='0';
	Er<='0';
	E<='1';
	R<='0';
	
elsif etat = MAJ then 

	Erd<='0';
	Rrd<='0';
	Er<='1';
	E<='0';
	R<='1';
	

	
	else
	
	Erd<='0';
	Rrd<='1';
	Er<='0';
	E<= '0';
	R<= '1';
	
end if;

end process P2;

P3: process(start,CE0,CE7, etat)
begin
case etat is

when att => if start='0' then etat_f<= att;
					elsif start = '1' and CE0= '1' then etat_f<= deca; 
					else etat_f<= att;
					end if; 
					
when deca => if CE7='1'  then
					etat_f<= MAJ;
				 elsif CE7='0'  then
				 etat_f<=etat;
				end if; 
				

					
					
when MAJ => etat_f<= att;
					
end case; 
end process P3; 

end behavioral;

