/*

 #####      #    #####           #    #
 #    #     #    #    #          #    #
 #    #     #    #    #          ######
 #    #     #    #####    ###    #    #
 #    #     #    #   #    ###    #    #
 #####      #    #    #   ###    #    #

	Declaration of public directory functions.
*/

#ifndef _eif_dir_h_
#define _eif_dir_h_

#include "eif_eiffel.h"

#ifdef __cplusplus
extern "C" {
#endif

RT_LNK EIF_POINTER dir_open(char *name);
RT_LNK EIF_REFERENCE dir_current(void);
RT_LNK EIF_CHARACTER eif_dir_separator (void);
RT_LNK EIF_INTEGER eif_chdir (EIF_OBJECT path);
RT_LNK EIF_BOOLEAN eif_dir_exists (char *name);
RT_LNK EIF_BOOLEAN eif_dir_is_readable (char *name);
RT_LNK EIF_BOOLEAN eif_dir_is_writable (char *name);
RT_LNK EIF_BOOLEAN eif_dir_is_executable (char *name);
RT_LNK EIF_BOOLEAN eif_dir_is_deletable (char *name);
RT_LNK void eif_dir_delete (char *name);
RT_LNK void dir_rewind(EIF_POINTER dirp);
RT_LNK char *dir_search(EIF_POINTER dirp, char *name);
RT_LNK EIF_REFERENCE dir_next(EIF_POINTER dirp);
RT_LNK void dir_close(EIF_POINTER dirp);

#ifdef __cplusplus
}
#endif

#endif  /* _eif_dir_h_ */
