/*--------------------------------------------------------------------*/
/*                                                                    */
/*  MICO/E --- a free CORBA implementation                            */
/*  Copyright (C) 1999 by Robert Switzer                              */
/*                                                                    */
/*  This library is free software; you can redistribute it and/or     */
/*  modify it under the terms of the GNU Library General Public       */
/*  License as published by the Free Software Foundation; either      */
/*  version 2 of the License, or (at your option) any later version.  */
/*                                                                    */
/*  This library is distributed in the hope that it will be useful,   */
/*  but WITHOUT ANY WARRANTY; without even the implied warranty of    */
/*  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU */
/*  Library General Public License for more details.                  */
/*                                                                    */
/*  You should have received a copy of the GNU Library General Public */
/*  License along with this library; if not, write to the Free        */
/*  Software Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.*/
/*                                                                    */
/*  Send comments and/or bug reports to:                              */
/*                 micoe@math.uni-goettingen.de                       */
/*                                                                    */
/*--------------------------------------------------------------------*/

#include <sys/types.h>
#include <sys/stat.h>
#include <sys/param.h>
#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>
#include <stdlib.h>
#include <dirent.h>
#include <string.h>
#include <errno.h>
#include <ctype.h>
#include <eif_portable.h>
#include <eif_hector.h>
#include <eif_macros.h>


static int select_directories(struct dirent* de);
static int select_files(struct dirent* de);
static char* working_directory(void);

static char*       path_cache = 0;
static struct stat buf_cache;
static char*       cwd = 0;

static struct dirent** namelist;
static int             nelts;
static int             crt_indx;

/**********************************************************/

void c_cluster_list(EIF_POINTER sptr)

{
    char* path = (char*) sptr;


    if (cwd != 0)
        free(cwd);
    cwd = strdup(working_directory());
    chdir (path);

    nelts    = scandir(path, &namelist, select_directories, alphasort);
    crt_indx = 0;
    chdir (cwd);

    if (nelts < 0)
        RTET("file_system.c_cluster_list: scandir failed", 24);
}

/**********************************************************/

EIF_POINTER c_next_name(void)

{
  if (namelist == 0 || crt_indx >= nelts)
      RTET("file_system.next_name", 24);

  return (EIF_POINTER) namelist[crt_indx++]->d_name;
}

/***********************************************************/

EIF_BOOLEAN c_more_names(void)

{
    EIF_BOOLEAN result = (EIF_BOOLEAN)((namelist != 0 && crt_indx < nelts) ? 1 : 0);

    if (!result && namelist != 0)
      free((char*)namelist);

    return result;
}
/**********************************************************/

void c_file_list(EIF_POINTER sptr)

{
    char* path = (char*) sptr;


    if (cwd != 0)
        free(cwd);
    cwd = strdup(working_directory ());
    chdir(path);

    nelts    = scandir(path, &namelist, select_files, alphasort);
    crt_indx = 0;
    chdir (cwd);

    if (nelts < 0)
        RTET("file_system.c_file_list: scandir failed", 24);
}
/********************************************************/

EIF_POINTER c_concat_paths(EIF_POINTER path1,EIF_POINTER path2)
{
    char* p1     = (char*) path1;
    char* p2     = (char*) path2;
    char* q;
    int   len;
    char* result = malloc(strlen(p1) + strlen(p2) + 2);

    p1  = strcpy(result, p1);
    len = strlen(p1);
    if (len >= 1 && p1[len - 1] == '/')
    {
        p1[len -1] = '\0';
        --len;
    }

    if (len >= 2 && p1[len - 2] == '.' && p1[len - 1] == '.')
    {                         /* hack off the last two components */
        if (q = strrchr (p1, '/'))
	{
            *q = '\0';
            if (q = strrchr (p1, '/'))
                *q = '\0';
        }
        else
            p1[len - 2] = '\0';

    }
    else if (len >= 1 && p1[len - 1] == '.')
    {                       /* hack off the last component */
        if (q = strrchr (p1, '/'))
            *q = '\0';
        else
            p1[len - 1] = '\0';
    }

    if (strlen(p1))
        strcat (result, "/");

    strcat (result, p2);
    return (EIF_POINTER) result;
}
/********************************************************/

