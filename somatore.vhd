
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity fullAdder is
 Port ( a : in STD_LOGIC;
        b : in STD_LOGIC;
      cin : in STD_LOGIC;
        s : out STD_LOGIC;
          cout : out STD_LOGIC);
end fullAdder;

architecture dataFlow of fullAdder is

begin
s<= a xor b xor cin;
cout<=((a xor b)nand cin) nand (a nand b); 

end dataFlow;
