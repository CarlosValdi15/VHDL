library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity adder_20_b is
    Port ( A1  : in  STD_LOGIC_VECTOR (19 downto 0);
           B1   : in  STD_LOGIC_VECTOR (19 downto 0);
           Sum : out STD_LOGIC_VECTOR (19 downto 0)
       );
end adder_20_b;

architecture Behavioral of adder_20_b is

component Full_Adder is
        Port ( X    : in  STD_LOGIC;
               Y    : in  STD_LOGIC;
               Cin  : in  STD_LOGIC;
               S    : out STD_LOGIC);
    end component;
    
    signal G,P : STD_LOGIC_VECTOR(19 downto 0);
    signal W_S : STD_LOGIC_VECTOR(19 downto 0);
    signal W_C : STD_LOGIC_VECTOR(20 downto 0);
    signal A_S : STD_LOGIC_VECTOR(19 downto 0);
    signal B_S : STD_LOGIC_VECTOR(19 downto 0);
    
begin
 
    GEN_FULL_ADDERS : for i in 0 to 19 generate
    FA : Full_Adder
    port map (
        X   => A_S(i),
        Y   => B_S(i),
        Cin => W_C(i),        
        S   => W_S(i)
    );
    end generate GEN_FULL_ADDERS;
    
    A_S <= A1;
    B_S <= B1;
    
 GEN_CLA : for j in 0 to 19 generate
        P(j)     <= A_S(j) xor B_S(j);
        G(j)     <= A_S(j) and B_S(j);
        W_C(j+1) <= G(j) or (P(j) and W_C(j));
    end generate GEN_CLA;
    
    W_C(0) <= '0';
    Sum <= W_S;

end Behavioral;
