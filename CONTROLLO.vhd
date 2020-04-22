
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
use IEEE.NUMERIC_STD.ALL;


entity controllo is 

Port (clk: in STD_LOGIC;
      start: in STD_LOGIC;
      valid: out STD_LOGIC;
      clear : out STD_LOGIC;
      data : out STD_LOGIC_VECTOR(7 DOWNTO 0)
      );
end controllo;

architecture Behavioral of controllo is
 
 component blk_mem_gen_0 is 
 
 Port (    clka : IN STD_LOGIC;
 ena : IN STD_LOGIC;
 wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
 addra : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
 dina : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
 douta : OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
 end component;
 
 type miei_stati is (init,s1,s2,s3,s4);
 signal stato : miei_stati;
 signal n: unsigned (7 downto 0):= "00000000";
 signal addra, dina,douta : std_logic_vector (7 downto 0);
 signal wea: std_logic_vector (0 downto 0);
 signal ena : std_logic:='0';
 
begin

memoria : blk_mem_gen_0  port map (clk,ena,wea,addra,dina,douta);

process (clk, start)
begin 
 
if start ='1' then   stato <= init; clear <= '1'; addra <= "00000000"; valid <='0';  n <="00000000";  wea <="0"; ena<='0';
   -- stato inait
   elsif falling_edge (clk) then 
       
       if stato=init then stato <= s1; clear <= '1'; addra <= "00000000";valid <='0';  n <="00000000"; ena<='1';
       ---STATO 1
       elsif stato = s1 then stato <= s2; clear <= '0'; addra <= addra + "00000001" ; n <= n+1;  data<=douta; valid <='0';   ena<='1';
      ---STATO 2    
          elsif stato =s2 then 
          if n<"1000110" then clear<='0'; addra<=addra+"00000001"; n<=n+1;data<=douta;valid<='0';ena<='1';
       --STATO 3  
          else stato<=s3; valid <='1'; clear <= '0'; addra <= addra + "00000001"; n <= n+1; data<=douta;  ena<='1';
          end if;
        
       elsif stato =s3 then 
     --     if n  < 161 and n>=70
              if (n<"10100001"and n>="1000110") then clear<='0'; addra<=addra+"00000001"; n<=n+1;data<=douta;valid <='1';ena<='1';
         
         --STATO 4
              else stato<=s4; valid <='1'; data<="00000000"; clear <= '0'; 
              n <= n+1;  ena<='0';
              end if;
 --        
        elsif stato=s4 then 
             if (n>="10100001" and n<"11100110") then valid<='1';data<="00000000";clear<='0';n<=n+1;ena<='0';
             else stato<=init; clear <= '0'; addra <= "00000000"; valid <='0';  n <="00000000"; wea <="0"; ena<='0';
             end if;
       end if;
end if ; 
        
     end process;
        
 end Behavioral;
