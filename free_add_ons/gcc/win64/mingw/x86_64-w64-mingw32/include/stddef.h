/**
 * This file has no copyright assigned and is placed in the Public Domain.
 * This file is part of the w64 mingw-runtime package.
 * No warranty is given; refer to the file DISCLAIMER.PD within this package.
 */

#include <_mingw.h>

#ifndef _INC_STDDEF
#define _INC_STDDEF

#ifdef __cplusplus
extern "C" {
#endif

#ifndef _CRT_ERRNO_DEFINED
#define _CRT_ERRNO_DEFINED
  _CRTIMP extern int *__cdecl _errno(void);
#define errno (*_errno())
  errno_t __cdecl _set_errno(int _Value);
  errno_t __cdecl _get_errno(int *_Value);
#endif /* _CRT_ERRNO_DEFINED */

  _CRTIMP extern unsigned long __cdecl __threadid(void);
#define _threadid (__threadid())
  _CRTIMP extern uintptr_t __cdecl __threadhandle(void);

#ifdef __cplusplus
}
#endif

#endif /* _INC_STDDEF */

