library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.Numeric_Std.all;

entity FILTRO_PIXEL_FILTRATO is
 Port (  clk: in STD_LOGIC;
         clear: in STD_LOGIC;
         Pixel_in: in STD_LOGIC_VECTOR(7 DOWNTO 0);
         A,B,C,D,E,F: in std_logic_vector(7 downto 0);
         Pixel_filtrato: out std_logic_vector (19 downto 0)
            );
end FILTRO_PIXEL_FILTRATO;

architecture Behavioral of FILTRO_PIXEL_FILTRATO is

   Component BUFFER_COMPLETO is

    Port ( clk       : in STD_LOGIC;
           clear     : in STD_LOGIC;
           Pixel_in  :  in STD_LOGIC_VECTOR (7 downto 0);
            Q0,Q1,Q2,Q3,Q4,Q5,Q6,Q7,Q8,Q9,Q10,Q11,Q12,Q13,Q14,Q15,Q16,Q17,Q18,Q19,Q20
            ,Q21,Q22,Q23,Q24 : out STD_LOGIC_VECTOR (7 downto 0)
           );
   end component;

Component SOMATORE_PIXELS is
    Port ( 
              clk  : in std_logic;
              P1   : in  STD_LOGIC_VECTOR (7 downto 0);
              P2   : in  STD_LOGIC_VECTOR (7 downto 0);
              P3   : in  STD_LOGIC_VECTOR (7 downto 0);
              P4   : in  STD_LOGIC_VECTOR (7 downto 0);
              Sum_out : out STD_LOGIC_VECTOR (9 downto 0)
         );
end component;
-- primer multiplicador 
Component mult_gen_0 is
    Port (  CLK : IN STD_LOGIC;
              A : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
              B : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
              P : OUT STD_LOGIC_VECTOR(17 DOWNTO 0)
  );
end component;
-- segundo multiplicador pipeline stage  2
Component mult_gen_1 is
    Port (   CLK : IN STD_LOGIC;
               A : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
               B : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
               P : OUT STD_LOGIC_VECTOR(17 DOWNTO 0)
);
end component;


-- SOMMA PER CONVOLUTORE 

Component ADDER_PER_CONVOLUTORE is
 Port (    
         clk: in std_logic;
         C1   : in  STD_LOGIC_VECTOR (19 downto 0);
         C2   : in  STD_LOGIC_VECTOR (19 downto 0);
         C3   : in  STD_LOGIC_VECTOR (19 downto 0);
         C4   : in  STD_LOGIC_VECTOR (19 downto 0);
         C5   : in  STD_LOGIC_VECTOR (19 downto 0);
         C6   : in  STD_LOGIC_VECTOR (19 downto 0);
         C7   : in  STD_LOGIC_VECTOR (19 downto 0);
         Sum  : out STD_LOGIC_VECTOR (19 downto 0)
           );
end component;





signal Q0,Q1,Q2,Q3,Q4,Q5,Q6,Q7,Q8,Q9,Q10,Q11,Q12,Q13,Q14,Q15,Q16,Q17,Q18,Q19,Q20,Q21,Q22,Q23,Q24 :std_logic_vector(7 downto 0);
signal QQ12,R1,R2,R3,R4,R5,R6,R7  : STD_LOGIC_VECTOR(9 downto 0);
signal S1,S2,S3,S4,S5,S6,S7  : STD_LOGIC_VECTOR(17 downto 0);
signal SS1,SS2,SS3,SS4,SS5,SS6,SS7  : STD_LOGIC_VECTOR(19 downto 0);
signal pixel : std_logic_vector (21 downto 0);

begin

QQ12<="00"&Q12;



 BUFF: BUFFER_COMPLETO port map (clk, clear, Pixel_in, Q0,Q1,Q2,Q3,Q4,Q5,Q6,Q7,Q8,Q9,Q10,Q11,Q12,Q13,Q14,Q15,Q16,Q17,Q18,Q19,Q20
            ,Q21,Q22,Q23,Q24); 


--GENRANDO LOS SUMADORES  
ADDER_8b_1_1: SOMATORE_PIXELS port map (clk ,Q0, Q4, Q20, Q24, R1);
ADDER_8b_1_2: SOMATORE_PIXELS port map (clk,Q2,Q22,Q10,Q14,R2);
ADDER_8b_1_3: SOMATORE_PIXELS port map (clk,Q1,Q5,Q3,Q9,R3);
ADDER_8b_1_4: SOMATORE_PIXELS port map (clk,Q15,Q21,Q23,Q19,R4);
ADDER_8b_1_5: SOMATORE_PIXELS port map (clk,Q6,Q8,Q16,Q18,R5);
ADDER_8b_1_6: SOMATORE_PIXELS port map (clk,Q7,Q11,Q13,Q17,R6);

--GENERARE I MOLTIPLICATORI 

MULT_2_1: mult_gen_0 port map(clk,R1, A, S1);
MULT_2_2: mult_gen_0 port map(clk,R2, B, S2);
MULT_2_3: mult_gen_0 port map(clk,R3, C, S3);
MULT_2_4: mult_gen_0 port map(clk,R4, C, S4);
MULT_2_5: mult_gen_0 port map(clk,R5, D, S5);
MULT_2_6: mult_gen_0 port map(clk,R6, E, S6);
-- moltiplicatore stage 2 pipeline 
MULT_2_7: mult_gen_1 port map(clk,QQ12, F, S7);

-- EXTENSION DEL LOS BITS PARA SUMADOR A 20 BITS 


SS1<= S1(17) & S1(17) & S1;
SS2<= S2(17) & S2(17) & S2;
SS3<= S3(17) & S3(17) & S3;
SS4<= S4(17) & S4(17) & S4;
SS5<= S5(17) & S5(17) & S5;
SS6<= S6(17) & S6(17) & S6;
SS7<= S7(17) & S7(17) & S7;

------------------------------------------------------

-- SOMATORE PER PIXEL FILTRATO 

    SUM_X_CONV : ADDER_PER_CONVOLUTORE
        Port map( clk => clk,
                  C1 => SS1,
                  C2 => SS2,
                  C3 => SS3,
                  C4 => SS4,
                  C5 => SS5,
                  C6 => SS6,
                  C7 => SS7,
                  Sum => Pixel_filtrato        
        );


end Behavioral;
