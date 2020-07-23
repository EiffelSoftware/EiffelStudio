#ifndef C2EIFFEL_H
#define C2EIFFEL_H
#include <stdio.h>

struct person {    
   int id;    
   char* name;
};    

 // return an array of random values with count elements.
int* getIntArray(int count );



 // return an array of double values with count elements.
double* getDoubleArray(int* count );


 // return an array of persons values with count elements.
struct person* getPersonsArray(int* count );

#endif

// Implementation

#ifdef C2EIFFEL_IMPL
int* getIntArray(int count ){
 	int * r = malloc(sizeof(int) * count); 
 	int i;
 	/* set the seed */	
 	srand( (unsigned)time( NULL ) );
				
	for ( i = 0; i < count; ++i) {
		r[i] = rand();
		//printf( "r[%d] = %d\n", i, r[i]);
	}
  	return r;
}


double* getDoubleArray(int* count ){
 	* count = 10;
 	double * r = malloc(sizeof(double) * (*count)); 
 	double arr[]={1000.0, 2.0, 3.4, 7.0, 50.0, 7.12, 1212.2, 12.56, 19.12, 10.0};  
 	for (int i = 0; i < 10; i++){
 		r[i]=arr[i];
 	}
 	return r;
}


struct person* getPersonsArray(int* count ){
 	* count = 3;
 	struct person * sp = malloc(sizeof(struct person) * (*count)); 
 	
 	struct person p = {1, "Peter"};
 	sp[0] =p;
 	struct person p2 = {2, "Jose"};
 	sp[1] =p2;
 	struct person p3 = {3, "Sofia"};
 	sp[2] =p3;
 	return sp;
}
#endif





