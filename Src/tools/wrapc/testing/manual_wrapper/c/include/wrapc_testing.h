#ifndef WRAPC_TESTING_H
#define WRAPC_TESTING_H
#include <stdio.h>

//In C we can implement output paramenters providing an argument that is a pointer.

// return a value of type int the output parameter `count`.
void getIntValue(int* count );

// return a value of type Unsigned int the output parameter `count`.
void getUnsignedIntValue(unsigned int* count );

// return a value of type long the output parameter `count`.
void getLongValue(long* count );

// return a value of type Unsigned int the output parameter `count`.
void getUnsignedLongValue(unsigned long* count );

// return a value of type float the output parameter `count`.
void getFloatValue(float* count );

// return a value of type double the output parameter `count`.
void getDoubleValue(double* count );

// return a value of type double the output parameter `count`.
void getCharValue(char* val );

// return a value of type double the output parameter `count`.
void getUnsingedCharValue(unsigned char* val );

#endif

// Implementation

#ifdef WRAPC_TESTING_IMPL

void getIntValue(int* count ){
 	
 	* count = -10;
}

void getUnsignedIntValue(unsigned int* count ){
 	
 	* count = 10;
}

void getLongValue(long* count ){
 	

 	* count = (long) 2147;
}

void getUnsignedLongValue(unsigned long* count ){
 	
 	* count = 10;
}

void getFloatValue(float* count ){
 	
 		
 	* count = (float) 10.5;
}


void getDoubleValue(double* count ){
 	
 	* count = (double) 3.142857;
}

void getCharValue(char* val ){
 	
 	* val = 97;
}

void getUnsingedCharValue(unsigned char* val ){
 	
 	* val = 97;
}

#endif





