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
   Database: "Ingres"
*/

#ifdef __cplusplus
extern "C" {
#endif

#define STRING_TYPE            10
#define CHARACTER_TYPE          2
/* Terry Tang changed the CHARACTER_TYPE from 3 to 2 */
#define INTEGER_TYPE            4
#define FLOAT_TYPE              6
#define REAL_TYPE 				5
#define BOOLEAN_TYPE            3
#define DATE_TYPE              11
#define UNKNOWN_TYPE            0

#define ERROR_MESSAGE_SIZE    450
#define WARN_MESSAGE_SIZE     450

/* Max descriptor available simultaneously */
#define MAX_DESCRIPTOR        (10) 
#define CURSOR_NAME_LEN       15 
#define NO_MORE_DESCRIPTOR    (-1)
#define NO_MORE_ROWS          100 

#define DB_ERROR				2
#define DB_DATE_LEN				26
#define DB_TOO_MANY_COL			3
#define DB_SIZEOF_CHAR 			sizeof(char)
#define DB_SIZEOF_SHORT			sizeof(short)
#define DB_SIZEOF_INT  			sizeof(int)
#define DB_SIZEOF_MONEY			sizeof(double)
#define DB_SIZEOF_REAL			sizeof(float)
#define DB_SIZEOF_DOUBLE 		sizeof(double)
#define DB_INGRES_NAME_LEN		34
#define DB_OUT_OF_INGRES_LIMIT	3000 
/* Ingres requires that the length of each field in a data base table is not longer*/
/* than 2000 byte.  So, we use this to indicate if a database field is DATE or     */
/* general string field(because Ingres also use string to express DATE to outside).*/


extern void enomem ();
/* Raises an "Out of memory" exception
   From Eiffel run-time library */


#define SetVarNum(desc, varSize) ((desc)->sqln = (varSize))
#define GetVarNum(desc) ((desc)->sqln)
#define SetColNum(desc, colNum) ((desc)->sqld = (colNum))
#define GetColNum(desc) ((desc)->sqld)
#define GetDbColType(daptr,i) ((((daptr)->sqlvar)[i]).sqltype)
#define GetDbColLength(daptr,i) ((((daptr)->sqlvar)[i]).sqllen)
#define GetDbColPtr(daptr,i) ((((daptr)->sqlvar)[i]).sqldata)


#ifdef __cplusplus
}
#endif
