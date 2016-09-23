`timescale 1ns/1ps

`include "AHBLAVLDefs.vh"

module AHBLite2AvalonMemoryMapped_tb;

	reg r_clk;
	reg r_reset_n;

	reg [31:0] r_ahb_haddr;
	reg r_ahb_hwrite;
	reg [2:0] r_ahb_hsize;
	reg [2:0] r_ahb_hburst;
	reg [1:0] r_ahb_htrans;
	reg [31:0] r_ahb_hwdata;
	wire [31:0] w_ahb_hrdata;
	wire w_ahb_hready;
	wire w_ahb_hresp;	

	wire [31:0] w_avl_address;
	wire w_avl_write;
	wire w_avl_read;
	wire [11:0] w_avl_burstcount;
	wire w_avl_beginbursttransfer;
	wire [31:0] w_avl_writedata;
	reg [31:0] r_avl_readdata;
	reg r_avl_readdatavalid;
	reg r_avl_waitrequest_n;
	reg [1:0] r_avl_response;

	AHBLite2AvalonMemoryMapped#(32,32) inst (
		.clk(r_clk),
		.reset_n(r_reset_n),

		.ahb_haddr(r_ahb_haddr),
		.ahb_hwrite(r_ahb_hwrite),
		.ahb_hsize(r_ahb_hsize),
		.ahb_hburst(r_ahb_hburst),
		.ahb_hmastlock(1'b0),
		.ahb_hprot(),
		.ahb_htrans(r_ahb_htrans),
		.ahb_hwdata(r_ahb_hwdata),
		.ahb_hrdata(w_ahb_hrdata),
		.ahb_hready(w_ahb_hready),
		.ahb_hresp(w_ahb_hresp),

		.avl_address(w_avl_address),
		.avl_write(w_avl_write),
		.avl_read(w_avl_read),
		.avl_burstcount(w_avl_burstcount),
		.avl_beginbursttransfer(w_avl_beginbursttransfer),
		.avl_lock(),
		.avl_writedata(w_avl_writedata),
		.avl_readdata(r_avl_readdata),
		.avl_readdatavalid(r_avl_readdatavalid),
		.avl_waitrequest_n(r_avl_waitrequest_n),
		.avl_response(r_avl_response)
	);

	initial begin
		$dumpfile("AHBLite2AvalonMemoryMapped_tb.vcd");
		$dumpvars(1, inst);
			/*r_ahb_haddr,
			r_ahb_hwrite,
			r_ahb_hsize,
			r_ahb_hburst,
			r_ahb_htrans,
			r_ahb_hwdata,
			w_ahb_hrdata,
			w_ahb_hready,
			w_ahb_hresp,	

			w_avl_address,
			w_avl_write,
			w_avl_read,
			w_avl_burstcount,
			w_avl_beginbursttransfer,
			w_avl_writedata,
			r_avl_readdata,
			r_avl_readdatavalid,
			r_avl_waitrequest_n,
			r_avl_response
		);*/

		r_clk <= 'b1;
		r_reset_n <= 'b0;

		r_ahb_haddr <= 'h0;
		r_ahb_hwrite <= 'b0;
		r_ahb_hsize <= `AHB_HSIZE_WORD;
		r_ahb_hburst <= `AHB_HBURST_SINGLE;
		r_ahb_htrans <= `AHB_HTRANS_IDLE;
		r_ahb_hwdata <= 'h0;

		r_avl_readdata <= 'h0;
		r_avl_readdatavalid <= 'b0;
		r_avl_waitrequest_n <= 'b1;
		r_avl_response <= `AVL_RESPONSE_OKAY;
		
		#100 @(posedge r_clk);
		r_reset_n <= 'b1;

		#50 @(posedge r_clk);
		r_ahb_haddr <= 'hA;
		r_ahb_hwrite <= 'b1;
		r_ahb_hsize <= `AHB_HSIZE_WORD;
		r_ahb_hburst <= `AHB_HBURST_SINGLE;
		r_ahb_htrans <= `AHB_HTRANS_NONSEQ;
		r_ahb_hwdata <= 'h0;
		r_avl_readdata <= 'h0;
		r_avl_readdatavalid <= 'b0;
		r_avl_waitrequest_n <= 'b1;
		r_avl_response <= `AVL_RESPONSE_OKAY;

		#50 @(posedge r_clk);
		r_ahb_haddr <= 'hB;
		r_ahb_hwrite <= 'b0;
		r_ahb_hsize <= `AHB_HSIZE_WORD;
		r_ahb_hburst <= `AHB_HBURST_SINGLE;
		r_ahb_htrans <= `AHB_HTRANS_NONSEQ;
		r_ahb_hwdata <= 'hAAAA;
		r_avl_readdata <= 'h0;
		r_avl_readdatavalid <= 'b0;
		r_avl_waitrequest_n <= 'b1;
		r_avl_response <= `AVL_RESPONSE_OKAY;

		#50 @(posedge r_clk);
		r_ahb_haddr <= 'hC;
		r_ahb_hwrite <= 'b1;
		r_ahb_hsize <= `AHB_HSIZE_WORD;
		r_ahb_hburst <= `AHB_HBURST_SINGLE;
		r_ahb_htrans <= `AHB_HTRANS_NONSEQ;
		r_ahb_hwdata <= 'h0;
		r_avl_readdata <= 'h0;
		r_avl_readdatavalid <= 'b0;
		r_avl_waitrequest_n <= 'b1;
		r_avl_response <= `AVL_RESPONSE_OKAY;

		#50 @(posedge r_clk);
		r_ahb_haddr <= 'hC;
		r_ahb_hwrite <= 'b1;
		r_ahb_hsize <= `AHB_HSIZE_WORD;
		r_ahb_hburst <= `AHB_HBURST_SINGLE;
		r_ahb_htrans <= `AHB_HTRANS_NONSEQ;
		r_ahb_hwdata <= 'h0;
		r_avl_readdata <= 'h0;
		r_avl_readdatavalid <= 'b0;
		r_avl_waitrequest_n <= 'b1;
		r_avl_response <= `AVL_RESPONSE_OKAY;

		#50 @(posedge r_clk);
		r_ahb_haddr <= 'hC;
		r_ahb_hwrite <= 'b1;
		r_ahb_hsize <= `AHB_HSIZE_WORD;
		r_ahb_hburst <= `AHB_HBURST_SINGLE;
		r_ahb_htrans <= `AHB_HTRANS_NONSEQ;
		r_ahb_hwdata <= 'h0;
		r_avl_readdata <= 'hBBBB;
		r_avl_readdatavalid <= 'b1;
		r_avl_waitrequest_n <= 'b1;
		r_avl_response <= `AVL_RESPONSE_OKAY;

		#50 @(posedge r_clk);
		r_ahb_haddr <= 'h0;
		r_ahb_hwrite <= 'b0;
		r_ahb_hsize <= `AHB_HSIZE_WORD;
		r_ahb_hburst <= `AHB_HBURST_SINGLE;
		r_ahb_htrans <= `AHB_HTRANS_IDLE;
		r_ahb_hwdata <= 'hCCCC;
		r_avl_readdata <= 'h0;
		r_avl_readdatavalid <= 'b0;
		r_avl_waitrequest_n <= 'b1;
		r_avl_response <= `AVL_RESPONSE_OKAY;

		#200 @(posedge r_clk);
		$finish;
	end

	always begin
		#50 r_clk <= ~r_clk;
	end

endmodule
