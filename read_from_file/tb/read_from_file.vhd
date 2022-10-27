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

entity read_from_file is
end read_from_file;
 
architecture behavior of read_from_file is 

	constant CONST_CLK_PERIOD   : time := 10 ns; --100 MHz
    signal   clk                : std_logic:= '0';
	
    constant CONST_FILE_NAME_RD : string := "read_file.txt";
	file     file_read          : text;

	signal   valid_v1           : std_logic:= '0';
	signal   data_v1            : std_logic_vector(31 downto 0):= (others => '0'); 

	signal   valid_v2           : std_logic:= '0';
	signal   data_v2            : std_logic_vector(31 downto 0):= (others => '0'); 


	procedure FUNC_READ_FILE
	(
		filename               : string;
		clk_period             : time;
		signal   clk           : in  std_logic;
		signal   valid_out     : out std_logic;
		signal   data_out      : out std_logic_vector(31 downto 0) 
	) is
		file     file_for_read : text;
		variable in_line       : line;
		variable in_data       : std_logic_vector(31 downto 0);
	begin
		file_open(file_for_read, filename, read_mode);

		wait until falling_edge(clk);

		while not endfile(file_for_read) loop 
			for i in 1 to 10 loop
				readline(file_for_read, in_line);
				hread(in_line, in_data);
				data_out <= in_data;
				valid_out <= '1';	
				wait for clk_period;
			end loop;
			
			valid_out <= '0';

			wait for 100 ns;

		end loop;

		file_close(file_for_read);
	end;

begin

	clk_process: process
	begin
		clk <= '0';
		wait for CONST_CLK_PERIOD / 2;
		clk <= '1';
		wait for CONST_CLK_PERIOD / 2;
	end process;

	read_file_v1: process
		variable input_line : line;
		variable input_data : std_logic_vector(31 downto 0);
	begin
		file_open(file_read, CONST_FILE_NAME_RD, read_mode);

		wait for 100 ns;
		wait until falling_edge(clk);

		while not endfile(file_read) loop 
			for i in 1 to 10 loop
				readline(file_read, input_line);
				hread(input_line, input_data);
				data_v1 <= input_data;
				valid_v1 <= '1';	
				wait for CONST_CLK_PERIOD;
			end loop;
			
			valid_v1 <= '0';

			wait for 100 ns;

		end loop;

		file_close(file_read);

		wait;
	end process;

	read_file_v2: process
	begin
		wait for 2500 ns;
		FUNC_READ_FILE(CONST_FILE_NAME_RD, CONST_CLK_PERIOD, clk, valid_v2, data_v2);
		wait;
	end process; 

end;	
