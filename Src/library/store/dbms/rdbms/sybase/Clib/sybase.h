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

#define STRING_TYPE            10
#define CHARACTER_TYPE          4
#define INTEGER_TYPE            4
#define FLOAT_TYPE              5
#define REAL_TYPE 		6
#define BOOLEAN_TYPE            3
#define DATE_TYPE              11
#define UNKNOWN_TYPE            0

#define ERROR_MESSAGE_SIZE    250

/* Max descriptor available simultaneously */
#define MAX_DESCRIPTOR        (5+1)  /* 1 for internal use */
#define NO_MORE_DESCRIPTOR    (-1)

extern void enomem ();
/* Raises an "Out of memory" exception
   From Eiffel run-time library */

#ifdef __cplusplus
}
#endif

#endif /* __SYBASE_H__ */
