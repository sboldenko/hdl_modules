library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity pwm_module is

    generic
    (
        G_WIDTH_PWM_VALUE : integer := 8
    );
    port
    (
        clk_i       : in  std_logic;
        reset_i     : in  std_logic;
        pwm_value_i : in  std_logic_vector(G_WIDTH_PWM_VALUE-1 downto 0);
        pwm_o       : out std_logic
    );

end entity pwm_module;

architecture rtl of pwm_module is

    signal counter : std_logic_vector(G_WIDTH_PWM_VALUE-1 downto 0);

begin

    process(clk_i)
    begin
        if rising_edge(clk_i) then
            if (reset_i = '1') then
                counter <= (others => '0');
            else
                counter <= counter + '1';

                if (counter < pwm_value_i) then
                    pwm_o <= '1';
                else
                    pwm_o <= '0';
                end if;
            end if;
        end if;
    end process;

end rtl;