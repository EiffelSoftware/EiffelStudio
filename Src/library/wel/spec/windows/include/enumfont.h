/*
 * ENUMFONT.H
 */

#ifndef __WEL_ENUMFONT__
#define __WEL_ENUMFONT__

#ifndef __WEL__
#	include "wel.h"
#endif

#ifndef __WEL_GLOBALS__
#	include "wel_globals.h"
#endif

typedef void (* EIF_ENUM_FONT_FAMILY_PROCEDURE)
	(EIF_OBJ,     /* WEL_FONT_FAMILY_ENUMERATOR Eiffel object */
	 EIF_POINTER, /* ENUMLOGFONT * */
	 EIF_POINTER, /* NEWTEXTMETRIC * */
	 EIF_INTEGER, /* Font type */
	 EIF_POINTER  /* user-data */
	 );
/* Eiffel routine signature for `converter' */

int CALLBACK cwel_enum_font_fam_procedure (ENUMLOGFONT *, NEWTEXTMETRIC *, int, LPARAM);

#define cwel_set_enum_font_fam_procedure_address(_addr_) (wel_enum_font_fam_procedure = (EIF_ENUM_FONT_FAMILY_PROCEDURE) _addr_)
/* Set `wel_enum_font_fam_procedure' with `addr' */

#define cwel_set_font_family_enumerator_object(_addr_) (font_family_enumerator = eif_adopt ((EIF_OBJ) _addr_))
/* Set `font_family_enumerator' with `addr' */

#define cwel_release_font_family_enumerator_object (eif_wean (font_family_enumerator))
/* Release `font_family_enumerator' with `addr' */

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
