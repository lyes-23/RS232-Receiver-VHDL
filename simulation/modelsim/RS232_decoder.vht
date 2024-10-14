

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY RS232_decoder_vhd_tst IS
END RS232_decoder_vhd_tst;
ARCHITECTURE RS232_decoder_arch OF RS232_decoder_vhd_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL clk : STD_LOGIC;
SIGNAL reset : STD_LOGIC;
SIGNAL RX : STD_LOGIC;
SIGNAL S : STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL start : STD_LOGIC;
COMPONENT RS232_decoder
	PORT (
	clk : IN STD_LOGIC;
	reset : IN STD_LOGIC;
	RX : IN STD_LOGIC;
	S : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	start : IN STD_LOGIC
	);
END COMPONENT;
BEGIN
	i1 : RS232_decoder
	PORT MAP (
-- list connections between master ports and signals
	clk => clk,
	reset => reset,
	RX => RX,
	S => S,
	start => start
	);
init : PROCESS                                               
                                   
BEGIN                                                        
start<='1';
reset<='0';
RX <= '1'; wait for 521 us;
reset<='1';
RX <= '0'; wait for 52 us; -- start valeur 7
RX <= '1'; wait for 52 us; -- D0
RX <= '1'; wait for 52 us; -- D1
RX <= '1'; wait for 52 us; -- D2
RX <= '0'; wait for 52 us; -- D3
RX <= '0'; wait for 52 us; -- D4
RX <= '0'; wait for 52 us; -- D5
RX <= '0'; wait for 52 us; -- D6
RX <= '0'; wait for 52 us; -- D7
RX <= '1'; wait for 104 us; -- stop
RX <= '0'; wait for 52 us; -- start valeur 129
RX <= '1'; wait for 52 us; -- D0
RX <= '0'; wait for 52 us; -- D1
RX <= '0'; wait for 52 us; -- D2
RX <= '0'; wait for 52 us; -- D3
RX <= '0'; wait for 52 us; -- D4
RX <= '0'; wait for 52 us; -- D5
RX <= '0'; wait for 52 us; -- D6
RX <= '1'; wait for 52 us; -- D7
RX <= '1'; wait for 156 us; -- stop
RX <= '0'; wait for 52 us; -- start valeur 40
RX <= '0'; wait for 52 us; -- D0
RX <= '0'; wait for 52 us; -- D1
RX <= '0'; wait for 52 us; -- D2
RX <= '1'; wait for 52 us; -- D3
RX <= '0'; wait for 52 us; -- D4
RX <= '1'; wait for 52 us; -- D5
RX <= '0'; wait for 52 us; -- D6
RX <= '0'; wait for 52 us; -- D7
RX <= '1'; wait for 312 us; -- stop
RX <= '0'; wait for 52 us; -- start valeur 68
RX <= '0'; wait for 52 us; -- D0
RX <= '0'; wait for 52 us; -- D1
RX <= '1'; wait for 52 us; -- D2
RX <= '0'; wait for 52 us; -- D3
RX <= '0'; wait for 52 us; -- D4
RX <= '0'; wait for 52 us; -- D5
RX <= '1'; wait for 52 us; -- D6
RX <= '0'; wait for 52 us; -- D7
RX <= '1'; wait for 150 us; -- stop                 
WAIT;                                                       
END PROCESS init;                                           
always : PROCESS                                             
                                     
BEGIN                                                         
   clk <= '1';
	for i in 0 to 200 loop
	wait for 26 us ;
	clk <= not(clk) ; 
	End loop; 
WAIT;                                                        
                                                      
END PROCESS always;                                          
END RS232_decoder_arch;
