#include <stdio.h>
#include <assert.h>
#include "eif_cecil.h"
#include "eif_eiffel.h"
#include "fext.h"

/*-----------------------------------------*/
/* Post the periodic bank report.          */
/* Synchronization is done from Eiffel.    */
/*-----------------------------------------*/
extern EIF_PROCEDURE post;
extern EIF_OBJECT post_office;

void c_post (EIF_POINTER ptr)
{
	int i;
	char *res;
	struct bank_account *acc = (struct bank_account *) ptr;
	struct transaction *t;

	printf ("**** Bank account report:\n");
	for ( i = 0; i < LISTSZ ; i++)
	{
		t = acc->history + i;
		printf ("%s\t%s\t%ld\n", t->who, t->type, t->amount);
	}
	printf ("*** BALANCE: %ld\n", acc->balance);
}

	
/*-----------------------------------------------------*/
/* Record a transaction into bank account's history    */
/*-----------------------------------------------------*/

void record_transaction (struct bank_account *acc, EIF_INTEGER m)
{
	EIF_GET_CONTEXT
	static int top = 0;
	struct transaction *t;
	assert (top < LISTSZ);
	assert (post);
	assert (post_office);

	t = (struct transaction *) malloc (sizeof (struct transaction));
	strcpy ((t->type) ,  (m >= 0 ? "DEPOSIT": "WITHDRAWAL"));
	sprintf (t->who, "Thread 0x%x", eif_thr_id);
	t->amount = abs (m);
	memcpy (acc->history + top , t, sizeof (struct transaction));
	free (t);
	top++;
	if (!(top % LISTSZ))
	{
		post (eif_access (post_office));
		top = 0;
	}
	
}
/*-------------------------------------------*/
/* Make a transaction.                       */
/* Synchronization is done from Eiffel.      */
/*-------------------------------------------*/
void c_make_transaction (EIF_INTEGER m, EIF_POINTER ptr) 
{
	
	struct bank_account *acc = (struct bank_account *) ptr;
	EIF_GET_CONTEXT
	assert (ptr);
	assert (m);
#ifdef DEBUG
	printf ("Make transaction: amount = %d, in account 0x%x in thread 0x%x\n", m, ptr, eif_thr_id);
#endif
	acc->balance += m;
	record_transaction (acc, m);
}	

