module display (
    clk,
    en,
    d0,
    d1,
    d2,
    d3,
    a,
    b,
    c,
    d,
    e,
    f,
    g,
    pos
);
    //定义输入输出
    input en, clk;
    input [3:0] d0, d1, d2, d3;
    output reg a, b, c, d, e, f, g;
    output [3:0] pos;

    //定义变量
    reg [3:0] din;
    reg [1:0] q = 0, d_temp, sel;
    reg [3:0] pos;

    //计数器模块
    always @(posedge clk)
    begin
        if(en)
        begin
            if(q==3)
                q = 0;
            else
                q = q + 1;
        end
    end

    //数据选择器
    always @(*)
    begin
        sel = q;
        case (sel)
            0 : din = d0;
            1 : din = d1;
            2 : din = d2;
            3 : din = d3;
            default: din = 0;
        endcase
    end

    //2-4译码器
    always @(*)
    begin
        d_temp = q;
        case (d_temp)
            0 : pos = 4'b1110;
            1 : pos = 4'b1101;
            2 : pos = 4'b1011;
            3 : pos = 4'b0111;
            default: pos = 0;
        endcase
    end

    //显示译码器
    always @(*) 
    begin
        case (din)
            0 : {a, b, c, d, e, f, g} = 7'b0000001;
            1 : {a, b, c, d, e, f, g} = 7'b1001111;
            2 : {a, b, c, d, e, f, g} = 7'b0010010;
            3 : {a, b, c, d, e, f, g} = 7'b0000110;
            4 : {a, b, c, d, e, f, g} = 7'b1001100;
            5 : {a, b, c, d, e, f, g} = 7'b0100100;
            6 : {a, b, c, d, e, f, g} = 7'b0100000;
            7 : {a, b, c, d, e, f, g} = 7'b0001111;
            8 : {a, b, c, d, e, f, g} = 7'b0000000;
            9 : {a, b, c, d, e, f, g} = 7'b0000100;
            default:  {a, b, c, d, e, f, g} = 7'b1111111;
        endcase
    end
endmodule