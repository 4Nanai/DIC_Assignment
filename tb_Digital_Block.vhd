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

entity Digital_Block_tb is
end Digital_Block_tb;

architecture Behavioral of Digital_Block_tb is

    -- signals for DUT inputs and outputs
    signal DIN0, DIN1, DIN2, DIN3, DIN4, DIN5, DIN6, DIN7: std_logic; 
    signal CLK : std_logic := '0'; -- Clock Signal
    signal RST : std_logic := '0'; -- Reset Signal
    signal DOUT1 : std_logic; 
    signal AOUT1 : std_logic;
    signal AOUT2 : std_logic;
    signal AOUT3 : std_logic;

    -- component declaration for DUT
    component Digital_Block is
        port (
            DIN0, DIN1, DIN2, DIN3, DIN4, DIN5, DIN6, DIN7: in std_logic; 
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
        wait for 10 ns;
        RST <= '0';
        -- first input value 0000_0110 = -36 Degree Celsius
        DIN0 <= '0';
        DIN1 <= '0';
        DIN2 <= '0';
        DIN3 <= '0';
        DIN4 <= '0';
        DIN5 <= '1';
        DIN6 <= '1';
        DIN7 <= '0';
        wait for 30 ns;
        -- second input value 0010_0011 = -16.5 Degree Culsius
        DIN0 <= '0';
        DIN1 <= '0';
        DIN2 <= '1';
        DIN3 <= '0';
        DIN4 <= '0';
        DIN5 <= '0';
        DIN6 <= '1';
        DIN7 <= '1';
        wait for 20 ns;
        -- third input value 0111_0101 = 19.5 Degree Culsius
        DIN0 <= '0';
        DIN1 <= '1';
        DIN2 <= '1';
        DIN3 <= '1';
        DIN4 <= '0';
        DIN5 <= '1';
        DIN6 <= '0';
        DIN7 <= '1';
        wait for 40 ns;
        -- fourth input value 1111_0110 = 84 Degree Celsius
        DIN0 <= '1';
        DIN1 <= '1';
        DIN2 <= '1';
        DIN3 <= '1';
        DIN4 <= '0';
        DIN5 <= '1';
        DIN6 <= '1';
        DIN7 <= '0';
        wait for 30 ns;
        -- stop the simulation
        assert false report "End of simulation" severity failure;
    end process;

end Behavioral;