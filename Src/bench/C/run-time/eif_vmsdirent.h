/*
	description: "[
			Header file for VMS readdir() routines.
			Written by Rich $alz, <rsalz@bbn.com> in August, 1990.
			This code has no copyright.
			You must #include <descrip.h> before this file.
			12-NOV-1990 added d_namlen field -GJC@MITECH.COM
			]"
	date:		"$Date$"
	revision:	"$Revision$"
*/

#ifndef _eif_vmsdirent_h_
#define _eif_vmsdirent_h_

#ifdef __cplusplus
extern "C" {
#endif

    /* Data structure returned by READDIR(). */
struct dirent {
    char	d_name[100];		/* File name		*/
    int         d_namlen;
    int		vms_verscount;		/* Number of versions	*/
    int		vms_versions[20];	/* Version numbers	*/
};

    /* Handle returned by opendir(), used by the other routines.  You
     * are not supposed to care what's inside this structure. */
typedef struct _dirdesc {
    unsigned int		context;
    int				vms_wantversions;
    char			*pattern;
    struct dirent		entry;
    struct dsc$descriptor_s	pat;
} DIR;


#define rewinddir(dirp)		seekdir((dirp), 0L)


extern DIR		*opendir(char *name);
extern struct dirent	*readdir(DIR *dd);
extern long		telldir(DIR *dd);
extern void		seekdir(DIR *dd, long pos);
extern void		closedir(DIR *dd);
extern void		vmsreaddirversions(DIR *dd, int flag);

#ifdef __cplusplus
}
#endif

#endif /* _eif_vmsdirent_h_ */
