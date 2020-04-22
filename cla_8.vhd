library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity CLA_8 is
    Port ( A   : in  STD_LOGIC_VECTOR (7 downto 0);
           B   : in  STD_LOGIC_VECTOR (7 downto 0);
           Sum : out STD_LOGIC_VECTOR (8 downto 0)
           );
end CLA_8;

architecture Behavioral of CLA_8 is

component Full_Adder is
        Port ( X    : in  STD_LOGIC;
               Y    : in  STD_LOGIC;
               Cin  : in  STD_LOGIC;
               S    : out STD_LOGIC);
    end component;
   
        signal G,P : STD_LOGIC_VECTOR(7 downto 0);
        signal W_S : STD_LOGIC_VECTOR(7 downto 0);
        signal W_C : STD_LOGIC_VECTOR(8 downto 0);
begin
    
GEN_FULL_ADDERS : for i in 0 to 7 generate
  FA : Full_Adder
  port map (
    X   => A(i),
    Y   => B(i),
    Cin => W_C(i),        
    S   => W_S(i)
   );
   end generate GEN_FULL_ADDERS;
   
GEN_CLA : for j in 0 to 7 generate
       P(j)     <= A(j) xor B(j);
       G(j)     <= A(j) and B(j);
       W_C(j+1) <= G(j) or (P(j) and W_C(j));
   end generate GEN_CLA;
   
   W_C(0) <= '0';
   Sum <= W_C(8) & W_S;


end Behavioral;