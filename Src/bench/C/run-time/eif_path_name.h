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

#ifdef EIF_VMS
#ifdef EIF_VMS_V6_ONLY
RT_LNK char * dir_dot_dir (char * dir);
#endif
RT_LNK int   eifrt_vms_has_path_terminator (const char* path) ;
RT_LNK void  eifrt_vms_append_file_name (char* path, const char* file) ;
RT_LNK char* eifrt_vms_filespec (const char* filespec, char* buf) ;
RT_LNK char* eifrt_vms_directory_file_name (const char* dir, char* buf) ;
#endif

#ifdef __cplusplus
}
#endif

#endif

