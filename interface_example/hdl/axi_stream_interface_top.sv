module axi_stream_interface_top
(
    input wire            s_axis_clk,
    input wire            s_axis_resetn,

    AXI_STREAM_BUS.MASTER m_axis,
    AXI_STREAM_BUS.SLAVE  s_axis
);


    wire        m_axis_valid;
    wire        m_axis_last;
    wire [31:0] m_axis_data;

    wire        s_axis_ready;

    assign s_axis.valid = 1;
    assign s_axis.last  = 0;
    assign s_axis.data  = 32'hABCDABCD;
    assign s_axis_ready = s_axis.ready;

    assign m_axis_valid = m_axis.valid;
    assign m_axis_last  = m_axis.last;
    assign m_axis_data  = m_axis.data;
    assign m_axis.ready = 1;

endmodule