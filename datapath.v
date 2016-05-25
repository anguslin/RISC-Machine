
module datapath(clk, readnum, vsel, loada, loadb, shift, asel, bsel, ALUop, loadc, loads, writenum, write, datapath_in, status, datapath_out);

	//constants to define
	`define WIDTH 16
	`define STATUSWIDTH 1

	input clk, loada, loadb, write, vsel, asel, bsel, loadc, loads;
	input [2:0] readnum, writenum;
	input [1:0] shift, ALUop;
	input [15:0] datapath_in;
	output [15:0] datapath_out;
	output status;
	wire [15:0] A, B, C, reg0, reg1, reg2, reg3, reg4, reg5, reg6, reg7;
	
	Register #(
		.width(`WIDTH)
		) instantiateReg(
	 	.clk(clk),
		.loada(loada),
		.write(write),
		.readnum(readnum),
		.reg0(reg0),
		.reg1(reg1),
		.reg2(reg2),
		.reg3(reg3),
		.reg4(reg4),
		.reg5(reg5),
		.reg6(reg6),
		.reg7(reg7),
		.A(A),
		.B(B)
	 );
	  
	Computation #(
		.width(`WIDTH),
		.statusWidth(`STATUSWIDTH) 
		) instantiateComp(
		.clk(clk), 
		.asel(asel), 
		.bsel(bsel), 
		.loadc(loadc), 
		.loads(loads), 
		.shift(shift), 
		.ALUop(ALUop), 
		.datapath_in(datapath_in), 
		.A(A), 
		.B(B), 
		.status(status), 
		.C(C)
	);
		
	Write #(
		.width(`WIDTH)
		) instantiateWrite(
		.clk(clk), 
		.vsel(vsel), 
		.write(write),
		.writenum(writenum), 
		.C(C), 
		.datapath_in(datapath_in), 
		.datapath_out(datapath_out), 
		.reg0(reg0), 
		.reg1(reg1), 
		.reg2(reg2), 
		.reg3(reg3), 
		.reg4(reg4), 
		.reg5(reg5), 
		.reg6(reg6), 
		.reg7(reg7)
	);
	
endmodule

