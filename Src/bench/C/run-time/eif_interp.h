/*
--|----------------------------------------------------------------
--| Eiffel runtime header file
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|     http://www.eiffel.com
--|----------------------------------------------------------------
*/

/*
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

#ifndef EIF_THREADS
#ifdef WORKBENCH
RT_LNK struct opstack cop_stack;	/* Operational stack */
RT_LNK unsigned char *IC;			/* Interpreter Counter (like PC on a CPU) */
#endif
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
RT_LNK void xinterp(unsigned char *icval);					/* Compound from a given address */
RT_LNK struct item *opush(register struct item *val);			/* Push value on operational stack */
RT_LNK struct item *opop(void);									/* Remove value from operational stack */

/* Macro used to prepare a cell on top of the stack */
#define iget()	opush((struct item *) 0)	/* Push empty cell on stack */

#ifdef __cplusplus
}
#endif

#endif
