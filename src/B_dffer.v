module dffer (
    d,
    clk,
    r,
    q,
    en
);
    input d, clk, r, en;
    output q;

    reg q;

    initial 
    begin
        q = 0;
    end

    always @(posedge clk or posedge r)
    begin
        if (r)
            q = 0;
        else if(en)
            q = d;
        //else
    end 
endmodule