static char result[MAXPATHLEN];

static void ParseComponent(char *p1, char *p2, char *result, char **q)
{
  if (p2 == p1 || (p2-p1 == 1 && *p1 == '.'))
  {
    /* "//" or "/./" => Do nothing. */
  }
  else if (p2-p1 == 2 && strncmp(p1, "..", 2) == 0)
  {
    /* "/../" => Chop off last component of result. */
    if (*q != result+1)
    {
      (*q)[-1] = '\0';
      *q = strrchr(result, '/') + 1;
      (*q)[0] = '\0';
    }
  }
  else
  {
    /* Just copy this component. */
    strncpy(*q, p1, p2-p1+1);
    *q += p2-p1+1;
    **q = '\0';
  }
}

EIF_POINTER c_absolute_path (EIF_POINTER path)
{
  char *p = (char*) path;
  char *p2;
  char *varbegin;
  char *var;
  char *env;
  char expanded[MAXPATHLEN];
  char *q = expanded;

  /* Expand environment variables. */
  while (*p != '\0')
  {
    switch (*p)
    {
    case '$':
      if (p[1] == '{')
      {
	/* Variable name is enclosed in brackets. */
	varbegin = p+2;
	if ((p = strchr(varbegin, '}')) == NULL)
	{
	  strcpy (result, 
		  "c_absolute_path: unbalanced bracket in variable name");
	  RTET(result, 24);
	}
	var = (char*) calloc(p-varbegin+1, 1);
	strncpy(var, varbegin, p-varbegin);
	p++;
      }
      else
      {
	/* Variable name ends with non alphanumeric character. */
	varbegin = p+1;
	for (p = varbegin; isalnum(*p) || *p == '_'; p++)
	  ;
	var = (char*) calloc(p-varbegin+1, 1);
	strncpy(var, varbegin, p-varbegin);
      }
      if ((env = getenv(var)) == NULL)
      {
	strcpy (result, "c_absolute_path: undefined environment variable ");
	strcat (result, var);
	free(var);
	RTET(result, 24);
      }
      free(var);
      strcpy(q, env);
      q += strlen(env);
      break;
    case '\\':
      /* Quoting. */
      if (*++p == '\0')
      {
	strcpy (result, 
		"c_absolute_path: quote character ('\\') at end of string");
	RTET(result, 24);
      }
      /* Fall into default case. */
    default:
      *q++ = *p++;
    }
  }
  *q = '\0';

  /* Add current working directory if path doesn't start with '/'. */
  if (expanded[0] != '/')
  {
    if (getcwd(result, MAXPATHLEN) == NULL)
    {
      strcpy(result, 
	     "c_absolute_path: unable to get current working directory");
      RTET(result, 24);
    }
    strcat(result, "/");
    p = expanded;
  }
  else
  {
    strcpy(result, "/");
    p = expanded + 1;
  }

  /* Add path components replacing '.' and '..'. q will always point to the
     terminating '\0' in result, behind the last '/'. */
  q = result + strlen(result);

  while ((p2 = strchr(p, '/')) != NULL)
  {
    ParseComponent(p, p2, result, &q);
    p = p2+1;
  }

  if (*p != '\0')
    ParseComponent(p, p + strlen(p), result, &q);

  return (EIF_POINTER) result;
}

/********************************************************/

/*
The next two functions are needed by c_cluster_list and
c_file_list. Beware of changing them!!
 */

static int select_directories(struct dirent* de)
{
    struct stat sbuf;

    stat(de->d_name, &sbuf);
    return (S_IFDIR & sbuf.st_mode);
}


/********************************************************/

