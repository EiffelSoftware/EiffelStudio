/*
	description: "Declarations for externals of class FILE."
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

#ifndef _eif_file_h_
#define _eif_file_h_
#if defined(_MSC_VER) && (_MSC_VER >= 1020)
#pragma once
#endif

#include <stdio.h>		/* %%zs moved from file.c */
#include <limits.h>							/* For PATH_MAX */

#ifdef I_DIRENT								/* For PATH_MAX under Linux */
#include <dirent.h>
#endif

#ifdef EIF_WINDOWS
#include <time.h>
#ifndef PATH_MAX
#define PATH_MAX 260	/* Maximum length of full path name */
#endif

#else

#include <unistd.h>		/* For R_OK,... */

#ifndef PATH_MAX
#define PATH_MAX 1024	/* Maximum length of full path name */
#endif

#endif

#include "eif_macros.h"

/*
 * The following universal constants might not be found in the standard headers
 * included in file.c. Rather than getting an headache trying to Configure that,
 * it seems better to provide them here...--RAM.
 */

#include <sys/types.h>
#include <sys/stat.h>

#ifdef __cplusplus
extern "C" {
#endif

/* Let's define the stat structure for our platforms. */
/* The definition is the same for both ANSI and Unicode versions on Windows. */
#ifdef EIF_WINDOWS
#	ifdef EIF_64_BITS
#		define rt_stat_buf	struct _stat64
#	else
#		define rt_stat_buf	struct _stat64i32
#	endif
#else
#	define rt_stat_buf		struct stat
#endif

/*
 * Functions declaration.
 */

RT_LNK char *file_open_mode(int how, char mode);
RT_LNK EIF_POINTER file_open(char *name, int how);
RT_LNK EIF_POINTER file_dopen(int fd, int how);
RT_LNK EIF_POINTER file_reopen(char *name, int how, FILE *old);
RT_LNK EIF_POINTER file_binary_open(char *name, int how);
RT_LNK EIF_POINTER file_binary_dopen(int fd, int how);
RT_LNK EIF_POINTER file_binary_reopen(char *name, int how, FILE *old);
RT_LNK void file_close(FILE *fp);
RT_LNK void file_flush(FILE *fp);
RT_LNK EIF_INTEGER eif_file_size (FILE *fp);
RT_LNK EIF_BOOLEAN file_feof(FILE *fp);
RT_LNK void file_pi(FILE *f, EIF_INTEGER number);
RT_LNK void file_pr(FILE *f, EIF_REAL_32 number);
RT_LNK void file_pib(FILE *f, EIF_INTEGER number);
RT_LNK void file_prb(FILE *f, EIF_REAL_32 number);
RT_LNK void file_ps(FILE *f, char *str, EIF_INTEGER len);
RT_LNK void file_pc(FILE *f, char c);
RT_LNK void file_pd(FILE *f, EIF_REAL_64 val);
RT_LNK void file_pdb(FILE *f, EIF_REAL_64 val);
RT_LNK void file_tnwl(FILE *f);
RT_LNK void file_append(FILE *f, FILE *other, EIF_INTEGER l);
RT_LNK void file_tnil(FILE *f);
RT_LNK EIF_INTEGER file_gi(FILE *f);
RT_LNK EIF_REAL_32 file_gr(FILE *f);
RT_LNK EIF_REAL_64 file_gd(FILE *f);
RT_LNK EIF_INTEGER file_gib(FILE *f);
RT_LNK EIF_REAL_32 file_grb(FILE *f);
RT_LNK EIF_REAL_64 file_gdb(FILE *f);
RT_LNK EIF_CHARACTER_8 file_gc(FILE *f);
RT_LNK EIF_INTEGER file_gs(FILE *f, char *s, EIF_INTEGER bound, EIF_INTEGER start);
RT_LNK EIF_INTEGER file_gss(FILE *f, char *s, EIF_INTEGER bound);
RT_LNK EIF_INTEGER file_gw(FILE *f, char *s, EIF_INTEGER bound, EIF_INTEGER start);
RT_LNK EIF_CHARACTER_8 file_lh(FILE *f);
RT_LNK void file_chown(char *name, int uid);
RT_LNK void file_chgrp(char *name, int gid);
RT_LNK void file_stat(char *path, rt_stat_buf *buf);
RT_LNK int eif_file_stat(char *path, rt_stat_buf *buf, int follow);
RT_LNK EIF_INTEGER file_info(rt_stat_buf *buf, int op);
RT_LNK EIF_BOOLEAN file_eaccess(rt_stat_buf *buf, int op);
RT_LNK EIF_BOOLEAN file_access(char *name, EIF_INTEGER op);
RT_LNK EIF_BOOLEAN file_exists(char *name);
RT_LNK EIF_BOOLEAN file_path_exists(char *name);
RT_LNK void file_rename(char *from, char *to);
RT_LNK void file_link(char *from, char *to);
RT_LNK void file_mkdir(char *path);
RT_LNK void file_unlink(char *name);
RT_LNK void file_touch(char *name);
RT_LNK void file_utime(char *name, time_t stamp, int how);
RT_LNK void file_perm(char *name, char *who, char *what, int flag);
RT_LNK void file_chmod(char *path, int mode);
RT_LNK EIF_INTEGER file_tell(FILE *f);
RT_LNK void file_go(FILE *f, EIF_INTEGER pos);
RT_LNK void file_recede(FILE *f, EIF_INTEGER pos);
RT_LNK void file_move(FILE *f, EIF_INTEGER pos);
RT_LNK EIF_INTEGER stat_size(void);
RT_LNK EIF_BOOLEAN file_creatable(char *path, EIF_INTEGER length);
RT_LNK EIF_INTEGER file_fd(FILE *f);
RT_LNK EIF_REFERENCE file_owner(int uid);
RT_LNK EIF_REFERENCE file_group(int gid);

RT_LNK EIF_POINTER eif_file_open_16(EIF_NATURAL_16 *name, int how);
RT_LNK EIF_POINTER eif_file_binary_open_16(EIF_NATURAL_16 *name, int how);
RT_LNK EIF_BOOLEAN eif_file_exists_16(EIF_NATURAL_16 *name);
RT_LNK EIF_BOOLEAN eif_file_path_exists_16(EIF_NATURAL_16 *name);
RT_LNK EIF_BOOLEAN eif_file_creatable_16(EIF_NATURAL_16 *path, EIF_INTEGER length);
#ifdef EIF_WINDOWS
RT_LNK int eif_file_stat_16(EIF_NATURAL_16 *path, rt_stat_buf *buf, int follow);
#endif
RT_LNK void eif_file_unlink_16(EIF_NATURAL_16 *name);
RT_LNK void eif_file_mkdir_16(EIF_NATURAL_16 *path);
RT_LNK void eif_file_rename_16(EIF_NATURAL_16 *from, EIF_NATURAL_16 *to);

#ifdef HAS_GETGROUPS
/* Does the list of groups the user belongs to include `gid'? */
extern EIF_BOOLEAN eif_group_in_list(int gid);
#endif

	/* FIXME: include the correct header files!!! */

#ifndef HAS_RENAME	/* %%zs added */
extern int rename(const char *from, const char *to);
#endif

#ifndef HAS_RMDIR
extern int rmdir(const char *path);
#endif

#ifndef HAS_MKDIR
extern int mkdir(char *path);
#endif

#ifdef __cplusplus
}
#endif

#endif
