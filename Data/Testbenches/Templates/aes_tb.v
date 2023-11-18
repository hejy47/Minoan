/////////////////////////////////////////////////////////////////////
////                                                             ////
////  AES Test Bench                                             ////
////                                                             ////
////                                                             ////
////  Author: Rudolf Usselmann                                   ////
////          rudi@asics.ws                                      ////
////                                                             ////
////                                                             ////
////  Downloaded from: http://www.opencores.org/cores/aes_core/  ////
////                                                             ////
/////////////////////////////////////////////////////////////////////
////                                                             ////
//// Copyright (C) 2000-2002 Rudolf Usselmann                    ////
////                         www.asics.ws                        ////
////                         rudi@asics.ws                       ////
////                                                             ////
//// This source file may be used and distributed without        ////
//// restriction provided that this copyright statement is not   ////
//// removed from the file and that any derivative work contains ////
//// the original copyright notice and the associated disclaimer.////
////                                                             ////
////     THIS SOFTWARE IS PROVIDED ``AS IS'' AND WITHOUT ANY     ////
//// EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED   ////
//// TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS   ////
//// FOR A PARTICULAR PURPOSE. IN NO EVENT SHALL THE AUTHOR      ////
//// OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,         ////
//// INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES    ////
//// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE   ////
//// GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR        ////
//// BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  ////
//// LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT  ////
//// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT  ////
//// OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE         ////
//// POSSIBILITY OF SUCH DAMAGE.                                 ////
////                                                             ////
/////////////////////////////////////////////////////////////////////

//  CVS Log
//
//  $Id: test_bench_top.v,v 1.2 2002-11-12 16:10:12 rudi Exp $
//
//  $Date: 2002-11-12 16:10:12 $
//  $Revision: 1.2 $
//  $Author: rudi $
//  $Locker:  $
//  $State: Exp $
//
// Change History:
//               $Log: not supported by cvs2svn $
//               Revision 1.1.1.1  2002/11/09 11:22:56  rudi
//               Initial Checkin
//
//
//
//
//
//

`include "timescale.v"

module test;

reg		clk;
reg		rst;

reg		kld;
reg	[127:0]	key1;
reg	[127:0]	key2;
reg	[127:0]	text_in;
wire	[127:0]	text_out;
wire	[127:0]	text_out2;
wire		done, done2;
integer		n, error_cnt;
integer 	f;

initial
   begin
	f = $fopen("output.txt");
    $fwrite(f, "time,text_in,kld,key1,key2,done,text_out,done2,text_out2\n");
	$display("\n\n");
	$display("*****************************************************");
	$display("* AES Test bench ...");
	$display("*****************************************************");
	$display("\n");
`ifdef WAVES
	$dumpfile("waves.vcd");
	$dumpvars();
	$display("INFO: Signal dump enabled ...\n\n");
`endif

	kld = 0;
	clk = 0;
	rst = 0;
	repeat(4)	@(posedge clk);
	rst = 1;
	repeat(20)	@(posedge clk);

	$display("");
	$display("");
	$display("Started random test ...");

	// test data
	// input test data
	// 


	$display("");
	$display("");
	$display("Test Done.");
	$display("");
	$display("");
	repeat(10)	@(posedge clk);
	$fclose(f);
	$finish;
end

always #5 clk = ~clk;

always @(posedge clk)
	$fwrite(f,"%g,%h,%h,%h,%h,%h,%h,%h,%h\n", $time, text_in, kld, key1, key2, done, text_out, done2, text_out2);

aes_cipher_top u0(
	.clk(		clk		),
	.rst(		rst		),
	.ld(		kld		),
	.done(		done		),
	.key(		key1		),
	.text_in(	text_in		),
	.text_out(	text_out	)
	);

aes_inv_cipher_top u1(
	.clk(		clk		),
	.rst(		rst		),
	.kld(		kld		),
	.ld(		done		),
	.done(		done2		),
	.key(		key2		),
	.text_in(	text_out	),
	.text_out(	text_out2	)
	);

endmodule


