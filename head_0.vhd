

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity main is
    Port ( clk : in STD_LOGIC;
           start : in STD_LOGIC;
           Pixel_filtrato : out STD_LOGIC_VECTOR (19 downto 0);
           valid : out STD_LOGIC);
end main;

architecture Behavioral of main is
    
     component controllo is
    Port ( clk : in STD_LOGIC;
           start : in STD_LOGIC;
           valid : out STD_LOGIC;
           clear : out STD_LOGIC;
           data : out STD_LOGIC_VECTOR (7 downto 0));
    end component;
    
    component FILTRO_PIXEL_FILTRATO is
 Port (  clk: in STD_LOGIC;
            clear: in STD_LOGIC;
            Pixel_in: in STD_LOGIC_VECTOR(7 DOWNTO 0);
            A,B,C,D,E,F : in STD_LOGIC_VECTOR(7 DOWNTO 0);
            Pixel_filtrato: out std_logic_vector (19 downto 0)
               );
    end component;
    
    signal clear : std_logic:='0';
    signal data : STD_LOGIC_VECTOR (7 downto 0);
    signal A: std_logic_vector(7 downto 0):="11111111";--  (-1)
    signal B: std_logic_vector(7 downto 0):="11111110"; --  (-2)
    signal C: std_logic_vector(7 downto 0):= "00000010";-- (2)
    signal D: std_logic_vector(7 downto 0):= "00000001";--  (1)
    signal E: std_logic_vector(7 downto 0):= "00000011";--   (3)
    signal F:std_logic_vector(7 downto 0):="00000100";--    (4)

begin
    
    ctrl: controllo port map (clk,start,valid,clear,data);
    convolutore : FILTRO_PIXEL_FILTRATO port map (clk,clear,data,A,B,C,D,E,F,Pixel_filtrato);

end Behavioral;
