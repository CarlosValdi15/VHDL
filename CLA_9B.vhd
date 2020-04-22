library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity CLA_9B is
    
    Port ( A8   : in  STD_LOGIC_VECTOR (8 downto 0);
           B8   : in  STD_LOGIC_VECTOR (8 downto 0);
           Sum10 : out STD_LOGIC_VECTOR (9 downto 0)
           );
end CLA_9B;

architecture Behavioral of CLA_9B is

component Full_Adder is
        Port ( X    : in  STD_LOGIC;
               Y    : in  STD_LOGIC;
               Cin  : in  STD_LOGIC;
               S    : out STD_LOGIC);
    end component;
   
        signal G,P : STD_LOGIC_VECTOR(8 downto 0);
        signal W_S : STD_LOGIC_VECTOR(8 downto 0);
        signal W_C : STD_LOGIC_VECTOR(9 downto 0);

begin

 GEN_FULL_ADDERS : for i in 0 to 8 generate
      FA : Full_Adder
      port map (
        X   => A8(i),
        Y   => B8(i),
        Cin => W_C(i),        
        S   => W_S(i)
       );
       end generate GEN_FULL_ADDERS;
       
    GEN_CLA : for j in 0 to 8 generate
           P(j)     <= A8(j) xor B8(j);
           G(j)     <= A8(j) and B8(j);
           W_C(j+1) <= G(j) or (P(j) and W_C(j));
       end generate GEN_CLA;
       
       W_C(0) <= '0';
       Sum10 <= W_C(9) & W_S;

end Behavioral;
