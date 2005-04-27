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
	Private declaration of public directory functions.
*/

#ifndef _rt_dir_h_
#define _rt_dir_h_

#include "eif_dir.h"

#ifdef I_DIRENT
#include <dirent.h>
#define DIRENTRY struct dirent
#elif defined(I_SYS_DIR)
#include <sys/dir.h>
#define DIRENTRY struct direct
#elif defined(I_SYS_NDIR)
#include <sys/ndir.h>
#define DIRENTRY struct direct
#elif defined(EIF_VMS_V6_ONLY)
#include <descrip.h>
#include "eif_vmsdirent.h"		/* local to run-time */
#define DIRENTRY struct dirent
#elif defined EIF_WINDOWS
#else
	Sorry! You have to find a directory package...
#endif

#ifdef EIF_WINDOWS
#include <windows.h>
#include <direct.h>	/* In order to use chdir and getcwd */
#else
#include <unistd.h>	/* In order to use chdir and getcwd */
#endif

#endif
