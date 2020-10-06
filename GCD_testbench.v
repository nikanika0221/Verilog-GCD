

module GCD_Testbench;

    //inputs
    reg rst;
    reg clk;
    reg [7:0] num_A;
    reg [7:0] num_B;
    reg button;
    
    //outputs
    wire [7:0]LED_out;
    
    GCD uut(
        .rst(rst),
        .clk(clk),
        .num_A(num_A),
        .num_B(num_B),
        .button(button),
        .LED_out(LED_out)     
    );
	 always #50 button <= !button;
    always #3 clk <= !clk;
    initial begin
    clk = 0;
    rst = 0;
    num_A = 8'b10010100;
    num_B = 8'b00111100;
    button = 0;
	 #220;
	 num_A = 22;
    num_B = 55;
	 #50;
	 #200;
	 num_A = 88;
    num_B = 50;
	 #200;
	 rst = 1;
	 #10;
	 rst = 0;
    end
endmodule

