module control (
    in,
    clk,
    reset,
    count,
    clr
);
    localparam 
        RESET = 2'b00,
        TIMING = 2'b01,
        STOP = 2'b10;

    input in, clk, reset;
    output clr, count;

    reg clr, count;
    reg [1:0] state, next_state;

    initial
    begin
        state = RESET;
        next_state = RESET;
    end

    always @(posedge clk)
    begin
        if(reset)
        begin
            state = RESET;
        end
        else
        begin
            state = next_state;
        end
    end
    
    always @(*) 
    begin
        case (state)
            RESET : 
                begin
                    clr = 1;
                    count = 0;
                    if (in)
                    begin
                        next_state = TIMING;
                    end
                    else
                    begin
                        next_state = RESET;
                    end
                end
            
            TIMING :
                begin
                    clr = 0;
                    count = 1;
                    
                    if (in)
                    begin
                        next_state = STOP;
                    end
                    else
                    begin
                        next_state = TIMING;
                    end
                end

            STOP :
            begin
                clr = 0;
                count = 0;
                
                if (in)
                begin
                    next_state = RESET;
                end
                else
                begin
                    next_state = STOP;
                end
            end

            default: 
            begin
                next_state = RESET;
            end
        endcase
    end
endmodule