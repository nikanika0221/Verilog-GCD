

module GCD(
    input rst, clk,
    input [7:0] num_A,
    input [7:0] num_B,
    input button,
    output reg [7:0] LED_out
    );
    
    reg [7:0] tempa, tempb;
    reg pulse;
    reg [1:0] state;
	 reg first_taken;
    parameter  take = 0, calculate = 1, hold = 2;
   
   
    initial begin
        state = hold;
		  LED_out <= 0;
		  tempa <= 0;
		  tempb <= 0;
		  pulse <= 0;
		  first_taken <= 0;
    end
     
    
    always@(posedge clk) begin
		  if(button && !pulse && !rst) begin
				state <= take;
				pulse <= 1;
		  end
		  if(!button) pulse <= 0;
        case(state)
            take : begin
					LED_out <= 0;
					//convert to positive if negative
					 if(!first_taken) begin
						tempa <= num_A[7] == 1? ~num_A+1 : num_A;
						first_taken <= 1;
						state <= hold;
					 end
					 else begin
						tempb <= num_B[7] == 1? ~num_B+1 : num_B;
						state <= calculate;
						first_taken <= 0;
					 end	 
					 
            end
				
            calculate : begin  
					if(tempa == 0) LED_out <= tempb;
					else if(tempb == 0) LED_out <= tempa;
					else if(tempa == tempb) LED_out <= tempa;
					else if(tempa > tempb) tempa <= tempa-tempb;
					else tempb <= tempb - tempa;
					if(LED_out) state <= hold;
				end
            default begin
					if(button && !pulse) state <= take;
					else state <= hold;
				end
        endcase
		  if(rst) begin
				state <= hold;
				tempa <= 0;
				tempb <= 0;
				first_taken <= 0;
				LED_out <= 0;
		  end

    end
        
endmodule
