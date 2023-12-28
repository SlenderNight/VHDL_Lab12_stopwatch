module synchronizer (
    asynch_in,
    clk,
    synch_out
);
    input asynch_in, clk;
    output synch_out;

    wire q1;
    
    //第一级d触发器
    dffer dffer_inst1(.d(asynch_in), .clk(clk), .r(1'b0), .q(q1), .en(1'b1));

    //第二级d触发器
    dffer dffer_inst2(.d(q1), .clk(clk), .r(1'b0), .q(synch_out), .en(1'b1));
endmodule