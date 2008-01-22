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

#ifdef __VMS  /* scope: to end of file */
#pragma module VMS_NAMES	/* force uppercase module name */


/* Native code on VMS defaults to coercing all external names to UPPERCASE.	*/
/* In order to support code that cannot be compiled to make external names	*/
/* case sensitive (i.e. CC/NAME=AS_IS), this module contains uppercase jacket	*/
/* routines that call the corresponding lower/mixed-case routines.		*/
/*										*/
/* Additionally, several X-related entry points that are not defined on VMS	*/
/* are stubbed out here, as well as any runtime functions that cannot be	*/
/* supported on VMS (like fork).						*/
/*										*/




/* workaround problem: EIF_TYPE_ID is a typedef defined in eif_cecil.h, but	*/
/* it needs to be a function name here (jacket for calling eif_type_id ().	*/
#define EIF_TYPE_ID EIF_TYPE_ID_TYPEDEF


#include "eif_portable.h"
#include "eif_cecil.h"
#include "eif_malloc.h"
#include "eif_setup.h"	/* for egc_init_plug() */


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



/*** cecil.c ***/
rt_public EIF_OBJECT EIFCREATE (EIF_TYPE_ID cid)
    { return eifcreate (cid); }

rt_public EIF_REFERENCE_FUNCTION EIFREF (char *routine, EIF_TYPE_ID cid)
    { return eifref (routine, cid); }

rt_public EIFVISEX (void)
    { eifvisex(); }

rt_public EIFUVISEX (void)
    { eifuvisex(); }


/*** hector.c ***/
rt_public EIF_REFERENCE EWEAN (EIF_OBJECT object)
    { return eif_wean (object); }

rt_public EIF_OBJECT HENTER (EIF_REFERENCE object)
    { return eif_protect (object); }


/*** plug.c ***/
rt_public EIF_REFERENCE MAKESTR (register char *s, register int len)
    { return makestr (s, len); }


/*** main.c ***/
rt_public void EIF_RTINIT (int argc, char **argv, char **envp)
    { eif_rtinit (argc, argv, envp); }

rt_public void FAILURE (void)
    { failure(); }


/*** malloc.c ***/
rt_public EIF_REFERENCE CMALLOC (unsigned int nbytes) 
    { return cmalloc (nbytes); }
#ifdef moose	/* conflicts with XFree (Xt library) */
rt_public void XFREE (EIF_REFERENCE ptr)
    { xfree (ptr); }
#endif


/*** garcol.c ***/
rt_public int COLLECT (void) 
    { return collect(); }


/*** sig.c ***/
void ESIGRESALL (void)
    { esigresall (); }

void INITSIG (void)
    { initsig(); }

/* New routines added for CECIL control of signal handling */
rt_public ESIG_CECIL_REGISTER (struct ex_vect * exvect)
    { esig_cecil_register (exvect); }

rt_public ESIG_CECIL_ENTER (void)
    { esig_cecil_enter(); }

rt_public ESIG_CECIL_EXIT (void)
    { esig_cecil_exit(); }


/*** local.c ***/
void INITSTK (void)
    { initstk(); }


/*** except.c ***/
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


/*** These symbols are defined in the Eiffel-generated code. ***/

/* emain.c (in [.EIFGEN.%_Code.E1]) */
rt_public void EGC_INIT_PLUG (void)
    { egc_init_plug(); }

/* einit.c (in [.EIFGEN.%_Code.E1]) */
extern void emain (int, char **) ;
rt_public void EMAIN (int argc, char ** argv)
    { emain (argc, argv); }



/*
** These symbols are referenced in Vision2 GTK implementation,
** but are not defined by VMS X (DECWindows) implementation.
*/

#define XSTUB(fn) int fn() \
{ fprintf (stderr, "*** undefined X entry point " #fn " called *** \n"); return -1; }

//XSTUB (XKeysymToKeycode)
XSTUB (XTestFakeButtonEvent)
XSTUB (XTestFakeKeyEvent)
XSTUB (XTestFakeMotionEvent)
XSTUB (XTestQueryExtension)



/*** Eiffel runtime calls that cannot be supported on VMS ***/

rt_public pid_t eifrt_vms_fork_jacket (void)
{
    fprintf (stderr, "*** undefined %s()) called ***\n", __func__);
    return (pid_t)-1;
}


#ifdef EIF_THREADS

/*** TEMP: stub out PTHREAD routines ***/
#define PTHREAD_STUB(fn) int fn() \
{ fprintf (stderr, "*** undefined PTHREAD entry point " #fn " called *** \n"); return -1; }

#endif /* EIF_THREADS */

#endif /* __VMS */
