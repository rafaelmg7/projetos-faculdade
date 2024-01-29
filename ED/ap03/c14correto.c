#include <stdio.h>

int main(void) {
  int n = 0, i = 0, fact = 1;

  printf("Positive integer:");
  scanf("%d", &n);
  
  for(i = 1; i<=n; i++) 
    fact = fact*i;

  printf("Factorial %d = %d\n", n, fact);

  return 0;
}
