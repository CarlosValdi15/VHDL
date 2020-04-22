library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SOMATORE_PIXELS is
    Port ( clk  : in std_logic;
           P1   : in  STD_LOGIC_VECTOR (7 downto 0);
           P2   : in  STD_LOGIC_VECTOR (7 downto 0);
           P3   : in  STD_LOGIC_VECTOR (7 downto 0);
           P4   : in  STD_LOGIC_VECTOR (7 downto 0);
           Sum_out : out STD_LOGIC_VECTOR (9 downto 0)
             );
end SOMATORE_PIXELS;

architecture Behavioral of SOMATORE_PIXELS is

component CLA_8 is
    Port ( A   : in  STD_LOGIC_VECTOR (7 downto 0);
           B   : in  STD_LOGIC_VECTOR (7 downto 0);
           Sum : out STD_LOGIC_VECTOR (8 downto 0)
           );
end component; 

component CLA_9B is
    Port ( A8   : in  STD_LOGIC_VECTOR (8 downto 0);
           B8   : in  STD_LOGIC_VECTOR (8 downto 0);
          Sum10 : out STD_LOGIC_VECTOR (9 downto 0)  
          ); 
end component; 

    signal A9    : STD_LOGIC_VECTOR(8 downto 0);
    signal B9    : STD_LOGIC_VECTOR(8 downto 0);
    signal sum    : STD_LOGIC_VECTOR(9 downto 0);
    
begin

CarryLA_8: CLA_8 port map (P1,P2,A9);
CarryLA2_8: CLA_8 port map (P3,P4,B9);
CarryLA_9B:  CLA_9B port map (A9,B9,sum);

  ff: process( clk )     
           begin         
            if( rising_edge(clk)) then              
            Sum_out <=sum;         
            end if;     
          end process; 

end Behavioral;
