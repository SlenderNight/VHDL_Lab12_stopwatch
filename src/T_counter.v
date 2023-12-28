module timing_counter (
    en,
    clk,
    r,
    co,
    q
);
    parameter n = 10;
    parameter counter_bits = 4;

    input en, clk, r;
    output co, q;

    reg [counter_bits-1 : 0] q=0;
    assign  co=(q==(n-1)) && en;//输出  q从0到n-1共遍历n个上升沿

    always @(posedge clk) 
    begin
        if(r) 
        begin
            q=0;
        end
        else if(en)  //en=1，可以计数
            begin
                if(q==(n-1))
                begin
                    q=0;
                end
                else 
                begin
                    q=q+1'b1;
                end
            end
    end
endmodule