static int select_files(struct dirent* de)
{
    struct stat sbuf;

    stat(de->d_name, &sbuf);
    return (S_IFREG & sbuf.st_mode);
}


/********************************************************/

static char buf[256];

static char* working_directory(void)
{
    int   fd[2];
    int   status, pid, w;
    char* end;

    if (pipe(fd) == -1)
        RTET("file_system.c_current_cluster: can't pipe", 0);

    if ((pid = fork()) == 0)
    {
        close(1); dup(fd[1]);
        execlp("/bin/sh", "sh", "-c", "pwd", (char*)0);
        exit(127); /* Something went wrong with execlp;      */
		   /* no point in raising an exception here  */
	           /* since we're in a separate process!     */
    }
    read(fd[0], buf, 256);

    end = strrchr(buf, '\n');

    if (end)
        *end = '\0';

    close(fd[0]); close(fd[1]);

    /* Don't leave orphans lying around */
    while ((w = wait(&status)) != pid && w != -1)
        ;
    if (status)
        RTET("Can't exec sh",0);

    return buf;
    
}


/********************************************************/

EIF_BOOLEAN c_exists(EIF_POINTER path)
{
    char* p = (char*)path;

/*
    if ((path_cache != 0) && (strcmp(p, path_cache) == 0))
        return 1;
*/

    if (stat(p, &buf_cache) != -1)
    {
/*
        if (path_cache != 0)
            free(path_cache);
        path_cache = strdup(p);
*/
        return 1;
    }

    return 0;
}

/********************************************************/

EIF_BOOLEAN c_has_readperm(EIF_POINTER path)
{
    uid_t euid = geteuid();
    gid_t egid = getegid();

    if (!c_exists(path))
        RTET("file_system.c_has_read_perm: file does not exist", 24);
    
    if (path_cache == 0)
    {
        path_cache = strdup((char*) path);
        if (stat(path_cache, &buf_cache) == -1)
            RTET("has_readperm : stat failed", 24);
    }

    if (euid == buf_cache.st_uid || euid == 0) /* I'm owner */
        return (buf_cache.st_mode & S_IRUSR) ? 1 : 0;
    else if (buf_cache.st_gid == egid)         /* I'm group */
        return (buf_cache.st_mode & S_IRGRP) ? 1 : 0;
    else                                       /* I'm world */
        return (buf_cache.st_mode & S_IROTH) ? 1 : 0;
}

/********************************************************/

EIF_BOOLEAN c_has_writeperm(EIF_POINTER path)
{
    uid_t euid = geteuid();
    gid_t egid = getegid();

    if (!c_exists(path))
        RTET("file_system.c_has_writeperm: file does not exist", 24);
    
    if (euid == buf_cache.st_uid || euid == 0) /* I'm owner */
        return (buf_cache.st_mode & S_IWUSR) ? 1 : 0;
    else if (buf_cache.st_gid == egid)         /* I'm group */
        return (buf_cache.st_mode & S_IWGRP) ? 1 : 0;
    else                                       /* I'm world */
        return (buf_cache.st_mode & S_IWOTH) ? 1 : 0;
}
/********************************************************/

EIF_BOOLEAN c_has_execperm(EIF_POINTER path)
{
    uid_t euid = geteuid();
    gid_t egid = getegid();

    if (!c_exists(path))
        RTET("file_system.c_has_execperm: file does not exist", 24);
    
    if (euid == buf_cache.st_uid || euid == 0) /* I'm owner */
        return (buf_cache.st_mode & S_IXUSR)? 1 : 0;
    else if (buf_cache.st_gid == egid)         /* I'm group */
        return (buf_cache.st_mode & S_IXGRP) ? 1 : 0;
    else                                       /* I'm world */
        return (buf_cache.st_mode & S_IXOTH) ? 1 : 0;
}/********************************************************/

