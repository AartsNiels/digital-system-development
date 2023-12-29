library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top_PS2_Controllers is
    Port ( clk : in STD_LOGIC;
           clr : in STD_LOGIC;
           ps2c : in STD_LOGIC;
           ps2d : in STD_LOGIC;
           Up_Arrow : out STD_LOGIC;
           Down_Arrow : out STD_LOGIC;
           Up_Down : out STD_LOGIC;
           Down_Down : out STD_LOGIC);
end top_PS2_Controllers;

architecture Behavioral of top_PS2_Controllers is

    component PS2_ArrowKeys is
        Generic(clk_freq: INTEGER := 100_000_000); -- system clock frequency in Hz
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

    signal ps2_Up, ps2_Down : STD_LOGIC;
    signal up_down_Up, up_down_Down : STD_LOGIC;
    signal ps2d_signal : std_logic_vector(7 downto 0);

begin
    U1: PS2_ArrowKeys 
        Port map ( clk => clk,
                   clr => clr,
                   ps2d => ps2d,
                   ps2c => ps2c,
                   Up => ps2_Up,
                   Down => ps2_Down);

    U2: UpDownKeys_Controller
        Port map ( clk => clk,
                   rst => clr,
                   data => ps2d_signal,
                   valid => ps2_Up,
                   Up => up_down_Up,
                   Down => up_down_Down);

    Up_Arrow <= ps2_Up;
    Down_Arrow <= ps2_Down;
    Up_Down <= up_down_Up;
    Down_Down <= up_down_Down;

end Behavioral;
