`timescale 1 ns / 1 ps

module axi_stream_interface_testbench;

    reg         clk           = 0;
    reg         resetn;

    wire        s_axis_clk;
    wire        s_axis_resetn;

    wire        s_axis_valid;
    wire        s_axis_last;
    wire [31:0] s_axis_data;
    wire        s_axis_ready  = 0;

    wire        m_axis_valid  = 0;
    wire        m_axis_last   = 1;
    wire [31:0] m_axis_data   = 32'h0A1B2C3D;
    wire        m_axis_ready;

    AXI_STREAM_BUS m_axis_tb();
    AXI_STREAM_BUS s_axis_tb();

    task resetn_generate;
        begin
            #0  resetn = 1;
            #90 resetn = 0;
            #10 resetn = 1;
        end
    endtask

    always #5 clk = ~clk;

    initial begin
        resetn_generate();
    end

    axi_stream_interface_top axi_stream_interface_top_inst
    (
        .s_axis_clk     ( s_axis_clk    ),
        .s_axis_resetn  ( s_axis_resetn ),
        .m_axis         ( m_axis_tb     ),
        .s_axis         ( s_axis_tb     )
    );

    assign s_axis_clk      = clk;
    assign s_axis_resetn   = resetn;

    assign s_axis_valid    = s_axis_tb.valid;
    assign s_axis_last     = s_axis_tb.last;
    assign s_axis_data     = s_axis_tb.data;
    assign s_axis_tb.ready = s_axis_ready;

    assign m_axis_tb.valid = m_axis_valid;
    assign m_axis_tb.last  = m_axis_last;
    assign m_axis_tb.data  = m_axis_data;
    assign m_axis_ready    = m_axis_tb.ready;

endmodule