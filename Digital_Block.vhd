----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2023/05/19 16:44:39
-- Design Name: Chitose
-- Module Name: Parellel_In_Serial_Out - Behavioral
-- Project Name: PT1000_Proj.
-- Target Devices: xz7c020clg484_1
-- Tool Versions: 2019.1
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

entity Digital_Block is
    port (
        DIN0, DIN1, DIN2, DIN3, DIN4, DIN5, DIN6, DIN7: in std_logic; -- 8 bit ADC In, DIN0 (MSB), DIN11 (LSB)
        CLK : in std_logic; -- External Clock In
        RST : in std_logic; -- Reset Signal
        DOUT1 : out std_logic; -- Serial Out
        AOUT1 : out std_logic; -- Yellow LED Control
        AOUT2 : out std_logic; -- Red LED Control
        AOUT3 : out std_logic -- Green LED Control
    );
end Digital_Block;

architecture Behavioral of Digital_Block is -- Declare architecture

    signal Temp : std_logic_vector(7 downto 0); --Define a 12 bits signal containing temperature
    constant Min_Temp : std_logic_vector(7 downto 0) := "00001000"; -- Define a temperature of -25 Celsius Degree (Assuming 0000_0000_1000)
    constant Max_Temp : std_logic_vector(7 downto 0) := "10000000"; -- Define a temperature of +75 Celsius Degree (Assuming 0000_1000_0000)
    constant Zero_Temp : std_logic_vector(7 downto 0) := "00010000"; -- Define a temperature of 0 Degree (Assuming 0001_0000)
    constant Device_ID : std_logic_vector(3 downto 0) := "0001"; -- Define the Device ID (Assuming "1")
    signal Byte : std_logic_vector(11 downto 0); -- Merge Device ID & Temperature
    signal Right_Shift : std_logic_vector(11 downto 0); -- Right shift register
    signal Counter : integer range 0 to 20 := 0; -- Define "20 seconds" (Assuming 1MHz clock frequency)
    signal Serial_Out : integer range 0 to 11; -- Count for shift register

begin
    process (CLK) -- Set CLK as sensitive signal
    begin
        Temp <= DIN0 & DIN1 & DIN2 & DIN3 & DIN4 & DIN5 & DIN6 & DIN7; -- Write ADC signal into temperature
        Byte <= Device_ID & Temp; -- Merge Device ID and Temperature
        AOUT1 <= '0';
        AOUT2 <= '0';
        AOUT3 <= '0';
        
        if Temp < Min_Temp or Temp > Max_Temp then
        AOUT1 <= '1'; -- illuminate Yellow LED
        AOUT2 <= '0';
        AOUT3 <= '0';
        elsif Temp < Zero_Temp and Temp > Min_Temp then
        AOUT1 <= '0'; 
        AOUT2 <= '1'; -- illuminate Red LED
        AOUT3 <= '0';
        elsif Temp > Zero_Temp and Temp < Max_Temp then
        AOUT1 <= '0'; 
        AOUT2 <= '0';
        AOUT3 <= '1'; -- illuminate Green LED
        end if;
        
        if RST = '1' then
            Counter <= 0;
            Temp <= (others => '0');
        elsif rising_edge(CLK) then -- always @(clk posedge)
            Counter <= Counter + 1;
            if Counter = 20 then -- If reaches 20 ms
                Counter <= 0; -- Reset Counter
                Serial_Out <= 11; -- Set shift register counter to be 15 
                Right_Shift <= Byte; -- Write byte into shift register 
            else -- If Counter != 2000
                if Serial_Out > 0 then -- If Serial_Out != 0
                    Right_Shift <= '0' & Right_Shift(11 downto 1); -- Right shift 1 bit
                    Serial_Out <= Serial_Out - 1; -- Serial_Out -= 1;
                end if;
            end if;
        end if;
    end process;
    DOUT1 <= Right_Shift(0); -- Output LSB
end Behavioral;
