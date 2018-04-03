// TITLE OF THE MINI PROJECT - MINI ATM MACHINE


// NAME: KEERTHANA POLKAMPALLY
//       ARCHANA PRIYADARSHANI SAHOO

// REG NO.: 16CO131
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



//DESCRIPTION OF CODE: REGISTERS AND WIRES ARE DECLARED
//                     THE REQUIRED VARIABLES ARE INITIALIZED.
//                     INPUTS ARE GIVEN ACCORDING TO THE TIMING SIGNALS AND THE CHANGE IN CLOCK PULSE WITH TIME IS ALSO PROVIDED.
//                     FINISH TIME IS GIVEN AND THE OUTPUT IS DISPLAYED ON THE SCREEN.      




//   TESTBENCH


`timescale 1ns/1ps
module test;

	wire [3:0]dout1;                 // THE AVAILABLE BALANCE
	wire signal;                     //SIGNAL INDICATING IF WRONG INPUTS ARE 3 OR NOT  
	wire wd;                         //WITHDRAW SIGNAL INDICATING IF THE AMOUNT WE WANT TO WITHDRAW IS NOT POSSIBLE 
	wire [3:0]dout;                  // FINAL BALANCE TO BE OUTPUT
	wire less ,greater,equal;        // TO COMPARE THE INPUT PIN WITH THE PREFED PIN

	reg [3:0]pin;                    // INPUT PIN GIVEN BY THE USER
	reg [3:0]amt;                    //INPUT AMOUNT TO BE DEPOSITED OR WITHDRAWED FROM MACHINE 
	reg [1:0]sel;                    //SELECT LINES FOR MUX TO SELECT WITHDRAWAL OR DEPOSIT OPTION
	reg [3:0]bal;                    //BALANCE PRESENT IN THE MACHINE
	reg clk;                         //CLOCK
	reg [3:0]prefed;                 // THE PREFED PIN

 main uut(bal,signal,wd,pin,sel,amt,clk,prefed,dout1,dout,less,greater,equal);

 initial begin
    
    $dumpfile("VerilogDM-131-207.vcd");                // FOR CREATION OF THE GTKWAVE
    //$dumpfile("VerilogBM-131-207.vcd");
    $dumpvars(0,test); 
 
	  clk = 0;                                     // INITIALIZATION OF THE VALUES
	  amt = 4'b0000;
	  bal = 4'b0000;
	  sel = 2'b00;
	  prefed = 4'b0110;
	 

	 
	 #2 pin = 4'b0110;
	 #2 pin = 4'b0011;
	 #2 pin = 4'b0110;
	 #2 pin = 4'b0011;
	 #2 pin = 4'b0110;
	 #2 pin = 4'b0110;
	 #2 pin = 4'b0011;
	 #2 pin = 4'b0110;

	 #2 amt = 4'b0000; 
	 #2 amt = 4'b0001;
	 #2 amt = 4'b0010;
	 #2 amt = 4'b0011;
	 #2 amt = 4'b0001;    
	 #2 amt = 4'b0001; 
	 #2 amt = 4'b0011;
	 #2 amt = 4'b0001;
	 #2 amt = 4'b0001;
	 #2 amt = 4'b0001;    
	 
	 #2 sel = 2'b00;
	 #2 sel = 2'b00;
	 #2 sel = 2'b01;
	 #2 sel = 2'b00;
	 #2 sel = 2'b01;
	 #2 sel = 2'b00;
	 #2 sel = 2'b01;
	 #2 sel = 2'b00;
	 #2 sel = 2'b00; 
	  
	 #2 bal = 4'b0000;
	 #2 bal = 4'b0000;
	 #2 bal = 4'b0001;
	 #2 bal = 4'b0011;
	 #2 bal = 4'b0110;
	 #2 bal = 4'b0111;
	 #2 bal = 4'b1000;
	 #2 bal = 4'b1011;
	 #2 bal = 4'b1100;
	 #2 bal = 4'b1101;    
	   
	 
end
 


always  #1 clk = ~clk;                        //CLOCK PULSE IS CHANGED EVERY ONE SECOND
 

 
initial #100 $finish;                         //THE PROCESS TERMINATES AFTER 100 SECONDS
   
initial begin                                 // OUTPUT MESSAGE 

                            
    $monitor("time = %d clk = %b pin = %b prefed = %b amt = %b sel = %b  bal = %b signal = %b wd = %d ",$time,clk,pin,prefed,amt,sel,dout1,signal,wd);


end

endmodule





