`include "AHBLAVLDefs.vh"

module AHBLite2AvalonMemoryMapped#(
		parameter ADDR_WIDTH = 32,
		parameter DATA_WIDTH = 32
	) (
		clk,
		reset_n,

		ahb_haddr,
		ahb_hwrite,
		ahb_hsize,
		ahb_hburst,
		ahb_hmastlock,
		ahb_hprot,
		ahb_htrans,
		ahb_hwdata,
		ahb_hrdata,
		ahb_hready,
		ahb_hresp,

		avl_address,
		avl_write,
		avl_read,
		avl_burstcount,
		avl_beginbursttransfer,
		avl_lock,
		avl_writedata,
		avl_readdata,
		avl_readdatavalid,
		avl_waitrequest_n,
		avl_response
	);

	input clk;
	input reset_n;

	input [ADDR_WIDTH-1:0] ahb_haddr;
	input ahb_hwrite;
	input [2:0] ahb_hsize;
	input [2:0] ahb_hburst;
	input ahb_hmastlock;
	input [3:0] ahb_hprot;
	input [1:0] ahb_htrans;
	input [DATA_WIDTH-1:0] ahb_hwdata;
	output [DATA_WIDTH-1:0] ahb_hrdata;
	output ahb_hready;
	output ahb_hresp;	

	output [ADDR_WIDTH-1:0] avl_address;
	output avl_write;
	output avl_read;
	output [11:0] avl_burstcount;
	output avl_beginbursttransfer;
	output avl_lock;
	output [DATA_WIDTH-1:0] avl_writedata;
	input [DATA_WIDTH-1:0] avl_readdata;
	input avl_readdatavalid;
	input avl_waitrequest_n;
	input [1:0] avl_response;

	reg [ADDR_WIDTH-1:0] r_haddr;
	reg r_hwrite;
	reg [2:0] r_hsize;
	reg [2:0] r_hburst;
	reg [1:0] r_htrans;
	reg r_hready;

	reg [DATA_WIDTH-1:0] r_readdata;

	reg r_pendingread;

	assign avl_address = r_haddr;
	assign avl_write = ((r_htrans != `AHB_HTRANS_NONSEQ && r_htrans != `AHB_HTRANS_SEQ) || (avl_waitrequest_n && !r_hready))? 1'b0 : r_hwrite;
	assign avl_read = ((r_htrans != `AHB_HTRANS_NONSEQ && r_htrans != `AHB_HTRANS_SEQ) || (avl_waitrequest_n && !r_hready))? 1'b0 : !r_hwrite;
	// TODO
	assign avl_burstcount = 1'b1;
	// TODO
	assign avl_beginbursttransfer = 1'b0;
	// XXX: NO LOCK IN THIS VERSION
	assign avl_lock = 1'b0;
	assign avl_writedata = ahb_hwdata;

	assign ahb_hrdata = avl_readdatavalid? avl_readdata : r_readdata;
	//assign ahb_hready = avl_waitrequest_n && (avl_waitrequest_n || r_pendingread);
	assign ahb_hready = avl_waitrequest_n && (!r_pendingread || avl_readdatavalid);
	assign ahb_hresp = (`AVL_RESPONSE_SLAVEERROR == avl_response || `AVL_RESPONSE_DECODEERROR == avl_response)? `AHB_HRESP_ERROR : `AHB_HRESP_OKAY;

	always @(posedge clk or negedge reset_n) begin
		if(!reset_n) begin
			r_htrans <= `AHB_HTRANS_IDLE;
		end
		else begin
			r_haddr <= ahb_haddr;
			r_hwrite <= ahb_hwrite;
			r_hsize <= ahb_hsize;
			r_hburst <= ahb_hburst;
			r_htrans <= ahb_htrans;
		end
	end

	always @(posedge clk or negedge reset_n) begin
		if(!reset_n) begin
			r_pendingread <= 1'b0;
		end
		else begin
			if((`AHB_HTRANS_NONSEQ == ahb_htrans || `AHB_HTRANS_SEQ == ahb_htrans) && !ahb_hwrite) begin
				r_pendingread <= 1'b1;
			end
			else if(avl_readdatavalid) begin
				r_pendingread <= 1'b0;
			end
		end
	end

	always @(posedge clk or negedge reset_n) begin
		if(!reset_n) begin
			r_readdata <= 'h0;
		end
		else begin
			if(avl_readdatavalid) begin
				r_readdata <= avl_readdata;
			end
		end
	end

	always @(posedge clk or negedge reset_n) begin
		r_hready <= ahb_hready;
	end

endmodule
