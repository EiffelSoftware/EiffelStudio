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
	Externals for classes PATH_NAME, DIRECTORY_NAME and FILE_NAME,
	platform independent manipulation of path names
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

