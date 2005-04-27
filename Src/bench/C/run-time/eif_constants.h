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
	Constants used in global variable definitions.
*/

#ifndef _eif_constants_h_
#define _eif_constants_h_

#ifdef __cplusplus
extern "C" {
#endif

	/*---------*/
	/* sig.c */
	/*---------*/
/* Make sure EIF_NSIG is defined. If not, set it to 32 (cross your fingers)--RAM */
#ifndef NSIG
#ifdef EIF_WINDOWS
#define EIF_NSIG 23
#else	/* EIF_WINDOWS */
#define EIF_NSIG 32		/* Number of signals (access from 1 to EIF_NSIG-1) */
#endif /* EIF_WINDOWS */
#else	/* !NSIG */

#ifdef EIF_LINUXTHREADS
#define EIF_NSIG	32	/* In MT-mode, it is better not to deal 
						 * with signals above 32. */
#else	/* EIF_THREADS */
#define	EIF_NSIG	NSIG	/* EIF_NSIG is NSIG in a single threaded runtime. */
#endif	/* EIF_THREADS */

#endif	/* !NSIG */

#define SIGSTACK	200		/* Size of FIFO stack for signal buffering */

	/*------------*/
	/*  except.h  */
	/*------------*/
#define EN_NEX		29			/* Number of internal exceptions */

	/*-------------*/
 	/*  pattern.c  */
	/*-------------*/
#define ASIZE 256     /* The alphabet's size */


	/*---------*/
	/*  out.c  */
	/*---------*/
#define TAG_SIZE 512  /* Maximum size for a single tagged expression */

	/*------------*/
	/*  string.c  */
	/*------------*/
#define	MAX_NUM_LEN	256	/* Maximum length for an ASCII number. */


#ifdef __cplusplus
}
#endif

#endif	/* _eif_constants_h_ */
