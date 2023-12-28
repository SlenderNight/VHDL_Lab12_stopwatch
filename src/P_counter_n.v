module counter_n(clk,en,r,co); 
  parameter  n = 2; //分频比   
  parameter  counter_bits = 1;//计数器位数
  
  input   clk, en, r;
  output  co;
  reg [counter_bits-1:0]  q=0;
  assign  co=(q==(n-1)) && en;//输出  q从0到n-1共遍历n个上升沿

  always @(posedge clk) 
  begin
    if(r) 
      q=0;
	  else if(en)  //en=1，可以计数
	          begin	 
                if(q==(n-1))
                  q=0 ;
                else 
                  q=q+1;
            end
  end
endmodule
