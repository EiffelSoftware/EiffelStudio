/*
indexing
	description: "Functions used by the class WEL_FONT_FAMILY_ENUMERATOR."
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
*/

#include "wel_globals.h"

#ifndef EIF_THREADS
	EIF_ENUM_FONT_FAMILY_PROCEDURE wel_enum_font_fam_procedure = NULL;
	/* Address of the Eiffel routine `converter' (class WEL_FONT_FAMILY_ENUMERATOR) */
	
	EIF_OBJ font_family_enumerator = NULL;
	/* Address of the Eiffel object WEL_FONT_FAMILY_ENUMERATOR created */
#endif

int CALLBACK cwel_enum_font_fam_procedure (ENUMLOGFONT * lpelf, NEWTEXTMETRIC * lpntm, DWORD font_type, LPARAM lparam)
{
	/*
	 * This function is called by Windows for each font found in the system.
	 * The Eiffel routine `convert' of the class WEL_FONT_FAMILY_ENUMERATOR
	 * is called for each font.
	 * -- PK.
	 */

	WGTCX
	if (font_family_enumerator)
	{
		((wel_enum_font_fam_procedure) (
#ifndef EIF_IL_DLL
			(EIF_OBJECT) eif_access (font_family_enumerator),
#endif
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

	WEDCX
}

#ifdef EIF_THREADS

void wel_set_enum_font_fam_procedure_address(EIF_POINTER _addr_)
{
		WGTCX
		wel_enum_font_fam_procedure = (EIF_ENUM_FONT_FAMILY_PROCEDURE) _addr_;
}

void wel_set_font_family_enumerator_object(EIF_POINTER _addr_)
{
		WGTCX
		font_family_enumerator = eif_adopt ((EIF_OBJ) _addr_);
}

EIF_REFERENCE wel_release_font_family_enumerator_object ()
{
		WGTCX
		return eif_wean (font_family_enumerator);
}


#endif
