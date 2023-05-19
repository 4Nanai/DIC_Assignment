----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2023/05/19 19:15:58
-- Design Name: 
-- Module Name: tb_Digital_Logic - Behavioral
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

-- testbench for Digital_Block
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Digital_Block_tb is
end Digital_Block_tb;

architecture Behavioral of Digital_Block_tb is

    -- signals for DUT inputs and outputs
    signal DIN0, DIN1, DIN2, DIN3, DIN4, DIN5, DIN6, DIN7, DIN8, DIN9, DIN10, DIN11 : std_logic; 
    signal CLK : std_logic := '0'; 
    signal RST : std_logic := '0'; -- Reset Signal
    signal DOUT1 : std_logic; 
    signal AOUT1 : std_logic;
    signal AOUT2 : std_logic;
    signal AOUT3 : std_logic;

    -- component declaration for DUT
    component Digital_Block is
        port (
            DIN0, DIN1, DIN2, DIN3, DIN4, DIN5, DIN6, DIN7, DIN8, DIN9, DIN10, DIN11 : in std_logic; 
            CLK : in std_logic; 
            RST : in std_logic; -- Reset Signal
            DOUT1 : out std_logic; 
            AOUT1 : out std_logic;
            AOUT2 : out std_logic;
            AOUT3 : out std_logic
        );
    end component;

begin

    -- instantiate DUT with port map
    DUT: Digital_Block port map (
        DIN0 => DIN0,
        DIN1 => DIN1,
        DIN2 => DIN2,
        DIN3 => DIN3,
        DIN4 => DIN4,
        DIN5 => DIN5,
        DIN6 => DIN6,
        DIN7 => DIN7,
        DIN8 => DIN8,
        DIN9 => DIN9,
        DIN10 => DIN10,
        DIN11 => DIN11,
        CLK => CLK,
        RST => RST,
        DOUT1 => DOUT1,
        AOUT1 => AOUT1,
        AOUT2 => AOUT2,
        AOUT3 => AOUT3
    );

    -- generate clock signal with 1 MHz frequency
    
    CLK <= not CLK after 0.5 ns;

    -- generate input signals with some random values
    process
    begin
        RST <= '1';
        wait for 5 ns;
        RST <= '0';
        wait for 19000000 ns;
        -- first input value
        DIN0 <= '0';
        DIN1 <= '0';
        DIN2 <= '0';
        DIN3 <= '0';
        DIN4 <= '0';
        DIN5 <= '0';
        DIN6 <= '0';
        DIN7 <= '0';
        DIN8 <= '0';
        DIN9 <= '0';
        DIN10 <= '1';
        DIN11 <= '0';
        wait for 2000000 ns;
        -- second input value
        DIN0 <= '0';
        DIN1 <= '0';
        DIN2 <= '0';
        DIN3 <= '0';
        DIN4 <= '0';
        DIN5 <= '1';
        DIN6 <= '0';
        DIN7 <= '0';
        DIN8 <= '0';
        DIN9 <= '0';
        DIN10 <= '1';
        DIN11 <= '0';       
        wait for 4000000 ns;
        -- third input value
        DIN0 <= '0';
        DIN1 <= '0';
        DIN2 <= '1';
        DIN3 <= '0';
        DIN4 <= '0';
        DIN5 <= '0';
        DIN6 <= '0';
        DIN7 <= '0';
        DIN8 <= '0';
        DIN9 <= '0';
        DIN10 <= '1';
        DIN11 <= '0';
        wait for 3000000 ns;
        -- fourth input value
        DIN0 <= '0';
        DIN1 <= '0';
        DIN2 <= '0';
        DIN3 <= '0';
        DIN4 <= '0';
        DIN5 <= '0';
        DIN6 <= '0';
        DIN7 <= '0';
        DIN8 <= '1';
        DIN9 <= '1';
        DIN10 <= '1';
        DIN11 <= '1';
        wait for 2000000 ns;
        -- stop the simulation
        assert false report "End of simulation" severity failure;
    end process;

end Behavioral;