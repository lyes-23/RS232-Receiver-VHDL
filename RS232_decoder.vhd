library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all; 


entity RS232_decoder is 
port(
RX, clk , start , reset: in std_logic; 
S: out std_logic_vector( 7 downto 0) 
);
end RS232_decoder; 


architecture behavioral of RS232_decoder is 


signal CE0,CE7,Erd,Rrd,Er,E,R: std_logic; 
signal counter: std_logic_vector(2 downto 0) ; 
signal DATA_0: std_logic_vector(7 downto 0) ; 

component comparateur is 
generic ( taille : integer := 1);
	PORT(A, B : IN STD_LOGIC_VECTOR(taille-1 DOWNTO 0);
	inf, sup, eg: out STD_LOGIC
	);
end component; 


component compteur_generic is 
generic (taille : integer := 4);
PORT (
	RESET, CLOCK,Rs, LOAD, UP, E: in std_logic;
	DATA : in std_logic_vector (taille-1 downto 0);
	Q : out std_logic_vector (taille-1 downto 0);
	Co : out std_logic);
end component; 



component reg_dec is 
generic ( taille : integer := 8);
	PORT(D : IN STD_LOGIC_VECTOR(taille-1 DOWNTO 0);
	clk, E, R, L: IN STD_LOGIC;
	Q : OUT STD_LOGIC_VECTOR(taille-1 DOWNTO 0));
end component;


component registre is 
generic ( taille : integer := 4);
	PORT(D : IN STD_LOGIC_VECTOR(taille-1 DOWNTO 0);
	clk, E, R: IN STD_LOGIC;
	Q : OUT STD_LOGIC_VECTOR(taille-1 DOWNTO 0));
	end component;
	
component UC_RS232 is 
port(
start,CE0,CE7,reset,clk: in std_logic;
Erd,Rrd,Er,E,R: out std_logic
);
end component;

begin 




comp0: comparateur  generic map( taille => 1)
							port map   (A(0)=>RX, 
											B=> "0",
											eg=> CE0
											);
											

comp7: comparateur  generic map( taille => 3)
							port map   (A=>counter, 
											B=> "111",
											eg=> CE7
											);
registre1: registre  generic map( taille => 8)
	port map(D => DATA_0,
				clk=> clk,
				E=>Er,
				R=>'0',
				Q=>S
	);
	
registre_deca: reg_dec generic map ( taille => 8 )
	port map (D(7)=>RX,
				D(6)=>'0',
				D(5)=>'0',
				D(4)=>'0',
				D(3)=>'0',
				D(2)=>'0',
				D(1)=>'0',
				D(0)=>'0',
	clk=>clk,
	E=>Erd,
	R=>Rrd,
	L=>'0',
	Q=> DATA_0
	);
											
counter_1: compteur_generic generic map(taille => 3)
									port map ( RESET => R, 
												  CLOCK => clk, 
												  E => E,
												  Rs=> '0',
												  LOAD=> '0',
												  DATA=> "000",
												  UP=>'1',
												  Q=> counter
												  );
												  
UC_fsm : UC_RS232 port map (	start=> start ,
							CE0=> CE0,
							CE7=> CE7,
							reset=>reset,
							clk=>clk, 
							Erd=>Erd,
							Rrd=>Rrd,
							Er=>Er,
							E=>E,
							R=>R
							
							);
												  
												  
end behavioral; 