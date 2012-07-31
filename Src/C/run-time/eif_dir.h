/*
	description: "Declaration of public directory functions."
	date:		"$Date$"
	revision:	"$Revision$"
	copyright:	"Copyright (c) 1985-2012, Eiffel Software."
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
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
*/

#ifndef _eif_dir_h_
#define _eif_dir_h_
#if defined(_MSC_VER) && (_MSC_VER >= 1020)
#pragma once
#endif

#include "eif_eiffel.h"

#ifdef __cplusplus
extern "C" {
#endif

RT_LNK EIF_POINTER dir_open(char *name);
RT_LNK EIF_REFERENCE dir_current(void);
RT_LNK EIF_CHARACTER_8 eif_dir_separator (void);
RT_LNK EIF_INTEGER eif_chdir (char * path);
RT_LNK EIF_BOOLEAN eif_dir_exists (char *name);
RT_LNK EIF_BOOLEAN eif_dir_is_readable (char *name);
RT_LNK EIF_BOOLEAN eif_dir_is_writable (char *name);
RT_LNK EIF_BOOLEAN eif_dir_is_executable (char *name);
RT_LNK EIF_BOOLEAN eif_dir_is_deletable (char *name);
RT_LNK void eif_dir_delete (char *name);
RT_LNK void dir_rewind(EIF_POINTER dirp);
RT_LNK EIF_REFERENCE dir_next(EIF_POINTER dirp);
RT_LNK void dir_close(EIF_POINTER dirp);

RT_LNK EIF_REFERENCE eif_dir_current_16 (void);
RT_LNK EIF_POINTER eif_dir_open_16 (EIF_NATURAL_16 *name);
RT_LNK EIF_INTEGER eif_chdir_16 (EIF_NATURAL_16 * path);
RT_LNK EIF_BOOLEAN eif_dir_exists_16 (EIF_NATURAL_16 *name);
RT_LNK EIF_BOOLEAN eif_dir_is_readable_16 (EIF_NATURAL_16 *name);
RT_LNK EIF_BOOLEAN eif_dir_is_writable_16 (EIF_NATURAL_16 *name);
RT_LNK EIF_BOOLEAN eif_dir_is_executable_16 (EIF_NATURAL_16 *name);
RT_LNK void eif_dir_delete_16 (EIF_NATURAL_16 *name);

#ifdef __cplusplus
}
#endif

#endif  /* _eif_dir_h_ */