EIF_BOOLEAN c_has_modperm(EIF_POINTER path)
{
    uid_t euid = geteuid();
    gid_t egid = getegid();
    char  buf[256];

    if (!c_exists(path))
    {
        sprintf(buf, "file_system.c_has_modperm: %s does not exist",
                (char*)path);
        RTET(buf, 24);
    }
    else if (!(buf_cache.st_mode & S_IFDIR))
    {
        sprintf(buf, "file_system.c_has_modperm: %s is not a directory",
                (char*)path);
        RTET(buf, 24);
    }
    
    if (euid == buf_cache.st_uid || euid == 0) /* I'm owner */
        return (buf_cache.st_mode & S_IWUSR)? 1 : 0;
    else if (buf_cache.st_gid == egid)         /* I'm group */
        return (buf_cache.st_mode & S_IWGRP) ? 1 : 0;
    else                                       /* I'm world */
        return (buf_cache.st_mode & S_IWOTH)? 1 : 0;
}
/********************************************************/

EIF_BOOLEAN c_has_listperm(EIF_POINTER path)
{
    uid_t euid = geteuid();
    gid_t egid = getegid();

    if (!c_exists(path) || !(buf_cache.st_mode & S_IFDIR))
        RTET("file_system.c_has_list_perm: directory does not exist", 24);
    
    if (euid == buf_cache.st_uid || euid == 0) /* I'm owner */
        return (buf_cache.st_mode & S_IXUSR)? 1 : 0;
    else if (buf_cache.st_gid == egid)         /* I'm group */
        return (buf_cache.st_mode & S_IXGRP)? 1 : 0;
    else                                       /* I'm world */
        return (buf_cache.st_mode & S_IXOTH)? 1 : 0;
}


/********************************************************/

EIF_POINTER c_current_cluster(void)
{
    if (cwd == 0)
        cwd = strdup (working_directory());

    return (EIF_POINTER) cwd;
}

/********************************************************/

void c_change_cluster(EIF_POINTER path)
{
    char* p = (char*) path;

    if (chdir(p) == -1)
    {
        switch (errno)
	{
        case ENOENT:
            RTET("c_change_cluster : The directory does not exist", 24);
            break;
        case EACCES:
        case EPERM :
            RTET("c_change_cluster : You don't have permission", 24);
            break;
        default:
            RTET("c_change_cluster : Some obscure error", 24);
            break;
        }
    }
    cwd = strdup(p);
}
/********************************************************/

EIF_POINTER c_path_prefix(EIF_POINTER path)
{
    char* p1 = (char*) path;
    char* p2 = strdup(p1);
    char* q = strrchr(p2, '/');
 
    if (q != 0)
        *q = '\0';
    else
    {
        free (p2);
        p2 = ".";
    }
    return (EIF_POINTER) p2;
}

/********************************************************/

EIF_POINTER c_path_suffix(EIF_POINTER path)
{
    char* p1 = (char*) path;
    char* q  = strrchr(p1, '/');
 
    if (q)
        return (EIF_POINTER) (q + 1);
    else
        return (EIF_POINTER) p1;
}

/********************************************************/

static char* p1;
static char* p2;
static char* p3;

static int parse_perms(char*);

/********************************************************/

void c_add_cluster(EIF_POINTER path, EIF_POINTER perms)

{
    char  cmd[256];
    int   perm = S_IXUSR | S_IXGRP | S_IXOTH; /* These are needed in any case. */
    char* cp   = strdup ((char*)perms);
    int   cnt  = parse_perms(cp);

    sprintf(cmd, "mkdir %s", (char*) path);

    if (system(cmd) != 0)
        RTET("c_add_cluster failed", 24);

    if (cnt > 0)
    {
         if (p1[0] == 'l')
             perm |= S_IRUSR;

         if (p1[0] == 'm' || p1[1] == 'm')
            perm |= S_IWUSR;
    }

    if (cnt > 1)
    {
        if (p2[0] == 'l')
           perm |= S_IRGRP;

        if (p2[0] =='m' || p2[1] == 'm')
           perm |= S_IWGRP;
    }

    if (cnt > 2)
    {
        if (p3[0] == 'l')
           perm |= S_IROTH;

        if (p3[0] == 'm' || p3[1] == 'm')
           perm |= S_IWOTH;
    }

    free (cp);

    sprintf(cmd, "chmod %o %s", perm, (char*) path);

    if (system(cmd) != 0)
    {
        sprintf(cmd, "c_add_cluster failed: %s", strerror(errno));
        RTET(cmd, 24);
    }
}

