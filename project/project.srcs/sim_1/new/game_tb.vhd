library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top_PS2_Controllers_Testbench is
end top_PS2_Controllers_Testbench;

architecture Behavioral of top_PS2_Controllers_Testbench is
    constant CLK_PERIOD : time := 10 ns; -- Klokperiode (voor simulatie)

    signal clk_tb, clr_tb, ps2c_tb, ps2d_tb : std_logic;
    signal Up_Arrow_tb, Down_Arrow_tb, Up_Down_tb, Down_Down_tb : std_logic;

    component top_PS2_Controllers is
        Port ( clk : in STD_LOGIC;
               clr : in STD_LOGIC;
               ps2c : in STD_LOGIC;
               ps2d : in STD_LOGIC;
               Up_Arrow : out STD_LOGIC;
               Down_Arrow : out STD_LOGIC;
               Up_Down : out STD_LOGIC;
               Down_Down : out STD_LOGIC);
    end component top_PS2_Controllers;

begin
    -- Instantieer de top-level controller
    UUT: top_PS2_Controllers port map (
        clk => clk_tb,
        clr => clr_tb,
        ps2c => ps2c_tb,
        ps2d => ps2d_tb,
        Up_Arrow => Up_Arrow_tb,
        Down_Arrow => Down_Arrow_tb,
        Up_Down => Up_Down_tb,
        Down_Down => Down_Down_tb
    );

    -- Clock process
    clk_process: process
    begin
        while now < 1000 ns loop -- Simuleer 1000 ns kloktijd
            clk_tb <= '0';
            wait for CLK_PERIOD / 2;
            clk_tb <= '1';
            wait for CLK_PERIOD / 2;
        end loop;
        wait; -- Wacht voor altijd op simulatiebeëindiging
    end process clk_process;

    -- Stimulus process om invoersignalen te genereren (bijv. PS/2 signalen)
    stimulus_process: process
    begin
        clr_tb <= '0'; -- Houd de reset uitgeschakeld
        ps2c_tb <= '0'; -- Simuleer PS/2 clock laag
        ps2d_tb <= '0'; -- Simuleer PS/2 data laag
        wait for 20 ns;

        -- Druk eerst knop 1 in
        ps2c_tb <= '0'; -- Startbit
        ps2d_tb <= '0'; -- Startbit
        wait for CLK_PERIOD;

        ps2c_tb <= '1'; -- Stopbit
        ps2d_tb <= '1'; -- Stopbit
        wait for CLK_PERIOD;

        -- Wacht even voordat de tweede knop wordt ingedrukt
        wait for 50 ns;

        -- Druk vervolgens knop 2 in
        ps2c_tb <= '0'; -- Startbit
        ps2d_tb <= '1'; -- Startbit (knop 2)
        wait for CLK_PERIOD;

        ps2c_tb <= '1'; -- Stopbit
        ps2d_tb <= '0'; -- Stopbit
        wait for CLK_PERIOD;

        wait;
    end process stimulus_process;

end Behavioral;
