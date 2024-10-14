-- Registre décalage à droite générique avec chargement parallèle et reset synchrone
-- taille correspond à la taille du registre en nombre de bits
-- E est l'entrée de validation du décalage à droite avec entrée série gauche (D(taille-1))
-- L est l'entrée de chargement parallèle des données D sur la sortie Q
-- R est le reset synchrone

LIBRARY ieee;
USE ieee.std_logic_unsigned.ALL;
USE ieee.std_logic_1164.ALL;

ENTITY reg_dec IS 
generic ( taille : integer := 8);
	PORT(D : IN STD_LOGIC_VECTOR(taille-1 DOWNTO 0);
	clk, E, R, L: IN STD_LOGIC;
	Q : OUT STD_LOGIC_VECTOR(taille-1 DOWNTO 0));
	end reg_dec;
ARCHITECTURE comportemental OF reg_dec IS
signal reg : STD_LOGIC_VECTOR(taille-1 downto 0);
begin 
	process (clk, R, E, L)
	begin
		if (clk'event and clk = '1') then
			if R = '1' then -- reset
			reg <= (others => '0') ;	
			elsif  L = '1' then -- chargement parallèle
				reg <= D ;
			elsif E = '1' then -- décalage à droite avec entrée série
				reg <= D(taille-1)&reg(taille-1 downto 1);
			end if ;
		else 
			null;
		end if;
	end process;
	Q <= reg;
end comportemental;