/********************************************************/


void c_add_file(EIF_POINTER path, EIF_POINTER perms)

{
    int   perm = 0;
    char* cp   = strdup ((char*) perms);
    int   cnt  = parse_perms(cp);     
    int   len;
    int   fd;
    char  msg[256];

    if (cnt > 0)
    {
         len = strlen(p1);

         if (p1[0] == 'r')
             perm |= S_IRUSR;
         
         if (p1[0] == 'w' || p1[1] == 'w')
            perm |= S_IWUSR;

         if (p1[0] == 'x' || p1[1] == 'x' || (len >= 2 && p1[2] == 'x'))
            perm |= S_IXUSR;
    }

    if (cnt > 1)
    {
        len = strlen(p2);

        if (p2[0] == 'r')
            perm |= S_IRGRP;

        if (p2[0] =='w' || p2[1] =='w')
            perm |= S_IWGRP;

        if (p2[0] == 'x' || p2[1] == 'x' || (len >= 2 && p2[2] == 'x'))
            perm |= S_IXGRP; 
    }

    if (cnt > 2)
    {
        len = strlen(p3);

        if (p3[0] == 'r')
            perm |= S_IROTH;

        if (p3[0] == 'w' || p3[1] == 'w')
            perm |= S_IWOTH;

        if (p3[0] == 'x' || p3[1] == 'x' || (len >= 2 && p3[2] == 'x'))
            perm |= S_IXOTH;
    }

    free (cp);

    if ((fd = creat ((char*) path, perm)) == -1)
    {
        sprintf(msg, "c_add_file: %s", strerror(errno));
        RTET(msg, 24);
    }
    else
        close(fd);
}

/**********************************************************/

static int parse_perms(char* p)

{
    int result = 1;
    p1 = p;

    while (*p)
    {
        if (*p == '.')
	{
	    ++result;
            *p = '\0';

            if (result == 2)
                p2 = p + 1;
            else if (result == 3)
	    {
                p3 = p + 1;
                break;
            }
        }
        ++p;
    }

    return result;
}

/**********************************************************/

void c_remove_cluster(EIF_POINTER path)

{
    char cmd[256];

    sprintf(cmd, "rmdir %s", (char*) path);

    if (system(cmd) != 0)
        RTET("c_remove_cluster failed", 24);
}

/**********************************************************/

void c_remove_file(EIF_POINTER path)

{
    if (unlink((char*) path) != 0)
        RTET("c_remove_file failed", 24);
}

/**********************************************************/

EIF_INTEGER c_cluster_count(EIF_POINTER path)

{
    int             nfiles;
    struct dirent** namelist;

    nfiles = scandir(path, &namelist, select_files, alphasort);

    if (nfiles == -1)
        RTET("c_cluster_count failed", 24);

    free((char*)namelist);
    return nfiles;
}
/**********************************************************/

EIF_INTEGER c_subcluster_count(EIF_POINTER path)

{
    int             ndirs;
    struct dirent** namelist;

    ndirs = scandir(path, &namelist, select_directories, alphasort);

    if (ndirs == -1)
        RTET("c_subcluster_count failed", 24);

    free((char*)namelist);
    return ndirs;
}

/**********************************************************/

EIF_POINTER c_temp_file (void)

{
    char* result = tmpnam((char*) 0);

    if (result == (char*)0)
        RTET("file_system.temp_file : tmpnam failed", 24);
    else
        return (EIF_POINTER) result;
}











