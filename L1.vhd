library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity serial_register is

Port(   clk   : in std_logic;
        clear : in std_logic;
        Data_in: in std_logic_vector(7 downto 0);
        Pixel_out0: inout std_logic_vector(7 downto 0);
        Pixel_out1: inout std_logic_vector(7 downto 0);
        Pixel_out2: inout std_logic_vector(7 downto 0);
        Pixel_out3: inout std_logic_vector(7 downto 0);
        Pixel_out4: inout std_logic_vector(7 downto 0) );

end serial_register;

architecture Behavioral of serial_register is

begin

 a1: process (clk,clear)
 begin
 if clear = '1' 
 
 then
     Pixel_out0 <= "00000000";
     Pixel_out1 <= "00000000";
     Pixel_out2 <= "00000000";
     Pixel_out3 <= "00000000";
     Pixel_out4 <= "00000000";
     
 elsif  (rising_edge(clk))
    then
    Pixel_out0 <= Data_in;
    Pixel_out1 <= Pixel_out0;
    Pixel_out2 <= Pixel_out1;
    Pixel_out3 <= Pixel_out2;
    Pixel_out4 <= Pixel_out3;
 end if;
 end process;

end Behavioral;
