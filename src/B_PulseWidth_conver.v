module PulseWidth_conver (
    in,
    clk,
    out
);
    input in, clk;
    output out;

    wire q;

    //第一级D触发器
    dffer dffer_inst_1(.d(in), .clk(clk), .r(1'b0), .q(q), .en(1'b1));

    assign out = (in && ~q);
endmodule