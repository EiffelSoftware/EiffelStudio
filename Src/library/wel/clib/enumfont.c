/*
 * ENUMFONT.C
 *
 * Functions used by the class WEL_FONT_FAMILY_ENUMERATOR.
 *
 */

#ifndef __WEL_ENUMFONT__
#	include <enumfont.h>
#endif

EIF_ENUM_FONT_FAMILY_PROCEDURE wel_enum_font_fam_procedure = NULL;
/* Address of the Eiffel routine `converter' (class WEL_FONT_FAMILY_ENUMERATOR) */

EIF_OBJ font_family_enumerator = NULL;
/* Address of the Eiffel object WEL_FONT_FAMILY_ENUMERATOR created */

int CALLBACK cwel_enum_font_fam_procedure (ENUMLOGFONT * lpelf, NEWTEXTMETRIC * lpntm, int font_type, LPARAM lparam)
{
	/*
	 * This function is called by Windows for each font found in the system.
	 * The Eiffel routine `convert' of the class WEL_FONT_FAMILY_ENUMERATOR
	 * is called for each font.
	 * -- PK.
	 */

	if (font_family_enumerator)
	{
		((wel_enum_font_fam_procedure) (
			(EIF_OBJ) eif_access (font_family_enumerator),
			(EIF_POINTER) lpelf,
			(EIF_POINTER) lpntm,
			(EIF_INTEGER) font_type,
			(EIF_POINTER) lparam));
		return 1; /* Continue the enumeration. */
	}
	else
	{
		return 0; /* Stop the enumeration. */
	}
}

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
