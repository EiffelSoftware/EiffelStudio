/* 
	filename:	"eif_vmsdef.h"
	description: "OpenVMS platform specific definitions"
	date:		"$Date$"
	revision:	"$Revision$"
	copyright:	"Copyright (c) 1985-2006, Eiffel Software."
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:  "Commercial license is available at http://www.eiffel.com/licensing"
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

/*
    This file is included by eif_portable.h
    It contains VMS platform-specific definitions for calling VMS system
    services and runtime library routines, and for dealing with 64 bit pointers. 
    It also contains definitions for VMS-specific Eiffel runtime abstractions
    that don't neeed to be defined earlier in eif_portable.h

*/


#ifndef _eif_vmsdef_h_
#define _eif_vmsdef_h_
#ifdef EIF_VMS	    /* scope: rest of this file */

/* Standard C includes */
#include <assert.h>
#include <dirent.h>
#include <stddef.h>
#include <string.h>
#include <unistd.h>
#include <unixlib.h>
#include <unixio.h>

/* VMS system specific includes */
#include <descrip.h>
#include <starlet_bigpage.h>	// for $is32_bits
#include <iledef.h>		// itemlist definitions (ILE3, ILEB_64)



/*** Definitions ***/


#ifdef HAS_TIMES
#define HZ  100   	/* seconds in units (10 millisecs) for times() */
#endif

#if !defined(FILENAME_MAX) || FILENAME_MAX < 4095
#undef  FILENAME_MAX	    /* override default 256, too small */
#define FILENAME_MAX 4095   /* == NAML$C_MAXRSS */
#endif 

/* This is usually defined in config.h; we define it correctly here. */
#undef PAGESIZE_VALUE
#if defined(__vax)
#define PAGESIZE_VALUE 512
#elif defined(__Alpha_AXP)
/* For Alpha, this is actually implementation-defined, and should be */
/* determined at runtime,  but this will have to do for now.  */
#define PAGESIZE_VALUE 8192
#else
    undefined architecture
#endif /* __vax */

typedef unsigned long VMS_STS;		/* VMS status (condition) value */
/*typedef struct _generic_64 vms_bintim;	/* VMS binary time (8 bytes) */

/* Macros to test for VMS-style (low bit) success/failure. */
#define  VMS_SUCCESS(x)	 (     (x) & 1   )
#define  VMS_FAILURE(x)  ( ! ( (x) & 1 ) )



/* Macros (and typedefs) for dealing with descriptors and itemlists.	*/
/* (Most are not portable because of aggregate initialization).  */
//#pragma message disable (NEEDCONSTEXT,ADDRCONSTEXT)	/* ignore non-constant address warnings (DECC extension) */
#pragma message enable (MAYHIDELOSS)	/* enable pointer cast warnings */

#if __INITIAL_POINTER_SIZE
#pragma __pointer_size __save
#pragma __pointer_size 32
#endif

/* 32 bit specific definitions */
typedef void* void_ptr32;
typedef char* char_ptr32;
typedef struct dsc$descriptor DX32;		/* 32 bit descriptor type */
#define DX32_INIT(siz,ptr,typ,class)	siz, typ,class, ptr
/* declare/initialize descriptor d with several flavours */
#define DX32_BUF(d,buf)	    DX32 d = { DX32_INIT(sizeof(buf), buf, DSC$K_DTYPE_T, DSC$K_CLASS_S) }
#define DX32_BLD(d,ptr,len) DX32 d = { DX32_INIT(len, ptr, DSC$K_DTYPE_T, DSC$K_CLASS_S) }
//**tbs** #define DX_STR(d,ptr)	    DX d = { strlen(ptr), DSC$K_DTYPE_T, DSC$K_CLASS_S, ptr }
//**tbs** #define DX_STRLIT(d,ptr) DX d = { sizeof(ptr)-1, DSC$K_DTYPE_T, DSC$K_CLASS_S, ptr }
//**tbs** #define DX_DYN(d) DX d = { 0, DSC$K_DTYPE_T, DSC$K_CLASS_D, 0 }
//**tbs** #define DX_ATOMIC(d,var,dtyp) DX d = { sizeof(var), dtyp, DSC$K_CLASS_S, &(var) }

/* itemlist entry for VMS system calls (32 bit flavor) */
typedef ILE3 ITEM_LIST_3[];
#define ITEM_3(code,ptr,siz,rlen)	{ siz, code, ptr, rlen }
#define ITEM_LIST_3_END			{ 0,0,0,0 }



#if __INITIAL_POINTER_SIZE  
#pragma __pointer_size 64

