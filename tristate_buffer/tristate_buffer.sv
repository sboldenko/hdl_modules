module tristate_buffer
#(
    parameter WIDTH = 4
)
(
    input              en,
    input  [WIDTH-1:0] i,
    output [WIDTH-1:0] o,
    inout  [WIDTH-1:0] io
);

    assign o  = io;
    assign io = en ? i : 'bZ;

endmodule