
#include <stdio.h>



double my_sin(double x){
    double rad = (x*3.142)/180;
    double answer = 0;
    for(int i =0; i<11; i++){
        double temp = 1;
        double fact = 1;
        if (i%2 != 0){
            temp *=-1;
        }
        for (int k =1; k<=2*i+1;k++){
            temp*= rad;
        }
        
        for(int f =1; f<=2*i+1 ; f++){
            fact *=f;
        }
        
        temp = temp/fact;
        answer+=temp;
    }
    return answer;
    
}





int main()
{
    double s = my_sin(30);
    printf("%f" , s);

    return 0;
}
