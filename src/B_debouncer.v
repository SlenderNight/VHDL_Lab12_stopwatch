module debouncer (
    clk,
    in,
    reset,
    out
);
    parameter sim = 0;

    input clk, in, reset;
    output out;

    wire pulse1kHz;
    wire timer_clr, timer_done;

    //分频�??
    counter_n #(.n(sim ? 32 : 100000), .counter_bits(sim ? 5 : 17)) 
        counter_n_inst(.clk(clk), .en(1'b1), .r(1'b0), .co(pulse1kHz));

    //创建计时�??
    timer #(.period(10), .count_bits(5)) 
        timer_inst(.clk(clk), .en(pulse1kHz), .timer_clr(timer_clr), .timer_done(timer_done));

    //创建控制�??
    Button_controler Button_controler_inst(.clk(clk), 
                             .in(in), 
                             .reset(reset), 
                             .timer_clr(timer_clr), 
                             .timer_done(timer_done), 
                             .out(out));
endmodule