/*
	Object id externals
*/

#include "portable.h"
#include "garcol.h"
#include "except.h"
#include "hector.h"


/*#define DEBUG 2		/* Debug level */

#define dprintf(n)      if (DEBUG & (n)) printf


/* The following stack records the addresses of objects for which
 * `object_id' has been called.
 */

public struct stack object_id_stack = {
	(struct stchunk *) 0,	/* st_hd */
	(struct stchunk *) 0,	/* st_tl */
	(struct stchunk *) 0,	/* st_cur */
	(char **) 0,			/* st_top */
	(char **) 0,			/* st_end */
};

private EIF_INTEGER max_object_id = 0;	/* Max object_id allocated */
/* This needs to be done as the chunks of memory are not cleared after
 * allocation and we do not want to consider some garbage as a valid
 * descendant of IDENTIFIED and then call `object_id' on it
 */

#define STACK_SIZE (STACK_CHUNK-(sizeof(struct stchunk)/sizeof(char*)))

public EIF_INTEGER eif_object_id(object)
EIF_REFERENCE object;
{
	register unsigned int stack_number = 0;
	register struct stchunk *end;
	register EIF_INTEGER Result;
	char *address;
	char *obj = eif_access(object);

	if (-1 == epush(&object_id_stack, obj)) {	/* Cannot record object */
		eraise("object id", EN_MEM);			/* No more memory */
		return (EIF_INTEGER) 0;					/* They ignored it */
		}
	address = (char *) (object_id_stack.st_top - 1);  /* Was allocated here */
	eif_access(address) = obj;       /* Record object's physical address */

	for(end = object_id_stack.st_hd;
		end != object_id_stack.st_cur;
		stack_number++)
		end = end->sk_next;

	Result = (EIF_INTEGER)
		stack_number*STACK_SIZE+1-(object_id_stack.st_cur->sk_arena-(char **)address);

	max_object_id = (Result>max_object_id)?Result:max_object_id;

#ifdef DEBUG
	dprintf (2) ("eif_object_id %d %lx %lx\n", Result, address, obj);
#endif
	return Result;
}

public EIF_REFERENCE eif_id_object(id)
EIF_INTEGER id;
{
	register unsigned int stack_number, i = 0;
	register struct stchunk *end;

	register char *address;

	if (id==0)							/* No object associated with 0 */
		return (EIF_REFERENCE) 0;

	if (id>max_object_id)
		return (EIF_REFERENCE) 0;

	if ((end = object_id_stack.st_hd) == (struct stchunk *) 0)	/* No stack */
		return (EIF_REFERENCE) 0;

	id --;

	stack_number = id / STACK_SIZE;		/* Get the chunk number */

	for (;stack_number != i; i++)
		if ((end = end->sk_next) == (struct stchunk *) 0)
			return (EIF_REFERENCE) 0;		/* Not that many chunks */

		/* add offset to the end of chunk */
	address = (char *) (end->sk_arena + (id % STACK_SIZE));

#ifdef DEBUG
	if (address)
		dprintf (2) ("eif_id_object %d %lx %lx\n", id+1, address, eif_access(address));
	else
		dprintf (2) ("eif_id_object %d No object\n", id+1);
#endif
	if (address)
			/* Use eif_access to return the "real" object */
		return (eif_access(address));

	return (EIF_REFERENCE) 0;
}

public void eif_object_id_free(id)
EIF_INTEGER id;
{
	/* Free the entry in the table */

	register unsigned int stack_number, i = 0;
	register struct stchunk *end;
	
	if (id==0)							/* No object associated with 0 */
		return;

	if (id>max_object_id)
		return;

	if ((end = object_id_stack.st_hd) == (struct stchunk *) 0)	/* No stack */
		return;

	id--;

	stack_number = id / STACK_SIZE;		/* Get the chunk number */

	for (;stack_number != i; i++)
		if ((end = end->sk_next) == (struct stchunk *) 0)
			return;		/* Not that many chunks */

		/* add offset to the end of chunk */
	eif_access((char *)((char **)end->sk_arena + (id % STACK_SIZE))) = (EIF_REFERENCE) 0;

}

