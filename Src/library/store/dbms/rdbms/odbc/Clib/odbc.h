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

/* Macro for memory allocation */
#define ODBC_SAFE_ALLOC(x,function)	\
	x = function; \
		if (x == NULL) \
				enomem()

#define ODBC_C_FREE free

/* Missing declaration in the Borland compiler */
#ifdef EIF_BORLAND
#ifndef SQL_HANDLE_ENV
#define SQL_HANDLE_ENV      1
#endif

#ifndef SQL_HANDLE_DBC
#define SQL_HANDLE_DBC      2
#endif

#ifndef SQL_HANDLE_SMTM
#define SQL_HANDLE_SMTM		3
#endif

#ifndef SQL_HANDLE_STMT
#define SQL_HANDLE_STMT		3
#endif

#ifndef SQL_TYPE_DATE
#define SQL_TYPE_DATE		91
#endif

#ifndef SQL_TYPE_TIME
#define SQL_TYPE_TIME		92
#endif

#ifndef SQL_TYPE_TIMESTAMP
#define SQL_TYPE_TIMESTAMP	93
#endif

#ifndef SQL_QUALIFIER_NAME_SEPARATOR
#define SQL_QUALIFIER_NAME_SEPARATOR	41
#endif

#ifndef SQL_C_TYPE_DATE
#define SQL_C_TYPE_DATE		SQL_TYPE_DATE
#endif

#ifndef SQL_C_TYPE_TIME
#define SQL_C_TYPE_TIME		SQL_TYPE_TIME
#endif

#ifndef SQL_C_TYPE_TIMESTAMP
#define SQL_C_TYPE_TIMESTAMP	SQL_TYPE_TIMESTAMP
#endif

#ifndef SQL_CATALOG_NAME_SEPARATOR
#define SQL_CATALOG_NAME_SEPARATOR	SQL_QUALIFIER_NAME_SEPARATOR
#endif

#ifndef SQL_NULL_HANDLE
#define SQL_NULL_HANDLE     0L
#endif

#ifndef SQL_OV_ODBC2
#define SQL_OV_ODBC2		2UL
#endif

#ifndef SQL_OV_ODBC3
#define SQL_OV_ODBC3		3UL
#endif

#ifndef SQL_ATTR_ODBC_VERSION
#define SQL_ATTR_ODBC_VERSION				200
#endif

#ifndef SQLPOINTER
typedef void *          SQLPOINTER;
#endif

#endif

/* the following are EIFFEL DATATYPEs supported by EiffelStore on ODBC */
#define STRING_TYPE            10
#define CHARACTER_TYPE          2
#define INTEGER_TYPE            4
#define FLOAT_TYPE              6
#define REAL_TYPE               5
#define BOOLEAN_TYPE            3
#define DATE_TYPE              11
#define TIME_TYPE              12
#define UNKNOWN_TYPE            0

/* the following are some lengthes' definitions */
#define ERROR_MESSAGE_SIZE    450 /* the max length of error message */
#define WARN_MESSAGE_SIZE     450 /* the max length of warning message */
#define MAX_ERROR_MSG         200 /* the max length of tempory error message */
#define MAX_DESCRIPTOR        10  /* Max descriptor available simultaneously */


#define NO_MORE_ROWS          100 /* No more row is fetched by FETCH operation */

/* the following are some ERROR codes */
#define NO_MORE_DESCRIPTOR    			(-1)
#define DB_ERROR                                2
#define DB_SQL_INVALID_HANDLE                   3
#define DB_SQL_ERROR                            4
#define DB_TOO_MANY_COL                 	5

/* the following are lengthes of some data types in EiffelStore on ODBC */
#define DB_DATE_LEN                             26
#define DB_MAX_NAME_LEN                 	40
#define DB_MAX_TABLE_LEN			50
#define DB_MAX_COLS                             300
// Added by David
//#define DB_MAX_STRING_LEN			254
#define DB_MAX_STRING_LEN			1024
#define DB_QUOTER_LEN				5
#define DB_NAME_SEP_LEN				5
#define DB_MAX_QUALIFIER_LEN			150
#define DB_MAX_USER_NAME_LEN			50
#define DB_SIZEOF_CHAR                  sizeof(char)
#define DB_SIZEOF_SHORT                 sizeof(short)
#define DB_SIZEOF_INT                   sizeof(int)
#define DB_SIZEOF_LONG                  sizeof(long)
#define DB_SIZEOF_UDWORD		sizeof(UDWORD)
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
	short   sqltype;
	short   c_type;
	long    sqllen;
	char    *sqldata;
	short   *sqlind;
	struct {
	    short sqlnamel;
	    char  sqlnamec[DB_MAX_NAME_LEN+1];
	} sqlname;
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
	short           sqln;                   \
	short           sqld;                   \
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


