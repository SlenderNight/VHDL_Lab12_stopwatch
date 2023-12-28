module timer(
    clk,
    en,
    timer_clr,
    timer_done
);
    parameter period = 10;
    parameter count_bits = 4;

    input clk, en, timer_clr;
    output timer_done;

    reg [count_bits - 1:0] count;
    reg timer_done;

    initial begin
        count = 0;
        timer_done = 0;
    end
    
    always @(posedge clk)
    begin
        if(en)
        begin
            //停止计时
            if(timer_clr)
            begin
                timer_done = 0;
                count = 0;
            end
            //开始计时
            else
                if (count >= period - 1)
                begin
                    timer_done = 1;
                    count = 0;
                end
                else
                begin
                    count = count + 1;
                end
        end
    end
     
endmodule