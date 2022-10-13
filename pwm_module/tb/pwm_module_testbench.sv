`timescale 1 ns / 100 ps

module pwm_module_testbench;

    localparam G_WIDTH_PWM_VALUE = 16;

    reg                          clk_i       = 0;
    reg                          reset_i        ;
    reg  [G_WIDTH_PWM_VALUE-1:0] pwm_value_i    ;
    wire                         pwm_o          ;

    task resetn_generate;
        begin
            #0  reset_i = 0;
            #90 reset_i = 1;
            #10 reset_i = 0;
        end
    endtask

    always #5 clk_i = ~clk_i;

    initial begin
        $display("------------- Start simulation! -------------");
        pwm_value_i = 16'h0578;
        resetn_generate();
        #10000000 pwm_value_i = 16'hAF09;
        #10000000 pwm_value_i = 16'hFF00;
        #10000000 pwm_value_i = 16'h0000;
        #10000000 pwm_value_i = 16'hFFFF;
        #10000000 pwm_value_i = 16'h0020;
        #10000000 pwm_value_i = 16'h5020;
        #10000000 $finish;
    end

    pwm_module
    #(G_WIDTH_PWM_VALUE)
    pwm_module_inst
    (.*);

endmodule