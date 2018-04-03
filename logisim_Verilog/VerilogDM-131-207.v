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



module main(bal,signal,wd,pin,sel,amt,clk,prefed,dout1,dout,less,greater ,equal);

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
	 output less ,greater,equal;

comparator a1(pin,prefed,less,equal,greater);         // COMPARING IF THE INPUT GIVEN BY THE USER IS SIMILAR TO THE PREFED PIN

adder_subtractor_4bit a2(4'b0000,4'b0001,1'b0,dout);  // A COUNTER TO CHECK IF THE NUMBER OF WRONG INPUTS IS LESS THEN 3

assign signal=4'b0001;
assign wd=1'b0;

adder_subtractor_4bit a3(amt,bal,1'b0,dout1);         // DEPOSIT AND WITHDRAWAL OF THE AMOUNT GIVEN BY THE USER


endmodule

module comparator(
    input [3:0]Data_in_A,               //input A
    input [3:0]Data_in_B,               //input B
    output less,                        //high when A is less than B
    output equal,                       //high when A is equal to B
     output greater                     //high when A is greater than B    
    );

     //Internal variables
     reg less;
     reg equal;
     reg greater;

    //When the inputs and A or B are changed execute this block
    always @(Data_in_A or Data_in_B)
     begin
        if(Data_in_A > Data_in_B)   begin              //check if A is bigger than B.
            less = 0;
            equal = 0;
            greater = 1;    end
        else if(Data_in_A == Data_in_B) begin          //Check if A is equal to B
            less = 0;
            equal = 1;
            greater = 0;    end
        else    begin                                 //Otherwise - check for A less than B.
            less = 1;
            equal = 0;
            greater =0;
        end 
    end
endmodule






module adder_subtractor_4bit ( a ,b , select ,dout );         // PARALLEL ADDER SUBTRACTOR

	output [3:0] dout ;

	input [3:0] a ;                                       // INPUT 1
	input [3:0] b ;                                       // INPUT 2
	input select ;                                        // SELECT LINE TO DECIDE IF THE COMPONET WORKS AS ADDER OR A SUBTRACTOR

	wire [2:0]s;
	wire [3:0]l;

	assign l = b ^ {select,select,select,select};

	full_adder u0 (a[0],l[0],select,dout[0],s[0]); // 4 FULL ADDERS PERFORMING THE OPERATION ON THE RESPECTIVE BITS INCLUDING THE CARRY BIT 
	full_adder u1 (a[1],l[1],s[0],dout[1],s[1]);
	full_adder u2 (a[2],l[2],s[1],dout[2],s[2]);
	full_adder u3 (a[3],l[3],s[2],dout[3],);

endmodule





module full_adder (a ,b ,c ,dout ,carry );     // MODULE FOR FULL ADDER WHICH IS BEING USED FOR MAKING 4-BIT PARRALEL ADDER SUBTRACTOR

	output dout ;
	output carry ;

	input a ;
	input b ;
	input c ;
	   
	assign dout = a ^ b ^ c;               // SUM 
	assign carry = (a&b) | (b&c) | (c&a);  // FINAL CARRY 

endmodule


module mux4_1(I0,I1,I2,I3,s2,s1,en,y);

	input I0,I1,I2,I3,s2,s1,en;  // THE MUX SELECTS FROM THE OPTIONS WHTHER IT HAS TO DEPOSIT OR WITHDRAW ACCORDING TO THE USER INPUT

	output y;

	wire y1,y2,y3,y4;

	assign y1 = ((~s2) & (~s1) & en & I0);
	assign y2 = ((~s2) & (s1) & en & I1);
	assign y3 = (s2 & (~s1) & en & I2);
	assign y4 = (s2 & s1 & en & I3);
	assign y = y1 | y2 | y3 | y4;

endmodule





module d(q,q_bar,d,clk);            // D FLIPFLOPS ARE THE MEMORY ELEMENTS WHICH PERFORM THE FUNCTION OF RETAINING THE BALANCE 

	output q,q_bar;

	input d;

	input clk;

	reg q;
	reg q_bar;

	always @(posedge clk)        //	POSITIVE EDGE TRIGGERED
	begin
	q=d;
	q_bar = ~d;
	end
endmodule

