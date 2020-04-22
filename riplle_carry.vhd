
----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.09.2017 18:38:08
-- Design Name: 
-- Module Name: rippleCarry - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity rippleCarry is
Port ( a : in STD_LOGIC_VECTOR (9 downto 0);
       b : in STD_LOGIC_VECTOR (9 downto 0);
       sum : out STD_LOGIC_VECTOR (9 downto 0);
       carry : out STD_LOGIC);
end rippleCarry;

architecture Behavioral of rippleCarry is
component Full_Adder
    Port ( a : in STD_LOGIC;
               b : in STD_LOGIC;
               cin : in STD_LOGIC;
               s : out STD_LOGIC;
               cout : out STD_LOGIC);
     end component;
signal carry1:std_logic_vector(10 downto 0);
begin
carry1(0)<='0';
set : for i in 0 to 9 generate 
    uut: Full_Adder port map (a(i),b(i),carry1(i),sum(i),carry1(i+1));
    end generate set;
    carry <=carry1(10);
  

end Behavioral;
