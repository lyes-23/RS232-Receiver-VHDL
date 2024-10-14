-- compteur décompteur universel paramétrable 
-- taille définit la taille en nombre de bits du compteur
-- reset est une remise à zéro asynchrone
-- Rs est une remise à zéro synchrone
-- load=1 correspond à un chargement de la valeur DATA dans le compteur => Q=DATA
-- E est l'entrée de validation prioritaire sur tout sauf reset
-- si E=1 et LOAD=0 et UP=1 on est en mode comptage synchrone
-- Co est un carry out à 1 en comptage lorsque l'on atteint la valeur max 
-- Co est à 1 en décomptage lorsque l'on atteind la valeur O du compteur.

Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;
Use ieee.std_logic_unsigned.all;
entity compteur_generic is
generic (taille : integer := 4);
PORT (
	RESET, Rs, CLOCK, LOAD, UP, E: in std_logic;
	DATA : in std_logic_vector (taille-1 downto 0);
	Q : out std_logic_vector (taille-1 downto 0);
	Co : out std_logic);
end compteur_generic ;
architecture DESCRIPTION of compteur_generic  is
signal CMP: std_logic_vector (taille-1 downto 0);
begin
	process (RESET,CLOCK, UP, CMP)
		begin
		Co <= '0';
		if (UP ='1') then -- calcul de Co en fonction de UP
			if to_integer(unsigned(cmp)) = 2**taille -1 then
				Co <= '1' ;
			end if;
		else
			if to_integer(unsigned(cmp)) = 0 then
				Co <= '1';
			end if;
		end if;
		if RESET ='1' then
			CMP <= (others => '0'); -- Remise à zéro asynchrone du compteur
		elsif (CLOCK ='1' and CLOCK'event) then
			if (Rs = '1') then
				CMP <= (others => '0'); -- Remise à zéro synchrone du compteur
			elsif (LOAD ='1') then
				CMP <= DATA; -- Préchargement synchrone		
			elsif (E = '1') then
					if (UP ='1') then
					CMP <= CMP + 1 ; -- Incrémentation synchrone
					else
					cmp <= cmp - 1 ; -- décrémentation synchrone
					end if;
			end if;
			
		end if;
	end process;
	Q <= CMP;
end DESCRIPTION;