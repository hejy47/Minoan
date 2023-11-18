/////////////////////////////////////////////////////////////////////
////                                                             ////
////  DES TEST BENCH                                             ////
////                                                             ////
////  Author: Rudolf Usselmann                                   ////
////          rudi@asics.ws                                      ////
////                                                             ////
/////////////////////////////////////////////////////////////////////
////                                                             ////
//// Copyright (C) 2001 Rudolf Usselmann                         ////
////                    rudi@asics.ws                            ////
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

module test;

reg		clk;
wire	[63:0]	desOut;
wire 	[63:0]  desOut2;
reg	[63:0]	des_in;
reg	[63:0]	key1;
reg	[63:0]	key2;
reg	[55:0]	delay_key2[0:17];
reg		decrypt;
wire [55:0] tmp_key1;
wire [55:0] tmp_key2;
integer f;
integer i;

always @(posedge clk)
	delay_key2[0] <= {key2[63:57],key2[55:49],key2[47:41],key2[39:33],
				key2[31:25],key2[23:17],key2[15:9],key2[7:1]};

always @(posedge clk)
	for(i=0;i<17;i=i+1)
		delay_key2[i+1] <= delay_key2[i];

initial
   begin
	f = $fopen("output.txt");
    $fwrite(f, "time,des_in,key1,key2,desOut,desOut2\n");
	$display("\n\n");
	$display("*********************************************************");
	$display("* Performance Optimized DES core simulation started ... *");
	$display("*********************************************************");
	$display("\n");

`ifdef WAVES
	$dumpfile("waves.vcd");
	$dumpvars();
	$display("INFO: Signal dump enabled ...\n\n");
`endif

	clk = 0;
	// Wait for clock edge
	decrypt = 0;
	@(posedge clk);

	$display("");
	$display("**************************************");
	$display("* Starting DES Test ...              *");
	$display("**************************************");
	$display("");
	
	// test data
	// input test data
	// 


	#200;
	$display("");
	$display("**************************************");
	$display("* DES Test done ...                  *");
	$display("**************************************");
	$display("");
	
	$fclose(f);
	$finish;
   end

// DES Clock
always #2 clk=~clk;

always @(posedge clk)
	$fwrite(f,"%g,%h,%h,%h,%h,%h\n", $time, des_in, tmp_key1, tmp_key2, desOut, desOut2);

assign tmp_key1 = {key1[63:57],key1[55:49],key1[47:41],key1[39:33],
				key1[31:25],key1[23:17],key1[15:9],key1[7:1]};
assign tmp_key2 = delay_key2[16];
// The DES instance
des u0(	.clk(		clk		),
	.desOut(	desOut		),
	.desIn(		des_in		),
	.key(		tmp_key1		),
	.decrypt(	decrypt	)
	);

// The DES instance
des u1(	.clk(		clk		),
	.desOut(	desOut2		),
	.desIn(		desOut		),
	.key(		tmp_key2		),
	.decrypt(	~decrypt	)
	);

endmodule
