#include "stdio.h"
#include "string.h"


void print_bin(int x, int size);

int main () {
  FILE* file;
  FILE* total_coeffs;
  FILE* t1s;
  char bitstring[16];
  char substring[16];
  int total_coeffs_array[100];
  int t1_array[100];
  int tmp;
  int length;
  int max_value;
  int i;
  int j;
  int num_1s;
  int num_lead_0s;
  //  if(!(file = fopen("coeff_token_neg_1_nospace.dat","r"))) {
    if(!(file = fopen("coeff_token_0_2_nospace.dat","r"))) {
    printf("error file\n");
    return -1;
  }

  if(!(total_coeffs = fopen("total_coeffs.dat","r"))) {
    printf("error file 2\n");
    return -1;
  }

  if(!(t1s = fopen("t1s.dat","r"))) {
    printf("error file 3\n");
    return -1;
  }

  i=0;
  while (!feof(total_coeffs)) {
    fscanf(total_coeffs,"%d",&tmp);
    total_coeffs_array[i] = tmp;
    i++;
  }

  i=0;
  while (!feof(t1s)) {
    fscanf(t1s,"%d",&tmp);
    t1_array[i] = tmp;
    i++;
  }
  
  j=0;
#if 1
  printf("module ROM (input [6:0] Address, output reg [4:0] TotalCoeff, output reg [1:0] TrailingOnes, output reg [4:0] NumShift, output reg Match);\n");
  printf("always @* begin\n");
#endif
  //  printf("case (Address)\n");
  while (!feof(file)) {
    if (fscanf(file,"%s",bitstring)>0) {
      length = strlen(bitstring);
      max_value = 1 << (16-length); // 2^(16-length)

      //      if (length==7)            printf("%d\t%s\n",length,bitstring);
      num_1s=0;
      num_lead_0s=0;
      substring[0]='\0';

      for(i=0;i<length;i++) if (bitstring[i]=='1') num_1s++;
      for(i=0;i<length;i++) {
	if (bitstring[i]=='1') break;
	else num_lead_0s++;
      }
      for(i=num_lead_0s;i<length;i++) substring[i-num_lead_0s]=bitstring[i];
      substring[length-num_lead_0s] = NULL;

      //      printf("%02d\t%d\t%d\t%d\t%s\t%s\n",num_lead_0s,length-num_lead_0s,total_coeffs_array[j],t1_array[j],substring,bitstring);

      if (num_lead_0s > 11 ) {
	for(i=12;i<length;i++) substring[i-12]=bitstring[i];
	substring[length-12] = NULL;

	if (j==0)	printf("if (Address[3:%d]==%d'b%s) begin\n", 4-(length-12),length-12,substring);
	else	printf("else if (Address[3:%d]==%d'b%s) begin\n", 4-(length-12),length-12,substring);


	printf("  TotalCoeff = 5'd%d;\n",total_coeffs_array[j]);
	printf("  TrailingOnes = 2'd%d;\n",t1_array[j]);
	printf("  NumShift = 5'd%d;\n",length);
	printf("  Match = 1'b1;\nend\n",length);
      }

      
      if (length==1) {
	//	printf("4'b%s : begin\n",bitstring);
	//	printf("  TotalCoeff = 5'd%d;\n",total_coeffs_array[j]);
	//	printf("  TrailingOnes = 2'd%d;\n",t1_array[j]);
	//	printf("  NumShift = 5'd%d;\nend\n",length);

      }

      for(i=0;i<length;i++) {
	if (bitstring[i] == '1') {
	  //
	}
      }

#if 0
      if (j==0) {
	printf("if (Address[15:%d]==%d'b%s) begin\n", 16-length,length,bitstring);
      } else {
	printf("else if (Address[15:%d]==%d'b%s) begin\n", 16-length,length,bitstring);
      }

      printf("  TotalCoeff = 5'd%d;\n",total_coeffs_array[j]);
      printf("  TrailingOnes = 2'd%d;\n",t1_array[j]);
      printf("  NumShift = 5'd%d;\n",length);
      printf("end\n");
#endif
/*      if (length != 16) {
	for(i=0;i<max_value;i++) {
	  printf("16'b");
	  printf("%s",bitstring);
	  print_bin(i,16-length);
	  printf(": begin\n");
	  printf("  TotalCoeff = 5'd%d;\n",total_coeffs_array[j]);
	  printf("  TrailingOnes = 2'd%d;\n",t1_array[j]);
	  printf("  NumShift = 5'd%d;\n",length);
	  printf("end\n");
	}
      }
      else if (length != 0) {
	printf("16'b");
	printf("%s",bitstring);
	printf(": begin\n");
	printf("  TotalCoeff = 5'd%d;\n",total_coeffs_array[j]);
	printf("  TrailingOnes = 2'd%d;\n",t1_array[j]);
	printf("  NumShift = 5'd%d;\n",length);
	printf("end\n");
      }
*/
      j++;

    }
  }

  //  printf("default : begin\n  TotalCoeff=5'd31;\n  TrailingOnes=2'd0;\n  NumShift=5'd0;\n\nend\n");
#if 1
   printf("else begin\n  TotalCoeff=5'd31;\n  TrailingOnes=2'd0;\n  NumShift=5'd0;\n  Match=1'b0;\nend\n");

 //  printf("endcase\nend\nendmodule\n");
  printf("end\nendmodule\n");
  return 0;
#endif
}
	  
// print a binary number up to 16 bits.
void print_bin (int x,int size) {
  int i;
  int mask = 0x8000;
  
  // initial shift
  mask = mask >> (16-size);

  for(i=0;i<size;i++) {
    if (mask & x) printf("1");
    else printf("0");
    mask = mask >> 1;
  }
}
