// Straightfoward implementation of the Coeff Token table.
module CoeffTokenTable(
                       input logic Clk,
                       input logic nReset,
                       input logic signed [5:0] nC,
                       input logic [15:0] BitStreamShifted,
                       output logic [5:0] TotalCoeff,
                       output logic [5:0] TrailingOnes
                       );

always_ff @(posedge Clk or negedge nReset) begin
  if (!nReset) begin
    {TrailingOnes,TotalCoeff} <= {'0,'0};
  end
  else begin
    
    if(BitStreamShifted[15]=='b1)                  
    else if(BitStreamShifted[15:10]=='b0001_01)            
    else if(BitStreamShifted[15:14]=='b01)                 
    else if(BitStreamShifted[]=='b0000_0111)          
    else if(BitStreamShifted[]=='b0001_00)            
    else if(BitStreamShifted[]=='b001)                
    else if(BitStreamShifted[]=='b0000_0011_1)        
    else if(BitStreamShifted[]=='b0000_0110)          
    else if(BitStreamShifted[]=='b0000_101)           
    else if(BitStreamShifted[]=='b0001_1)             
    else if(BitStreamShifted[]=='b0000_0001_11)       
    else if(BitStreamShifted[]=='b0000_0011_0)        
    else if(BitStreamShifted[]=='b0000_0101)          
    else if(BitStreamShifted[]=='b0000_11)            
    else if(BitStreamShifted[]=='b0000_0000_111)      
    else if(BitStreamShifted[]=='b0000_0001_10)       
    else if(BitStreamShifted[]=='b0000_0010_1)        
    else if(BitStreamShifted[]=='b0000_100)           
    else if(BitStreamShifted[]=='b0000_0000_0111_1)   
    else if(BitStreamShifted[]=='b0000_0000_110)      
    else if(BitStreamShifted[]=='b0000_0001_01)       
    else if(BitStreamShifted[]=='b0000_0100)          
    else if(BitStreamShifted[]=='b0000_0000_0101_1)   
    else if(BitStreamShifted[]=='b0000_0000_0111_0)   
    else if(BitStreamShifted[]=='b0000_0000_101)      
    else if(BitStreamShifted[]=='b0000_0010_0)        
    else if(BitStreamShifted[]=='b0000_0000_0100_0)   
    else if(BitStreamShifted[]=='b0000_0000_0101_0)   
    else if(BitStreamShifted[]=='b0000_0000_0110_1)   
    else if(BitStreamShifted[]=='b0000_0001_00)       
    else if(BitStreamShifted[]=='b0000_0000_0011_11)  
    else if(BitStreamShifted[]=='b0000_0000_0011_10)  
    else if(BitStreamShifted[]=='b0000_0000_0100_1)   
    else if(BitStreamShifted[]=='b0000_0000_100)      
    else if(BitStreamShifted[]=='b0000_0000_0010_11)  
    else if(BitStreamShifted[]=='b0000_0000_0010_10)  
    else if(BitStreamShifted[]=='b0000_0000_0011_01)  
    else if(BitStreamShifted[]=='b0000_0000_0110_0)   
    else if(BitStreamShifted[]=='b0000_0000_0001_111) 
    else if(BitStreamShifted[]=='b0000_0000_0001_110) 
    else if(BitStreamShifted[]=='b0000_0000_0010_01)  
    else if(BitStreamShifted[]=='b0000_0000_0011_00)  
    else if(BitStreamShifted[]=='b0000_0000_0001_011) 
    else if(BitStreamShifted[]=='b0000_0000_0001_010) 
    else if(BitStreamShifted[]=='b0000_0000_0001_101) 
    else if(BitStreamShifted[]=='b0000_0000_0010_00)  
    else if(BitStreamShifted[]=='b0000_0000_0000_1111)
    else if(BitStreamShifted[]=='b0000_0000_0000_001) 
    else if(BitStreamShifted[]=='b0000_0000_0001_001) 
    else if(BitStreamShifted[]=='b0000_0000_0001_100) 
    else if(BitStreamShifted[]=='b0000_0000_0000_1011)
    else if(BitStreamShifted[]=='b0000_0000_0000_1110)
    else if(BitStreamShifted[]=='b0000_0000_0000_1101)
    else if(BitStreamShifted[]=='b0000_0000_0001_000) 
    else if(BitStreamShifted[]=='b0000_0000_0000_0111)
    else if(BitStreamShifted[]=='b0000_0000_0000_1010)
    else if(BitStreamShifted[]=='b0000_0000_0000_1001)
    else if(BitStreamShifted[]=='b0000_0000_0000_1100)
    else if(BitStreamShifted[]=='b0000_0000_0000_0100)
    else if(BitStreamShifted[]=='b0000_0000_0000_0110)
    else if(BitStreamShifted[]=='b0000_0000_0000_0101)
    else if(BitStreamShifted[]=='b0000_0000_0000_1000)













  end
end



endmodule
