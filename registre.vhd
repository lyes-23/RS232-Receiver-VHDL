-- registre paramétrable de paramètre "taille" initialisé à 4 et 
-- définissant la taille du vecteur d'entrée (D) et de sortie (Q) du registre
-- E est une entrée de validation 
-- R est l'entrée de reset asynchrone

LIBRARY ieee;
USE ieee.std_logic_unsigned.ALL;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.all;

ENTITY registre IS 
generic ( taille : integer := 4);
	PORT(D : IN STD_LOGIC_VECTOR(taille-1 DOWNTO 0);
	clk, E, R: IN STD_LOGIC;
	Q : OUT STD_LOGIC_VECTOR(taille-1 DOWNTO 0));
	end registre;
ARCHITECTURE comportemental OF registre IS
signal ADDS : STD_LOGIC_VECTOR(taille-1 downto 0);
begin 
	process (clk, R)
	begin
		if (R ='1') then
			Q <= (others => '0') ;	
		elsif (clk'event and clk = '1') then 
			if E = '1' then 
				Q <= D ;
			end if ;
		else 
			null;
		end if;
	end process;
end comportemental;