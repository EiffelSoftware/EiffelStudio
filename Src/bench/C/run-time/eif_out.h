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
	Include file for printing an Eiffel object
*/

#ifndef _eif_out_h_
#define _eif_out_h_

#include "eif_portable.h"
#include "eif_cecil.h"		/* %%zs added for EIF_OBJECT definition line 26... */
#include "eif_interp.h"		/* %%zs added for 'struct item' definition line 48 */

#ifdef __cplusplus
extern "C" {
#endif

/*
 * Function declarations 
 */

RT_LNK EIF_REFERENCE  c_generator_of_type(EIF_INTEGER dftype); /* Called by `generator' from ANY */
#define c_generator(obj)	c_generator_of_type (Dftype (obj))

RT_LNK EIF_REFERENCE c_tagged_out(EIF_OBJECT object);	/* Called by `tagged_out' from ANY */
RT_LNK char *eif_out(EIF_REFERENCE object);		/* Build the output of an EIF_REFERENCE */
extern char *build_out(EIF_OBJECT object);		/* Build tagged out in C buffer */

/*
 * Building `out' string for simple types.
 */

RT_LNK EIF_REFERENCE c_outi(EIF_INTEGER i);
RT_LNK EIF_REFERENCE c_outi64(EIF_INTEGER_64 i);
RT_LNK EIF_REFERENCE c_outr32(EIF_REAL_32 f);
RT_LNK EIF_REFERENCE c_outr64(EIF_REAL_64 d);
RT_LNK EIF_REFERENCE c_outc(EIF_CHARACTER c);
RT_LNK EIF_REFERENCE c_outp(EIF_POINTER p);

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
