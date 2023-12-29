library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Combined_Testbench is
end Combined_Testbench;

architecture Behavioral of Combined_Testbench is
    -- Signalen voor top_PS2_Controllers
    signal clk_tb, clr_tb, ps2c_tb, ps2d_tb : std_logic;
    signal Up_Arrow_tb, Down_Arrow_tb, Up_Down_tb, Down_Down_tb : std_logic;

    -- Signalen voor PS2_ArrowKeys
    signal ps2_clk_tb, ps2_clr_tb, ps2_data_tb, ps2_clock_tb : std_logic;
    signal Up_tb, Down_tb : std_logic;

    -- Signalen voor UpDownKeys_Controller
signal clk_ud, rst_ud : std_logic;
signal data_ud : std_logic_vector(7 downto 0);
signal valid_ud, Up_ud, Down_ud : std_logic;

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

    component PS2_ArrowKeys is
        Generic(clk_freq: INTEGER := 100_000_000); --system clock frequency in Hz 
        Port ( clk : in STD_LOGIC;
               clr : in STD_LOGIC;
               ps2d : in STD_LOGIC;
               ps2c : in STD_LOGIC;
               Up : out STD_LOGIC;
               Down : out STD_LOGIC);
    end component PS2_ArrowKeys;

    component UpDownKeys_Controller is
        Port ( clk : in STD_LOGIC;
               rst : in STD_LOGIC;
               data : in STD_LOGIC_VECTOR (7 downto 0);
               valid : in STD_LOGIC;
               Up : out STD_LOGIC;
               Down : out STD_LOGIC);
    end component UpDownKeys_Controller;

begin
    -- Instantieer de top-level controller
    UUT_top_PS2_Controllers: top_PS2_Controllers port map (
        clk => clk_tb,
        clr => clr_tb,
        ps2c => ps2c_tb,
        ps2d => ps2d_tb,
        Up_Arrow => Up_Arrow_tb,
        Down_Arrow => Down_Arrow_tb,
        Up_Down => Up_Down_tb,
        Down_Down => Down_Down_tb
    );

    -- Instantieer de PS2_ArrowKeys-component
    UUT_PS2_ArrowKeys: PS2_ArrowKeys port map (
        clk => ps2_clk_tb,
        clr => ps2_clr_tb,
        ps2c => ps2_clock_tb,
        ps2d => ps2_data_tb,
        Up => Up_tb,
        Down => Down_tb
    );

    -- Instantieer de UpDownKeys_Controller-component
    UUT_UpDownKeys_Controller: UpDownKeys_Controller port map (
        clk => clk_ud,
        rst => rst_ud,
        data => data_ud,
        valid => valid_ud,
        Up => Up_ud,
        Down => Down_ud
    );

    -- Voeg hier de simulatieprocessen voor de drie componenten toe

    -- Simulatieproces voor top_PS2_Controllers
    process
    begin
        -- Simuleer klok voor top_PS2_Controllers
        clk_tb <= '0';
        wait for 5 ns;  -- Halve klokperiode
        clk_tb <= '1';
        wait for 5 ns;  -- Halve klokperiode
    end process;

    -- Simulatieproces voor PS2_ArrowKeys
    process
    begin
        -- Simuleer klok voor PS2_ArrowKeys
        ps2_clk_tb <= '0';
        wait for 10 ns;  -- Halve klokperiode
        ps2_clk_tb <= '1';
        wait for 10 ns;  -- Halve klokperiode
    end process;

    -- Simulatieproces voor UpDownKeys_Controller
    process
    begin
        -- Simuleer klok voor UpDownKeys_Controller
        clk_ud <= '0';
        wait for 7 ns;  -- Halve klokperiode
        clk_ud <= '1';
        wait for 7 ns;  -- Halve klokperiode
    end process;

    -- Simulatieproces voor UpDownKeys_Controller invoerdata
    process
    begin
        -- Simuleer invoerdata voor UpDownKeys_Controller
        data_ud <= "00000001"; -- Voorbeeld van een 8-bit invoer
        wait for 50 ns;  -- Wacht even
        data_ud <= "00001010"; -- Voorbeeld van een andere 8-bit invoer
        wait; -- Wacht voor altijd op simulatiebeëindiging
    end process;

end Behavioral;