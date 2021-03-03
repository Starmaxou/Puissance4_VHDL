library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity registre is
     port (
    in_data : in std_logic_vector(13 downto 0);
    ce : in std_logic;
    clk : in std_logic;
    reset : in std_logic;
    out_data : out std_logic_vector(13 downto 0)
    );
end registre;

architecture Behavioral of registre is

begin

    resgistre : process(clk,reset)
        begin
            if(reset='1')then
                out_data <= (others => '0');
            elsif clk = '1' and clk'event then
                if(ce='1')then
                        out_data <= in_data;
                end if;
            end if;
    end process;
end Behavioral;