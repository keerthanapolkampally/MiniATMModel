//TITLE OF THE MINI PROJECT - MINI ATM MACHINE


// NAME: KEERTHANA POLKAMPALLY
//       ARCHANA PRIYADARSHANI SAHOO


//REG NO.: 16CO131
//       : 16CO207 


//ABSTRACT: THE FOLLOWING MINI PROJECT IMPLEMENTS A MINI ATM MACHINE BY TAKING THE INPUT AS A 4 BIT PIN AND IF THE PIN 
//          MATCHES THE PREFED CODE THE MACHINE ALLOWS YOU TO DEPOSIT OR WITHDRAW AND IF THE WRONG PIN IS FED FOR MORE THAN 3 TIMES 
//          THE PROCESS TERMINATES. FOR EVERY SUCCESSFULL TRANSACTION THE BALANCE IS ALSO DISPLAYED.


//FUNCTIONALITIES: 1. CHECKS IF THE PIN IS CORRECT:
//                                                 THE MACHINE VERIFIES IF THE PIN ENTERED BY THE USER MATCHES THE PREFED PIN . THIS FUNCIONALITY 
//                                                 IS VERIFIED BY USING A  4 BIT COMPARATOR. 
//                 2. IF THE WRONG PIN IS ENTERED FOR MORE THAN 3 TIMES:
//                                                                       THIS FUNCTIONALITY IS CHECKED BY USING A 4 BIT PARALLEL ADDER SUBTRACTOR
//                                                                       AND AGAIN A COMPARATOR IS USED TO CHECK IF IT IS MORE THAN 3 OR NOT .IF IT IS THEN IT IS INDICATED BY A SIGNAL.     
//                 3. DEPOSIT OPTION: 
//                                    A SELECT OPTION IS GIVEN IF WE WANT TO OPT FOR DEPOSIT OR WITHDRAWAL .
//                                    DEPOSIT FUNCTIONALITY ALLOWS THE USER TO DEPOSIT AN AMOUNT IN THE MACHINE AND IT REMEMBERS THE AMOUNT USING THE D FLIP FLOPS .
//                                    AND A PARALLEL ADDER SUBTRACTOR AGAIN TAKES CARE OF THE TOTAL BALANCE AND ALSO REMEMBERS FOR FURTHER USE.    
//                 4. WITHDRAWAL OPTION:
//                                      WITHDRAWAL FUNCTIONALITY ALLOWS USER TO WITHDRAW FROM THE MACHINE IF SUFFICIENT BALANCE IS PRESENT IN THE MACHINE .
//                                      ELSE IT GIVES AN ERROR SIGNAL INDICATING NO SUFFICIENT BALANCE. IN CASE OF SUCCESSFULL WITHDRAWAL THE BALANCE IS AGAIN GIVEN AS THE OUTPUT.  



//DESCRIPTION OF CODE: THE CODE CONCENTRATES ON THE ABOVE MENTIONED FUNCTIONALITIES.IT MAINLY HAS 4 COMPONENTS 
//                    1. 4 BIT MAGNITUDE COMPARATOR  2. 4 BIT PARALLEL ADDER SUBTRACTOR 3. MULTIPLEXER 4.D FLIP FLOPS
//                    THE CODE CHECKS IF THE PIN ENTERED BY USER AND PREFED PIN IS EQUAL OR NOT . IF IT IS THEN DEPENDING ON MUX SELECT LINES
//                    DEPOSIT AND WITHDRAWAL OPTION IS CHOSEN AND AGAIN DEPENDING ON THE WITHDRAWAL OR DEPOSIT THE BALANCE IS DISPLAYED AFTER ADDING THE AMOUNT OR SUBTRACTING THE AMOUNT.
//                    IF THE INPUT PIN AND PREFED PASSWORD ARE NOT EQUAL THEN A COUNT IS KEPT TO CHECK IF THE WRONG PIN IS NOT FED FOR MORE THAN 3 TIMES IF IT IS FED FOR 3 MORE THAN 3 TIMES THEN
//                    THE PROCESS IS TERMINATED.      





module main(bal,signal,wd,pin,sel,amt,clk,prefed,dout1,dout,less,greater,equal);

	input [3:0]pin;       //INPUT PIN BY USER
	input [1:0]sel;       //SELECT LINES FOR MUX TO SELECT WITHDRAWAL OR DEPOSIT OPTION
	input [3:0]amt;       //INPUT AMOUNT TO BE DEPOSITED OR WITHDRAWED FROM MACHINE 
	input clk;            //CLOCK
	input [3:0]prefed;    //PREFED PIN WILL BE GIVEN IN TESTBENCH
	input [3:0]bal;       //BALANCE PRESENT IN THE MACHINE
	output signal;        //SIGNAL INDICATING IF WRONG INPUTS ARE 3 OR NOT  
	output wd;            //WITHDRAW SIGNAL INDICATING IF THE AMOUNT WE WANT TO WITHDRAW IS NOT POSSIBLE 
	output [3:0]dout;     // FINAL BALANCE TO BE OUTPUTTED
	output [3:0]dout1;
	output less;          // REGISTER VALUE TO CHECK IF THE ENTERED INPUT PIN IS WRONG AND INCREMENT THE COUNT IF ITS WRONG
	output greater;
	output equal;
	reg signal; 
	reg less;  
	reg greater;
	reg equal;
	       
	reg wd;
	reg [3:0]dout1;
	reg [3:0]dout;
	wire [3:0]pin;
	wire [3:0]bal;
	wire [3:0]amt;
	wire [1:0]sel;
	wire clk;
	wire [3:0]prefed;
always @(posedge clk)
	begin
         if( pin < prefed || pin > prefed )                         // CHECKING IF PIN IS NOT EQUAL TO PREFED
		    begin
			  dout = 4'b0000 + 4'b0001 ;                //INCREMENTING THE COUNT IF IT IS NOT EQUAL 
		          if(dout < 4'b0011 || dout == 4'b0011)     // CHECKING IF THE COUNT IS 3 
			         begin
				      signal = 1'b1;                // ASSIGNING THE SIGNAL VALUE 1 IF COUNT IS NOT 3
			         end
		          else
				  begin
				      signal = 1'b0;                // ASSIGNING THE SIGNAL VALUE 0 IF COUNT IS MORE THAN 3
				  end
		    end
	 else if(pin == prefed)                                     // CHECKING IF PIN IS EQUAL TO PREFED
	      begin
	       if(sel == 2'b00)              // CHECKING IF THE SELECT LINE FOR MUX IS DEPOSIT OR WITHDRAW WHERE 00 IS FOR DEPOSIT 
		       begin  
		       dout1 = amt + bal;                           // FINAL BALANCE AFTER DEPOSIT   
		       end 
	       else if (sel == 2'b01)                               // SELECT 01 IS FOR WITHDRAW OPTION
			 begin
			 if( dout1 >= amt)  // CHECKING IF THE AMOUNT TO BE WITHDRAWN IS GREATER THAN PRESENT ALREADY IN THE MACHINE
				 begin
				 dout1 = amt - bal;                 // FINAL BALANCE AFTER WITHDRAW
				 wd = 1'b0;                         // ASSIGNING WITHDRAW SIGNAL AS 0 IF WITHDRAW IS POSSIBLE   
				 end
			 else if (dout1 < amt)
				 begin
				 wd = 1'b1;                         // ASSIGNING WITHDRAW SIGNAL AS 1 IF WITHDRAW IS NOT POSSIBLE
				 end
			end
		end
	     
	 end
endmodule 
      
      
















