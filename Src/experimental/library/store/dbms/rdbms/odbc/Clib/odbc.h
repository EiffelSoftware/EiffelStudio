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
   Database: "ODBC"
*/

#ifndef _EIFFEL_ODBC_H_
#define _EIFFEL_ODBC_H_

#ifdef __cplusplus
extern "C" {
#endif

#include <sql.h>
#include <sqlext.h>

/* Macro for memory allocation */
#define ODBC_SAFE_ALLOC(x,function)	\
	x = function; \
		if (x == NULL) \
				enomem()

#define ODBC_C_FREE(x) if(x)free(x)

#ifndef SQL_IC_UNKNOWN
#define SQL_IC_UNKNOWN	0
#endif

/* the following are EIFFEL DATATYPEs supported by EiffelStore on ODBC */
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

/* the following are some lengthes' definitions */
#define MAX_DESCRIPTOR        100  /* Max descriptor available simultaneously */

#define NO_MORE_ROWS          100 /* No more row is fetched by FETCH operation */

/* the following are some ERROR codes */
#define NO_MORE_DESCRIPTOR    			(-1)
#define DB_ERROR                                2
#define DB_SQL_INVALID_HANDLE                   3
#define DB_SQL_ERROR                            4
#define DB_TOO_MANY_COL                 	5

/* the following are lengthes of some data types in EiffelStore on ODBC */
#define DB_MAX_NAME_LEN                 	80
#define DB_MAX_COLS                             300
// Added by David
//#define DB_MAX_STRING_LEN			254
#define DB_MAX_STRING_LEN			1024
#define DB_QUOTER_LEN				5
#define DB_NAME_SEP_LEN				5
#define DB_MAX_QUALIFIER_LEN			150
#define DB_MAX_USER_NAME_LEN			50
#define DB_SIZEOF_CHAR                  sizeof(SQL_CHAR)
#define DB_SIZEOF_WCHAR                  sizeof(SQL_WCHAR)
#define DB_SIZEOF_SHORT                 sizeof(short)
#define DB_SIZEOF_INT                   sizeof(int)
#define DB_SIZEOF_LONG                  sizeof(long)
#define DB_SIZEOF_UDWORD				sizeof(UDWORD)
#define DB_SIZEOF_BIGINT				sizeof (EIF_INTEGER_64)
#define DB_SIZEOF_MONEY                 sizeof(double)
#define DB_SIZEOF_REAL                  sizeof(float)
#define DB_SIZEOF_DOUBLE                sizeof(double)
#define DB_SIZEOF_DATE					sizeof(TIMESTAMP_STRUCT)
// Added by Jacques
#define DB_REP_LEN					128+1

/* the following are some flags  */
#define ODBC_SQL                0
#define ODBC_CATALOG_COL        1
#define ODBC_CATALOG_TAB        2
#define ODBC_CATALOG_PROC       3
#define ODBC_PK					4
#define ODBC_FK					5
#define ODBC_TIME				0
#define ODBC_DATE				1
#define ODBC_TIMESTAMP			2


/* Raises an "Out of memory" exception
   From Eiffel run-time library */

/* the following are some MACRO used to access the DESCRIPTOR of a SQL statement, */
/* which is described below */
#define SetVarNum(desc, varSize) ((desc)->sqln = (varSize))
#define GetVarNum(desc) ((desc)->sqln)
#define SetColNum(desc, colNum) ((desc)->sqld = (colNum))
#define GetColNum(desc) ((desc)->sqld)
#define GetDbColType(daptr,i) ((((daptr)->sqlvar)[i]).sqltype)
#define GetDbCType(daptr, i)  ((((daptr)->sqlvar)[i]).c_type)
#define GetDbColLength(daptr,i) ((((daptr)->sqlvar)[i]).sqllen)
#define SetDbColLength(daptr,i, length) ((((daptr)->sqlvar)[i]).sqllen = (length))
#define GetDbColPtr(daptr,i) ((((daptr)->sqlvar)[i]).sqldata)
#define SetDbColPtr(daptr,i,ptr) ((((daptr)->sqlvar)[i]).sqldata = (ptr))

/*
 * String type with count
 */
typedef struct countable_string_ {
	SQLTCHAR *string;
	size_t char_count;	/* Size in character */
	size_t capacity;	/* Capacity in character */
} COUNTABLE_STRING;

/*
**  Description:
**      The SQLDA is a structure for holding data descriptions, used by
**      EiffelStore on ODBC run-time system during execution of
**      dynamic SQL statements.
**
**  Defines:
**      ODBCSQLDA_TYPE    - Macro to declare type or variable for SQLDA.
**      ODBCSQLDA         - Actual SQLDA typedef that programs use.
**      Constants and type codes required for using the SQLDA.
**
*/

/*
** IISQLVAR - Single Element of SQLDA variable as described in manual.
*/
typedef struct sqlvar_ {
	SQLSMALLINT sqltype;
	SQLSMALLINT c_type;
	SQLULEN	sqllen;
	char    *sqldata;
	COUNTABLE_STRING sqlname;
} IISQLVAR;

/*
** ODBCSQLDA_TYPE - Macro that declares an SQLDA structure object (typedef or
**                variable) with tag 'sq_struct_tag' and object name
** 'sq_sqlda_name'.  The number of SQLDA variables is specified by
** 'sq_num_vars'.  The SQLDA structure object is defined in the manual.
**
**
** Usage Example:
**      static ODBCSQLDA_TYPE(small_sq_, small_sqlda, 10);
**              Declares a static variable (small_sqlda) with 10 vars.
**
**      typedef ODBCSQLDA_TYPE(xsq_, MY_SQLDA, 50);
**              Defines a type (MY_SQLDA) with 50 vars.
*/

# define        ODBCSQLDA_TYPE(sq_struct_tag, sq_sqlda_name, sq_num_vars) \
						\
    struct sq_struct_tag {                      \
	char            sqldaid[8];             \
	int             sqldabc;                \
	SQLUSMALLINT	sqln;                   \
	SQLSMALLINT           sqld;                   \
	IISQLVAR        sqlvar[sq_num_vars];    \
    } sq_sqlda_name


/*
** ODBCSQLDA - Type needed for generic SQLDA allocation and processing.
*/
# define        IISQ_MAX_COLS   300

typedef ODBCSQLDA_TYPE(sqda_, ODBCSQLDA, IISQ_MAX_COLS);

/*
** Allocation sizes - When allocating an SQLDA for the size use:
**              IISQDA_HEAD_SIZE + (N * IISQDA_VAR_SIZE)
*/
# define        IISQDA_HEAD_SIZE        16
# define        IISQDA_VAR_SIZE         sizeof(IISQLVAR)

#define TXTLEN(x) 	(sqlstrlen((SQLTCHAR *) x))

/*
 * Specific constants for SQL Server (usually included in sqlncli.h)
 * If SQL_SS_LENGTH_UNLIMITED is not defined, then none of the others are.
 */
#ifndef SQL_SS_LENGTH_UNLIMITED
/* SQL_SS_LENGTH_UNLIMITED is used to describe the max length of
 * VARCHAR(max), VARBINARY(max), NVARCHAR(max), and XML columns
 */
#define SQL_SS_LENGTH_UNLIMITED             0
/* Driver specific SQL data type defines.
 * Microsoft has -150 thru -199 reserved for Microsoft SQL Server
 * Native Client driver usage.
 */
#define SQL_SS_VARIANT                      (-150)
#define SQL_SS_UDT                          (-151)
#define SQL_SS_XML                          (-152)
#define SQL_SS_TABLE                        (-153)
#define SQL_SS_TIME2                        (-154)
#define SQL_SS_TIMESTAMPOFFSET              (-155)
#endif

extern size_t sqlstrlen(const SQLTCHAR *str);

extern void *c_odbc_make (int m_size);
extern int odbc_new_descriptor (void *con);
extern int odbc_available_descriptor (void *con);
extern int odbc_max_descriptor ();
extern void odbc_pre_immediate(void *con, int no_desc, int argNum);
extern void odbc_exec_immediate (void *con, int no_desc, SQLTCHAR *order, int order_count);
extern void odbc_init_order (void *con, int no_desc, SQLTCHAR *order, int order_count, int argNum);
extern void odbc_start_order (void *con, int no_desc);
extern void odbc_terminate_order (void *con, int no_des);
extern void odbc_close_cursor (void *con, int no_des);
extern int odbc_next_row (void *con, int no_des);
extern int odbc_support_proc();
extern SQLTCHAR *odbc_procedure_term (void *con);
extern int odbc_support_information_schema();
extern SQLTCHAR * odbc_driver_name();
extern int odbc_insensitive_upper();
extern int odbc_insensitive_lower();
extern int odbc_sensitive_mixed();
extern int odbc_insensitive_mixed();
extern void odbc_set_parameter(void *con, int no_desc, int seri, int dir, int eifType, int collen, int value_count, void *value);
extern SQLTCHAR *odbc_hide_qualifier(SQLTCHAR *buf, int char_count);
extern void odbc_unhide_qualifier(SQLTCHAR *buf, int char_count);
extern SQLTCHAR *odbc_identifier_quoter();
extern SQLTCHAR *odbc_qualifier_separator();
extern void odbc_set_qualifier(void *con, SQLTCHAR *qfy, int len);
extern void odbc_set_owner(void *con, SQLTCHAR *owner, int len);
extern void odbc_connect (void *con, SQLTCHAR *name, int name_count, SQLTCHAR *passwd, int passwd_count, SQLTCHAR *dsn, int dsn_count);
extern void odbc_connect_by_connection_string (void *con, SQLTCHAR *a_string, int str_count);
extern void odbc_disconnect (void *con);
extern void odbc_rollback (void *con);
extern void odbc_commit (void *con);
extern void odbc_begin (void *con);
extern int odbc_trancount (void *con);
extern int odbc_get_count (void *con, int no_des);
extern SQLTCHAR *odbc_col_name (void *con, int no_des, int index);
extern size_t odbc_col_name_len (void *con, int no_des, int index);
extern SQLULEN odbc_get_col_len (void *con, int no_des, int index);
extern SQLULEN odbc_get_data_len (void *con, int no_des, int index);
extern int odbc_conv_type (int typeCode);
extern int odbc_get_col_type (void *con, int no_des, int index);
extern SQLULEN odbc_put_data (void *con, int no_des, int index, char **result);
extern SQLINTEGER odbc_get_integer_data (void *con, int no_des, int index);
extern SQLSMALLINT odbc_get_integer_16_data (void *con, int no_des, int index);
extern EIF_INTEGER_64 odbc_get_integer_64_data (void *con, int no_des, int index);
extern int odbc_get_boolean_data (void *con, int no_des, int index);
extern double odbc_get_float_data (void *con, int no_des, int index);
extern float odbc_get_real_data (void *con, int no_des, int index);
extern int odbc_is_null_data(void *con, int no_des, int index);
extern int odbc_get_date_data (void *con, int no_des, int index);
extern int odbc_get_year(void *con);
extern int odbc_get_month(void *con);
extern int odbc_get_day(void *con);
extern int odbc_get_hour(void *con);
extern int odbc_get_min(void *con);
extern int odbc_get_sec(void *con);
extern int odbc_get_decimal (void *con, int no_des, int index, void *p);
extern int odbc_get_error_code (void *con);
extern SQLTCHAR * odbc_get_error_message (void *con);
extern size_t odbc_get_error_message_count (void *con);
extern size_t odbc_get_warn_message_count (void *con);
extern SQLTCHAR * odbc_get_warn_message (void *con);
extern void odbc_clear_error (void *);
extern SQLSMALLINT odbc_c_type(SQLSMALLINT odbc_type);
extern void odbc_get_col_desc (int no_desc, int index);
extern void odbc_free_connection (void *con);
extern EIF_NATURAL_64 strhextoval(SQL_NUMERIC_STRUCT *NumStr);
extern void odbc_set_decimal_presicion_and_scale (void *con, int precision, int scale);
extern SQLLEN odbc_row_count (void *con, int no_desc);


/*****************************************************************/
/*                                                               */
/*                     ROUTINE  DESCRIPTION                      */


#ifdef __cplusplus
}
#endif

#endif /* _EIFFEL_ODBC_H_ */
