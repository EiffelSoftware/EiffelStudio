/*

  ####   #    #   #####          #    #
 #    #  #    #     #            #    #
 #    #  #    #     #            ######
 #    #  #    #     #     ###    #    #
 #    #  #    #     #     ###    #    #
  ####    ####      #     ###    #    #

			Include file for printing an Eiffel object
*/

#ifndef _eif_out_h_
#define _eif_out_h_

#ifdef __cplusplus
extern "C" {
#endif

#include "eif_portable.h"
#include "eif_cecil.h"		/* %%zs added for EIF_OBJECT definition line 26... */
#include "eif_interp.h"		/* %%zs added for 'struct item' definition line 48 */

/*
 * Function declarations 
 */

RT_LNK char *c_generator(register char *Current);		/* Eiffel feature `generator' (GENERAL) */
extern char *c_tagged_out(EIF_OBJECT object);	/* Eiffel feature `tagged_out' (GENERAL) */
RT_LNK char *eif_out(EIF_REFERENCE object);		/* Build the output of an EIF_REFERENCE */
extern char *build_out(EIF_OBJECT object);		/* Build tagged out in C buffer */

/*
 * Building `out' string for simple types.
 */

extern EIF_REFERENCE c_outb(EIF_BOOLEAN b);		/* %%zs modified EIF_REFERENCE was char * */
extern EIF_REFERENCE c_outi(EIF_INTEGER i);		/* %%zs modified EIF_REFERENCE was char * */
extern EIF_REFERENCE c_outr(EIF_REAL f);		/* %%zs modified EIF_REFERENCE was char * */
extern EIF_REFERENCE c_outd(EIF_DOUBLE d);		/* %%zs modified EIF_REFERENCE was char * */
extern EIF_REFERENCE c_outc(EIF_CHARACTER c);		/* %%zs modified EIF_REFERENCE was char * */
extern EIF_REFERENCE c_outp(EIF_POINTER p);		/* %%zs modified EIF_REFERENCE was char * */

/*
 *	`out' string.
 */

#ifndef EIF_THREADS
extern char*tagged_out;
#endif /* EIF_THREADS */



#ifdef WORKBENCH

/* The following routine builds a tagged out string out of simple types.
 * The reason for this is that the debugger can request the value of, say,
 * local #2, and this might be an integer for instance... We cannot call
 * build_out, as it expects a true object, not a simple type...
 */

extern char *simple_out(struct item *val);		/* Tagged out form for simple types */	/* %%zs need to include 'item' definition */

#endif /* WORKBENCH */

#ifdef __cplusplus
}
#endif

#endif
