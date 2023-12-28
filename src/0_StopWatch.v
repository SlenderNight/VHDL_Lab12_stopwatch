module stopwatch (
    clk,
    ButtonIn,
    a,
    b,
    c,
    d,
    e,
    f,
    g,
    dp,
    pos,
    reset
);
    parameter sim = 0;

    input clk, ButtonIn, reset;
    output a, b, c, d, e, f, g, dp;
    output [3:0] pos;

    wire pulse400Hz, pulse10Hz, ButtonOut, count, clr;
    wire [3:0] q0, qm;
    wire [7:0] qs, qs_bcd;

    assign dp = pos[1];

    //创建分频器I
    counter_n #(.n(sim ? 2 : 250000), .counter_bits(sim ? 1 : 18))
        counter_inst_I (.clk(clk), .en(1'b1), .co(pulse400Hz));

    //创建分频器II
    counter_n #(.n(sim ? 10 : 40), .counter_bits(sim ? 4 : 6))
        counter_inst_II (.clk(clk), .en(pulse400Hz), .co(pulse10Hz));

    //创建按钮处理模块实例
    button_unit #(.sim(sim))
        button_unit_inst(.clk(clk), .reset(reset), .ButtonIn(ButtonIn), .ButtonOut(ButtonOut));
    
    //创建控制器实例
    control control_inst(.clk(clk), .reset(reset), .in(ButtonOut), .count(count), .clr(clr));

    //创建计时器组实例
    timing timing_inst(.clk(clk), .r(clr), .en(pulse10Hz && count), .q0(q0), .qs(qs), .qm(qm));

    //创建二进制转BCD码实例
    bin2bcd bin2bcd_inst(.bin_in(qs), .bcd_out(qs_bcd));

    //~创建数码显示器实例
    display display_inst(.clk(clk), 
                         .en(pulse400Hz), 
                         .d0(q0), 
                         .d1(qs_bcd[3:0]),
                         .d2(qs_bcd[7:4]),
                         .d3(qm),
                         .a(a),
                         .b(b),
                         .c(c),
                         .d(d),
                         .e(e),
                         .f(f),
                         .g(g),
                         .pos(pos));

endmodule