/* 64 bit specific definitions */
typedef void* void_ptr64;
typedef char* char_ptr64;
typedef struct dsc64$descriptor DX64;	/* 64 bit descriptor type */
#define DX64_INIT(siz,ptr,typ,class)	1, typ,class, -1, (siz), ((void*)(ptr))
#define DX64_BUF(d,buf)	    DX64 d = { DX64_INIT(sizeof(buf), buf, DSC$K_DTYPE_T, DSC$K_CLASS_S) }
#define DX64_BLD(d,ptr,len) DX64 d = { DX64_INIT(len, ptr, DSC$K_DTYPE_T, DSC$K_CLASS_S) }

/* access to descriptor fields */
#define DX_LEN(dx) ( $is_desc64(&(dx)) ? ((DX64*)&(dx))->dsc64$q_length : ((DX32*)&(dx))->dsc$w_length )
#define DX_PTR(dx) ( $is_desc64(&(dx)) ? ((DX64*)&(dx))->dsc64$pq_pointer : ((DX32*)&(dx))->dsc$a_pointer )

/* set a descriptor to given pointer p, length l */
#define DX_SET(dx,p,l)  if ($is_desc64(&(dx))) { ((DX64*)&(dx))->dsc64$q_length = (l); ((DX64*)&(dx))->dsc64$pq_pointer = (p); } \
 else { ((DX32*)&(dx))->dsc$w_length = (l); assert ($is_32bits(p)); ((DX32*)&(dx))->dsc$a_pointer = (__void_ptr32)(p); }
/* set a descriptor to string s */
//#define DX_SETSTR(dx,s)  DX_SET (dx,s,strlen(s))
#ifdef moose
#define DX_SETSTR(dx,s)  if ($is_desc64(&(dx))) { ((DX64*)&(dx))->dsc64$q_length = strlen ( ((DX64*)&(dx))->dsc64$pq_pointer = (s) ); } \
 else { assert ($is_32bits(s)); ((DX32*)&(dx))->dsc$w_length = strlen ( ((DX32*)&(dx))->dsc$a_pointer = (__void_ptr32)(s) ); }
#else
#define DX_SETSTR(dx,s)  if ($is_desc64(&(dx))) { (dx).dsc64$q_length = strlen ( (dx).dsc64$pq_pointer = (s) ); } \
 else { assert ($is_32bits(s)); ((DX32*)&(dx))->dsc$w_length = strlen ( ((DX32*)&(dx))->dsc$a_pointer = (__void_ptr32)(s) ); }
#endif

/* set descriptor length to l */
#define DX_SETLEN(dx,l)  if ($is_desc64(&(dx))) { ((DX64*)&(dx))->dsc64$q_length = (l); } else { ((DX32*)&(dx))->dsc$w_length = (l); }
/* set descriptor pointer to p */
#define DX_SETPTR(dx,p)  if ($is_desc64(&(dx))) { ((DX64*)&(dx))->dsc64$pq_pointer = (p); } \
 else { assert ($is_32bits(p)); ((DX32*)&(dx))->dsc$a_pointer = (__void_ptr32)(p); }

/* default: 64 bit descriptors */
typedef DX64  DX;
#define DX_BUF(d,buf)	    DX64_BUF(d,buf)
#define DX_BLD(d,ptr,len)   DX64_BLD(d,ptr,len)

/* itemlist entry for VMS system calls (64 bit flavor) */
typedef ILEB_64 ITEM_LIST_64B[];
#define ITEM_64B(code,ptr,siz,rlen)	{ 1, (code), -1, (siz), (ptr), (rlen) }
#define ITEM_LIST_64B_END		{ 0,0,0,0,0,0 }

/* default: 64 bit itemlist */
typedef ITEM_LIST_64B	ITEM_LIST;
typedef unsigned __int64 ile_retlen_t;		/* type of returned length (see <iledef.h> struct _ileb_64) */
#define ITEM_LIST_ENTRY ITEM_64B
#define ITEM_LIST_END	ITEM_LIST_64B_END
#define ITEM_CODE	ileb_64$w_code;		/* Item code value		    */
#define ITEM_BUFLEN	ileb_64$q_length;	/* Length of buffer in bytes	    */
#define ITEM_BUFADR	ileb_64$pq_bufaddr;	/* Buffer address		    */
#define ITEM_RETLENADR	ileb_64$pq_retlen_addr; /* Address of quadword for returned length */

#endif /* __INITIAL_POINTER_SIZE (end 64 bit specific definitions) */


#if __INITIAL_POINTER_SIZE

#pragma __pointer_size __restore

#else  /* __INITIAL_POINTER_SIZE */

/* default: 32 bit descriptors */
typedef DX32  DX;
#define DX_BUF(d,buf)	    DX32_BUF (d,buf)	    //DX d = { DX32_INIT(sizeof(buf), buf, DSC$K_DTYPE_T, DSC$K_CLASS_S) }
#define DX_BLD(d,ptr,len)   DX32_BLD (d,ptr,len)    //DX d = { DX32_INIT(len, ptr, DSC$K_DTYPE_T, DSC$K_CLASS_S) }

