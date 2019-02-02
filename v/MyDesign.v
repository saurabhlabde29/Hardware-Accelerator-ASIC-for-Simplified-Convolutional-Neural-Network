//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
// DUT
//synopsys translate_off
`include "/afs/eos.ncsu.edu/dist/synopsys2013/syn/dw/sim_ver/DW02_mac.v"
//synopsys translate_on
module MyDesign (

            //---------------------------------------------------------------------------
            // Control
            //
            output reg                  dut__xxx__finish   ,
            input  wire                 xxx__dut__go       ,  

            //---------------------------------------------------------------------------
            // b-vector memory 
            //
            output reg  [ 9:0]          dut__bvm__address  ,
            output reg                  dut__bvm__enable   ,
            output reg                  dut__bvm__write    ,
            output reg  [15:0]          dut__bvm__data     ,  // write data
            input  wire [15:0]          bvm__dut__data     ,  // read data
            
            //---------------------------------------------------------------------------
            // Input data memory 
            //
            output reg  [ 8:0]          dut__dim__address  ,
            output reg                  dut__dim__enable   ,
            output reg                  dut__dim__write    ,
            output reg  [15:0]          dut__dim__data     ,  // write data
            input  wire [15:0]          dim__dut__data     ,  // read data


            //---------------------------------------------------------------------------
            // Output data memory 
            //
            output reg  [ 2:0]          dut__dom__address  ,
            output reg  [15:0]          dut__dom__data     ,  // write data
            output reg                  dut__dom__enable   ,
            output reg                  dut__dom__write    ,


            //-------------------------------
            // General
            //
            input  wire                 clk             ,
            input  wire                 reset  

            );
  //---------------------------------------------------------------------------
  //
  //<<<<----  YOUR CODE HERE    ---->>>>
  //
  //`include "v564.vh"
  // 
  //---------------------------------------------------------------------------
  reg [15:0] bvector0 [8:0]; // create a 16 bit wide 9 deep array
  reg [15:0] bvector1 [8:0]; // create a 16 bit wide 9 deep array
  reg [15:0] bvector2 [8:0]; // create a 16 bit wide 9 deep array
  reg [15:0] bvector3 [8:0]; // create a 16 bit wide 9 deep array
  reg [15:0] avector00 [8:0]; // create a 16 bit wide 9 deep array
  reg [15:0] avector01 [8:0]; // create a 16 bit wide 9 deep array
  reg [15:0] avector02 [8:0]; // create a 16 bit wide 9 deep array
  reg [15:0] avector03 [8:0]; // create a 16 bit wide 9 deep array
  reg [15:0] avector10 [8:0]; // create a 16 bit wide 9 deep array
  reg [15:0] avector11 [8:0]; // create a 16 bit wide 9 deep array
  reg [15:0] avector12 [8:0]; // create a 16 bit wide 9 deep array
  reg [15:0] avector13 [8:0]; // create a 16 bit wide 9 deep array
  reg [15:0] avector20 [8:0]; // create a 16 bit wide 9 deep array
  reg [15:0] avector21 [8:0]; // create a 16 bit wide 9 deep array
  reg [15:0] avector22 [8:0]; // create a 16 bit wide 9 deep array
  reg [15:0] avector23 [8:0]; // create a 16 bit wide 9 deep array
  reg [15:0] avector30 [8:0]; // create a 16 bit wide 9 deep array
  reg [15:0] avector31 [8:0]; // create a 16 bit wide 9 deep array
  reg [15:0] avector32 [8:0]; // create a 16 bit wide 9 deep array
  reg [15:0] avector33 [8:0]; // create a 16 bit wide 9 deep array
  
  reg [3:0] counter = 4'b0000;
  reg [3:0] bitselect = 4'b0000;
  reg [3:0] select = 4'b0000;
  reg [3:0] bitselect1 = 4'b0000;
  reg startdesign = 0;
  reg flag_b;
  reg flag_a = 0;
  reg [15:0] mac_a0 = 16'b0000000000000000;
  reg [15:0] mac_a1 = 16'b0000000000000000;
  reg [15:0] mac_a2 = 16'b0000000000000000;
  reg [15:0] mac_a3 = 16'b0000000000000000;
  reg [15:0] mac_b = 16'b0000000000000000;
  
  reg [15:0] mac_out0; 
  reg [15:0] mac_out1; 
  reg [15:0] mac_out2; 
  reg [15:0] mac_out3;
  
  reg [3:0] zcount = 4'b0000;
  
  reg [15:0] z [63:0]; // create a 16 bit wide 64 deep array
  reg [3:0] bitselect2 = 4'b0000;
  reg z_start;
  reg flag_z = 0;
  
  reg [9:0] count_m = 10'b0000000000;
  reg [15:0] m;
  reg flag_zsynch = 0;
  reg [15:0] mac_z;
 
  reg [5:0] sendz_count = 6'b000000;
  
  reg [15:0] final_output;
  reg [15:0] output_store [7:0]; // create a 16 bit wide 8 deep array for storing the output
  reg [2:0] count_out = 3'b000;
  reg flag_out = 0;
  reg [3:0] count_store = 4'b0000;
  
  // logic for "go" and "finish"
  always@(posedge clk)
  begin
	if(reset||count_store==4'b1111)
	begin
		dut__xxx__finish<=1;
		startdesign <= 0;
	end
	else if(xxx__dut__go==1)
	begin
		dut__xxx__finish<=0;
		startdesign<=1;         // flag to indicate start of design
	end
  end
  // Counter logic for data fetching
  always@(posedge clk)
  begin
  if(startdesign==1)
  begin
	if(bitselect==4'b1001)
	begin
		bitselect <= 4'b0000;
	end
	else
	begin
		bitselect <= bitselect + 4'b0001;
	end
	case({bitselect==4'b1001,counter==4'b1111})
		2'b00:
		begin
			counter<=counter;
		end
		2'b01:
		begin
			counter<=counter;
		end
		2'b10:
		begin
			counter<=counter+4'b0001;
		end
		2'b11:
		begin
			counter<=4'b0000;
		end
	endcase
  end
	//**********
	if(reset||count_store==4'b1111)
	begin
		counter <= 4'b0000;
		bitselect <= 4'b0000;
	end
  end
  // counter for sending mac values
  always@(posedge clk)
  begin
  if(startdesign==1 && flag_a==1)
  begin
	if(bitselect1==4'b1000)
	begin
		bitselect1 <= 4'b0000;
	end
	else
	begin
		bitselect1 <= bitselect1 + 4'b0001;
	end
	case({bitselect1==4'b1000,select==4'b1111})
		2'b00:
		begin
			select<=select;
		end
		2'b01:
		begin
			select<=select;
		end
		2'b10:
		begin
			select<=select+4'b0001;
		end
		2'b11:
		begin
			select<=4'b0000;
		end
	endcase
  end
	//**********
	if(reset||count_store==4'b1111)
	begin
		select <= 4'b0000;
		bitselect1 <= 4'b0000;
	end
  end
  // counter for storing z values
  always@(posedge clk)
  begin
	if(startdesign==1 && bitselect1==4'b0001 && select==4'b0000)
	begin
		z_start<=1;
	end
	//************
	if(reset||count_store==4'b1111)
	begin
		z_start<=0;
	end
  end
  always@(posedge clk)
  begin
  if(startdesign==1 && flag_a==1 && z_start==1)
  begin
	if(bitselect2==4'b1000)
	begin
		bitselect2 <= 4'b0000;
	end
	else
	begin
		bitselect2 <= bitselect2 + 4'b0001;
	end
	
	if(zcount!=4'b1111 && bitselect2==4'b1000)
	begin
		zcount<=zcount+4'b0001;
	end
	else
	begin
		zcount<=zcount;
	end
  end
	//************
	if(reset||count_store==4'b1111)
	begin
		zcount <= 4'b0000;
		bitselect2 <= 4'b0000;
	end
  end
  
  // counter for m-vector
  always@(posedge clk)
  begin
	if(startdesign==1 && flag_z==1)
	begin
		if(count_m==10'b1000000000)
		begin
			count_m <= 10'b0000000000;
		end
		else
		begin
			count_m <= count_m + 10'b0000000001;
		end
	end
	//*************
	if(reset||count_store==4'b1111)
	begin
		count_m <= 10'b0000000000;
	end
  end
  
  //counter for sending z to mac 
  always@(posedge clk)
  begin
	if(startdesign==1 && flag_z==1 && flag_zsynch==1)
	begin
		if(sendz_count==6'b111111)
		begin
			sendz_count <= 6'b000000;
		end
		else
		begin
			sendz_count <= sendz_count + 6'b000001;
		end
	end
	//*************
	if(reset||count_store==4'b1111)
	begin
		sendz_count <= 6'b000000;
	end
  end
  
  //counter for storing final output
  always@(posedge clk)
  begin
	if (startdesign==1 && flag_z==1)
	begin
		if(sendz_count==6'b111111 && count_out!=3'b111)
		begin
			count_out<=count_out+3'b001;
		end
		else if(sendz_count==6'b111111 && count_out==3'b111)
		begin
			count_out<=3'b000;
		end
		else
		begin
			count_out<=count_out;
		end
	end
	//*************
	if(reset||count_store==4'b1111)
	begin
		count_out <= 3'b000;
	end
  end
  
  // counter for writing into output memory
  always@(posedge clk)
  begin
	if(startdesign==1 && flag_out==1)
	begin
		if(count_store==4'b1111)
		begin
			count_store<=count_store;
		end
		else
		begin
			count_store<=count_store+4'b0001;
		end
	end
	//*************
	if(reset||count_store==4'b1111)
	begin
		count_store <= 4'b0000;
	end
  end
  
  // storing a-vectors of all the quadrants
  always@(posedge clk)
  begin
  if(startdesign==1)
  begin
	dut__dim__write<=0;
	dut__dim__enable<=1;
	if(counter[3:2]==2'b00)
	begin
		if(counter[1:0]==2'b00)
		begin
			case(bitselect)
				4'b0000:
				begin
					dut__dim__address<=9'b000000000+9'b000000000+9'b000000000;
				end
				4'b0001:
				begin
					dut__dim__address<=9'b000000000+9'b000000000+9'b000000001;
					avector00[0]<=dim__dut__data;
				end
				4'b0010:
				begin
					dut__dim__address<=9'b000000000+9'b000000000+9'b000000010;
					avector00[1]<=dim__dut__data;
				end
				4'b0011:
				begin
					dut__dim__address<=9'b000000000+9'b000000000+9'b000010000;
					avector00[2]<=dim__dut__data;
				end
				4'b0100:
				begin
					dut__dim__address<=9'b000000000+9'b000000000+9'b000010001;
					avector00[3]<=dim__dut__data;
				end
				4'b0101:
				begin
					dut__dim__address<=9'b000000000+9'b000000000+9'b000010010;
					avector00[4]<=dim__dut__data;
				end
				4'b0110:
				begin
					dut__dim__address<=9'b000000000+9'b000000000+9'b000100000;
					avector00[5]<=dim__dut__data;
				end
				4'b0111:
				begin
					dut__dim__address<=9'b000000000+9'b000000000+9'b000100001;
					avector00[6]<=dim__dut__data;
				end
				4'b1000:
				begin
					dut__dim__address<=9'b000000000+9'b000000000+9'b000100010;
					avector00[7]<=dim__dut__data;
				end
				4'b1001:
				begin
					avector00[8]<=dim__dut__data;
				end
			endcase
		end
		else if(counter[1:0]==2'b01)
		begin
			case(bitselect)
				4'b0000:
				begin
					dut__dim__address<=9'b000000000+9'b000000110+9'b000000000;
				end
				4'b0001:
				begin
					dut__dim__address<=9'b000000000+9'b000000110+9'b000000001;
					avector10[0]<=dim__dut__data;
				end
				4'b0010:
				begin
					dut__dim__address<=9'b000000000+9'b000000110+9'b000000010;
					avector10[1]<=dim__dut__data;
				end
				4'b0011:
				begin
					dut__dim__address<=9'b000000000+9'b000000110+9'b000010000;
					avector10[2]<=dim__dut__data;
				end
				4'b0100:
				begin
					dut__dim__address<=9'b000000000+9'b000000110+9'b000010001;
					avector10[3]<=dim__dut__data;
				end
				4'b0101:
				begin
					dut__dim__address<=9'b000000000+9'b000000110+9'b000010010;
					avector10[4]<=dim__dut__data;
				end
				4'b0110:
				begin
					dut__dim__address<=9'b000000000+9'b000000110+9'b000100000;
					avector10[5]<=dim__dut__data;
				end
				4'b0111:
				begin
					dut__dim__address<=9'b000000000+9'b000000110+9'b000100001;
					avector10[6]<=dim__dut__data;
				end
				4'b1000:
				begin
					dut__dim__address<=9'b000000000+9'b000000110+9'b000100010;
					avector10[7]<=dim__dut__data;
				end
				4'b1001:
				begin
					avector10[8]<=dim__dut__data;
				end
			endcase
		end
		else if(counter[1:0]==2'b10)
		begin
			case(bitselect)
				4'b0000:
				begin
					dut__dim__address<=9'b000000000+9'b001100000+9'b000000000;
				end
				4'b0001:
				begin
					dut__dim__address<=9'b000000000+9'b001100000+9'b000000001;
					avector20[0]<=dim__dut__data;
				end
				4'b0010:
				begin
					dut__dim__address<=9'b000000000+9'b001100000+9'b000000010;
					avector20[1]<=dim__dut__data;
				end
				4'b0011:
				begin
					dut__dim__address<=9'b000000000+9'b001100000+9'b000010000;
					avector20[2]<=dim__dut__data;
				end
				4'b0100:
				begin
					dut__dim__address<=9'b000000000+9'b001100000+9'b000010001;
					avector20[3]<=dim__dut__data;
				end
				4'b0101:
				begin
					dut__dim__address<=9'b000000000+9'b001100000+9'b000010010;
					avector20[4]<=dim__dut__data;
				end
				4'b0110:
				begin
					dut__dim__address<=9'b000000000+9'b001100000+9'b000100000;
					avector20[5]<=dim__dut__data;
				end
				4'b0111:
				begin
					dut__dim__address<=9'b000000000+9'b001100000+9'b000100001;
					avector20[6]<=dim__dut__data;
				end
				4'b1000:
				begin
					dut__dim__address<=9'b000000000+9'b001100000+9'b000100010;
					avector20[7]<=dim__dut__data;
				end
				4'b1001:
				begin
					avector20[8]<=dim__dut__data;
				end
			endcase
		end
		else if(counter[1:0]==2'b11)
		begin
			case(bitselect)
				4'b0000:
				begin
					dut__dim__address<=9'b000000000+9'b001100110+9'b000000000;
				end
				4'b0001:
				begin
					dut__dim__address<=9'b000000000+9'b001100110+9'b000000001;
					avector30[0]<=dim__dut__data;
				end
				4'b0010:
				begin
					dut__dim__address<=9'b000000000+9'b001100110+9'b000000010;
					avector30[1]<=dim__dut__data;
				end
				4'b0011:
				begin
					dut__dim__address<=9'b000000000+9'b001100110+9'b000010000;
					avector30[2]<=dim__dut__data;
				end
				4'b0100:
				begin
					dut__dim__address<=9'b000000000+9'b001100110+9'b000010001;
					avector30[3]<=dim__dut__data;
				end
				4'b0101:
				begin
					dut__dim__address<=9'b000000000+9'b001100110+9'b000010010;
					avector30[4]<=dim__dut__data;
				end
				4'b0110:
				begin
					dut__dim__address<=9'b000000000+9'b001100110+9'b000100000;
					avector30[5]<=dim__dut__data;
				end
				4'b0111:
				begin
					dut__dim__address<=9'b000000000+9'b001100110+9'b000100001;
					avector30[6]<=dim__dut__data;
				end
				4'b1000:
				begin
					dut__dim__address<=9'b000000000+9'b001100110+9'b000100010;
					avector30[7]<=dim__dut__data;
				end
				4'b1001:
				begin
					avector30[8]<=dim__dut__data;
				end
			endcase
		end
	end
	else if(counter[3:2]==2'b01)
	begin
		if(counter[1:0]==2'b00)
		begin
			case(bitselect)
				4'b0000:
				begin
					dut__dim__address<=9'b000000011+9'b000000000+9'b000000000;
				end
				4'b0001:
				begin
					dut__dim__address<=9'b000000011+9'b000000000+9'b000000001;
					avector01[0]<=dim__dut__data;
				end
				4'b0010:
				begin
					dut__dim__address<=9'b000000011+9'b000000000+9'b000000010;
					avector01[1]<=dim__dut__data;
				end
				4'b0011:
				begin
					dut__dim__address<=9'b000000011+9'b000000000+9'b000010000;
					avector01[2]<=dim__dut__data;
				end
				4'b0100:
				begin
					dut__dim__address<=9'b000000011+9'b000000000+9'b000010001;
					avector01[3]<=dim__dut__data;
				end
				4'b0101:
				begin
					dut__dim__address<=9'b000000011+9'b000000000+9'b000010010;
					avector01[4]<=dim__dut__data;
				end
				4'b0110:
				begin
					dut__dim__address<=9'b000000011+9'b000000000+9'b000100000;
					avector01[5]<=dim__dut__data;
				end
				4'b0111:
				begin
					dut__dim__address<=9'b000000011+9'b000000000+9'b000100001;
					avector01[6]<=dim__dut__data;
				end
				4'b1000:
				begin
					dut__dim__address<=9'b000000011+9'b000000000+9'b000100010;
					avector01[7]<=dim__dut__data;
				end
				4'b1001:
				begin
					avector01[8]<=dim__dut__data;
				end
			endcase
		end
		else if(counter[1:0]==2'b01)
		begin
			case(bitselect)
				4'b0000:
				begin
					dut__dim__address<=9'b000000011+9'b000000110+9'b000000000;
				end
				4'b0001:
				begin
					dut__dim__address<=9'b000000011+9'b000000110+9'b000000001;
					avector11[0]<=dim__dut__data;
				end
				4'b0010:
				begin
					dut__dim__address<=9'b000000011+9'b000000110+9'b000000010;
					avector11[1]<=dim__dut__data;
				end
				4'b0011:
				begin
					dut__dim__address<=9'b000000011+9'b000000110+9'b000010000;
					avector11[2]<=dim__dut__data;
				end
				4'b0100:
				begin
					dut__dim__address<=9'b000000011+9'b000000110+9'b000010001;
					avector11[3]<=dim__dut__data;
				end
				4'b0101:
				begin
					dut__dim__address<=9'b000000011+9'b000000110+9'b000010010;
					avector11[4]<=dim__dut__data;
				end
				4'b0110:
				begin
					dut__dim__address<=9'b000000011+9'b000000110+9'b000100000;
					avector11[5]<=dim__dut__data;
				end
				4'b0111:
				begin
					dut__dim__address<=9'b000000011+9'b000000110+9'b000100001;
					avector11[6]<=dim__dut__data;
				end
				4'b1000:
				begin
					dut__dim__address<=9'b000000011+9'b000000110+9'b000100010;
					avector11[7]<=dim__dut__data;
				end
				4'b1001:
				begin
					avector11[8]<=dim__dut__data;
				end
			endcase
		end
		else if(counter[1:0]==2'b10)
		begin
			case(bitselect)
				4'b0000:
				begin
					dut__dim__address<=9'b000000011+9'b001100000+9'b000000000;
				end
				4'b0001:
				begin
					dut__dim__address<=9'b000000011+9'b001100000+9'b000000001;
					avector21[0]<=dim__dut__data;
				end
				4'b0010:
				begin
					dut__dim__address<=9'b000000011+9'b001100000+9'b000000010;
					avector21[1]<=dim__dut__data;
				end
				4'b0011:
				begin
					dut__dim__address<=9'b000000011+9'b001100000+9'b000010000;
					avector21[2]<=dim__dut__data;
				end
				4'b0100:
				begin
					dut__dim__address<=9'b000000011+9'b001100000+9'b000010001;
					avector21[3]<=dim__dut__data;
				end
				4'b0101:
				begin
					dut__dim__address<=9'b000000011+9'b001100000+9'b000010010;
					avector21[4]<=dim__dut__data;
				end
				4'b0110:
				begin
					dut__dim__address<=9'b000000011+9'b001100000+9'b000100000;
					avector21[5]<=dim__dut__data;
				end
				4'b0111:
				begin
					dut__dim__address<=9'b000000011+9'b001100000+9'b000100001;
					avector21[6]<=dim__dut__data;
				end
				4'b1000:
				begin
					dut__dim__address<=9'b000000011+9'b001100000+9'b000100010;
					avector21[7]<=dim__dut__data;
				end
				4'b1001:
				begin
					avector21[8]<=dim__dut__data;
				end
			endcase
		end
		else if(counter[1:0]==2'b11)
		begin
			case(bitselect)
				4'b0000:
				begin
					dut__dim__address<=9'b000000011+9'b001100110+9'b000000000;
				end
				4'b0001:
				begin
					dut__dim__address<=9'b000000011+9'b001100110+9'b000000001;
					avector31[0]<=dim__dut__data;
				end
				4'b0010:
				begin
					dut__dim__address<=9'b000000011+9'b001100110+9'b000000010;
					avector31[1]<=dim__dut__data;
				end
				4'b0011:
				begin
					dut__dim__address<=9'b000000011+9'b001100110+9'b000010000;
					avector31[2]<=dim__dut__data;
				end
				4'b0100:
				begin
					dut__dim__address<=9'b000000011+9'b001100110+9'b000010001;
					avector31[3]<=dim__dut__data;
				end
				4'b0101:
				begin
					dut__dim__address<=9'b000000011+9'b001100110+9'b000010010;
					avector31[4]<=dim__dut__data;
				end
				4'b0110:
				begin
					dut__dim__address<=9'b000000011+9'b001100110+9'b000100000;
					avector31[5]<=dim__dut__data;
				end
				4'b0111:
				begin
					dut__dim__address<=9'b000000011+9'b001100110+9'b000100001;
					avector31[6]<=dim__dut__data;
				end
				4'b1000:
				begin
					dut__dim__address<=9'b000000011+9'b001100110+9'b000100010;
					avector31[7]<=dim__dut__data;
				end
				4'b1001:
				begin
					avector31[8]<=dim__dut__data;
				end
			endcase
		end
	end
	else if(counter[3:2]==2'b10)
	begin
		if(counter[1:0]==2'b00)
		begin
			case(bitselect)
				4'b0000:
				begin
					dut__dim__address<=9'b000110000+9'b000000000+9'b000000000;
				end
				4'b0001:
				begin
					dut__dim__address<=9'b000110000+9'b000000000+9'b000000001;
					avector02[0]<=dim__dut__data;
				end
				4'b0010:
				begin
					dut__dim__address<=9'b000110000+9'b000000000+9'b000000010;
					avector02[1]<=dim__dut__data;
				end
				4'b0011:
				begin
					dut__dim__address<=9'b000110000+9'b000000000+9'b000010000;
					avector02[2]<=dim__dut__data;
				end
				4'b0100:
				begin
					dut__dim__address<=9'b000110000+9'b000000000+9'b000010001;
					avector02[3]<=dim__dut__data;
				end
				4'b0101:
				begin
					dut__dim__address<=9'b000110000+9'b000000000+9'b000010010;
					avector02[4]<=dim__dut__data;
				end
				4'b0110:
				begin
					dut__dim__address<=9'b000110000+9'b000000000+9'b000100000;
					avector02[5]<=dim__dut__data;
				end
				4'b0111:
				begin
					dut__dim__address<=9'b000110000+9'b000000000+9'b000100001;
					avector02[6]<=dim__dut__data;
				end
				4'b1000:
				begin
					dut__dim__address<=9'b000110000+9'b000000000+9'b000100010;
					avector02[7]<=dim__dut__data;
				end
				4'b1001:
				begin
					avector02[8]<=dim__dut__data;
				end
			endcase
		end
		else if(counter[1:0]==2'b01)
		begin
			case(bitselect)
				4'b0000:
				begin
					dut__dim__address<=9'b000110000+9'b000000110+9'b000000000;
				end
				4'b0001:
				begin
					dut__dim__address<=9'b000110000+9'b000000110+9'b000000001;
					avector12[0]<=dim__dut__data;
				end
				4'b0010:
				begin
					dut__dim__address<=9'b000110000+9'b000000110+9'b000000010;
					avector12[1]<=dim__dut__data;
				end
				4'b0011:
				begin
					dut__dim__address<=9'b000110000+9'b000000110+9'b000010000;
					avector12[2]<=dim__dut__data;
				end
				4'b0100:
				begin
					dut__dim__address<=9'b000110000+9'b000000110+9'b000010001;
					avector12[3]<=dim__dut__data;
				end
				4'b0101:
				begin
					dut__dim__address<=9'b000110000+9'b000000110+9'b000010010;
					avector12[4]<=dim__dut__data;
				end
				4'b0110:
				begin
					dut__dim__address<=9'b000110000+9'b000000110+9'b000100000;
					avector12[5]<=dim__dut__data;
				end
				4'b0111:
				begin
					dut__dim__address<=9'b000110000+9'b000000110+9'b000100001;
					avector12[6]<=dim__dut__data;
				end
				4'b1000:
				begin
					dut__dim__address<=9'b000110000+9'b000000110+9'b000100010;
					avector12[7]<=dim__dut__data;
				end
				4'b1001:
				begin
					avector12[8]<=dim__dut__data;
				end
			endcase
		end
		else if(counter[1:0]==2'b10)
		begin
			case(bitselect)
				4'b0000:
				begin
					dut__dim__address<=9'b000110000+9'b001100000+9'b000000000;
				end
				4'b0001:
				begin
					dut__dim__address<=9'b000110000+9'b001100000+9'b000000001;
					avector22[0]<=dim__dut__data;
				end
				4'b0010:
				begin
					dut__dim__address<=9'b000110000+9'b001100000+9'b000000010;
					avector22[1]<=dim__dut__data;
				end
				4'b0011:
				begin
					dut__dim__address<=9'b000110000+9'b001100000+9'b000010000;
					avector22[2]<=dim__dut__data;
				end
				4'b0100:
				begin
					dut__dim__address<=9'b000110000+9'b001100000+9'b000010001;
					avector22[3]<=dim__dut__data;
				end
				4'b0101:
				begin
					dut__dim__address<=9'b000110000+9'b001100000+9'b000010010;
					avector22[4]<=dim__dut__data;
				end
				4'b0110:
				begin
					dut__dim__address<=9'b000110000+9'b001100000+9'b000100000;
					avector22[5]<=dim__dut__data;
				end
				4'b0111:
				begin
					dut__dim__address<=9'b000110000+9'b001100000+9'b000100001;
					avector22[6]<=dim__dut__data;
				end
				4'b1000:
				begin
					dut__dim__address<=9'b000110000+9'b001100000+9'b000100010;
					avector22[7]<=dim__dut__data;
				end
				4'b1001:
				begin
					avector22[8]<=dim__dut__data;
				end
			endcase
		end
		else if(counter[1:0]==2'b11)
		begin
			case(bitselect)
				4'b0000:
				begin
					dut__dim__address<=9'b000110000+9'b001100110+9'b000000000;
				end
				4'b0001:
				begin
					dut__dim__address<=9'b000110000+9'b001100110+9'b000000001;
					avector32[0]<=dim__dut__data;
				end
				4'b0010:
				begin
					dut__dim__address<=9'b000110000+9'b001100110+9'b000000010;
					avector32[1]<=dim__dut__data;
				end
				4'b0011:
				begin
					dut__dim__address<=9'b000110000+9'b001100110+9'b000010000;
					avector32[2]<=dim__dut__data;
				end
				4'b0100:
				begin
					dut__dim__address<=9'b000110000+9'b001100110+9'b000010001;
					avector32[3]<=dim__dut__data;
				end
				4'b0101:
				begin
					dut__dim__address<=9'b000110000+9'b001100110+9'b000010010;
					avector32[4]<=dim__dut__data;
				end
				4'b0110:
				begin
					dut__dim__address<=9'b000110000+9'b001100110+9'b000100000;
					avector32[5]<=dim__dut__data;
				end
				4'b0111:
				begin
					dut__dim__address<=9'b000110000+9'b001100110+9'b000100001;
					avector32[6]<=dim__dut__data;
				end
				4'b1000:
				begin
					dut__dim__address<=9'b000110000+9'b001100110+9'b000100010;
					avector32[7]<=dim__dut__data;
				end
				4'b1001:
				begin
					avector32[8]<=dim__dut__data;
				end
			endcase
		end
	end
	else if(counter[3:2]==2'b11)
	begin
		if(counter[1:0]==2'b00)
		begin
			case(bitselect)
				4'b0000:
				begin
					dut__dim__address<=9'b000110011+9'b000000000+9'b000000000;
				end
				4'b0001:
				begin
					dut__dim__address<=9'b000110011+9'b000000000+9'b000000001;
					avector03[0]<=dim__dut__data;
				end
				4'b0010:
				begin
					dut__dim__address<=9'b000110011+9'b000000000+9'b000000010;
					avector03[1]<=dim__dut__data;
				end
				4'b0011:
				begin
					dut__dim__address<=9'b000110011+9'b000000000+9'b000010000;
					avector03[2]<=dim__dut__data;
				end
				4'b0100:
				begin
					dut__dim__address<=9'b000110011+9'b000000000+9'b000010001;
					avector03[3]<=dim__dut__data;
				end
				4'b0101:
				begin
					dut__dim__address<=9'b000110011+9'b000000000+9'b000010010;
					avector03[4]<=dim__dut__data;
				end
				4'b0110:
				begin
					dut__dim__address<=9'b000110011+9'b000000000+9'b000100000;
					avector03[5]<=dim__dut__data;
				end
				4'b0111:
				begin
					dut__dim__address<=9'b000110011+9'b000000000+9'b000100001;
					avector03[6]<=dim__dut__data;
				end
				4'b1000:
				begin
					dut__dim__address<=9'b000110011+9'b000000000+9'b000100010;
					avector03[7]<=dim__dut__data;
				end
				4'b1001:
				begin
					avector03[8]<=dim__dut__data;
				end
			endcase
		end
		else if(counter[1:0]==2'b01)
		begin
			case(bitselect)
				4'b0000:
				begin
					dut__dim__address<=9'b000110011+9'b000000110+9'b000000000;
				end
				4'b0001:
				begin
					dut__dim__address<=9'b000110011+9'b000000110+9'b000000001;
					avector13[0]<=dim__dut__data;
				end
				4'b0010:
				begin
					dut__dim__address<=9'b000110011+9'b000000110+9'b000000010;
					avector13[1]<=dim__dut__data;
				end
				4'b0011:
				begin
					dut__dim__address<=9'b000110011+9'b000000110+9'b000010000;
					avector13[2]<=dim__dut__data;
				end
				4'b0100:
				begin
					dut__dim__address<=9'b000110011+9'b000000110+9'b000010001;
					avector13[3]<=dim__dut__data;
				end
				4'b0101:
				begin
					dut__dim__address<=9'b000110011+9'b000000110+9'b000010010;
					avector13[4]<=dim__dut__data;
				end
				4'b0110:
				begin
					dut__dim__address<=9'b000110011+9'b000000110+9'b000100000;
					avector13[5]<=dim__dut__data;
				end
				4'b0111:
				begin
					dut__dim__address<=9'b000110011+9'b000000110+9'b000100001;
					avector13[6]<=dim__dut__data;
				end
				4'b1000:
				begin
					dut__dim__address<=9'b000110011+9'b000000110+9'b000100010;
					avector13[7]<=dim__dut__data;
				end
				4'b1001:
				begin
					avector13[8]<=dim__dut__data;
				end
			endcase
		end
		else if(counter[1:0]==2'b10)
		begin
			case(bitselect)
				4'b0000:
				begin
					dut__dim__address<=9'b000110011+9'b001100000+9'b000000000;
				end
				4'b0001:
				begin
					dut__dim__address<=9'b000110011+9'b001100000+9'b000000001;
					avector23[0]<=dim__dut__data;
				end
				4'b0010:
				begin
					dut__dim__address<=9'b000110011+9'b001100000+9'b000000010;
					avector23[1]<=dim__dut__data;
				end
				4'b0011:
				begin
					dut__dim__address<=9'b000110011+9'b001100000+9'b000010000;
					avector23[2]<=dim__dut__data;
				end
				4'b0100:
				begin
					dut__dim__address<=9'b000110011+9'b001100000+9'b000010001;
					avector23[3]<=dim__dut__data;
				end
				4'b0101:
				begin
					dut__dim__address<=9'b000110011+9'b001100000+9'b000010010;
					avector23[4]<=dim__dut__data;
				end
				4'b0110:
				begin
					dut__dim__address<=9'b000110011+9'b001100000+9'b000100000;
					avector23[5]<=dim__dut__data;
				end
				4'b0111:
				begin
					dut__dim__address<=9'b000110011+9'b001100000+9'b000100001;
					avector23[6]<=dim__dut__data;
				end
				4'b1000:
				begin
					dut__dim__address<=9'b000110011+9'b001100000+9'b000100010;
					avector23[7]<=dim__dut__data;
				end
				4'b1001:
				begin
					avector23[8]<=dim__dut__data;
				end
			endcase
		end
		else if(counter[1:0]==2'b11)
		begin
			case(bitselect)
				4'b0000:
				begin
					dut__dim__address<=9'b000110011+9'b001100110+9'b000000000;
				end
				4'b0001:
				begin
					dut__dim__address<=9'b000110011+9'b001100110+9'b000000001;
					avector33[0]<=dim__dut__data;
				end
				4'b0010:
				begin
					dut__dim__address<=9'b000110011+9'b001100110+9'b000000010;
					avector33[1]<=dim__dut__data;
				end
				4'b0011:
				begin
					dut__dim__address<=9'b000110011+9'b001100110+9'b000010000;
					avector33[2]<=dim__dut__data;
				end
				4'b0100:
				begin
					dut__dim__address<=9'b000110011+9'b001100110+9'b000010001;
					avector33[3]<=dim__dut__data;
				end
				4'b0101:
				begin
					dut__dim__address<=9'b000110011+9'b001100110+9'b000010010;
					avector33[4]<=dim__dut__data;
				end
				4'b0110:
				begin
					dut__dim__address<=9'b000110011+9'b001100110+9'b000100000;
					avector33[5]<=dim__dut__data;
				end
				4'b0111:
				begin
					dut__dim__address<=9'b000110011+9'b001100110+9'b000100001;
					avector33[6]<=dim__dut__data;
				end
				4'b1000:
				begin
					dut__dim__address<=9'b000110011+9'b001100110+9'b000100010;
					avector33[7]<=dim__dut__data;
				end
				4'b1001:
				begin
					avector33[8]<=dim__dut__data;
					flag_a<=1;
				end
			endcase
		end
	end

  end
	//*************
	if(reset||count_store==4'b1111)
	begin
		flag_a <= 0;
	end
  end
  // storing b-vectors of all the quadrants
  always@(posedge clk)
  begin
  if(startdesign==1 && flag_z==0 && flag_a==0)
  begin
	dut__bvm__write<=0;
	dut__bvm__enable<=1;
	if(counter[1:0]==2'b00)
	begin
		case(bitselect)
			4'b0000:
			begin
				dut__bvm__address<=10'b0000000000+10'b0000000000;	
			end
			4'b0001:
			begin
				dut__bvm__address<=10'b0000000000+10'b0000000001;
				bvector0[0]<=bvm__dut__data;
			end
			4'b0010:
			begin
				dut__bvm__address<=10'b0000000000+10'b0000000010;
				bvector0[1]<=bvm__dut__data;
			end
			4'b0011:
			begin
				dut__bvm__address<=10'b0000000000+10'b0000000011;
				bvector0[2]<=bvm__dut__data;
			end
			4'b0100:
			begin
				dut__bvm__address<=10'b0000000000+10'b0000000100;
				bvector0[3]<=bvm__dut__data;
			end
			4'b0101:
			begin
				dut__bvm__address<=10'b0000000000+10'b0000000101;
				bvector0[4]<=bvm__dut__data;
			end
			4'b0110:
			begin
				dut__bvm__address<=10'b0000000000+10'b0000000110;
				bvector0[5]<=bvm__dut__data;
			end
			4'b0111:
			begin
				dut__bvm__address<=10'b0000000000+10'b0000000111;
				bvector0[6]<=bvm__dut__data;
			end
			4'b1000:
			begin
				dut__bvm__address<=10'b0000000000+10'b0000001000;
				bvector0[7]<=bvm__dut__data;
			end
			4'b1001:
			begin
				bvector0[8]<=bvm__dut__data;
			end
		endcase
	end
	else if(counter[1:0]==2'b01)
	begin
		case(bitselect)
			4'b0000:
			begin
				dut__bvm__address<=10'b0000010000+10'b0000000000;
			end
			4'b0001:
			begin
				dut__bvm__address<=10'b0000010000+10'b0000000001;
				bvector1[0]<=bvm__dut__data;
			end
			4'b0010:
			begin
				dut__bvm__address<=10'b0000010000+10'b0000000010;
				bvector1[1]<=bvm__dut__data;
			end
			4'b0011:
			begin
				dut__bvm__address<=10'b0000010000+10'b0000000011;
				bvector1[2]<=bvm__dut__data;
			end
			4'b0100:
			begin
				dut__bvm__address<=10'b0000010000+10'b0000000100;
				bvector1[3]<=bvm__dut__data;
			end
			4'b0101:
			begin
				dut__bvm__address<=10'b0000010000+10'b0000000101;
				bvector1[4]<=bvm__dut__data;
			end
			4'b0110:
			begin
				dut__bvm__address<=10'b0000010000+10'b0000000110;
				bvector1[5]<=bvm__dut__data;
			end
			4'b0111:
			begin
				dut__bvm__address<=10'b0000010000+10'b0000000111;
				bvector1[6]<=bvm__dut__data;
			end
			4'b1000:
			begin
				dut__bvm__address<=10'b0000010000+10'b0000001000;
				bvector1[7]<=bvm__dut__data;
			end
			4'b1001:
			begin
				bvector1[8]<=bvm__dut__data;
			end
		endcase
	end
	else if(counter[1:0]==2'b10)
	begin
		case(bitselect)
			4'b0000:
			begin
				dut__bvm__address<=10'b0000100000+10'b0000000000;
			end
			4'b0001:
			begin
				dut__bvm__address<=10'b0000100000+10'b0000000001;
				bvector2[0]<=bvm__dut__data;
			end
			4'b0010:
			begin
				dut__bvm__address<=10'b0000100000+10'b0000000010;
				bvector2[1]<=bvm__dut__data;
			end
			4'b0011:
			begin
				dut__bvm__address<=10'b0000100000+10'b0000000011;
				bvector2[2]<=bvm__dut__data;
			end
			4'b0100:
			begin
				dut__bvm__address<=10'b0000100000+10'b0000000100;
				bvector2[3]<=bvm__dut__data;
			end
			4'b0101:
			begin
				dut__bvm__address<=10'b0000100000+10'b0000000101;
				bvector2[4]<=bvm__dut__data;
			end
			4'b0110:
			begin
				dut__bvm__address<=10'b0000100000+10'b0000000110;
				bvector2[5]<=bvm__dut__data;
			end
			4'b0111:
			begin
				dut__bvm__address<=10'b0000100000+10'b0000000111;
				bvector2[6]<=bvm__dut__data;
			end
			4'b1000:
			begin
				dut__bvm__address<=10'b0000100000+10'b0000001000;
				bvector2[7]<=bvm__dut__data;
			end
			4'b1001:
			begin
				bvector2[8]<=bvm__dut__data;
			end
		endcase
	end
	else if(counter[1:0]==2'b11)
	begin
		case(bitselect)
			4'b0000:
			begin
				dut__bvm__address<=10'b0000110000+10'b0000000000;	
			end
			4'b0001:
			begin
				dut__bvm__address<=10'b0000110000+10'b0000000001;
				bvector3[0]<=bvm__dut__data;
			end
			4'b0010:
			begin
				dut__bvm__address<=10'b0000110000+10'b0000000010;
				bvector3[1]<=bvm__dut__data;
			end
			4'b0011:
			begin
				dut__bvm__address<=10'b0000110000+10'b0000000011;
				bvector3[2]<=bvm__dut__data;
			end
			4'b0100:
			begin
				dut__bvm__address<=10'b0000110000+10'b0000000100;
				bvector3[3]<=bvm__dut__data;
			end
			4'b0101:
			begin
				dut__bvm__address<=10'b0000110000+10'b0000000101;
				bvector3[4]<=bvm__dut__data;
			end
			4'b0110:
			begin
				dut__bvm__address<=10'b0000110000+10'b0000000110;
				bvector3[5]<=bvm__dut__data;
			end
			4'b0111:
			begin
				dut__bvm__address<=10'b0000110000+10'b0000000111;
				bvector3[6]<=bvm__dut__data;
			end
			4'b1000:
			begin
				dut__bvm__address<=10'b0000110000+10'b0000001000;
				bvector3[7]<=bvm__dut__data;
			end
			4'b1001:
			begin
				bvector3[8]<=bvm__dut__data;
				flag_b<=1;
			end
		endcase
	end
  end
  // m synch
  if(startdesign==1 && flag_z==0 && flag_a==1)
  begin
	dut__bvm__enable<=0;
  end
  //fetching m-vector
  if(startdesign==1 && flag_z==1)
	begin
		dut__bvm__enable<=1;
		dut__bvm__address <= 10'b0001000000 + count_m;
		m <= bvm__dut__data;
		flag_zsynch<=1;
	end
	//*************
	if(reset||count_store==4'b1111)
	begin
		flag_zsynch <= 0;
		flag_b <= 0;
	end
  end
  
  // sending values to mac variables
  always@(posedge clk)
  begin
  if(startdesign==1 && flag_a==1)
  begin
	if(select[3:2]==2'b00)
	begin
		if(select[1:0]==2'b00)
		begin
			case(bitselect1)
			4'b0000:
			begin
				mac_a0<=avector00[0];
				mac_a1<=avector10[0];
				mac_a2<=avector20[0];
				mac_a3<=avector30[0];
				mac_b<=bvector0[0];
			end
			4'b0001:
			begin
				mac_a0<=avector00[1];
				mac_a1<=avector10[1];
				mac_a2<=avector20[1];
				mac_a3<=avector30[1];
				mac_b<=bvector0[1];
			end
			4'b0010:
			begin
				mac_a0<=avector00[2];
				mac_a1<=avector10[2];
				mac_a2<=avector20[2];
				mac_a3<=avector30[2];
				mac_b<=bvector0[2];
			end
			4'b0011:
			begin
				mac_a0<=avector00[3];
				mac_a1<=avector10[3];
				mac_a2<=avector20[3];
				mac_a3<=avector30[3];
				mac_b<=bvector0[3];
			end
			4'b0100:
			begin
				mac_a0<=avector00[4];
				mac_a1<=avector10[4];
				mac_a2<=avector20[4];
				mac_a3<=avector30[4];
				mac_b<=bvector0[4];
			end
			4'b0101:
			begin
				mac_a0<=avector00[5];
				mac_a1<=avector10[5];
				mac_a2<=avector20[5];
				mac_a3<=avector30[5];
				mac_b<=bvector0[5];
			end
			4'b0110:
			begin
				mac_a0<=avector00[6];
				mac_a1<=avector10[6];
				mac_a2<=avector20[6];
				mac_a3<=avector30[6];
				mac_b<=bvector0[6];
			end
			4'b0111:
			begin
				mac_a0<=avector00[7];
				mac_a1<=avector10[7];
				mac_a2<=avector20[7];
				mac_a3<=avector30[7];
				mac_b<=bvector0[7];
			end
			4'b1000:
			begin
				mac_a0<=avector00[8];
				mac_a1<=avector10[8];
				mac_a2<=avector20[8];
				mac_a3<=avector30[8];
				mac_b<=bvector0[8];
			end
			endcase
		end
		else if(select[1:0]==2'b01)
		begin
			case(bitselect1)
			4'b0000:
			begin
				mac_a0<=avector00[0];
				mac_a1<=avector10[0];
				mac_a2<=avector20[0];
				mac_a3<=avector30[0];
				mac_b<=bvector1[0];
			end
			4'b0001:
			begin
				mac_a0<=avector00[1];
				mac_a1<=avector10[1];
				mac_a2<=avector20[1];
				mac_a3<=avector30[1];
				mac_b<=bvector1[1];
			end
			4'b0010:
			begin
				mac_a0<=avector00[2];
				mac_a1<=avector10[2];
				mac_a2<=avector20[2];
				mac_a3<=avector30[2];
				mac_b<=bvector1[2];
			end
			4'b0011:
			begin
				mac_a0<=avector00[3];
				mac_a1<=avector10[3];
				mac_a2<=avector20[3];
				mac_a3<=avector30[3];
				mac_b<=bvector1[3];
			end
			4'b0100:
			begin
				mac_a0<=avector00[4];
				mac_a1<=avector10[4];
				mac_a2<=avector20[4];
				mac_a3<=avector30[4];
				mac_b<=bvector1[4];
			end
			4'b0101:
			begin
				mac_a0<=avector00[5];
				mac_a1<=avector10[5];
				mac_a2<=avector20[5];
				mac_a3<=avector30[5];
				mac_b<=bvector1[5];
			end
			4'b0110:
			begin
				mac_a0<=avector00[6];
				mac_a1<=avector10[6];
				mac_a2<=avector20[6];
				mac_a3<=avector30[6];
				mac_b<=bvector1[6];
			end
			4'b0111:
			begin
				mac_a0<=avector00[7];
				mac_a1<=avector10[7];
				mac_a2<=avector20[7];
				mac_a3<=avector30[7];
				mac_b<=bvector1[7];
			end
			4'b1000:
			begin
				mac_a0<=avector00[8];
				mac_a1<=avector10[8];
				mac_a2<=avector20[8];
				mac_a3<=avector30[8];
				mac_b<=bvector1[8];
			end
			endcase
		end
		else if(select[1:0]==2'b10)
		begin
			case(bitselect1)
			4'b0000:
			begin
				mac_a0<=avector00[0];
				mac_a1<=avector10[0];
				mac_a2<=avector20[0];
				mac_a3<=avector30[0];
				mac_b<=bvector2[0];
			end
			4'b0001:
			begin
				mac_a0<=avector00[1];
				mac_a1<=avector10[1];
				mac_a2<=avector20[1];
				mac_a3<=avector30[1];
				mac_b<=bvector2[1];
			end
			4'b0010:
			begin
				mac_a0<=avector00[2];
				mac_a1<=avector10[2];
				mac_a2<=avector20[2];
				mac_a3<=avector30[2];
				mac_b<=bvector2[2];
			end
			4'b0011:
			begin
				mac_a0<=avector00[3];
				mac_a1<=avector10[3];
				mac_a2<=avector20[3];
				mac_a3<=avector30[3];
				mac_b<=bvector2[3];
			end
			4'b0100:
			begin
				mac_a0<=avector00[4];
				mac_a1<=avector10[4];
				mac_a2<=avector20[4];
				mac_a3<=avector30[4];
				mac_b<=bvector2[4];
			end
			4'b0101:
			begin
				mac_a0<=avector00[5];
				mac_a1<=avector10[5];
				mac_a2<=avector20[5];
				mac_a3<=avector30[5];
				mac_b<=bvector2[5];
			end
			4'b0110:
			begin
				mac_a0<=avector00[6];
				mac_a1<=avector10[6];
				mac_a2<=avector20[6];
				mac_a3<=avector30[6];
				mac_b<=bvector2[6];
			end
			4'b0111:
			begin
				mac_a0<=avector00[7];
				mac_a1<=avector10[7];
				mac_a2<=avector20[7];
				mac_a3<=avector30[7];
				mac_b<=bvector2[7];
			end
			4'b1000:
			begin
				mac_a0<=avector00[8];
				mac_a1<=avector10[8];
				mac_a2<=avector20[8];
				mac_a3<=avector30[8];
				mac_b<=bvector2[8];
			end
			endcase
		end
		else if(select[1:0]==2'b11)
		begin
			case(bitselect1)
			4'b0000:
			begin
				mac_a0<=avector00[0];
				mac_a1<=avector10[0];
				mac_a2<=avector20[0];
				mac_a3<=avector30[0];
				mac_b<=bvector3[0];
			end
			4'b0001:
			begin
				mac_a0<=avector00[1];
				mac_a1<=avector10[1];
				mac_a2<=avector20[1];
				mac_a3<=avector30[1];
				mac_b<=bvector3[1];
			end
			4'b0010:
			begin
				mac_a0<=avector00[2];
				mac_a1<=avector10[2];
				mac_a2<=avector20[2];
				mac_a3<=avector30[2];
				mac_b<=bvector3[2];
			end
			4'b0011:
			begin
				mac_a0<=avector00[3];
				mac_a1<=avector10[3];
				mac_a2<=avector20[3];
				mac_a3<=avector30[3];
				mac_b<=bvector3[3];
			end
			4'b0100:
			begin
				mac_a0<=avector00[4];
				mac_a1<=avector10[4];
				mac_a2<=avector20[4];
				mac_a3<=avector30[4];
				mac_b<=bvector3[4];
			end
			4'b0101:
			begin
				mac_a0<=avector00[5];
				mac_a1<=avector10[5];
				mac_a2<=avector20[5];
				mac_a3<=avector30[5];
				mac_b<=bvector3[5];
			end
			4'b0110:
			begin
				mac_a0<=avector00[6];
				mac_a1<=avector10[6];
				mac_a2<=avector20[6];
				mac_a3<=avector30[6];
				mac_b<=bvector3[6];
			end
			4'b0111:
			begin
				mac_a0<=avector00[7];
				mac_a1<=avector10[7];
				mac_a2<=avector20[7];
				mac_a3<=avector30[7];
				mac_b<=bvector3[7];
			end
			4'b1000:
			begin
				mac_a0<=avector00[8];
				mac_a1<=avector10[8];
				mac_a2<=avector20[8];
				mac_a3<=avector30[8];
				mac_b<=bvector3[8];
			end
			endcase
		end
	end
	else if(select[3:2]==2'b01)
	begin
		if(select[1:0]==2'b00)
		begin
			case(bitselect1)
			4'b0000:
			begin
				mac_a0<=avector01[0];
				mac_a1<=avector11[0];
				mac_a2<=avector21[0];
				mac_a3<=avector31[0];
				mac_b<=bvector0[0];
			end
			4'b0001:
			begin
				mac_a0<=avector01[1];
				mac_a1<=avector11[1];
				mac_a2<=avector21[1];
				mac_a3<=avector31[1];
				mac_b<=bvector0[1];
			end
			4'b0010:
			begin
				mac_a0<=avector01[2];
				mac_a1<=avector11[2];
				mac_a2<=avector21[2];
				mac_a3<=avector31[2];
				mac_b<=bvector0[2];
			end
			4'b0011:
			begin
				mac_a0<=avector01[3];
				mac_a1<=avector11[3];
				mac_a2<=avector21[3];
				mac_a3<=avector31[3];
				mac_b<=bvector0[3];
			end
			4'b0100:
			begin
				mac_a0<=avector01[4];
				mac_a1<=avector11[4];
				mac_a2<=avector21[4];
				mac_a3<=avector31[4];
				mac_b<=bvector0[4];
			end
			4'b0101:
			begin
				mac_a0<=avector01[5];
				mac_a1<=avector11[5];
				mac_a2<=avector21[5];
				mac_a3<=avector31[5];
				mac_b<=bvector0[5];
			end
			4'b0110:
			begin
				mac_a0<=avector01[6];
				mac_a1<=avector11[6];
				mac_a2<=avector21[6];
				mac_a3<=avector31[6];
				mac_b<=bvector0[6];
			end
			4'b0111:
			begin
				mac_a0<=avector01[7];
				mac_a1<=avector11[7];
				mac_a2<=avector21[7];
				mac_a3<=avector31[7];
				mac_b<=bvector0[7];
			end
			4'b1000:
			begin
				mac_a0<=avector01[8];
				mac_a1<=avector11[8];
				mac_a2<=avector21[8];
				mac_a3<=avector31[8];
				mac_b<=bvector0[8];
			end
			endcase
		end
		else if(select[1:0]==2'b01)
		begin
			case(bitselect1)
			4'b0000:
			begin
				mac_a0<=avector01[0];
				mac_a1<=avector11[0];
				mac_a2<=avector21[0];
				mac_a3<=avector31[0];
				mac_b<=bvector1[0];
			end
			4'b0001:
			begin
				mac_a0<=avector01[1];
				mac_a1<=avector11[1];
				mac_a2<=avector21[1];
				mac_a3<=avector31[1];
				mac_b<=bvector1[1];
			end
			4'b0010:
			begin
				mac_a0<=avector01[2];
				mac_a1<=avector11[2];
				mac_a2<=avector21[2];
				mac_a3<=avector31[2];
				mac_b<=bvector1[2];
			end
			4'b0011:
			begin
				mac_a0<=avector01[3];
				mac_a1<=avector11[3];
				mac_a2<=avector21[3];
				mac_a3<=avector31[3];
				mac_b<=bvector1[3];
			end
			4'b0100:
			begin
				mac_a0<=avector01[4];
				mac_a1<=avector11[4];
				mac_a2<=avector21[4];
				mac_a3<=avector31[4];
				mac_b<=bvector1[4];
			end
			4'b0101:
			begin
				mac_a0<=avector01[5];
				mac_a1<=avector11[5];
				mac_a2<=avector21[5];
				mac_a3<=avector31[5];
				mac_b<=bvector1[5];
			end
			4'b0110:
			begin
				mac_a0<=avector01[6];
				mac_a1<=avector11[6];
				mac_a2<=avector21[6];
				mac_a3<=avector31[6];
				mac_b<=bvector1[6];
			end
			4'b0111:
			begin
				mac_a0<=avector01[7];
				mac_a1<=avector11[7];
				mac_a2<=avector21[7];
				mac_a3<=avector31[7];
				mac_b<=bvector1[7];
			end
			4'b1000:
			begin
				mac_a0<=avector01[8];
				mac_a1<=avector11[8];
				mac_a2<=avector21[8];
				mac_a3<=avector31[8];
				mac_b<=bvector1[8];
			end
			endcase
		end
		else if(select[1:0]==2'b10)
		begin
			case(bitselect1)
			4'b0000:
			begin
				mac_a0<=avector01[0];
				mac_a1<=avector11[0];
				mac_a2<=avector21[0];
				mac_a3<=avector31[0];
				mac_b<=bvector2[0];
			end
			4'b0001:
			begin
				mac_a0<=avector01[1];
				mac_a1<=avector11[1];
				mac_a2<=avector21[1];
				mac_a3<=avector31[1];
				mac_b<=bvector2[1];
			end
			4'b0010:
			begin
				mac_a0<=avector01[2];
				mac_a1<=avector11[2];
				mac_a2<=avector21[2];
				mac_a3<=avector31[2];
				mac_b<=bvector2[2];
			end
			4'b0011:
			begin
				mac_a0<=avector01[3];
				mac_a1<=avector11[3];
				mac_a2<=avector21[3];
				mac_a3<=avector31[3];
				mac_b<=bvector2[3];
			end
			4'b0100:
			begin
				mac_a0<=avector01[4];
				mac_a1<=avector11[4];
				mac_a2<=avector21[4];
				mac_a3<=avector31[4];
				mac_b<=bvector2[4];
			end
			4'b0101:
			begin
				mac_a0<=avector01[5];
				mac_a1<=avector11[5];
				mac_a2<=avector21[5];
				mac_a3<=avector31[5];
				mac_b<=bvector2[5];
			end
			4'b0110:
			begin
				mac_a0<=avector01[6];
				mac_a1<=avector11[6];
				mac_a2<=avector21[6];
				mac_a3<=avector31[6];
				mac_b<=bvector2[6];
			end
			4'b0111:
			begin
				mac_a0<=avector01[7];
				mac_a1<=avector11[7];
				mac_a2<=avector21[7];
				mac_a3<=avector31[7];
				mac_b<=bvector2[7];
			end
			4'b1000:
			begin
				mac_a0<=avector01[8];
				mac_a1<=avector11[8];
				mac_a2<=avector21[8];
				mac_a3<=avector31[8];
				mac_b<=bvector2[8];
			end
			endcase
		end
		else if(select[1:0]==2'b11)
		begin
			case(bitselect1)
			4'b0000:
			begin
				mac_a0<=avector01[0];
				mac_a1<=avector11[0];
				mac_a2<=avector21[0];
				mac_a3<=avector31[0];
				mac_b<=bvector3[0];
			end
			4'b0001:
			begin
				mac_a0<=avector01[1];
				mac_a1<=avector11[1];
				mac_a2<=avector21[1];
				mac_a3<=avector31[1];
				mac_b<=bvector3[1];
			end
			4'b0010:
			begin
				mac_a0<=avector01[2];
				mac_a1<=avector11[2];
				mac_a2<=avector21[2];
				mac_a3<=avector31[2];
				mac_b<=bvector3[2];
			end
			4'b0011:
			begin
				mac_a0<=avector01[3];
				mac_a1<=avector11[3];
				mac_a2<=avector21[3];
				mac_a3<=avector31[3];
				mac_b<=bvector3[3];
			end
			4'b0100:
			begin
				mac_a0<=avector01[4];
				mac_a1<=avector11[4];
				mac_a2<=avector21[4];
				mac_a3<=avector31[4];
				mac_b<=bvector3[4];
			end
			4'b0101:
			begin
				mac_a0<=avector01[5];
				mac_a1<=avector11[5];
				mac_a2<=avector21[5];
				mac_a3<=avector31[5];
				mac_b<=bvector3[5];
			end
			4'b0110:
			begin
				mac_a0<=avector01[6];
				mac_a1<=avector11[6];
				mac_a2<=avector21[6];
				mac_a3<=avector31[6];
				mac_b<=bvector3[6];
			end
			4'b0111:
			begin
				mac_a0<=avector01[7];
				mac_a1<=avector11[7];
				mac_a2<=avector21[7];
				mac_a3<=avector31[7];
				mac_b<=bvector3[7];
			end
			4'b1000:
			begin
				mac_a0<=avector01[8];
				mac_a1<=avector11[8];
				mac_a2<=avector21[8];
				mac_a3<=avector31[8];
				mac_b<=bvector3[8];
			end
			endcase
		end
	end
	else if(select[3:2]==2'b10)
	begin
		if(select[1:0]==2'b00)
		begin
			case(bitselect1)
			4'b0000:
			begin
				mac_a0<=avector02[0];
				mac_a1<=avector12[0];
				mac_a2<=avector22[0];
				mac_a3<=avector32[0];
				mac_b<=bvector0[0];
			end
			4'b0001:
			begin
				mac_a0<=avector02[1];
				mac_a1<=avector12[1];
				mac_a2<=avector22[1];
				mac_a3<=avector32[1];
				mac_b<=bvector0[1];
			end
			4'b0010:
			begin
				mac_a0<=avector02[2];
				mac_a1<=avector12[2];
				mac_a2<=avector22[2];
				mac_a3<=avector32[2];
				mac_b<=bvector0[2];
			end
			4'b0011:
			begin
				mac_a0<=avector02[3];
				mac_a1<=avector12[3];
				mac_a2<=avector22[3];
				mac_a3<=avector32[3];
				mac_b<=bvector0[3];
			end
			4'b0100:
			begin
				mac_a0<=avector02[4];
				mac_a1<=avector12[4];
				mac_a2<=avector22[4];
				mac_a3<=avector32[4];
				mac_b<=bvector0[4];
			end
			4'b0101:
			begin
				mac_a0<=avector02[5];
				mac_a1<=avector12[5];
				mac_a2<=avector22[5];
				mac_a3<=avector32[5];
				mac_b<=bvector0[5];
			end
			4'b0110:
			begin
				mac_a0<=avector02[6];
				mac_a1<=avector12[6];
				mac_a2<=avector22[6];
				mac_a3<=avector32[6];
				mac_b<=bvector0[6];
			end
			4'b0111:
			begin
				mac_a0<=avector02[7];
				mac_a1<=avector12[7];
				mac_a2<=avector22[7];
				mac_a3<=avector32[7];
				mac_b<=bvector0[7];
			end
			4'b1000:
			begin
				mac_a0<=avector02[8];
				mac_a1<=avector12[8];
				mac_a2<=avector22[8];
				mac_a3<=avector32[8];
				mac_b<=bvector0[8];
			end
			endcase
		end
		else if(select[1:0]==2'b01)
		begin
			case(bitselect1)
			4'b0000:
			begin
				mac_a0<=avector02[0];
				mac_a1<=avector12[0];
				mac_a2<=avector22[0];
				mac_a3<=avector32[0];
				mac_b<=bvector1[0];
			end
			4'b0001:
			begin
				mac_a0<=avector02[1];
				mac_a1<=avector12[1];
				mac_a2<=avector22[1];
				mac_a3<=avector32[1];
				mac_b<=bvector1[1];
			end
			4'b0010:
			begin
				mac_a0<=avector02[2];
				mac_a1<=avector12[2];
				mac_a2<=avector22[2];
				mac_a3<=avector32[2];
				mac_b<=bvector1[2];
			end
			4'b0011:
			begin
				mac_a0<=avector02[3];
				mac_a1<=avector12[3];
				mac_a2<=avector22[3];
				mac_a3<=avector32[3];
				mac_b<=bvector1[3];
			end
			4'b0100:
			begin
				mac_a0<=avector02[4];
				mac_a1<=avector12[4];
				mac_a2<=avector22[4];
				mac_a3<=avector32[4];
				mac_b<=bvector1[4];
			end
			4'b0101:
			begin
				mac_a0<=avector02[5];
				mac_a1<=avector12[5];
				mac_a2<=avector22[5];
				mac_a3<=avector32[5];
				mac_b<=bvector1[5];
			end
			4'b0110:
			begin
				mac_a0<=avector02[6];
				mac_a1<=avector12[6];
				mac_a2<=avector22[6];
				mac_a3<=avector32[6];
				mac_b<=bvector1[6];
			end
			4'b0111:
			begin
				mac_a0<=avector02[7];
				mac_a1<=avector12[7];
				mac_a2<=avector22[7];
				mac_a3<=avector32[7];
				mac_b<=bvector1[7];
			end
			4'b1000:
			begin
				mac_a0<=avector02[8];
				mac_a1<=avector12[8];
				mac_a2<=avector22[8];
				mac_a3<=avector32[8];
				mac_b<=bvector1[8];
			end
			endcase
		end
		else if(select[1:0]==2'b10)
		begin
			case(bitselect1)
			4'b0000:
			begin
				mac_a0<=avector02[0];
				mac_a1<=avector12[0];
				mac_a2<=avector22[0];
				mac_a3<=avector32[0];
				mac_b<=bvector2[0];
			end
			4'b0001:
			begin
				mac_a0<=avector02[1];
				mac_a1<=avector12[1];
				mac_a2<=avector22[1];
				mac_a3<=avector32[1];
				mac_b<=bvector2[1];
			end
			4'b0010:
			begin
				mac_a0<=avector02[2];
				mac_a1<=avector12[2];
				mac_a2<=avector22[2];
				mac_a3<=avector32[2];
				mac_b<=bvector2[2];
			end
			4'b0011:
			begin
				mac_a0<=avector02[3];
				mac_a1<=avector12[3];
				mac_a2<=avector22[3];
				mac_a3<=avector32[3];
				mac_b<=bvector2[3];
			end
			4'b0100:
			begin
				mac_a0<=avector02[4];
				mac_a1<=avector12[4];
				mac_a2<=avector22[4];
				mac_a3<=avector32[4];
				mac_b<=bvector2[4];
			end
			4'b0101:
			begin
				mac_a0<=avector02[5];
				mac_a1<=avector12[5];
				mac_a2<=avector22[5];
				mac_a3<=avector32[5];
				mac_b<=bvector2[5];
			end
			4'b0110:
			begin
				mac_a0<=avector02[6];
				mac_a1<=avector12[6];
				mac_a2<=avector22[6];
				mac_a3<=avector32[6];
				mac_b<=bvector2[6];
			end
			4'b0111:
			begin
				mac_a0<=avector02[7];
				mac_a1<=avector12[7];
				mac_a2<=avector22[7];
				mac_a3<=avector32[7];
				mac_b<=bvector2[7];
			end
			4'b1000:
			begin
				mac_a0<=avector02[8];
				mac_a1<=avector12[8];
				mac_a2<=avector22[8];
				mac_a3<=avector32[8];
				mac_b<=bvector2[8];
			end
			endcase
		end
		else if(select[1:0]==2'b11)
		begin
			case(bitselect1)
			4'b0000:
			begin
				mac_a0<=avector02[0];
				mac_a1<=avector12[0];
				mac_a2<=avector22[0];
				mac_a3<=avector32[0];
				mac_b<=bvector3[0];
			end
			4'b0001:
			begin
				mac_a0<=avector02[1];
				mac_a1<=avector12[1];
				mac_a2<=avector22[1];
				mac_a3<=avector32[1];
				mac_b<=bvector3[1];
			end
			4'b0010:
			begin
				mac_a0<=avector02[2];
				mac_a1<=avector12[2];
				mac_a2<=avector22[2];
				mac_a3<=avector32[2];
				mac_b<=bvector3[2];
			end
			4'b0011:
			begin
				mac_a0<=avector02[3];
				mac_a1<=avector12[3];
				mac_a2<=avector22[3];
				mac_a3<=avector32[3];
				mac_b<=bvector3[3];
			end
			4'b0100:
			begin
				mac_a0<=avector02[4];
				mac_a1<=avector12[4];
				mac_a2<=avector22[4];
				mac_a3<=avector32[4];
				mac_b<=bvector3[4];
			end
			4'b0101:
			begin
				mac_a0<=avector02[5];
				mac_a1<=avector12[5];
				mac_a2<=avector22[5];
				mac_a3<=avector32[5];
				mac_b<=bvector3[5];
			end
			4'b0110:
			begin
				mac_a0<=avector02[6];
				mac_a1<=avector12[6];
				mac_a2<=avector22[6];
				mac_a3<=avector32[6];
				mac_b<=bvector3[6];
			end
			4'b0111:
			begin
				mac_a0<=avector02[7];
				mac_a1<=avector12[7];
				mac_a2<=avector22[7];
				mac_a3<=avector32[7];
				mac_b<=bvector3[7];
			end
			4'b1000:
			begin
				mac_a0<=avector02[8];
				mac_a1<=avector12[8];
				mac_a2<=avector22[8];
				mac_a3<=avector32[8];
				mac_b<=bvector3[8];
			end
			endcase
		end
	end
	else if(select[3:2]==2'b11)
	begin
		if(select[1:0]==2'b00)
		begin
			case(bitselect1)
			4'b0000:
			begin
				mac_a0<=avector03[0];
				mac_a1<=avector13[0];
				mac_a2<=avector23[0];
				mac_a3<=avector33[0];
				mac_b<=bvector0[0];
			end
			4'b0001:
			begin
				mac_a0<=avector03[1];
				mac_a1<=avector13[1];
				mac_a2<=avector23[1];
				mac_a3<=avector33[1];
				mac_b<=bvector0[1];
			end
			4'b0010:
			begin
				mac_a0<=avector03[2];
				mac_a1<=avector13[2];
				mac_a2<=avector23[2];
				mac_a3<=avector33[2];
				mac_b<=bvector0[2];
			end
			4'b0011:
			begin
				mac_a0<=avector03[3];
				mac_a1<=avector13[3];
				mac_a2<=avector23[3];
				mac_a3<=avector33[3];
				mac_b<=bvector0[3];
			end
			4'b0100:
			begin
				mac_a0<=avector03[4];
				mac_a1<=avector13[4];
				mac_a2<=avector23[4];
				mac_a3<=avector33[4];
				mac_b<=bvector0[4];
			end
			4'b0101:
			begin
				mac_a0<=avector03[5];
				mac_a1<=avector13[5];
				mac_a2<=avector23[5];
				mac_a3<=avector33[5];
				mac_b<=bvector0[5];
			end
			4'b0110:
			begin
				mac_a0<=avector03[6];
				mac_a1<=avector13[6];
				mac_a2<=avector23[6];
				mac_a3<=avector33[6];
				mac_b<=bvector0[6];
			end
			4'b0111:
			begin
				mac_a0<=avector03[7];
				mac_a1<=avector13[7];
				mac_a2<=avector23[7];
				mac_a3<=avector33[7];
				mac_b<=bvector0[7];
			end
			4'b1000:
			begin
				mac_a0<=avector03[8];
				mac_a1<=avector13[8];
				mac_a2<=avector23[8];
				mac_a3<=avector33[8];
				mac_b<=bvector0[8];
			end
			endcase
		end
		else if(select[1:0]==2'b01)
		begin
			case(bitselect1)
			4'b0000:
			begin
				mac_a0<=avector03[0];
				mac_a1<=avector13[0];
				mac_a2<=avector23[0];
				mac_a3<=avector33[0];
				mac_b<=bvector1[0];
			end
			4'b0001:
			begin
				mac_a0<=avector03[1];
				mac_a1<=avector13[1];
				mac_a2<=avector23[1];
				mac_a3<=avector33[1];
				mac_b<=bvector1[1];
			end
			4'b0010:
			begin
				mac_a0<=avector03[2];
				mac_a1<=avector13[2];
				mac_a2<=avector23[2];
				mac_a3<=avector33[2];
				mac_b<=bvector1[2];
			end
			4'b0011:
			begin
				mac_a0<=avector03[3];
				mac_a1<=avector13[3];
				mac_a2<=avector23[3];
				mac_a3<=avector33[3];
				mac_b<=bvector1[3];
			end
			4'b0100:
			begin
				mac_a0<=avector03[4];
				mac_a1<=avector13[4];
				mac_a2<=avector23[4];
				mac_a3<=avector33[4];
				mac_b<=bvector1[4];
			end
			4'b0101:
			begin
				mac_a0<=avector03[5];
				mac_a1<=avector13[5];
				mac_a2<=avector23[5];
				mac_a3<=avector33[5];
				mac_b<=bvector1[5];
			end
			4'b0110:
			begin
				mac_a0<=avector03[6];
				mac_a1<=avector13[6];
				mac_a2<=avector23[6];
				mac_a3<=avector33[6];
				mac_b<=bvector1[6];
			end
			4'b0111:
			begin
				mac_a0<=avector03[7];
				mac_a1<=avector13[7];
				mac_a2<=avector23[7];
				mac_a3<=avector33[7];
				mac_b<=bvector1[7];
			end
			4'b1000:
			begin
				mac_a0<=avector03[8];
				mac_a1<=avector13[8];
				mac_a2<=avector23[8];
				mac_a3<=avector33[8];
				mac_b<=bvector1[8];
			end
			endcase
		end
		else if(select[1:0]==2'b10)
		begin
			case(bitselect1)
			4'b0000:
			begin
				mac_a0<=avector03[0];
				mac_a1<=avector13[0];
				mac_a2<=avector23[0];
				mac_a3<=avector33[0];
				mac_b<=bvector2[0];
			end
			4'b0001:
			begin
				mac_a0<=avector03[1];
				mac_a1<=avector13[1];
				mac_a2<=avector23[1];
				mac_a3<=avector33[1];
				mac_b<=bvector2[1];
			end
			4'b0010:
			begin
				mac_a0<=avector03[2];
				mac_a1<=avector13[2];
				mac_a2<=avector23[2];
				mac_a3<=avector33[2];
				mac_b<=bvector2[2];
			end
			4'b0011:
			begin
				mac_a0<=avector03[3];
				mac_a1<=avector13[3];
				mac_a2<=avector23[3];
				mac_a3<=avector33[3];
				mac_b<=bvector2[3];
			end
			4'b0100:
			begin
				mac_a0<=avector03[4];
				mac_a1<=avector13[4];
				mac_a2<=avector23[4];
				mac_a3<=avector33[4];
				mac_b<=bvector2[4];
			end
			4'b0101:
			begin
				mac_a0<=avector03[5];
				mac_a1<=avector13[5];
				mac_a2<=avector23[5];
				mac_a3<=avector33[5];
				mac_b<=bvector2[5];
			end
			4'b0110:
			begin
				mac_a0<=avector03[6];
				mac_a1<=avector13[6];
				mac_a2<=avector23[6];
				mac_a3<=avector33[6];
				mac_b<=bvector2[6];
			end
			4'b0111:
			begin
				mac_a0<=avector03[7];
				mac_a1<=avector13[7];
				mac_a2<=avector23[7];
				mac_a3<=avector33[7];
				mac_b<=bvector2[7];
			end
			4'b1000:
			begin
				mac_a0<=avector03[8];
				mac_a1<=avector13[8];
				mac_a2<=avector23[8];
				mac_a3<=avector33[8];
				mac_b<=bvector2[8];
			end
			endcase
		end
		else if(select[1:0]==2'b11)
		begin
			case(bitselect1)
			4'b0000:
			begin
				mac_a0<=avector03[0];
				mac_a1<=avector13[0];
				mac_a2<=avector23[0];
				mac_a3<=avector33[0];
				mac_b<=bvector3[0];
			end
			4'b0001:
			begin
				mac_a0<=avector03[1];
				mac_a1<=avector13[1];
				mac_a2<=avector23[1];
				mac_a3<=avector33[1];
				mac_b<=bvector3[1];
			end
			4'b0010:
			begin
				mac_a0<=avector03[2];
				mac_a1<=avector13[2];
				mac_a2<=avector23[2];
				mac_a3<=avector33[2];
				mac_b<=bvector3[2];
			end
			4'b0011:
			begin
				mac_a0<=avector03[3];
				mac_a1<=avector13[3];
				mac_a2<=avector23[3];
				mac_a3<=avector33[3];
				mac_b<=bvector3[3];
			end
			4'b0100:
			begin
				mac_a0<=avector03[4];
				mac_a1<=avector13[4];
				mac_a2<=avector23[4];
				mac_a3<=avector33[4];
				mac_b<=bvector3[4];
			end
			4'b0101:
			begin
				mac_a0<=avector03[5];
				mac_a1<=avector13[5];
				mac_a2<=avector23[5];
				mac_a3<=avector33[5];
				mac_b<=bvector3[5];
			end
			4'b0110:
			begin
				mac_a0<=avector03[6];
				mac_a1<=avector13[6];
				mac_a2<=avector23[6];
				mac_a3<=avector33[6];
				mac_b<=bvector3[6];
			end
			4'b0111:
			begin
				mac_a0<=avector03[7];
				mac_a1<=avector13[7];
				mac_a2<=avector23[7];
				mac_a3<=avector33[7];
				mac_b<=bvector3[7];
			end
			4'b1000:
			begin
				mac_a0<=avector03[8];
				mac_a1<=avector13[8];
				mac_a2<=avector23[8];
				mac_a3<=avector33[8];
				mac_b<=bvector3[8];
				//flag_mac <= 1;
			end
			endcase
		end
	end
  end
  end
  
  // storing z values
  always@(posedge clk)
  begin
  if(startdesign==1 && flag_a==1 && z_start==1 && flag_z==0)
  begin
	case(zcount)
	4'b0000:
	begin
		z[0] <= mac_out0;
		z[2] <= mac_out1;
		z[8] <= mac_out2;
		z[10] <= mac_out3;
	end
	4'b0001:
	begin
		z[16] <= mac_out0;
		z[18] <= mac_out1;
		z[24] <= mac_out2;
		z[26] <= mac_out3;
	end
	4'b0010:
	begin
		z[32] <= mac_out0;
		z[34] <= mac_out1;
		z[40] <= mac_out2;
		z[42] <= mac_out3;
	end
	4'b0011:
	begin
		z[48] <= mac_out0;
		z[50] <= mac_out1;
		z[56] <= mac_out2;
		z[58] <= mac_out3;
	end
	4'b0100:
	begin
		z[1] <= mac_out0;
		z[3] <= mac_out1;
		z[9] <= mac_out2;
		z[11] <= mac_out3;
	end
	4'b0101:
	begin
		z[17] <= mac_out0;
		z[19] <= mac_out1;
		z[25] <= mac_out2;
		z[27] <= mac_out3;
	end
	4'b0110:
	begin
		z[33] <= mac_out0;
		z[35] <= mac_out1;
		z[41] <= mac_out2;
		z[43] <= mac_out3;
	end
	4'b0111:
	begin
		z[49] <= mac_out0;
		z[51] <= mac_out1;
		z[57] <= mac_out2;
		z[59] <= mac_out3;
	end
	4'b1000:
	begin
		z[4] <= mac_out0;
		z[6] <= mac_out1;
		z[12] <= mac_out2;
		z[14] <= mac_out3;
	end
	4'b1001:
	begin
		z[20] <= mac_out0;
		z[22] <= mac_out1;
		z[28] <= mac_out2;
		z[30] <= mac_out3;
	end
	4'b1010:
	begin
		z[36] <= mac_out0;
		z[38] <= mac_out1;
		z[44] <= mac_out2;
		z[46] <= mac_out3;
	end
	4'b1011:
	begin
		z[52] <= mac_out0;
		z[54] <= mac_out1;
		z[60] <= mac_out2;
		z[62] <= mac_out3;
	end
	4'b1100:
	begin
		z[5] <= mac_out0;
		z[7] <= mac_out1;
		z[13] <= mac_out2;
		z[15] <= mac_out3;
	end
	4'b1101:
	begin
		z[21] <= mac_out0;
		z[23] <= mac_out1;
		z[29] <= mac_out2;
		z[31] <= mac_out3;
	end
	4'b1110:
	begin
		z[37] <= mac_out0;
		z[39] <= mac_out1;
		z[45] <= mac_out2;
		z[47] <= mac_out3;
	end
	4'b1111:
	begin
		z[53] <= mac_out0;
		z[55] <= mac_out1;
		z[61] <= mac_out2;
		z[63] <= mac_out3;
		// flag_z <= 1;
	end
	endcase
	if(zcount==4'b1111 && bitselect2==4'b1000)
	begin
		flag_z <= 1;
	end
	
  end
	//*************
	if(reset||count_store==4'b1111)
	begin
		flag_z <= 0;
	end
  end
  
  
  
  //sending z to mac for final calculation
  always@(posedge clk)
  begin
	if(startdesign==1 && flag_z==1 && flag_zsynch==1)
	begin
		case(sendz_count)
			6'b000000:
			begin
				mac_z <= z[0];
			end
			6'b000001:
			begin
				mac_z <= z[1];
			end
			6'b000010:
			begin
				mac_z <= z[2];
			end
			6'b000011:
			begin
				mac_z <= z[3];
			end
			6'b000100:
			begin
				mac_z <= z[4];
			end
			6'b000101:
			begin
				mac_z <= z[5];
			end
			6'b000110:
			begin
				mac_z <= z[6];
			end
			6'b000111:
			begin
				mac_z <= z[7];
			end
			6'b001000:
			begin
				mac_z <= z[8];
			end
			6'b001001:
			begin
				mac_z <= z[9];
			end
			6'b001010:
			begin
				mac_z <= z[10];
			end
			6'b001011:
			begin
				mac_z <= z[11];
			end
			6'b001100:
			begin
				mac_z <= z[12];
			end
			6'b001101:
			begin
				mac_z <= z[13];
			end
			6'b001110:
			begin
				mac_z <= z[14];
			end
			6'b001111:
			begin
				mac_z <= z[15];
			end
			6'b010000:
			begin
				mac_z <= z[16];
			end
			6'b010001:
			begin
				mac_z <= z[17];
			end
			6'b010010:
			begin
				mac_z <= z[18];
			end
			6'b010011:
			begin
				mac_z <= z[19];
			end
			6'b010100:
			begin
				mac_z <= z[20];
			end
			6'b010101:
			begin
				mac_z <= z[21];
			end
			6'b010110:
			begin
				mac_z <= z[22];
			end
			6'b010111:
			begin
				mac_z <= z[23];
			end
			6'b011000:
			begin
				mac_z <= z[24];
			end
			6'b011001:
			begin
				mac_z <= z[25];
			end
			6'b011010:
			begin
				mac_z <= z[26];
			end
			6'b011011:
			begin
				mac_z <= z[27];
			end
			6'b011100:
			begin
				mac_z <= z[28];
			end
			6'b011101:
			begin
				mac_z <= z[29];
			end
			6'b011110:
			begin
				mac_z <= z[30];
			end
			6'b011111:
			begin
				mac_z <= z[31];
			end
			6'b100000:
			begin
				mac_z <= z[32];
			end
			6'b100001:
			begin
				mac_z <= z[33];
			end
			6'b100010:
			begin
				mac_z <= z[34];
			end
			6'b100011:
			begin
				mac_z <= z[35];
			end
			6'b100100:
			begin
				mac_z <= z[36];
			end
			6'b100101:
			begin
				mac_z <= z[37];
			end
			6'b100110:
			begin
				mac_z <= z[38];
			end
			6'b100111:
			begin
				mac_z <= z[39];
			end
			6'b101000:
			begin
				mac_z <= z[40];
			end
			6'b101001:
			begin
				mac_z <= z[41];
			end
			6'b101010:
			begin
				mac_z <= z[42];
			end
			6'b101011:
			begin
				mac_z <= z[43];
			end
			6'b101100:
			begin
				mac_z <= z[44];
			end
			6'b101101:
			begin
				mac_z <= z[45];
			end
			6'b101110:
			begin
				mac_z <= z[46];
			end
			6'b101111:
			begin
				mac_z <= z[47];
			end
			6'b110000:
			begin
				mac_z <= z[48];
			end
			6'b110001:begin
				mac_z <= z[49];
			end
			6'b110010:
			begin
				mac_z <= z[50];
			end
			6'b110011:
			begin
				mac_z <= z[51];
			end
			6'b110100:
			begin
				mac_z <= z[52];
			end
			6'b110101:
			begin
				mac_z <= z[53];
			end
			6'b110110:
			begin
				mac_z <= z[54];
			end
			6'b110111:
			begin
				mac_z <= z[55];
			end
			6'b111000:
			begin
				mac_z <= z[56];
			end
			6'b111001:
			begin
				mac_z <= z[57];
			end
			6'b111010:
			begin
				mac_z <= z[58];
			end
			6'b111011:
			begin
				mac_z <= z[59];
			end
			6'b111100:
			begin
				mac_z <= z[60];
			end
			6'b111101:
			begin
				mac_z <= z[61];
			end
			6'b111110:
			begin
				mac_z <= z[62];
			end
			6'b111111:
			begin
				mac_z <= z[63];
			end
		endcase
	end
  end
  
  // storing final output into register and tranfering it to memory
  always@(posedge clk)
  begin
	if(startdesign==1 && flag_z==1)
	begin
		if(sendz_count==6'b111111)
		begin
			case(count_out)
				3'b000:
				begin
				output_store[0] <= final_output;
				end
				3'b001:
				begin
				output_store[1] <= final_output;
				end
				3'b010:
				begin
				output_store[2] <= final_output;
				end
				3'b011:
				begin
				output_store[3] <= final_output;
				end
				3'b100:
				begin
				output_store[4] <= final_output;
				end
				3'b101:
				begin
				output_store[5] <= final_output;
				end
				3'b110:
				begin
				output_store[6] <= final_output;
				end
				3'b111:
				begin
				output_store[7] <= final_output;
				end
			endcase
		end
		if(sendz_count==6'b111111 && count_out==3'b111)
		begin
			flag_out<=1;
		end
		if(flag_out==1 && count_store < 4'b1000)
		begin
			dut__dom__enable<=1;
			dut__dom__write<=1;
			case(count_store)
			4'b0000:
			begin
				dut__dom__address<=count_store[2:0];
				dut__dom__data<=output_store[0];
			end
			4'b0001:
			begin
				dut__dom__address<=count_store[2:0];
				dut__dom__data<=output_store[1];
			end
			4'b0010:
			begin
				dut__dom__address<=count_store[2:0];
				dut__dom__data<=output_store[2];
			end
			4'b0011:
			begin
				dut__dom__address<=count_store[2:0];
				dut__dom__data<=output_store[3];
			end
			4'b0100:
			begin
				dut__dom__address<=count_store[2:0];
				dut__dom__data<=output_store[4];
			end
			4'b0101:
			begin
				dut__dom__address<=count_store[2:0];
				dut__dom__data<=output_store[5];
			end
			4'b0110:
			begin
				dut__dom__address<=count_store[2:0];
				dut__dom__data<=output_store[6];
			end
			4'b0111:
			begin
				dut__dom__address<=count_store[2:0];
				dut__dom__data<=output_store[7];
			end
			endcase
		end
		if(count_store==4'b1000)
		begin
			dut__dom__enable<=0;
			dut__dom__write<=0;
		end
		
	end
	//*************
	if(reset||count_store==4'b1111)
	begin
		flag_out <= 0;
	end
  end
  
  macopertion W(.in_a_mac(mac_a0), .in_b_mac(mac_b), .bitselect1(bitselect1), .clk(clk), .min(mac_out0));
  macopertion X(.in_a_mac(mac_a1), .in_b_mac(mac_b), .bitselect1(bitselect1), .clk(clk), .min(mac_out1));
  macopertion Y(.in_a_mac(mac_a2), .in_b_mac(mac_b), .bitselect1(bitselect1), .clk(clk), .min(mac_out2));
  macopertion Z(.in_a_mac(mac_a3), .in_b_mac(mac_b), .bitselect1(bitselect1), .clk(clk), .min(mac_out3));
  macopertion_m Z1(.in_z_mac(mac_z), .in_m_mac(m), .sendz_count(sendz_count), .clk(clk), .minm(final_output));
endmodule

module macopertion(
	input [15:0] in_a_mac,
	input [15:0] in_b_mac,
	input [3:0] bitselect1,
	input clk,
	output reg [15:0] min
);
	parameter A_width = 16;
	parameter B_width = 16;
	reg [31:0] out_mac;
	reg [31:0] in_c_mac;
	DW02_mac #(A_width, B_width) U1 ( .A(in_a_mac), .B(in_b_mac), .C(in_c_mac), .TC(1'b1), .MAC(out_mac) );
	always@(posedge clk)
	begin
	case(bitselect1 == 4'b0000)
	0:
	begin
		in_c_mac <= out_mac;
	end
	1:
	begin
		in_c_mac <= 32'b00000000000000000000000000000000;
	end
	endcase
	case(out_mac[31]==1'b1)
	0:
	begin
		min <= out_mac[31:16];
	end
	1:
	begin
		min <= 16'b0000000000000000;
	end
	endcase
	end
endmodule

module macopertion_m(
	input [15:0] in_z_mac,
	input [15:0] in_m_mac,
	input [5:0] sendz_count,
	input clk,
	output reg [15:0] minm
);
	parameter A_width = 16;
	parameter B_width = 16;
	reg [31:0] outm_mac;
	reg [31:0] in_cm_mac;
	DW02_mac #(A_width, B_width) U1 ( .A(in_z_mac), .B(in_m_mac), .C(in_cm_mac), .TC(1'b1), .MAC(outm_mac) );
	always@(posedge clk)
	begin
	case(sendz_count == 6'b000000)
	0:
	begin
		in_cm_mac <= outm_mac;
	end
	1:
	begin
		in_cm_mac <= 32'b00000000000000000000000000000000;
	end
	endcase
	case(outm_mac[31]==1'b1)
	0:
	begin
		minm <= outm_mac[31:16];
	end
	1:
	begin
		minm <= 16'b0000000000000000;
	end
	endcase
	end
endmodule