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
#include "eif_file.h"

#ifdef __cplusplus
extern "C" {
#endif

/* New Unicode compliant API. */
RT_LNK EIF_POINTER eif_dir_open(EIF_FILENAME name);
RT_LNK EIF_INTEGER eif_dir_current (EIF_FILENAME a_buffer, EIF_INTEGER a_count);
RT_LNK EIF_CHARACTER_8 eif_dir_separator (void);
RT_LNK EIF_INTEGER eif_chdir (EIF_FILENAME path);
RT_LNK EIF_BOOLEAN eif_dir_exists (EIF_FILENAME name);
RT_LNK EIF_BOOLEAN eif_dir_is_readable (EIF_FILENAME name);
RT_LNK EIF_BOOLEAN eif_dir_is_writable (EIF_FILENAME name);
RT_LNK EIF_BOOLEAN eif_dir_is_executable (EIF_FILENAME name);
RT_LNK EIF_BOOLEAN eif_dir_is_deletable (EIF_FILENAME name);
RT_LNK EIF_POINTER eif_dir_rewind (EIF_POINTER d, EIF_FILENAME dir_name);
RT_LNK EIF_POINTER eif_dir_next(EIF_POINTER d);
RT_LNK void eif_dir_close(EIF_POINTER dirp);

#ifdef __cplusplus
}
#endif

#endif  /* _eif_dir_h_ */
