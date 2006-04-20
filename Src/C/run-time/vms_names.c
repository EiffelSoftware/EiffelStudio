/*
	description: "VMS helper."
	date:		"$Date$"
	revision:	"$Revision$"
	copyright:	"Copyright (c) 1985-2006, Eiffel Software."
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"Commercial license is available at http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Runtime.
			
			Eiffel Software's Runtime is free software; you can
			redistribute it and/or modify it under the terms of the
			GNU General Public License as published by the Free
			Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Runtime is distributed in the hope
			that it will be useful,	but WITHOUT ANY WARRANTY;
			without even the implied warranty of MERCHANTABILITY
			or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Runtime; if not,
			write to the Free Software Foundation, Inc.,
			51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
*/

/* vms_names.c */
/* Uppercase entry points for cecil code. */
/* $Id$ */

#ifdef __VMS
#pragma module VMS_NAMES	/* force uppercase module name */
#endif


/* Native code on VMS defaults to coercing all external names to UPPERCASE. */
/* In order to support code that cannot be recompiled to make external	    */
/* names case sensitive (eg. CC /NAME=AS_IS), this module contains jacket   */
/* routines that call the corresponding lower/mixed-case routine.	    */
/*									    */
/* Additionally, several X-related entry points that are not defined on VMS */
/* are stubbed out here.						    */
/*									    */
/*									    */





/* workaround problem: EIF_TYPE_ID is a typedef, needs to be a function	    */
/* name here (jacket for eif_type_id function)				    */
#define EIF_TYPE_ID EIF_TYPE_ID_TYPEDEF


#include "eif_portable.h"
#include "eif_cecil.h"
#include "eif_malloc.h"
#include "eif_setup.h"	/* egc_init_plug() */


/* The following entry points are defined in lower case:		    */
/*									    */
/*									    */
/* %LINK-W-NUDFSYMS, 20 undefined symbols:				    */
/* %LINK-I-UDFSYM,         CMALLOC					    */
/* %LINK-I-UDFSYM,         COLLECT					    */
/* %LINK-I-UDFSYM,         DESCR_HIST					    */
/* %LINK-I-UDFSYM,         EGC_INIT_PLUG:				    */
/*			ref: emain, def: eplug (big_file_e1)		    */
/* %LINK-I-UDFSYM,         EIFCREATE					    */
/* %LINK-I-UDFSYM,         EIFLONG					    */
/* %LINK-I-UDFSYM,         EIFPROC					    */
/* %LINK-I-UDFSYM,         EIFPTR					    */
/* %LINK-I-UDFSYM,         EIF_RTINIT					    */
/* %.............
/*
** EGC_INIT_PLUG
** EIF_TYPE_ID
** EMAIN
** ESIGRESALL
** EXSET
** FAILURE
** INITSIG
** INITSTK
**
** Missing X symbols:
** XKeysymToKeycode
** XTestFakeButtonEvent
** XTestFakeKeyEvent
** XTestFakeMotionEvent
** XTestQueryExtension
*/ 


//#ifdef moose_cecil	// dont mask cecil calls; some modules must use /NAME=AS for proper extern configuration

/* cecil.c */
rt_public EIF_OBJECT EIFCREATE (EIF_TYPE_ID cid)
    { return eifcreate (cid); }

rt_public EIF_PROCEDURE EIFPROC (char *routine, EIF_TYPE_ID cid)
    { return eifproc (routine, cid); }

rt_public EIF_INTEGER_FUNCTION EIFLONG (char *routine, EIF_TYPE_ID cid)
    { return eiflong (routine, cid); }

rt_public EIF_CHARACTER_FUNCTION EIFCHAR (char *routine, EIF_TYPE_ID cid)
    { return eifchar (routine, cid); }

rt_public EIF_REAL_FUNCTION EIFREAL (char *routine, EIF_TYPE_ID cid)
    { return eifreal (routine, cid); }

rt_public EIF_DOUBLE_FUNCTION EIFDOUBLE (char *routine, EIF_TYPE_ID cid)
    { return eifdouble (routine, cid); }

rt_public EIF_BIT_FUNCTION EIFBIT (char *routine, EIF_TYPE_ID cid)
    { return eifbit (routine, cid); }

rt_public EIF_BOOLEAN_FUNCTION EIFBOOL (char *routine, EIF_TYPE_ID cid)
    { return eifbool (routine, cid); }

rt_public EIF_POINTER_FUNCTION EIFPTR (char *routine, EIF_TYPE_ID cid)
    { return eifptr (routine, cid); }

rt_public EIF_REFERENCE_FUNCTION EIFREF (char *routine, EIF_TYPE_ID cid)
    { return eifref (routine, cid); }


/* hector.c */
rt_public EIF_REFERENCE EWEAN (EIF_OBJECT object)
    { return ewean (object); }

rt_public EIF_OBJECT HENTER (EIF_REFERENCE object)
    { return henter (object); }


/* plug.c */
rt_public EIF_REFERENCE MAKESTR (register char *s, register int len)
    { return makestr (s, len); }


/* main.c */
rt_public void EIF_RTINIT (int argc, char **argv, char **envp)
    { eif_rtinit (argc, argv, envp); }

rt_public void FAILURE (void)
    { failure(); }


/* malloc.c */
rt_public EIF_REFERENCE CMALLOC (unsigned int nbytes) 
    { return cmalloc (nbytes); }
#ifdef moose	/* conflicts with XFree (Xt library) */
rt_public void XFREE (EIF_REFERENCE ptr)
    { xfree (ptr); }
#endif


/* garcol.c */
rt_public int COLLECT (void) 
    { return collect(); }


/* sig.c */
void ESIGRESALL (void)
    { esigresall (); }

void INITSIG (void)
    { initsig(); }


/* local.c */
void INITSTK (void)
    { initstk(); }


/* except.c */
rt_public struct ex_vect * EXSET (char *name, int origin, char *object)
    { return exset(name, origin, object); }


/* eif_type_id.c (in run-time) */
#undef EIF_TYPE_ID /* cannnot use this anymore, must be at end of file */
#ifndef moose /* problem: EIF_TYPE_ID is a typedef in eif_cecil.h */
rt_public EIF_TYPE_ID_TYPEDEF EIF_TYPE_ID (char *type_string)
    { return eif_type_id (type_string); }
#else
xxx rt_public int32 EIF_TYPE_ID (char *type_string)
    { return eif_type_id (type_string); }
#endif


/* These symbols are defined in the generated code. */

/* emain.c (in [.EIFGEN.%_Code.E1]) */
rt_public void EGC_INIT_PLUG (void)
    { egc_init_plug(); }

/* einit.c (in [.EIFGEN.%_Code.E1]) */
extern void emain (int, char **) ;
rt_public void EMAIN (int argc, char ** argv)
    { emain (argc, argv); }


//#endif	// moose cecil


/*
** These symbols are referenced in Vision2 GTK implementation,
** but are not defined by VMS X (DECWindows) implementation.
*/

#define XSTUB(fn) int fn() \
{ fprintf (stderr, "*** undefined X entry point " #fn " called *** \n"); return -1; }

XSTUB (XKeysymToKeycode)
XSTUB (XTestFakeButtonEvent)
XSTUB (XTestFakeKeyEvent)
XSTUB (XTestFakeMotionEvent)
XSTUB (XTestQueryExtension)

