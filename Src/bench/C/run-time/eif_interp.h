/*

	#    #    #   #####  ######  #####   #####           #    #
	#    ##   #     #    #       #    #  #    #          #    #
	#    # #  #     #    #####   #    #  #    #          ######
	#    #  # #     #    #       #####   #####    ###    #    #
	#    #   ##     #    #       #   #   #        ###    #    #
	#    #    #     #    ######  #    #  #        ###    #    #

	Interpreter declarations and definitions.
*/

#ifndef _eif_interp_h_
#define _eif_interp_h_

#include "eif_globals.h"
#include <stdio.h>		/* %%zs added: for FILE definition line 91 */
#include "eif_portable.h"
#include "eif_struct.h"

#ifdef __cplusplus
extern "C" {
#endif

/* Macros for easy reference */
#define it_char		itu.itu_char
#define it_int8		itu.itu_int8
#define it_int16	itu.itu_int16
#define it_wchar	itu.itu_wchar
#define it_int32	itu.itu_int32
#define it_int64	itu.itu_int64
#define it_float	itu.itu_float
#define it_double	itu.itu_double
#define it_ref		itu.itu_ref
#define it_ptr		itu.itu_ptr
#define it_bit		itu.itu_bit

/* Interpreter interface to outside world */
RT_LNK void call_disp(uint32 dtype, char *object);				/* Function to call dispose routines */ 
RT_LNK void xinterp(unsigned char *icval);					/* Compound from a given address */
extern void xiinv(unsigned char *icval, int where);			/* Invariant interpreter */
extern void xinitint(void);										/* Initialize the interpreter */
RT_LNK struct item *opush(register struct item *val);			/* Push value on operational stack */
RT_LNK struct item *opop(void);									/* Remove value from operational stack */
extern struct item *otop(void);									/* Top of the stack */
extern struct item *ivalue(int code, int num, uint32 start);	/* Value request from current routine */
extern void sync_registers(struct stochunk *stack_cur, struct item *stack_top);		/* Resynchronize registers on routine */

/* Macro used to prepare a cell on top of the stack */
#define iget()	opush((struct item *) 0)	/* Push empty cell on stack */

extern void idump(FILE *fd, char *start);

#ifdef __cplusplus
}
#endif

#endif
