#include "eif_cecil.h"

#define LISTSZ 10
struct transaction 
{
	char who[34] ;
	char type[24] ;
	EIF_INTEGER amount;
};
struct bank_account 
{
	EIF_INTEGER balance;	
	struct transaction *history;
};
extern EIF_PROCEDURE post;
extern EIF_OBJECT post_office;
extern void record_transaction (struct bank_account *ba, EIF_INTEGER m, EIF_POINTER tid);
extern void c_make_transaction (EIF_INTEGER m, EIF_POINTER ptr, EIF_POINTER tid); 
extern void c_post (EIF_POINTER ptr); 
