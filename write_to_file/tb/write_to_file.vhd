--------------------------------------------------------------------------------
-- Engineer:     sboldenko
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_textio.all;

library std;
use std.textio.all;

entity write_to_file is
end write_to_file;

architecture behavior of write_to_file is 

    constant CONST_CLK_PERIOD   : time := 10 ns; --100 MHz
    signal clk                  : std_logic:= '0';
    
    constant CONST_FILE_NAME_WR : string := "write_file.txt";
    file fptrwr                 : TEXT;

    signal valid                : std_logic:= '0';
    signal last                 : std_logic:= '0';
    signal data                 : std_logic_vector(31 downto 0):= (others => '0'); 

begin
    
    generating_data_process: process
    begin
        wait for 300 ns;
        wait until rising_edge(clk);

        for i in 1 to 100 loop
            valid <= '1';
            data <= data + '1';
            wait for CONST_CLK_PERIOD;
        end loop;

        valid <= '0';
        data <= (others => '0');
        wait for 300 ns;
        wait until rising_edge(clk);

        for i in 1 to 100 loop
            valid <= '1';
            data <= data + '1';
            wait for CONST_CLK_PERIOD;
        end loop;

        valid <= '0';
        data <= (others => '0');
        wait for 300 ns;
        wait until rising_edge(clk);

        for i in 1 to 100 loop
            valid <= '1';
            data <= data + '1';

            if (i = 100) then
                last <= '1';
            end if;

            wait for CONST_CLK_PERIOD;
        end loop;

        valid <= '0';
        last <= '0';
        data <= (others => '0');
        wait;
    end process;


    write_to_file_process: process
        variable statwr   : FILE_OPEN_STATUS;
        variable out_line : line;
    begin
        file_open(statwr, fptrwr, CONST_FILE_NAME_WR, write_mode);
        wait until falling_edge(clk);

        if (valid = '1') then
            for k in 1 to 100 loop
                HWRITE(out_line, data, left, 8);
                WRITELINE(fptrwr, out_line);
                wait for CONST_CLK_PERIOD;
            end loop;
        end if;

        if (last = '1') then
            file_close(fptrwr);
        end if;
    end process;

    clk_process: process
    begin
        clk <= '0';
        wait for CONST_CLK_PERIOD / 2;
        clk <= '1';
        wait for CONST_CLK_PERIOD / 2;
    end process;

end;
