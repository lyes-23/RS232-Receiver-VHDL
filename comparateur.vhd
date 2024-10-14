-- comparateur paramétrable 
-- le parammètre "taille" est initialisé à 4 et définit la taille des vecteurs std d'entrée
-- trois sorties (inf, sup, eg) (A<B, A>B, A=B)

LIBRARY ieee;
USE ieee.std_logic_unsigned.ALL;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.all;
ENTITY comparateur IS 
generic ( taille : integer := 4);
	PORT(A, B : IN STD_LOGIC_VECTOR(taille-1 DOWNTO 0);
	inf, sup, eg: out STD_LOGIC
	);
	end comparateur;
ARCHITECTURE comportemental OF comparateur IS

begin 
	process (A,B)
	begin
		if (A = B) then
			inf <= '0';
			sup <= '0';
			eg <= '1';
		elsif ( A < B ) then 
			inf <= '1';
			sup <= '0';
			eg <= '0';
		else 
			inf <= '0';
			sup <= '1';
			eg <= '0';
		end if;
	end process;
end comportemental;