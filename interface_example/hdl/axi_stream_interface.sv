interface AXI_STREAM_BUS
#(
    parameter int unsigned AXI_DATA_WIDTH = 32
);

    logic                      valid;
    logic                      last;
    logic [AXI_DATA_WIDTH-1:0] data;
    logic                      ready;

    modport MASTER
    (
        input  valid,
        input  last,
        input  data,
        output ready
    );

    modport SLAVE
    (
        output valid,
        output last,
        output data,
        input  ready
    );

endinterface