
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity BUFFER_COMPLETO is

    Port ( clk       : in STD_LOGIC;
           clear     : in STD_LOGIC;
           Pixel_in  :  in STD_LOGIC_VECTOR (7 downto 0);
            Q0,Q1,Q2,Q3,Q4,Q5,Q6,Q7,Q8,Q9,Q10,Q11,Q12,Q13,Q14,Q15,Q16,Q17,Q18,Q19,Q20
            ,Q21,Q22,Q23,Q24: out STD_LOGIC_VECTOR (7 downto 0)
           );
end BUFFER_COMPLETO;

architecture Behavioral of BUFFER_COMPLETO is

Component serial_register is

Port(   clk   : in std_logic;
        clear : in std_logic;
        Data_in: in std_logic_vector(7 downto 0);
        Pixel_out0: inout std_logic_vector(7 downto 0);
        Pixel_out1: inout std_logic_vector(7 downto 0);
        Pixel_out2: inout std_logic_vector(7 downto 0);
        Pixel_out3: inout std_logic_vector(7 downto 0);
        Pixel_out4: inout std_logic_vector(7 downto 0) );

end component;

Component FIFO_m is
    Port (
           clk      : in STD_LOGIC;
           clear    : in STD_LOGIC;
           DATA_IN        : in STD_LOGIC_VECTOR (7 downto 0);
           Q        : out STD_LOGIC_VECTOR (7 downto 0)
           );
end Component; 

type  registro is array (0 to 24) of STD_LOGIC_VECTOR (7 downto 0);
type  reg1 is array (0 to 4) of STD_LOGIC_VECTOR (7 downto 0);
signal P_int :registro;
signal Out_Reg :reg1;

begin  
     --- inizializare l'operazione dei registri
        Out_reg(0) <= Pixel_in;
        
        L1: for i in 0 to 4 generate 
        begin 
        
       reg: serial_register port map (clk,clear,Out_reg(i),P_int(5*i),P_int(5*i+1),
       P_int(5*i+2),P_int(5*i+3),P_int(5*i+4));
       
       end generate;
       
       L2: for i in 0 to 3 generate
       begin
         fifo: FIFO_m port map (clk,clear,P_int(5*i+4),Out_Reg(i+1));
         
       end generate;
       
       -- istanziare le porte d'uscita  con le segnale dei registri
       
       Q0 <= P_int(0);
       Q1 <= P_int(1);
       Q2 <= P_int(2);
       Q3 <= P_int(3);
       Q4 <= P_int(4);
       Q5 <= P_int(5);
       Q6 <= P_int(6);
       Q7 <= P_int(7);
       Q8 <= P_int(8);
       Q9 <= P_int(9);
       Q10<= P_int(10);
       Q11 <= P_int(11);
       Q12 <= P_int(12);
       Q13 <= P_int(13);
       Q14 <= P_int(14);
       Q15 <= P_int(15);
       Q16 <= P_int(16);
       Q17 <= P_int(17);
       Q18 <= P_int(18);
       Q19 <= P_int(19);
       Q20<= P_int(20);
       Q21<= P_int(21);
       Q22<= P_int(22);
       Q23<= P_int(23);
       Q24<= P_int(24);
       
end Behavioral;