extern void c_odbc_make (int m_size);
extern int odbc_new_descriptor ();
extern int odbc_first_descriptor_available (void);
extern int odbc_available_descriptor ();
extern int odbc_max_descriptor ();
extern void odbc_pre_immediate(int no_desc, int argNum);
extern void odbc_exec_immediate (int no_desc, char *order);
extern void odbc_init_order (int no_desc, char *order, int argNum);
extern void odbc_start_order (int no_desc);
extern void odbc_terminate_order (int no_des);
extern void odbc_close_cursor (int no_des);
extern int odbc_next_row (int no_des);
extern int odbc_support_proc();
extern int odbc_support_create_proc();
extern int odbc_support_information_schema();
extern char * odbc_driver_name();
extern int odbc_insensitive_upper();
extern int odbc_insensitive_lower();
extern int odbc_sensitive_mixed();
extern int odbc_insensitive_mixed();
extern void odbc_set_parameter(int no_desc, int seri, int dir, int eifType, int collen, int value_count, void *value);
extern void odbc_set_col_flag(int no_desc);
extern void odbc_set_tab_flag(int no_desc);
extern void odbc_set_proc_flag(int no_desc);
extern char *odbc_hide_qualifier(char *buf);
extern void odbc_unhide_qualifier(char *buf);
extern char *odbc_identifier_quoter();
extern char *odbc_qualifier_seperator();
extern void odbc_set_qualifier(char *qfy);
extern void odbc_set_owner(char *owner);
extern void odbc_unset_catalog_flag(int no_desc);
extern char *odbc_date_to_str(int year, int month, int day, int hour, int minute, int sec, int type);
extern char *odbc_stru_of_date(int year, int month, int day, int hour, int minute, int sec, int frac, int type);
extern char *odbc_str_from_str(char *ptr);
extern void odbc_connect (char *name, char *passwd, char *dsn);
extern void odbc_disconnect ();
extern void odbc_rollback ();
extern void odbc_commit ();
extern void odbc_begin ();
extern int odbc_trancount ();
extern void cut_tail_blank(char *buf);
extern int odbc_get_count (int no_des);
extern int odbc_get_user  (char *result);
extern int odbc_put_col_name (int no_des, int index, char *result);
extern int odbc_get_col_len (int no_des, int index);
extern int odbc_get_data_len (int no_des, int index);
extern int odbc_conv_type (int typeCode);
extern int odbc_get_col_type (int no_des, int index);
extern int odbc_put_data (int no_des, int index, char *result);
extern int odbc_get_integer_data (int no_des, int index);
extern int odbc_get_boolean_data (int no_des, int index);
extern double odbc_get_float_data (int no_des, int index);
extern float odbc_get_real_data (int no_des, int index);
extern int odbc_is_null_data(int no_des, int index);
extern int odbc_get_date_data (int no_des, int index);
extern int odbc_get_year();
extern int odbc_get_month();
extern int odbc_get_day();
extern int odbc_get_hour();
extern int odbc_get_min();
extern int odbc_get_sec();
extern int odbc_str_len(char *val);
extern char *odbc_str_value(char *val);
extern int odbc_get_error_code ();
extern char * odbc_get_error_message ();
extern char * odbc_get_warn_message ();
extern void odbc_clear_error ();
extern int odbc_c_type(int odbc_type);
extern void odbc_disp_c_type();
extern void odbc_disp_rec(int no_des);
extern void odbc_get_col_desc (int no_desc, int index);

/*****************************************************************/
/*                                                               */
/*                     ROUTINE  DESCRIPTION                      */


#ifdef __cplusplus
}
#endif

#endif /* _EIFFEL_ODBC_H_ */
