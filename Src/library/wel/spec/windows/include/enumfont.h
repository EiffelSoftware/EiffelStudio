/*
 * ENUMFONT.H
 */

#ifndef __WEL_ENUMFONT__
#define __WEL_ENUMFONT__

#ifndef __WEL__
#	include "wel.h"
#endif

#ifdef __cplusplus
extern "C" {
#endif


typedef void (* EIF_ENUM_FONT_FAMILY_PROCEDURE) (
#ifndef EIF_IL_DLL
	EIF_OBJ,     /* WEL_FONT_FAMILY_ENUMERATOR Eiffel object */
#endif
	 EIF_POINTER, /* ENUMLOGFONT * */
	 EIF_POINTER, /* NEWTEXTMETRIC * */
	 EIF_INTEGER, /* Font type */
	 EIF_POINTER  /* user-data */
	 );

#ifdef __cplusplus
}
#endif


#ifndef __WEL_GLOBALS__
#	include "wel_globals.h"
#endif

#ifdef __cplusplus
extern "C" {
#endif


/* Eiffel routine signature for `converter' */
int CALLBACK cwel_enum_font_fam_procedure (ENUMLOGFONT *, NEWTEXTMETRIC *, DWORD, LPARAM);

#ifdef EIF_THREADS

	extern void wel_set_enum_font_fam_procedure_address(EIF_POINTER _addr_);
#	define cwel_set_enum_font_fam_procedure_address(_addr_)  (wel_set_enum_font_fam_procedure_address(_addr_))
		/* Set `wel_enum_font_fam_procedure' with `addr' */
	
	extern void wel_set_font_family_enumerator_object(EIF_POINTER _addr_);
#	define cwel_set_font_family_enumerator_object(_addr_)  (wel_set_font_family_enumerator_object(_addr_))
		/* Set `font_family_enumerator' with `addr' */
		
	extern EIF_OBJ wel_release_font_family_enumerator_object() ;
#	define cwel_release_font_family_enumerator_object (wel_release_font_family_enumerator_object ())
		/* Release `font_family_enumerator' with `addr' */
		
#else

#	define cwel_set_enum_font_fam_procedure_address(_addr_) (wel_enum_font_fam_procedure = (EIF_ENUM_FONT_FAMILY_PROCEDURE) _addr_)
		/* Set `wel_enum_font_fam_procedure' with `addr' */

#	define cwel_set_font_family_enumerator_object(_addr_) (font_family_enumerator = eif_adopt ((EIF_OBJ) _addr_))
		/* Set `font_family_enumerator' with `addr' */

#	define cwel_release_font_family_enumerator_object (eif_wean (font_family_enumerator))
		/* Release `font_family_enumerator' with `addr' */

#endif

#ifdef __cplusplus
}
#endif

#endif /* __WEL_ENUMFONT__ */

/*
--|-------------------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1995-1997, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
*/
