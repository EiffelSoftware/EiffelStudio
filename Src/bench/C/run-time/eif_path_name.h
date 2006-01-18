/*
	description: "[
			Externals for classes PATH_NAME, DIRECTORY_NAME and FILE_NAME,
			platform independent manipulation of path names
			]"
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

#ifndef _eif_path_name_h_
#define _eif_path_name_h_

#include "eif_portable.h"

#ifdef __cplusplus
extern "C" {
#endif

RT_LNK EIF_BOOLEAN eif_is_directory_valid(EIF_CHARACTER *p);
RT_LNK EIF_BOOLEAN eif_is_volume_name_valid (EIF_CHARACTER *p);
RT_LNK EIF_BOOLEAN eif_is_file_name_valid (EIF_CHARACTER *p);
RT_LNK EIF_BOOLEAN eif_is_extension_valid (EIF_CHARACTER *p);
RT_LNK EIF_BOOLEAN eif_is_file_valid (EIF_CHARACTER *p);
RT_LNK EIF_BOOLEAN eif_is_directory_name_valid (EIF_CHARACTER *p);
RT_LNK EIF_BOOLEAN eif_path_name_compare(EIF_CHARACTER *s, EIF_CHARACTER *t, EIF_INTEGER length);
RT_LNK void eif_append_directory(EIF_REFERENCE string, EIF_CHARACTER *p, EIF_CHARACTER *v);
RT_LNK void eif_set_directory(EIF_REFERENCE string, EIF_CHARACTER *p, EIF_CHARACTER *v);
RT_LNK void eif_append_file_name(EIF_REFERENCE string, EIF_CHARACTER *p, EIF_CHARACTER *v);
RT_LNK EIF_REFERENCE eif_volume_name(EIF_CHARACTER *p);
RT_LNK EIF_REFERENCE eif_extracted_paths(EIF_CHARACTER *p);
RT_LNK EIF_BOOLEAN eif_case_sensitive_path_names(void);
RT_LNK EIF_REFERENCE eif_current_dir_representation(void);
RT_LNK EIF_BOOLEAN eif_home_dir_supported(void);
RT_LNK EIF_BOOLEAN eif_root_dir_supported(void);
RT_LNK EIF_REFERENCE eif_home_directory_name(void);
RT_LNK EIF_REFERENCE eif_root_directory_name(void);

#ifdef __cplusplus
}
#endif

#endif

