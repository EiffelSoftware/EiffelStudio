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
RT_LNK EIF_POINTER dir_search(EIF_POINTER dirp, char *name);
RT_LNK EIF_REFERENCE dir_next(EIF_POINTER dirp);
RT_LNK void dir_close(EIF_POINTER dirp);

#ifdef __cplusplus
}
#endif

#endif  /* _eif_dir_h_ */
