/*

	Externals for classes PATH_NAME, DIRECTORY_NAME and FILE_NAME,
	platform independent manipulation of path names

*/

#ifndef _eif_path_name_h_
#define _eif_path_name_h_

#ifdef __cplusplus
extern "C" {
#endif

#include "eif_portable.h"

extern EIF_BOOLEAN eif_is_directory_valid(EIF_POINTER p);
extern EIF_BOOLEAN eif_is_volume_name_valid (EIF_POINTER p);
extern EIF_BOOLEAN eif_is_file_name_valid (EIF_POINTER p);
extern EIF_BOOLEAN eif_is_extension_valid (EIF_POINTER p);
extern EIF_BOOLEAN eif_is_file_valid (EIF_POINTER p);
extern EIF_BOOLEAN eif_is_directory_name_valid (EIF_POINTER p);
extern EIF_BOOLEAN eif_path_name_compare(EIF_POINTER s, EIF_POINTER t, EIF_INTEGER length);
extern void eif_append_directory(EIF_REFERENCE string, EIF_POINTER p, EIF_POINTER v);
extern void eif_set_directory(EIF_REFERENCE string, EIF_POINTER p, EIF_POINTER v);
extern void eif_append_file_name(EIF_REFERENCE string, EIF_POINTER p, EIF_POINTER v);
extern EIF_BOOLEAN eif_case_sensitive_path_names(void);
extern EIF_REFERENCE eif_current_dir_representation(void);
extern EIF_BOOLEAN eif_home_dir_supported(void);
extern EIF_BOOLEAN eif_root_dir_supported(void);
extern EIF_REFERENCE eif_home_directory_name(void);
extern EIF_REFERENCE eif_root_directory_name(void);
extern EIF_REFERENCE eif_volume_name(EIF_POINTER p);
extern EIF_REFERENCE eif_extracted_paths(EIF_POINTER p);

#ifdef EIF_VMS
#ifdef EIF_VMS_V6_ONLY
RT_LNK char * dir_dot_dir (char * dir);
#endif
RT_LNK char * eifrt_vms_directory_file_name (const char* dir, char* buf);
#endif

#ifdef __cplusplus
}
#endif

#endif

