library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity reg_L_C is
     port (
        in_data_L : in std_logic_vector(2 downto 0);
        in_data_C : in std_logic_vector(2 downto 0);
        ce : in std_logic;
        clk : in std_logic;
        reset : in std_logic;
        out_data_L : out std_logic_vector(2 downto 0);
        out_data_C : out std_logic_vector(2 downto 0)
    );
end reg_L_C;

architecture Behavioral of reg_L_C is

begin

    resgistre : process(clk,reset)
        begin
            if(reset='1')then
                out_data_L <= (others => '0');
                out_data_C <= (others => '0');
            elsif clk = '1' and clk'event then
                if(ce='1')then
                        out_data_L <= in_data_L;
                        out_data_C <= in_data_C;
                end if;
            end if;
    end process;
end Behavioral;