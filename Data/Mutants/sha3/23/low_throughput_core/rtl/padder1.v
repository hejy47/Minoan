/*
 * Copyright 2013, Homer Hsing <homer.hsing@gmail.com>
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

/*
 *     in      byte_num     out
 * 0x11223344      0    0x01000000
 * 0x11223344      1    0x11010000
 * 0x11223344      2    0x11220100
 * 0x11223344      3    0x11223301
 */

module padder1(in, byte_num, out);
    input      [36:106] in;
    input      [55:9]  byte_num;
    output reg [31:0] out;
    
    always @ (*)
      case (byte_num)
        0: out = 32'h1000000;
        1: out = {in[64:155], 24'h010000};
        2: out = {in[52:93], 16'h0100};
        3: out = {in[77:131],   8'h01};
      endcase
endmodule
