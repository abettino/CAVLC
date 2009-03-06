#include "stdio.h"
#include "string.h"


void print_bin(int x, int size);

int main () {
  FILE* file;
  FILE* total_coeffs;
  FILE* t1s;
  char bitstring[16];
  int total_coeffs_array[100];
  int t1_array[100];
  int tmp;
  int length;
  int max_value;
  int i;
  int j;
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

  printf("module ROM (input [15:0] Address, output reg [4:0] TotalCoeff, output reg [1:0] TrailingOnes);\n");
  printf("case (Address)\n");
  while (!feof(file)) {
    if (fscanf(file,"%s",bitstring)>0) {
      length = strlen(bitstring);
      max_value = 1 << (16-length); // 2^(16-length)
      if (length != 16) {
	for(i=0;i<max_value;i++) {
	  printf("16'b");
	  printf("%s",bitstring);
	  print_bin(i,16-length);
	  printf(": begin\n");
	  printf("  TotalCoeff = 5'd%d;\n",total_coeffs_array[j]);
	  printf("  TrailingOnes = 2'd%d;\n",t1_array[j]);
	  printf("end\n");
	}
      }
      else if (length != 0) {
	printf("16'b");
	printf("%s",bitstring);
	printf(": begin\n");
	printf("  TotalCoeff = 5'd%d;\n",total_coeffs_array[j]);
	printf("  TrailingOnes = 2'd%d;\n",t1_array[j]);
	printf("end\n");
      }

      j++;

    }
  }

  printf("default : begin\n  TotalCoeff=5'd31;\n  TrailingOnes=2'd0;\nend\n");

  printf("endcase\nendmodule\n");
  return 0;
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
