module write(clk, vsel, write, writenum, C, mdata, sximm8, PC, reg0, reg1, reg2, reg3, reg4, reg5, reg6, reg7);

	parameter width= 1;
	input clk, write;
	input [1:0] vsel;
	input [2:0] writenum;
	input [7:0] PC;
	input [15:0] C, mdata, sximm8;
	output [15:0] reg0, reg1, reg2, reg3, reg4, reg5, reg6, reg7;
	reg [15:0] data_in;
	reg [7:0] regSelect;	

	//Update based on clock 
	//regSelect chooses which register to update -> 1 means update 
	always @(*) begin
		case(writenum)
			3'b000: regSelect= write? 8'b00000001: 8'b00000000; 	//if write= 1 and writenum= 000 
			3'b001: regSelect= write? 8'b00000010: 8'b00000000; 	//if write= 1 and writenum= 001 
			3'b010: regSelect= write? 8'b00000100: 8'b00000000; 	//if write= 1 and writenum= 010 
			3'b011: regSelect= write? 8'b00001000: 8'b00000000; 	//if write= 1 and writenum= 011 
			3'b100: regSelect= write? 8'b00010000: 8'b00000000; 	//if write= 1 and writenum= 100 
			3'b101: regSelect= write? 8'b00100000: 8'b00000000;	//if write= 1 and writenum= 101 
			3'b110: regSelect= write? 8'b01000000: 8'b00000000;	//if write= 1 and writenum= 110 
			3'b111: regSelect= write? 8'b10000000: 8'b00000000; 	//if write= 1 and writenum= 111 
			default: regSelect= {8{1'bx}};				//default all x
		endcase
	end

	//Update registers on a clock
	DFlipFlopAllow #(.width(width)) loadreg0Data(clk, regSelect[0], data_in, reg0);
	DFlipFlopAllow #(.width(width)) loadreg1Data(clk, regSelect[1], data_in, reg1);
	DFlipFlopAllow #(.width(width)) loadreg2Data(clk, regSelect[2], data_in, reg2);
	DFlipFlopAllow #(.width(width)) loadreg3Data(clk, regSelect[3], data_in, reg3);
	DFlipFlopAllow #(.width(width)) loadreg4Data(clk, regSelect[4], data_in, reg4);
	DFlipFlopAllow #(.width(width)) loadreg5Data(clk, regSelect[5], data_in, reg5);
	DFlipFlopAllow #(.width(width)) loadreg6Data(clk, regSelect[6], data_in, reg6);
	DFlipFlopAllow #(.width(width)) loadreg7Data(clk, regSelect[7], data_in, reg7);

	//update data_in depending on value of vsel
	always @(*) begin
		case(vsel)
			2'b00: data_in= mdata; 
			2'b01: data_in= sximm8;
			2'b10: data_in= {8'b00000000, PC};
			2'b11: data_in= C;
			default: data_in={16{1'bx}};
		endcase
	end
	
endmodule
