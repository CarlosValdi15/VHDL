library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FIFO_m is
    Port (
           clk      : in STD_LOGIC;
           clear    : in STD_LOGIC;
           DATA_IN        : in STD_LOGIC_VECTOR (7 downto 0);
           Q        : out STD_LOGIC_VECTOR (7 downto 0)
           );
end FIFO_m; 

architecture Behavioral of FIFO_m is

  type MEMORIA is array (0 to 26) of STD_LOGIC_VECTOR (7 downto 0);
  signal Q_int :MEMORIA;
  signal array_zeros : std_logic_vector(7 downto 0) :=(others=>'0');


begin

    process (clk,clear)
    begin
    if (clear = '1')
        then
          g1: for i in 0 to 26 loop
          Q_int(i)<= array_zeros;
          end loop;
          
     elsif (rising_edge(clk))
      
      then  
       Q_int(0)<=DATA_IN;
          g2: for j in 1 to 26 loop
          Q_int(j)<=Q_int(j-1);
       end loop;
    end if;
  end process;
 Q <= Q_int(26);
end Behavioral;
