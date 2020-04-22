library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.Numeric_Std.all;

entity FILTRO_PIXEL_FILTRATO is
 Port (  clk: in STD_LOGIC;
         clear: in STD_LOGIC;
         Pixel_in: in STD_LOGIC_VECTOR(7 DOWNTO 0);
         A,B,C,D,E,F : in STD_LOGIC_VECTOR(7 DOWNTO 0);
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
       P1   : in  STD_LOGIC_VECTOR (7 downto 0);
       P2   : in  STD_LOGIC_VECTOR (7 downto 0);
       P3   : in  STD_LOGIC_VECTOR (7 downto 0);
       P4   : in  STD_LOGIC_VECTOR (7 downto 0);
       Sum_out : out STD_LOGIC_VECTOR (9 downto 0)
         );
end component;


Component mult_gen_0 is
Port ( 
                                  clk : in std_logic;
                                   A  : in std_logic_vector (9 downto 0);
                                   B  : in std_logic_vector (7 downto 0);
                                   P  : out std_logic_vector (19 downto 0)
                                   );
        
end component;

Component ADDER_PER_CONVOLUTORE is
 Port (    
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
signal S1,S2,S3,S4,S5,S6,S7  : STD_LOGIC_VECTOR(19 downto 0);
signal QQ12,R1,R2,R3,R4,R5,R6,R7  : STD_LOGIC_VECTOR(9 downto 0);
signal pixel : std_logic_vector (21 downto 0);



begin

QQ12<="00"&Q12;


 BUFF: BUFFER_COMPLETO port map (clk, clear, Pixel_in, Q0,Q1,Q2,Q3,Q4,Q5,Q6,Q7,Q8,Q9,Q10,Q11,Q12,Q13,Q14,Q15,Q16,Q17,Q18,Q19,Q20
            ,Q21,Q22,Q23,Q24); 

--GENRANDO LOS SUMADORES 
ADDER_8b_1_1: SOMATORE_PIXELS port map(Q0, Q4, Q20, Q24, R1);
ADDER_8b_1_2: SOMATORE_PIXELS port map(Q2, Q22, Q10, Q14, R2);
ADDER_8b_1_3: SOMATORE_PIXELS port map(Q1, Q5, Q3, Q9, R3);
ADDER_8b_1_4: SOMATORE_PIXELS port map(Q15, Q21, Q23, Q19, R4);
ADDER_8b_1_5: SOMATORE_PIXELS port map(Q6, Q8, Q18, Q16, R5);
ADDER_8b_1_6: SOMATORE_PIXELS port map(Q7, Q11, Q13, Q17, R6);
--GENRANDO LOS MULTIPLICADORES 
MULT_2_1: mult_gen_0 port map(clk,R1, A, S1);
MULT_2_2: mult_gen_0 port map(clk,R2, B, S2);
MULT_2_3: mult_gen_0 port map(clk,R3, C, S3);
MULT_2_4: mult_gen_0 port map(clk,R4, C, S4);
MULT_2_5: mult_gen_0 port map(clk,R5, D, S5);
MULT_2_6: mult_gen_0 port map(clk,R6, E, S6);
MULT_2_7: mult_gen_0 port map(clk,QQ12, F, S7);
-- SUMATORE PER CONVOLUTORE 
--SUM_X_CONV: ADDER_PER_CONVOLUTORE port map( S1, S2, S3, S4, S5, S6, S7, Sum);

    SUM_X_CONV : ADDER_PER_CONVOLUTORE
        Port map(  C1 => S1,
                  C2 => S2,
                  C3 => S3,
                  C4 => S4,
                  C5 => S5,
                  C6 => S6,
                  C7 => S7,
                  Sum => Pixel_filtrato        
        );

end Behavioral;
