library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity button_synchronizer is
port
(
    clk_i     : in  std_logic;
    reset_n_i : in  std_logic;

    button_i  : in  std_logic;
    sync_o    : out std_logic
);
end button_synchronizer;

architecture behavioral of button_synchronizer is

    type sync_states is
    (
        S_IDLE,
        S_DETECT,
        S_WAIT,
        S_CHECK
    );

    signal button_sync  : std_logic_vector(1 downto 0);
    signal sync_counter : std_logic_vector(9 downto 0);
    signal sync_state   : sync_states;

begin

    process(clk_i)
    begin
        if rising_edge(clk_i) then
            button_sync <= button_sync(0) & button_i;
        end if;
    end process;

    process(clk_i)
    begin
        if rising_edge(clk_i) then
            if (reset_n_i = '0') then
                sync_o     <= '0';
                sync_state <= S_IDLE;
            else
                case(sync_state) is
                    when S_IDLE =>
                        sync_counter <= (others => '0');

                        if (button_sync(1) = '1') then
                            sync_state <= S_DETECT;
                        end if;
                    when S_DETECT =>
                        sync_counter <= sync_counter + '1';

                        if (sync_counter = x"3FF") then
                            sync_state <= S_WAIT;
                        end if;
                    when S_WAIT =>
                        if (button_sync(1) = '1') then
                            sync_o <= '1';
                        end if;

                        sync_state <= S_CHECK;
                    when S_CHECK =>
                        sync_o <= '0';

                        if (button_sync(1) = '0') then
                            sync_state <= S_IDLE;
                        end if;
                end case;
            end if;
        end if;
    end process;

end behavioral;
