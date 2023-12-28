module timing (
    clk,
    r,
    en,
    q0,
    qs,
    qm
);
    input clk, r, en;

    output [3:0] q0, qm;
    output [7:0] qs;

    wire q0_to_qs, qs_to_qm;

    //创建十分之一秒计时器
    timing_counter #(.n(10), .counter_bits(4))
    timing_counter_q0 (.en(en), .clk(clk), .r(r), .co(q0_to_qs), .q(q0));

    //创建秒位计时器
    timing_counter #(.n(60), .counter_bits(8))
    timing_counter_qs (.en(q0_to_qs), .clk(clk), .r(r), .co(qs_to_qm), .q(qs));

    //创建分位计时器
    timing_counter #(.n(10), .counter_bits(4))
    timing_counter_qm (.en(qs_to_qm), .clk(clk), .r(r), .co(co), .q(qm));
endmodule