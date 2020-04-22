library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.Numeric_Std.all;

entity ADDER_PER_CONVOLUTORE is

 Port (   clk: in std_logic;
          C1   : in  STD_LOGIC_VECTOR (19 downto 0);
          C2   : in  STD_LOGIC_VECTOR (19 downto 0);
          C3   : in  STD_LOGIC_VECTOR (19 downto 0);
          C4   : in  STD_LOGIC_VECTOR (19 downto 0);
          C5   : in  STD_LOGIC_VECTOR (19 downto 0);
          C6   : in  STD_LOGIC_VECTOR (19 downto 0);
          C7   : in  STD_LOGIC_VECTOR (19 downto 0);
          Sum  : out STD_LOGIC_VECTOR (19 downto 0)
            );


end ADDER_PER_CONVOLUTORE;

architecture Behavioral of ADDER_PER_CONVOLUTORE is

Component adder_20_b is

Port ( 
       A1   : in  STD_LOGIC_VECTOR (19 downto 0);
       B1   : in  STD_LOGIC_VECTOR (19 downto 0);
       Sum  : out STD_LOGIC_VECTOR (19 downto 0)
            );
end component;

signal S1,S2,S3,S4,S5,S6   : STD_LOGIC_VECTOR(19 downto 0);


 
begin

add_20b_1_1: adder_20_b port map( C1, C2, S1);
add_20b_1_2: adder_20_b port map( C3, C4, S2);
add_20b_1_3: adder_20_b port map( C5, C6, S3);
-- SECONDO LIVELLO
add_20b_2_1: adder_20_b port map( S1, S2, S4);
add_20b_2_2: adder_20_b port map( S3, C7, S5);
-- terzo livello 
add_20b_3_2: adder_20_b port map( S4, S5, S6);

   ff: process( clk )     
            begin         
            if( rising_edge(clk)) then              
            Sum <= S6;         
            end if;     
            end process; 
            
end Behavioral;
