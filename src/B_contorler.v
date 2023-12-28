module Button_controler (
    clk,
    in,
    reset,
    timer_clr,
    timer_done,
    out
);
    localparam  
        LOW = 4'b0001,
        WAIT_HIGH = 4'b0010,
        HIGH = 4'b0100,
        WAIT_LOW = 4'b1000;

    input clk, in, reset, timer_done;
    output out, timer_clr;

    reg [3:0] state;
    //state 状态机变量
    //0：LOW状态
    //1：WAIT_HIGH状态
    //2：HIGH状态
    //3: WAIT_LOW状态
    reg timer_clr, out; 

    initial 
    begin
        //等待启动
        state = LOW;
    end

    always @(posedge clk)
    begin
        if(reset)
        begin
            state = LOW;
            timer_clr = 1;
            out = 0;
        end
        else
        begin
            case (state)
                LOW : 
                begin
                    timer_clr = 1;
                    out = 0;

                    if (in)
                    //按钮输入高电平信号，转至WAIT_HIGH
                    begin
                        state = WAIT_HIGH;
                    end
                    //else
                end

                WAIT_HIGH:
                begin
                    timer_clr = 0;
                    out = 1;

                    if(timer_done)
                    //计时结束转至HIGH
                    begin
                        state = HIGH;
                    end
                    // else
                end

                HIGH:
                begin
                    timer_clr = 1;
                    out = 1;

                    if(!in)
                    //按钮松开，转至WAIT_LOW
                    begin
                        state = WAIT_LOW;
                    end
                    // else
                end

                WAIT_LOW:
                begin
                    timer_clr = 0;
                    out = 1;

                    if(timer_done)
                    //计时结束，至此已完成一次按钮输入过程，重新转至LOW状态等待输入
                    begin
                        state = LOW;
                    end
                end

                default: 
                begin
                    state = LOW;
                    timer_clr = 1;
                    out = 0;
                end
            endcase
        end
    end
    
endmodule