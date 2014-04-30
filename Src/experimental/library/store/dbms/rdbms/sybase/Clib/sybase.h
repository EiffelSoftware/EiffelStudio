/*
--|----------------------------------------------------------------
--| EiffelStore: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1995, Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------

   Date: "$Date$";
   Revision: "$Revision$";
   Product: "EiffelStore";
   Database: "Sybase"
*/

#ifndef __SYBASE_H__ 
#define __SYBASE_H__ 

#ifdef __cplusplus
extern "C" {
#endif

/* Type macros */
#define EIF_C_UNKNOWN_TYPE		-1
#define EIF_C_NULL_TYPE			0
#define EIF_C_STRING_TYPE		1
#define EIF_C_WSTRING_TYPE		2
#define EIF_C_INTEGER_32_TYPE	3
#define EIF_C_INTEGER_16_TYPE	4
#define EIF_C_INTEGER_64_TYPE	5
#define EIF_C_DATE_TYPE			6
#define EIF_C_TIME_TYPE			7
#define EIF_C_REAL_32_TYPE		8
#define EIF_C_REAL_64_TYPE		9
#define EIF_C_BOOLEAN_TYPE		10
#define EIF_C_CHARACTER_TYPE	11
#define EIF_C_DECIMAL_TYPE		12

#define ERROR_MESSAGE_SIZE    250

/* Max descriptor available simultaneously */
#define MAX_DESCRIPTOR        (5+1)  /* 1 for internal use */
#define NO_MORE_DESCRIPTOR    (-1)

#define TXTLEN(x) 	(sqlstrlen((char *) x))

extern size_t sqlstrlen(const char *str);

extern void enomem ();
/* Raises an "Out of memory" exception
   From Eiffel run-time library */

#ifdef __cplusplus
}
#endif

#endif /* __SYBASE_H__ */