/* access to descriptor fields */
#define DX_LEN(d) ( (d).dsc$w_length )
#define DX_PTR(d) ( (d).dsc$a_pointer )

/* set a descriptor to given pointer p, length l */
#define DX_SET(dx,p,l)  { ((DX32*)&(dx))->dsc$w_length = (l); ((DX32*)&(dx))->dsc$a_pointer = (__void_ptr32)(p); }
/* set a descriptor to string s */
//#define DX_SETSTR(dx,s)  DX_SET (dx, s, strlen(s))
#define DX_SETSTR(dx,s)  { (dx).dsc$w_length = strlen ( (dx).dsc$a_pointer = (s) ); }
/* set descriptor length to l */
#define DX_SETLEN(dx,l)  ((DX32*)&(dx))->dsc$w_length = (l)
/* set descriptor pointer to p */
#define DX_SETPTR(dx,p)  ((DX32*)&(dx))->dsc$a_pointer = (__void_ptr32)(p)

/* default: 32 bit itemlist */
typedef ITEM_LIST_3  ITEM_LIST;
typedef unsigned short int ile_retlen_t;	/* type of returned length (see <iledef.h> struct _ile3) */
#define ITEM_LIST_ENTRY  ITEM_3
#define ITEM_LIST_END ITEM_LIST_3_END
#define ITEM_CODE	ile3$w_code;		/* Item code value		    */
#define ITEM_BUFLEN	ile3$w_length;		/* Length of buffer in bytes	    */
#define ITEM_BUFADR	ile3$ps_bufaddr;	/* Buffer address		    */
#define ITEM_RETLENADR	ile3$ps_retlen_addr;	/* Address of word for returned length */

#endif /* __INITIAL_POINTER_SIZE */


/* macros for building scalar and array item list entries */
#define ITEM_S(code,ident,rlen)	ITEM_LIST_ENTRY(code, &ident, sizeof(ident), rlen )
#define ITEM_A(code,array,rlen)	ITEM_LIST_ENTRY(code, array,  sizeof(array), rlen )



/* Definitions for VMS jacket routines */
#define getenv eifrt_vms_getenv
#define putenv eifrt_vms_putenv
#define setenv eifrt_vms_setenv
//#define strdup eifrt_vms_strdup



/*** Forward references ***/


/*** VMS C runtime library ***/
__char_ptr32 DECC$GETENV (const char *name) ;	/* nicked from VMS unixlib.h */

/*** VMS specific abstractions/jackets used in runtime ***/
RT_LNK pid_t eifrt_vms_fork_jacket (void) ;
RT_LNK char* eifrt_vms_getenv (const char* nam) ; 
RT_LNK int eifrt_vms_putenv (const char* str) ;
RT_LNK int eifrt_vms_setenv (const char* nam, const char*val, int overwrite) ;

RT_LNK size_t eifrt_vms_dirname_len (const char* path) ;
RT_LNK int eifrt_vms_spawn (const char* cmd, int flags) ;
RT_LNK const char* eifrt_vms_imagename (char* buf, size_t bufsiz) ;
RT_LNK const char* eifrt_vms_get_progname (char* buf, size_t bufsiz) ;
RT_LNK int   eifrt_vms_has_path_terminator (const char* path) ;
RT_LNK void  eifrt_vms_append_file_name (char* path, const char* file) ;
RT_LNK char* eifrt_vms_filespec (const char* filespec, char* buf) ;
RT_LNK char* eifrt_vms_pathspec (const char* filespec, char* buf) ;
RT_LNK char* eifrt_vms_directory_file_name (const char* dir, char* buf) ;

#ifdef EIF_VMS_V6_ONLY
RT_LNK char * dir_dot_dir (char * dir) ;
#endif

RT_LNK int eifrt_is_vms_filespec (const char* p) ;

extern const char eifrt_vms_path_terminators[], eifrt_vms_path_delimiters[];
extern const char eifrt_vms_valid_filename_chars[];



/* flags for eifrt_vms_spawn */
#define EIFRT_VMS_SPAWN_FLAG_ASYNC	    1
#define EIFRT_VMS_SPAWN_FLAG_NOWAIT	    1
#define EIFRT_VMS_SPAWN_FLAG_TRANSLATE	    2
#define EIFRT_VMS_SPAWN_FLAG_ECHO	    4
#define EIFRT_VMS_SPAWN_FLAG_SET_MELT_PATH  8	/* reserved */
#define EIFRT_VMS_SPAWN_FLAG_UNTRUSTED	    128



//#ifdef moose /* this was needed in prior versions of Eiffel compiler */
#pragma message disable EXTRASEMI  	// disable extraneous semicolon messages (in generated [.E?]epoly*.c modules) 
//#endif


#endif /* EIF_VMS        */
#endif /* _eif_vmsdef_h_ */
