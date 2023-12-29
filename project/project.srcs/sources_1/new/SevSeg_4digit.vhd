library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity SevSeg_4digit is
    Port (
        clk : in STD_LOGIC;
        in0, in1, in2, in3 : in STD_LOGIC_VECTOR(3 downto 0);
        a, b, c, d, e, f, g, dp : out STD_LOGIC;
        an : out STD_LOGIC_VECTOR(3 downto 0)
    );
end entity SevSeg_4digit;

architecture Behavioral of SevSeg_4digit is
    constant N : integer := 18;
    signal count : STD_LOGIC_VECTOR(N-1 downto 0) := (others => '0');
    signal digit_val : STD_LOGIC_VECTOR(3 downto 0);
    signal digit_en : STD_LOGIC_VECTOR(3 downto 0);
    signal sseg_LEDs : STD_LOGIC_VECTOR(6 downto 0);

begin
    process(clk)
    begin
        if rising_edge(clk) then
            count <= count + "1";
        end if;
    end process;

    process(count, in0, in1, in2, in3)
    begin
        digit_en <= "1111"; -- default
        digit_val <= in0; -- default

        case count(N-1 downto N-2) is
            when "00" => -- select first 7Seg.
                digit_val <= in0;
                digit_en <= "1110";
            when "01" => -- select second 7Seg.
                digit_val <= in1;
                digit_en <= "1101";
            when "10" => -- select third 7Seg.
                digit_val <= in2;
                digit_en <= "1011";
            when others => -- select fourth 7Seg.
                digit_val <= in3;
                digit_en <= "0111";
        end case;
    end process;

    process(digit_val)
    begin
        sseg_LEDs <= "1111111"; -- default
        case digit_val is
            when "0000" => sseg_LEDs <= "1000000"; -- to display 0
            when "0001" => sseg_LEDs <= "1111001"; -- to display 1
            when "0010" => sseg_LEDs <= "0100100"; -- to display 2
            when "0011" => sseg_LEDs <= "0110000"; -- to display 3
            when "0100" => sseg_LEDs <= "0011001"; -- to display 4
            when "0101" => sseg_LEDs <= "0010010"; -- to display 5
            when "0110" => sseg_LEDs <= "0000010"; -- to display 6
            when "0111" => sseg_LEDs <= "1111000"; -- to display 7
            when "1000" => sseg_LEDs <= "0000000"; -- to display 8
            when "1001" => sseg_LEDs <= "0010000"; -- to display 9
            when others => sseg_LEDs <= "0111111"; -- dash
        end case;
    end process;

    an <= digit_en;
    (g, f, e, d, c, b, a) <= sseg_LEDs;
    dp <= '1'; -- turn dp off

end architecture Behavioral;
