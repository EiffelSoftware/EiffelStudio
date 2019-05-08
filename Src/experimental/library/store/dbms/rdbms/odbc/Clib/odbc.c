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
#define tWARN_MSG	1
#define tDEBUG	1
#define tPRN    1
#define tTEST 1

#include "eif_eiffel.h"

#ifdef EIF_WINDOWS
#include <windows.h>
#else
#define UNIX
#endif

#ifdef EIF_WINDOWS
#define snprintf _snprintf
#endif

#include <stdio.h>
#include <string.h>
#include "odbc.h"
#include <ctype.h>
#include <math.h>

/* Allocate string in characters */
#define ALLOC_STRING(s,c) \
	ODBC_SAFE_ALLOC((s)->string, (SQLTCHAR *) calloc ((c),sizeof (SQLTCHAR)));	\
	(s)->capacity = (c);	\
	(s)->char_count = 0

/* Reallocate string in characters */
#define REALLOC_STRING(s,c) \
	if ((s)->string == NULL) {	\
		ALLOC_STRING ((s), (c));	\
	} else if ((c) > (s)->capacity) {	\
		ODBC_SAFE_ALLOC((s)->string, (SQLTCHAR *) realloc ((s)->string, sizeof (SQLTCHAR) * (c)));	\
		(s)->capacity = (c); \
	}

/* Reallocate string to ensure space for given remaining character number */
#define ENSURE_STRING_REMAINING_SIZE(s,remaining) \
	REALLOC_STRING((s),(sizeof (SQLTCHAR) * ((s)->char_count+remaining)))

/* Reset string if the string is allocated */
#define RESET_STRING(s) \
	if ((s)->string != NULL && (s)->char_count > 0) {	\
		(s)->string[0] = (SQLTCHAR)0;	\
		(s)->char_count = 0;	\
	}

/* Free string */
#define FREE_STRING(s)	\
	ODBC_C_FREE((s)->string);	\
	memset(s, 0, sizeof(COUNTABLE_STRING))

/*
** Data used by a single connection
*/
typedef struct con_context_ {
		/* ODBC connection handle, A connection consists of a driver and a data source.
		 * A connection handle identifies each connection. The connection handle defines not only which driver to use
		 * but which data source to use with that driver. */
	HDBC    hdbc;
	ODBCSQLDA *odbc_descriptor[MAX_DESCRIPTOR];
	short   flag[MAX_DESCRIPTOR];
	SQLHSTMT   hstmt[MAX_DESCRIPTOR];
	SQLLEN *pcbValue[MAX_DESCRIPTOR]; /* Used by SQLBindParameter. Pointers to a buffer for the parameter's length. */
	SQLLEN *odbc_indicator[MAX_DESCRIPTOR];
	RETCODE rc; /* Return code */
	TIMESTAMP_STRUCT odbc_date; /* Date data for temporary use */
		/* Messages: Are not exported to Eiffel due to
		 * merge with Oracle variables when using both files.
		 * Wrapping functions are used.*/
	COUNTABLE_STRING error_message;
	COUNTABLE_STRING warn_message;
	int error_number;
	short odbc_tranNumber; /* number of transaction opened at present */
	int default_precision;
	int default_scale;
	COUNTABLE_STRING odbc_qualifier;
	COUNTABLE_STRING odbc_owner;
} CON_CONTEXT;

rt_private void odbc_error_handler (CON_CONTEXT *con, HSTMT,int);
void odbc_clear_error (void *);
void odbc_unhide_qualifier(SQLTCHAR *buf, int char_count);
SQLSMALLINT	 odbc_c_type(SQLSMALLINT odbc_type);

rt_private EIF_REAL_64 c_numeric_to_real_64 (SQL_NUMERIC_STRUCT *NumStr);
rt_private SQLTCHAR *sqlstrcpy(SQLTCHAR *strDestination, int pos, const char *strSource);
rt_private int find_name (SQLTCHAR *buf, int buf_count, SQLTCHAR * sqlStat, int sqlStat_count);
rt_private void setup_result_space (void *con, int no_desc);
rt_private void free_sqldata (ODBCSQLDA *dap);
rt_private int odbc_first_descriptor_available (void *con);
rt_private void change_to_low(SQLTCHAR *buf, size_t length);
rt_private void odbc_fetch_connection_info (void *con);
rt_private void odbc_retrieve_error_message (CON_CONTEXT *con, HSTMT h_err_stmt, COUNTABLE_STRING *error_string);
rt_private void string_right_adjust(COUNTABLE_STRING *buf);

/* Safe allocation and memory reset */\
#define ODBC_SAFE_CLEAN_ALLOC(p,function,size) \
	ODBC_SAFE_ALLOC(p,function); \
	if (p) {memset (p, 0, size);}

/*
SQLTXTCMP	- SQL text cmp
SQLTXTCPY	- SQL text copy len + one character for the null character
ATSTXTCPY	- ASCII to SQL text copy
SQLTXTCAT	- SQL text cat
ATSTXTCAT	- ASCII to SQL text cat

SQLTCSCAT	- SQL text to countable string cat
ATCSTXTCAT	- ASCII to countable string cat
CSTXTCAT	- countable string cat
*/

#define SQLTXTCMP(s1,s2,len_s2) 	(memcmp(s1, s2, len_s2*sizeof(SQLTCHAR)))
#define SQLTXTCPY(s1,s2,len_s2)		(memcpy(s1, s2, (len_s2+1)*sizeof(SQLTCHAR)))
#define ATSTXTCPY(s1,s2)	 (sqlstrcpy(s1, 0, s2))
#define SQLTXTCAT(s1,len_s1,s2,len_s2)	(SQLTXTCPY(((SQLTCHAR *)(s1)+len_s1), (s2), len_s2))
#define ATSTXTCAT(s1,len_s1,s2)	(sqlstrcpy(s1, (int)(len_s1), s2))

#define SQLTCSCAT(s1,s2,len_s2)	\
	ENSURE_STRING_REMAINING_SIZE((s1), len_s2);	\
	(SQLTXTCAT(((s1)->string), ((s1)->char_count), s2, len_s2));	\
	(s1)->char_count += len_s2;

#define ATCSTXTCAT(s1,s2)  \
	{	\
		size_t len = strlen(s2);	\
		ENSURE_STRING_REMAINING_SIZE((s1), len);	\
		(sqlstrcpy(((s1)->string), (int)((s1)->char_count), (s2))); \
		(s1)->char_count += len;	\
	}

#define CSTXTCAT(s1,s2)	\
	ENSURE_STRING_REMAINING_SIZE((s1), (s2)->char_count);	\
	(SQLTXTCAT(((s1)->string), ((s1)->char_count), ((s2)->string), ((s2)->char_count))); \
	(s1)->char_count += (s2)->char_count;


#define TXTC(x)  ((SQLTCHAR) x)

/* Global ODBC environment,
 * for the moment we only allow single environment in one process.
 * Mutex is needed later for multithreading support.
 */
HENV    henv = NULL;
short number_connection;

SQLTCHAR idQuoter[DB_QUOTER_LEN];
SQLTCHAR quaNameSep[DB_NAME_SEP_LEN];
long odbc_case;
long odbc_info_schema;
SQLTCHAR storedProc[2];
SQLTCHAR CreateStoredProc[DB_MAX_NAME_LEN];
SQLTCHAR dbmsName[DB_MAX_NAME_LEN];
SQLTCHAR dbmsVer[DB_MAX_NAME_LEN];

/* each function return 0 in case of success */
/* and database error code ( >= 1) else */

/*****************************************************************/
/* initialise ODBC   c-module                                    */
/*****************************************************************/

void *c_odbc_make (int m_size)
{
	CON_CONTEXT *l_res;
	int count;

	ODBC_SAFE_ALLOC(l_res, (CON_CONTEXT *) calloc (1, sizeof (CON_CONTEXT)));
	number_connection++;

	if (!henv)
	{
		/* Even though the error message is not related to current connection,
		 * but the global environment handle.
		 * We still store the message in it due to the way on Eiffel side of
		 * retrieving error message.
		 */

		l_res->rc = SQLAllocHandle(SQL_HANDLE_ENV,SQL_NULL_HANDLE,&henv);
		if (l_res->rc) {
			odbc_error_handler(l_res, NULL,10);
			return l_res;
		}
	}
	l_res->rc = SQLSetEnvAttr(henv,SQL_ATTR_ODBC_VERSION,(SQLPOINTER)SQL_OV_ODBC3,0);
	if (l_res->rc) {
		odbc_error_handler(l_res, NULL,910);
		return l_res;
	}

	for (count = 0; count < MAX_DESCRIPTOR; count++) {
		l_res->odbc_descriptor[count] = NULL;
	}
	return l_res;
}


/*****************************************************************/
/* A descriptor is used to store a row fetched by FETCH command. */
/* Whenever perform a SELECT statement, allocate a new descriptor*/
/* by int_new_descriptor(), the descriptor is freed when the     */
/* SELECT statement terminates.                                  */
/*****************************************************************/

/*****************************************************************/
/*                                                               */
/*                     ROUTINE  DESCRIPTION                      */
/*                                                               */
/* NAME: odbc_new_descriptor()                                    */
/* DESCRIPTION:                                                  */
/* This routine allocate a DESCRIPTOR in the following way:      */
/* 1. find a free cell in vector 'descriptor' to store a pointer */
/*    to ODBCSQLDA                                               */
/* 2. allocate a minimum space for the ODBCSQLDA(with space for  */
/*    only one table field). The space will be adjusted later(in */
/*    odbc_init_order(), when the ODBCSQLDA will be actually used*/
/*    and enough information has obtained for allocating proper  */
/*    size of memory space).                                     */
/*                                                               */
/*****************************************************************/
int odbc_new_descriptor (void *con)
{
	CON_CONTEXT *l_con = (CON_CONTEXT *)con;
	int result = odbc_first_descriptor_available (con);

	if (result != NO_MORE_DESCRIPTOR)
	{
		l_con->rc = SQLAllocHandle (SQL_HANDLE_STMT, l_con->hdbc, &(l_con->hstmt[result]));
		if (l_con->rc) {
			odbc_error_handler(con, NULL, 0);
			return NO_MORE_DESCRIPTOR;
		}

		/* malloc area for the descriptor and then initialize it */
		/* Initially allocate head size plus one var size.
		* Previously we set odbc_descriptor[result] as arbitary pointer 0x1 which is not good */
		ODBC_SAFE_ALLOC(l_con->odbc_descriptor[result], (ODBCSQLDA *) calloc(IISQDA_HEAD_SIZE + IISQDA_VAR_SIZE, 1));
		SetVarNum(l_con->odbc_descriptor[result], 1);
		ODBC_C_FREE(l_con->pcbValue[result]);
		l_con->pcbValue[result] = NULL;
		ODBC_C_FREE(l_con->odbc_indicator[result]);
		l_con->odbc_indicator[result] = NULL;
		l_con->flag[result] = ODBC_SQL;
	}
	else {
		odbc_error_handler(con, NULL, 201);
		RESET_STRING(&l_con->error_message);
		ATCSTXTCAT(&l_con->error_message, " No available descriptor\n");
	}
	return result;
}

/*****************************************************************/
/*                                                               */
/*                     ROUTINE  DESCRIPTION                      */
/* NAME: odbc_first_descriptor_available()                        */
/* DESCRIPTION:                                                  */
/*   The routine decide if there free cell in vector 'descriptor'*/
/*If exist, return the index of the cell in the vector, otherwise*/
/*return NO_MORE_DESCRIPTOR.                                     */
/*                                                               */
/*****************************************************************/
int odbc_first_descriptor_available (void *con)
{
	int no_descriptor;
	CON_CONTEXT *l_con = (CON_CONTEXT *)con;

	for (no_descriptor = 0;
		no_descriptor < MAX_DESCRIPTOR &&
		l_con->odbc_descriptor[no_descriptor] != NULL;
	no_descriptor++)
	{
		/* empty */
	}

	if (no_descriptor < MAX_DESCRIPTOR)
	{
		return no_descriptor;
	}
	else
	{
		return NO_MORE_DESCRIPTOR;
	}
}

/*****************************************************************/
/*                                                               */
/*                     ROUTINE  DESCRIPTION                      */
/*                                                               */
/* NAME: odbc_available_descriptor()                              */
/* DESCRIPTION:                                                  */
/*   To decide if there is free cell in vector 'descriptor',     */
/* if answer is YES, return 1; otherwise return 0.               */
/*                                                               */
/*****************************************************************/
int odbc_available_descriptor (void *con)
{
	return odbc_first_descriptor_available (con) != NO_MORE_DESCRIPTOR;
}

/*****************************************************************/
/*                                                               */
/*                     ROUTINE  DESCRIPTION                      */
/*                                                               */
/* NAME: odbc_max_descriptor()                                    */
/* DESCRIPTION:                                                  */
/*   Return the max number of cells in vector 'descriptor'.      */
/*                                                               */
/*****************************************************************/
int odbc_max_descriptor ()
{
	return MAX_DESCRIPTOR;
}

/*****************************************************************/
/*  The following functions perform SQL statement in 2 ways:     */
/*  1. immediately ---- a mode to perform Insert, Update and     */
/*     Delete.                                                   */
/*  2. dynamicly   ---- a mode to perform all kinds of operations*/
/*****************************************************************/

/*****************************************************************/
/*                                                               */
/*                     ROUTINE  DESCRIPTION                      */
/*                                                               */
/* NAME: odbc_pre_immediate(int no_desc, int argNum)             */
/* PARAMETERS: no_desc - the descriptor number for the statement */
/*             argNum  - the number of the arguments of the      */
/*                       statement                               */
/* DESCRIPTION:                                                  */
/*   In IMMEDIATE EXECUTE mode, if the performed SQL statement is*/
/* a call to a stored procedure, allocate some area used by the  */
/* stored procedure.                                             */
/*                                                               */
/*****************************************************************/
void odbc_pre_immediate(void *con, int no_desc, int argNum)
{
	CON_CONTEXT *l_con = (CON_CONTEXT *)con;

	odbc_clear_error(con);

	if (no_desc < 0 || no_desc > MAX_DESCRIPTOR) {
		odbc_error_handler(con, NULL, 202);
		ATCSTXTCAT(&l_con->error_message, "\nInvalid Descriptor Number!");
		return;
	}
	if (argNum > 0) {
		/* Reset memory to be safe */
		ODBC_SAFE_ALLOC(l_con->pcbValue[no_desc], (SQLLEN *) calloc(argNum, sizeof(SQLLEN)));
	} else {
		ODBC_C_FREE(l_con->pcbValue[no_desc]);
		l_con->pcbValue[no_desc] = NULL;
	}
}

/*****************************************************************/
/*                                                               */
/*                     ROUTINE  DESCRIPTION                      */
/*                                                               */
/* NAME: odbc_exec_immediate(order)                              */
/* PARAMETERS: order - a SQL statement to be performed.          */
/* DESCRIPTION:                                                  */
/*   In IMMEDIATE EXECUTE mode perform the SQL statement, and    */
/* then check if there is warning message for the execution,     */
/* and finally return error number.                              */
/*                                                               */
/*****************************************************************/
void odbc_exec_immediate (void *con, int no_desc, SQLTCHAR *order, int order_count)
{
	CON_CONTEXT *l_con = (CON_CONTEXT *)con;

	odbc_unhide_qualifier(order, order_count);
	l_con->odbc_tranNumber = 1;
	RESET_STRING(&l_con->warn_message);

	l_con->rc = SQLExecDirect(l_con->hstmt[no_desc], order, order_count);
	free_sqldata (l_con->odbc_descriptor[no_desc]);
	l_con->odbc_descriptor[no_desc] = NULL;
	if (l_con->rc) {
		odbc_error_handler(con, l_con->hstmt[no_desc], 2);
	}
	l_con->rc = SQLFreeHandle (SQL_HANDLE_STMT, l_con->hstmt[no_desc]);
	if (l_con->rc) {
		odbc_error_handler(con, l_con->hstmt[no_desc],3);
	}
	free_sqldata (l_con->odbc_descriptor[no_desc]);
	l_con->odbc_descriptor[no_desc] = NULL;
	if (l_con->pcbValue[no_desc] != NULL) {
		ODBC_C_FREE(l_con->pcbValue[no_desc]);
		l_con->pcbValue[no_desc] = NULL;
	}
}

/*****************************************************************/
/*                                                               */
/*                     ROUTINE  DESCRIPTION                      */
/*                                                               */
/* NAME: odbc_init_order(no_des, order)                           */
/* PARAMETERS: order - a SQL statement to be performed.          */
/*             no_des- index in descriptor vector.               */
/* DESCRIPTION:                                                  */
/*   In DYNAMICALLY EXECUTE mode perform the SQL statement. But  */
/* this routine only get things ready for dynamic execution:     */
/*   1. get the SQL statement PREPARED; and check if there are   */
/*      warning message for the SQL statement;                   */
/*   2. DESCRIBE the SQL statement and get enough information to */
/*      allocate enough memory space for the corresponding       */
/*      ODBCSQLDA.                                               */
/*   3. return error number.                                     */
/*                                                               */
/*****************************************************************/
void odbc_init_order (void *con, int no_desc, SQLTCHAR *order, int order_count, int argNum)
{
	int is_as_primary = 0;
	int found_byte_count;
	CON_CONTEXT *l_con = (CON_CONTEXT *)con;
	COUNTABLE_STRING *l_qualifier, *l_owner;

/* Predefined names have at minimum 9 characters (shortest being "sqltables". */
#define COMPARED_LENGTH	(9)
#define COMPARED_BYTES	(COMPARED_LENGTH * sizeof (SQLTCHAR))

	SQLTCHAR *order_in_lower;
	SQLTCHAR sqltab[30];
	SQLTCHAR sqlcol[30];
	SQLTCHAR sqlproc[30];
	SQLTCHAR sqlpk[30];
	SQLTCHAR sqlfk[30];
	SQLTCHAR sqlfk_as_primary[30];

	ATSTXTCPY(sqltab,  "sqltables");
	ATSTXTCPY(sqlcol,  "sqlcolumns");
	ATSTXTCPY(sqlproc, "sqlprocedu");
	ATSTXTCPY(sqlpk,   "sqlprimary");
	ATSTXTCPY(sqlfk,   "sqlforeign");
	ATSTXTCPY(sqlfk_as_primary, "sqlforeignkeysprimary");


	if (no_desc < 0 || no_desc > MAX_DESCRIPTOR) {
		odbc_error_handler(con, NULL, 203);
		ATCSTXTCAT(&l_con->error_message, "\nInvalid Descriptor Number!");
		return;
	}
	odbc_unhide_qualifier(order, order_count);
	l_con->odbc_tranNumber = 1;
	odbc_clear_error(con);
	RESET_STRING(&l_con->warn_message);

	l_con->flag[no_desc] = ODBC_SQL;

	if (order_count >= COMPARED_LENGTH) {
		ODBC_SAFE_ALLOC(order_in_lower, (SQLTCHAR *) malloc ((order_count + 1) * sizeof(SQLTCHAR)));
		memcpy(order_in_lower , order, order_count * sizeof (SQLTCHAR));
		order_in_lower [order_count] = (SQLTCHAR)0;
		change_to_low(order_in_lower , order_count);
		if (memcmp(order_in_lower , sqltab, COMPARED_BYTES) == 0) {
			l_con->flag[no_desc] = ODBC_CATALOG_TAB;
			found_byte_count = find_name (order_in_lower, order_count, order, order_count);

			l_qualifier = &l_con->odbc_qualifier;
			l_owner = &l_con->odbc_owner;
			if (found_byte_count) {
				if (l_qualifier->char_count > 0 && l_owner->char_count > 0)
					l_con->rc = SQLTables(l_con->hstmt[no_desc], l_qualifier->string, (SQLSMALLINT)l_qualifier->char_count, l_owner->string, (SQLSMALLINT)l_owner->char_count, order_in_lower , (SQLSMALLINT)found_byte_count, NULL, 0);
				if (l_qualifier->char_count == 0 && l_owner->char_count > 0)
					l_con->rc = SQLTables(l_con->hstmt[no_desc], NULL, 0, l_owner->string, (SQLSMALLINT)l_owner->char_count, order_in_lower , (SQLSMALLINT)found_byte_count, NULL, 0);
				if (l_qualifier->char_count > 0 && l_owner->char_count == 0)
					l_con->rc = SQLTables(l_con->hstmt[no_desc], l_qualifier->string, (SQLSMALLINT)l_qualifier->char_count, NULL, 0, order_in_lower , (SQLSMALLINT)found_byte_count, NULL, 0);
				if (l_qualifier->char_count == 0 && l_owner->char_count == 0)
					l_con->rc = SQLTables(l_con->hstmt[no_desc], NULL, 0, NULL, 0, order_in_lower , (SQLSMALLINT)found_byte_count, NULL, 0);
			} else {
				l_con->rc = SQLTables(l_con->hstmt[no_desc], NULL, 0, NULL, 0, NULL, 0, NULL, 0);
				RESET_STRING (l_qualifier);
				RESET_STRING (l_owner);
			}
		} else if (memcmp(order_in_lower , sqlcol, COMPARED_BYTES) == 0) {
			l_con->flag[no_desc] = ODBC_CATALOG_COL;
			found_byte_count = find_name (order_in_lower, order_count, order, order_count);
			if (found_byte_count) {
				l_con->rc = SQLColumns(l_con->hstmt[no_desc], NULL, 0, NULL, 0, order_in_lower , (SQLSMALLINT)found_byte_count, NULL, 0);
			} else {
				l_con->rc = SQLColumns(l_con->hstmt[no_desc], NULL, 0, NULL, 0, NULL, 0, NULL, 0);
			}
		} else if (memcmp(order_in_lower , sqlproc, COMPARED_BYTES) == 0) {
			l_con->flag[no_desc] = ODBC_CATALOG_PROC;
			found_byte_count = find_name (order_in_lower, order_count, order, order_count);
			if (found_byte_count){
				l_con->rc = SQLProcedures(l_con->hstmt[no_desc], NULL, 0, NULL, 0, order_in_lower , (SQLSMALLINT)found_byte_count);
			} else {
				l_con->rc = SQLProcedures(l_con->hstmt[no_desc], NULL, 0, NULL, 0, NULL, 0);
			}
		} else if (memcmp(order_in_lower , sqlpk, COMPARED_BYTES) == 0) {
			l_con->flag[no_desc] = ODBC_PK;
			found_byte_count = find_name (order_in_lower, order_count, order, order_count);
			if (found_byte_count) {
				l_con->rc = SQLPrimaryKeys(l_con->hstmt[no_desc], NULL, 0, NULL, 0, order_in_lower , (SQLSMALLINT)found_byte_count);
			} else {
				l_con->rc = SQLPrimaryKeys(l_con->hstmt[no_desc], NULL, 0, NULL, 0, NULL, 0);
			}
		} else if (memcmp(order_in_lower , sqlfk, COMPARED_BYTES) == 0) {
			is_as_primary = (memcmp(order_in_lower , sqlfk_as_primary, 21) ? 0 : 1);
			l_con->flag[no_desc] = ODBC_FK;
			found_byte_count = find_name (order_in_lower, order_count, order, order_count);
				/* Now let's find what type of primary keys we are looking for. */
			if (is_as_primary) {
				l_con->rc = SQLForeignKeys(l_con->hstmt[no_desc], NULL, 0, NULL, 0, order_in_lower , (SQLSMALLINT)found_byte_count, NULL, 0, NULL, 0, NULL, 0);
			} else {
				l_con->rc = SQLForeignKeys(l_con->hstmt[no_desc], NULL, 0, NULL, 0, NULL, 0, NULL, 0, NULL, 0, order_in_lower , (SQLSMALLINT)found_byte_count);
			}
		}
		ODBC_C_FREE(order_in_lower);
	}

	if (l_con->rc) {
		odbc_error_handler(con, l_con->hstmt[no_desc],100);
		if (l_con->error_number) {
			free_sqldata (l_con->odbc_descriptor[no_desc]);
			l_con->odbc_descriptor[no_desc] = NULL;
			l_con->rc = SQLFreeHandle (SQL_HANDLE_STMT, l_con->hstmt[no_desc]);
		}
	}



	if (l_con->flag[no_desc] == ODBC_SQL) {
			/* Process general ODBC SQL statements    */
		l_con->rc = SQLPrepare(l_con->hstmt[no_desc], order, order_count);
		if (l_con->rc) {
			odbc_error_handler(con, l_con->hstmt[no_desc],4);
			if (l_con->error_number) {
				free_sqldata (l_con->odbc_descriptor[no_desc]);
				l_con->odbc_descriptor[no_desc] = NULL;
				l_con->rc = SQLFreeHandle (SQL_HANDLE_STMT, l_con->hstmt[no_desc]);
				return;
			}
		}
	}

	if (argNum > 0) {
			/* Reset memory to be safe */
		ODBC_SAFE_ALLOC(l_con->pcbValue[no_desc], (SQLLEN *) calloc(argNum, sizeof(SQLLEN)));
	} else {
		ODBC_C_FREE(l_con->pcbValue[no_desc]);
		l_con->pcbValue[no_desc] = NULL;
	}
}

/*****************************************************************/
/*                                                               */
/*                     ROUTINE  DESCRIPTION                      */
/*                                                               */
/* NAME: odbc_start_order(no_des)                                 */
/* PARAMETERS: no_des- index in descriptor vector.               */
/* DESCRIPTION:                                                  */
/*   Finish execution of a SQL statement in DYNAMIC EXECUTION */
/* mode:                                                         */
/*   1. if the PREPAREd SQL statement is a NON_SELECT statement, */
/*      just EXECUTE it; otherwise, DEFINE a CURSOR for it and   */
/*      OPEN the CURSOR. In the process, if error occurs, do some*/
/*      clearence;                                               */
/*   3. return error number.                                     */
/*                                                               */
/*****************************************************************/

void odbc_start_order (void *con, int no_desc)
{
	CON_CONTEXT *l_con = (CON_CONTEXT *)con;

	if (l_con->flag[no_desc] == ODBC_SQL) {
			/* Process general ODBC SQL statements    */
		l_con->rc = SQLExecute(l_con->hstmt[no_desc]);
		if (l_con->rc) {
			odbc_error_handler(con, l_con->hstmt[no_desc],7);
			if (l_con->error_number > 0) {
				free_sqldata (l_con->odbc_descriptor[no_desc]);
				l_con->odbc_descriptor[no_desc] = NULL;
				if (l_con->pcbValue[no_desc] != NULL) {
					ODBC_C_FREE(l_con->pcbValue[no_desc]);
					l_con->pcbValue[no_desc] = NULL;
				}
				l_con->rc = SQLFreeHandle (SQL_HANDLE_STMT, l_con->hstmt[no_desc]);
				return;
			}
		}
	}
	setup_result_space (con, no_desc);
}

/* Setup/describe result space and fill some necessary info. */
void setup_result_space (void *con, int no_desc)
{
	CON_CONTEXT *l_con = (CON_CONTEXT *)con;
	ODBCSQLDA *dap=l_con->odbc_descriptor[no_desc];
	SQLSMALLINT colNum = 0;
	SQLSMALLINT oldVarNum = 0;
	SQLSMALLINT i;
	SQLULEN l_length;
	SQLSMALLINT type;
	SQLSMALLINT indColName;
	SQLSMALLINT tmpScale;
	SQLSMALLINT tmpNullable;
	char *dataBuf;
	SQLHDESC hdesc = NULL;
	SQLTCHAR l_temp[2];

	/* Save old val numbers */
	oldVarNum = GetVarNum(dap);

	/* Get the old number of var */
	l_con->rc = SQLNumResultCols(l_con->hstmt[no_desc], &colNum);
	if (l_con->rc) {
		odbc_error_handler(con, l_con->hstmt[no_desc],5);
		if (l_con->error_number) {
			free_sqldata (l_con->odbc_descriptor[no_desc]);
			l_con->odbc_descriptor[no_desc] = NULL;
			if (l_con->pcbValue[no_desc] != NULL) {
				ODBC_C_FREE(l_con->pcbValue[no_desc]);
				l_con->pcbValue[no_desc] = NULL;
			}
			l_con->rc = SQLFreeHandle (SQL_HANDLE_STMT, l_con->hstmt[no_desc]);
			return;
		}
	}


	if (colNum > DB_MAX_COLS) {
		if (l_con->error_number) {
			ATCSTXTCAT(&l_con->error_message, "\n Number of selected columns exceed max number(300) ");
		}
		else {
			RESET_STRING(&l_con->error_message);
			ATCSTXTCAT(&l_con->error_message, "\n Number of selected columns exceed max number(300) ");
			l_con->error_number = -DB_TOO_MANY_COL;
		}
		free_sqldata (l_con->odbc_descriptor[no_desc]);
		l_con->odbc_descriptor[no_desc] = NULL;
		if (l_con->pcbValue[no_desc] != NULL) {
			ODBC_C_FREE(l_con->pcbValue[no_desc]);
			l_con->pcbValue[no_desc] = NULL;
		}
		l_con->rc = SQLFreeHandle (SQL_HANDLE_STMT, l_con->hstmt[no_desc]);
		return;
	}

	if (colNum > 0)
		i = colNum;
	else
		i = 1;
	/* Reallocate the DESCRIPTOR area.   */
	ODBC_SAFE_ALLOC(l_con->odbc_descriptor[no_desc], (ODBCSQLDA *) realloc(l_con->odbc_descriptor[no_desc], IISQDA_HEAD_SIZE + i * IISQDA_VAR_SIZE));
	/* If there is resizing, we only clean up the new space, because some memory referenced by old space for var can be reused.*/
	if (i > oldVarNum)	{
		memset (l_con->odbc_descriptor[no_desc]->sqlvar + oldVarNum, 0, (i - oldVarNum) * IISQDA_VAR_SIZE);
	}

	dap = l_con->odbc_descriptor[no_desc];
	SetVarNum(dap,i);
	SetColNum(dap, colNum);

	/* For numeric type */
	SQLGetStmtAttr(l_con->hstmt[no_desc], SQL_ATTR_APP_ROW_DESC, &hdesc, 0, NULL);

	for (i=0; i < colNum && !l_con->error_number; i++) {
		/* Get column name length. Ideally we would want to do that:
		l_con->rc = SQLDescribeCol(l_con->hstmt[no_desc], (SQLSMALLINT) i+1, NULL, 0, &indColName, NULL, NULL, NULL, NULL);
		but it does not work on some ODBC driver implementation that fails to recognize we are just interested in computing
		the length of the column name.
		*/
		l_con->rc = SQLDescribeCol(l_con->hstmt[no_desc], (SQLSMALLINT) i+1, l_temp, 1, &indColName, NULL, NULL, NULL, NULL);
		/* Allocate string for column name, extra character for null character */
		ALLOC_STRING(&((dap->sqlvar)[i].sqlname),indColName+1);

		/* fill in the describing information for each column, and calculate */
		/* the total length of the data buffer                               */
		l_con->rc = SQLDescribeCol(
					l_con->hstmt[no_desc],
					(SQLSMALLINT) i+1,
					(dap->sqlvar)[i].sqlname.string,
					(dap->sqlvar)[i].sqlname.capacity,
					&indColName,
					&((dap->sqlvar)[i].sqltype),
					&((dap->sqlvar)[i].sqllen),
					&tmpScale,
					&tmpNullable);
		(dap->sqlvar)[i].sqlname.char_count = indColName;
		string_right_adjust (&((dap->sqlvar)[i].sqlname));
		if (l_con->rc)
			odbc_error_handler(con, l_con->hstmt[no_desc],6);
		if (l_con->error_number == 0) {
			dap->sqlvar[i].c_type = odbc_c_type(dap->sqlvar[i].sqltype);
			type = dap->sqlvar[i].c_type;
			switch(type) {
				/* case SQL_C_DATE: */
				case SQL_C_TYPE_DATE:
					SetDbColLength(dap, i, sizeof(DATE_STRUCT));
					break;
				/* case SQL_C_TIME: */
				case SQL_C_TYPE_TIME:
					SetDbColLength(dap, i, sizeof(TIME_STRUCT));
					break;
				/* case SQL_C_TIMESTAMP: */
				case SQL_C_TYPE_TIMESTAMP:
					SetDbColLength(dap, i, sizeof(TIMESTAMP_STRUCT));
					break;
				case SQL_C_STINYINT:
					SetDbColLength(dap, i, DB_SIZEOF_CHAR);
					break;
				case SQL_C_SSHORT:
					SetDbColLength(dap, i, DB_SIZEOF_SHORT);
					break;
				case SQL_C_SLONG:
					SetDbColLength(dap, i, DB_SIZEOF_LONG);
					break;
				case SQL_C_SBIGINT:
					SetDbColLength(dap, i, DB_SIZEOF_BIGINT);
					break;
				case SQL_C_FLOAT:
					SetDbColLength(dap, i, DB_SIZEOF_REAL);
					break;
				case SQL_C_DOUBLE:
					SetDbColLength(dap, i, DB_SIZEOF_DOUBLE);
					break;
				case SQL_C_TCHAR:
					SetDbColLength(dap, i, sizeof (SQLTCHAR) * GetDbColLength(dap, i));
					break;
				case SQL_C_NUMERIC:
					SQLSetDescField (hdesc,i+1,SQL_DESC_TYPE,(SQLPOINTER)SQL_C_NUMERIC,0);
					SQLSetDescField (hdesc,i+1,SQL_DESC_PRECISION,(SQLPOINTER) l_con->default_precision,0); /* presision of 64bits */
					SQLSetDescField (hdesc,i+1,SQL_DESC_SCALE,(SQLPOINTER) l_con->default_scale,0); /* presision of 64bits */
					SetDbColLength(dap, i, sizeof (SQL_NUMERIC_STRUCT));
					break;
				case SQL_C_GUID:
					SetDbColLength(dap, i, sizeof (SQLGUID));
					break;
				default:
					break;
			}
			type = GetDbColType(dap, i);
			switch (type) {
				case SQL_LONGVARBINARY:
				case SQL_LONGVARCHAR:
				case SQL_WLONGVARCHAR:
				case SQL_SS_XML:
					SetDbColLength(dap, i, DB_MAX_STRING_LEN);
					break;
			}
		}
	}


	if (l_con->error_number) {
		free_sqldata(dap);
		l_con->odbc_descriptor[no_desc] = NULL;
		if (l_con->pcbValue[no_desc] != NULL) {
			ODBC_C_FREE(l_con->pcbValue[no_desc]);
			l_con->pcbValue[no_desc] = NULL;
		}
		l_con->rc = SQLFreeHandle (SQL_HANDLE_STMT, l_con->hstmt[no_desc]);
		return;
	}

	if (colNum) {
			/* Allocate for each column the buffer that will hold its value. */
		for (i=0; i<colNum; i++) {
			l_length = GetDbColLength(dap, i);
				/* The underlying API will require an extra character for the null terminating character
				 * of string data. */
			if ((GetDbCType(dap, i) == SQL_C_WCHAR) || (GetDbCType(dap, i) == SQL_C_CHAR)) {
				l_length = l_length + sizeof(SQLTCHAR);
			}
			dataBuf = GetDbColPtr(dap, i);
			ODBC_SAFE_ALLOC(dataBuf, (char *) realloc(dataBuf, l_length));
			SetDbColPtr(dap, i, dataBuf);
		}
	}

	/* allocate buffer for INDICATORs of the output fields, reuse old memory if possible. */
	ODBC_SAFE_ALLOC(l_con->odbc_indicator[no_desc], (SQLLEN *) realloc(l_con->odbc_indicator[no_desc], (colNum+1)*sizeof(SQLLEN)));
}


/*****************************************************************/
/*                                                               */
/*                     ROUTINE  DESCRIPTION                      */
/*                                                               */
/* NAME: odbc_terminate_order(no_des)                             */
/* PARAMETERS: no_des- index in descriptor vector.               */
/* DESCRIPTION:                                                  */
/*   A SQL has been performed in DYNAMIC EXECUTION mode, so the  */
/* routine is to do some clearence:                              */
/*   1. if the DYNAMICLLY EXECUTED SQL statement is a NON_SELECT */
/*      statement, just free the memory for ODBCSQLDA and clear the*/
/*      cell in 'descriptor' to NULL; otherwise, CLOSE the CURSOR*/
/*      and then do the same clearence.                          */
/*   2. return error number.                                     */
/*                                                               */
/*****************************************************************/
void odbc_terminate_order (void *con, int no_des)
{
	CON_CONTEXT *l_con = (CON_CONTEXT *)con;
	ODBCSQLDA *dap = l_con->odbc_descriptor[no_des];

	if (dap) {
		free_sqldata (dap);
		l_con->odbc_descriptor[no_des] = NULL;
		ODBC_C_FREE(l_con->odbc_indicator[no_des]);
		l_con->odbc_indicator[no_des] = NULL;
		if (l_con->pcbValue[no_des] != NULL) {
			ODBC_C_FREE(l_con->pcbValue[no_des]);
			l_con->pcbValue[no_des] = NULL;
		}
		l_con->rc = SQLFreeHandle (SQL_HANDLE_STMT, l_con->hstmt[no_des]);
	}
}

/* Free the whole ODBCSQLDA pointed by `dap' */
void free_sqldata (ODBCSQLDA *dap)
{
	int i;
	char *data_buffer;

	int colNum;

	if (dap) {
		colNum = GetColNum(dap);
		if (colNum) {
			for (i=0; i < colNum; i++) {
				data_buffer = GetDbColPtr(dap,i);
				ODBC_C_FREE(data_buffer);
				FREE_STRING(&(((dap->sqlvar)[i]).sqlname));
			}
		}
		ODBC_C_FREE(dap);
	}
}
/*****************************************************************/
/*                                                               */
/*                     ROUTINE  DESCRIPTION                      */
/*                                                               */
/* NAME: odbc_close_cursor(no_des)                               */
/* PARAMETERS: no_des- index in descriptor vector.               */
/* DESCRIPTION:                                                  */
/*   A SQL has been performed in DYNAMIC EXECUTION mode, so the  */
/* routine is to do some clearence:                              */
/*   1. if the DYNAMICLLY EXECUTED SQL statement is a NON_SELECT */
/*      statement, just free the memory for ODBCSQLDA and clear the*/
/*      cell in 'descriptor' to NULL; otherwise, CLOSE the CURSOR*/
/*      and then do the same clearence.                          */
/*   2. return error number.                                     */
/*                                                               */
/*****************************************************************/
void odbc_close_cursor (void *con, int no_des)
{
	CON_CONTEXT *l_con = (CON_CONTEXT *)con;
    l_con->rc = SQLFreeStmt(l_con->hstmt[no_des], SQL_CLOSE);
}

/*****************************************************************/
/*                                                               */
/*                     ROUTINE  DESCRIPTION                      */
/*                                                               */
/* NAME: odbc_next_row(no_des)                                    */
/* PARAMETERS: no_des- index in descriptor vector.               */
/* DESCRIPTION:                                                  */
/*   A SELECT statement is now being executed in DYNAMIC EXECU-  */
/* TION mode,  the  routine is to FETCH a new tuple from database*/
/* and if a new tuple is fetched, return 1 otherwise return 0.   */
/*                                                               */
/*****************************************************************/

int odbc_next_row (void *con, int no_des)
     /* move to the next row of selection */
     /* return 0 if there is a next row, 1 if no row left */
{
	CON_CONTEXT *l_con = (CON_CONTEXT *)con;
	ODBCSQLDA *dap = l_con->odbc_descriptor[no_des];
	short colNum = GetColNum(dap);
	UWORD i;


	odbc_clear_error (con);
	l_con->rc = SQLFetch(l_con->hstmt[no_des]);
	if (l_con->rc && l_con->rc != NO_MORE_ROWS) {
		SQLTCHAR tmpSQLSTATE[6];
		if
			(SQLGetDiagRec(SQL_HANDLE_STMT, l_con->hstmt[no_des], 1, tmpSQLSTATE,
				NULL, NULL, 0, NULL) != SQL_NO_DATA)
		{
				/* If `tmpSQLSTATE' is 24000, we try to go to next result set. */
			if
				((tmpSQLSTATE[0] == TXTC('2')) && (tmpSQLSTATE[1] == TXTC('4')) && (tmpSQLSTATE[2] == TXTC('0')) &&
				(tmpSQLSTATE[3] == TXTC('0')) && (tmpSQLSTATE[4] == TXTC('0')))
			{
				l_con->rc = SQLMoreResults(l_con->hstmt[no_des]);

				while (l_con->rc != SQL_SUCCESS && l_con->rc != SQL_SUCCESS_WITH_INFO && l_con->rc != SQL_NO_DATA && l_con->rc != SQL_ERROR)
				{
					l_con->rc = SQLMoreResults(l_con->hstmt[no_des]);
				};
				if (l_con->rc != SQL_NO_DATA && l_con->rc != SQL_ERROR)
				{
					setup_result_space (con, no_des);
					dap = l_con->odbc_descriptor[no_des];
					colNum = GetColNum(dap);
					l_con->rc = SQLFetch(l_con->hstmt[no_des]);
				}
				if (l_con->rc == SQL_NO_DATA)
				{
					/* We do the same thing later as SQLFetch returns NO_MORE_ROWS
					 * if SQLMoreResults returns SQL_NO_DATA
					 */
					l_con->rc = NO_MORE_ROWS;
				}
			}
		}
		if (l_con->rc && l_con->rc != NO_MORE_ROWS)
		{
			odbc_error_handler(con, l_con->hstmt[no_des],8);
			if (l_con->error_number) {
				odbc_terminate_order(con, no_des);
				return 1;
			}
		}
	}


	if (l_con->rc == NO_MORE_ROWS) /* NO_MORE_ROWS */ {
		return 1;
	}
	else {
		for (i=0; i<colNum && l_con->error_number == 0; i++) {
			SQLULEN old_length = GetDbColLength(dap, i);
			char *l_buffer = GetDbColPtr(dap, i);
			SQLULEN l_terminator_size = 0;
			l_con->odbc_indicator[no_des][i] = 0;
				/* String data have an extra character for the null terminating character. */
			if (GetDbCType(dap, i) == SQL_C_WCHAR) {
				l_terminator_size = sizeof(SQLWCHAR);
				old_length += l_terminator_size;
			} else if (GetDbCType(dap, i) == SQL_C_CHAR) {
				l_terminator_size = sizeof(SQLCHAR);
				old_length += l_terminator_size;
			}
			if (GetDbCType(dap, i) == SQL_C_NUMERIC){
				/* Use SQL_ARD_TYPE to force the driver to use data in the row descriptor */
				l_con->rc = SQLGetData(l_con->hstmt[no_des], i+1, SQL_ARD_TYPE, l_buffer, old_length, &(l_con->odbc_indicator[no_des][i]));
			} else {
				l_con->rc = SQLGetData(l_con->hstmt[no_des], i+1, GetDbCType(dap, i), l_buffer, old_length, &(l_con->odbc_indicator[no_des][i]));
			}
			if (l_con->rc) {
					/* Check if it failed because we did not have enough space to store the data. */
				if (l_con->rc == SQL_SUCCESS_WITH_INFO) {
					SQLTCHAR tmpSQLSTATE[6];
					if
						(SQLGetDiagRec(SQL_HANDLE_STMT, l_con->hstmt[no_des], 1, tmpSQLSTATE,
							NULL, NULL, 0, NULL) != SQL_NO_DATA)
					{
							/* If `tmpSQLSTATE' is 01004 then we just make our buffer bigger and
							 * reissue the call. */
						if
							((tmpSQLSTATE[0] == TXTC('0')) && (tmpSQLSTATE[1] == TXTC('1')) && (tmpSQLSTATE[2] == TXTC('0')) &&
							(tmpSQLSTATE[3] == TXTC('0')) && (tmpSQLSTATE[4] == TXTC('4')))
						{
							SQLULEN additional_length;
								/* We remove the null character from the previous call made to SQLGetData
								 * because when data is truncated SQLGetData it always add the null character.*/
							old_length -= l_terminator_size;
							if (l_con->odbc_indicator[no_des][i] == SQL_NO_TOTAL) {
								additional_length = DB_MAX_STRING_LEN;
							} else {
								additional_length = l_con->odbc_indicator[no_des][i] - old_length + l_terminator_size;
							}
								/* Reuse old memory if possible */
							ODBC_SAFE_ALLOC(l_buffer, (char *) realloc (l_buffer, old_length + additional_length));
							SetDbColPtr(dap, i, l_buffer);
							SetDbColLength(dap, i, old_length + additional_length - l_terminator_size);
								/* Reissue the call, this time starting from the end of `l_buffer' since we want to get
								 * the remaining data. */
							l_con->rc = SQLGetData(l_con->hstmt[no_des], i+1, GetDbCType(dap, i), l_buffer + old_length,
								additional_length, NULL);
						}
					}
				}
			}
			if (l_con->rc) {
				SQLTCHAR	  SqlState[6], Msg[SQL_MAX_MESSAGE_LENGTH];
				SQLINTEGER    NativeError;
				SQLSMALLINT   MsgLen;

				/* Get the status records. */
				if ((SQLGetDiagRec(SQL_HANDLE_STMT, l_con->hstmt[no_des], 1, SqlState, &NativeError,
					Msg, sizeof(Msg), &MsgLen)) != SQL_NO_DATA) {
						/* DisplayError(SqlState,NativeError,Msg,MsgLen); */
				}

				odbc_error_handler(con, l_con->hstmt[no_des],9);
			}
		}
		if (l_con->error_number)
			return 1;
		else
			return 0;
	}
}
/*****************************************************************/
/*                                                               */
/*                     ROUTINE  DESCRIPTION                      */
/*                                                               */
/* NAME: odbc_support_proc()                                     */
/* DESCRIPTION:                                                  */
/*   to determine if the current ODBC Data Source/Driver support */
/* stored procedure: 1-- yes, 0 -- no                            */
/*                                                               */
/*****************************************************************/

int odbc_support_proc() {
	return *storedProc == TXTC('Y') || *storedProc == TXTC('y');
}

/*****************************************************************/
/*                                                               */
/*                    ROUTINE DESCRIPTION                        */
/*                                                               */
/* NAME: odbc_procedure_term()                              	 */
/* DESCRIPTION:                                                  */
/* Return the value of SQL_PROCEDURE_TERM, queried by SQLGetInfo */
/*                                                               */
/*****************************************************************/

SQLTCHAR *odbc_procedure_term (void *con) {
	return CreateStoredProc;
}

/*****************************************************************/
/*                                                               */
/*                    ROUTINE DESCRIPTION                        */
/*                                                               */
/* NAME: odbc_support_infomation_schema()                              */
/* DESCRIPTION:                                                  */
/*  to determine if the current ODBC Data Source/Driver support  */
/* stored procedure table INFORMATION_SCHEMA: 1-- yes, 0-- no                    */
/*                                                               */
/*****************************************************************/
int odbc_support_information_schema() {
	return odbc_info_schema == SQL_IC_MIXED;
}


/*****************************************************************/
/*                                                               */
/*                    ROUTINE DESCRIPTION                        */
/*                                                               */
/* NAME: odbc_driver_name()                                      */
/* DESCRIPTION:                                                  */
/* 	return the name of the driver                                */
/*                                                               */
/*****************************************************************/

SQLTCHAR * odbc_driver_name() {
		return dbmsName;
	}

/*****************************************************************/
/*                                                               */
/*                     ROUTINE  DESCRIPTION                      */
/*                                                               */
/* NAME: odbc_inseneitive_upper()                                */
/*       odbc_insensitive_lower()                                */
/*       odbc_insensitive_mixed()				 */
/*       odbc_sensitive_mixed()					 */
/* DESCRIPTION:                                                  */
/*   Decide if the underlying driver is sensitive to upper/lower */
/* cases, and what format is stored in database.                 */
/*                                                               */
/*****************************************************************/
int odbc_insensitive_upper() {
	return odbc_case == SQL_IC_UPPER;
}


int odbc_insensitive_lower() {
	return odbc_case == SQL_IC_LOWER;
}

int odbc_sensitive_mixed() {
		/* Values for odbc_case should be either SQL_IC_UPPER, SQL_IC_LOWER, SQL_IC_MIXED
		 * or SQL_IC_SENSITIVE. If it is SQL_IC_UNKNOWN(that is to say none of the above), then we consider
		 * it is case sensitive. */
	return (odbc_case == SQL_IC_SENSITIVE) || (odbc_case == SQL_IC_UNKNOWN);
}

int odbc_insensitive_mixed() {
	return odbc_case == SQL_IC_MIXED;
}

void odbc_set_parameter(void *con, int no_desc, int seri, int dir, int eifType, int collen, int value_count, void *value) {

	SQLUSMALLINT seriNumber = (SQLUSMALLINT)seri;
	SQLSMALLINT direction = (SQLSMALLINT)dir;
	SQLSMALLINT l_sql_data_type, l_eiffel_type, l_decimal_digits;
	SQLULEN l_param_size;
	SQLLEN len;
	CON_CONTEXT *l_con = (CON_CONTEXT *)con;
	SQL_NUMERIC_STRUCT *l_num;
	SQLHDESC hdesc = NULL;
	int l_is_binary;

	l_con->pcbValue[no_desc][seriNumber-1] = len = value_count;
	l_con->rc = 0;
	direction = SQL_PARAM_INPUT;
	l_con->rc = SQLDescribeParam(l_con->hstmt[no_desc], seriNumber, &l_sql_data_type, &l_param_size, &l_decimal_digits, NULL);
	if (!l_con->rc) {
		switch (eifType) {
			case EIF_C_CHARACTER_TYPE:
			case EIF_C_STRING_TYPE:
					/* Depending on the size of the columnm the SQL data type is different. Because we do not
					 * know this size, we query SQLDescribParam which gives us an answer. However it is not
					 * perfect because for large strings, the `l_param_size' value will be 0. In which case, we
					 * force the usage of SQL_LONGVARCHAR. See autotests#TEST_LARGE_DATA.
					 * Note that we can only do that if the computed type was not a binary type
					 * as otherwise we would get an error as char is incompatible with binary. See
					 * autotest#TEST_BINARY_CONTENT. */
				l_is_binary = (l_sql_data_type == SQL_VARBINARY) || (l_sql_data_type == SQL_LONGVARBINARY);
				if ((l_param_size == 0) && !l_is_binary) {
						/* Heuristic shows that when it is 0, it means it is unbounded. */
					l_sql_data_type = SQL_LONGVARCHAR;
				}
				if (l_is_binary) {
						/* To avoid having to encode the binary in hexa decimal on the client side,
						 * we just tell that the client side has already done the transformation.
						 * See autotest#TEST_BINARY_CONTENT. */
					l_eiffel_type = SQL_C_BINARY;
				} else {
					l_eiffel_type = SQL_C_CHAR;
				}
				l_con->rc = SQLBindParameter(l_con->hstmt[no_desc], seriNumber, direction, l_eiffel_type, l_sql_data_type, value_count, DB_SIZEOF_CHAR, value, value_count, &(l_con->pcbValue[no_desc][seriNumber-1]));
				break;
			case EIF_C_WSTRING_TYPE:
					/* Depending on the size of the columnm the SQL data type is different. Because we do not
					 * know this size, we query SQLDescribParam which gives us an answer. However it is not
					 * perfect because for large strings, the `l_param_size' value will be 0. In which case, we
					 * force the usage of SQL_WLONGVARCHAR. See autotests#TEST_LARGE_DATA.
					 * Note that we can only do that if the computed type was not a binary type
					 * as otherwise we would get an error as char is incompatible with binary. See
					 * autotest#TEST_BINARY_CONTENT. */
				l_is_binary = (l_sql_data_type == SQL_VARBINARY) || (l_sql_data_type == SQL_LONGVARBINARY);
				if ((l_param_size == 0) && !l_is_binary) {
						/* Heuristic shows that when it is 0, it means it is unbounded. */
					l_sql_data_type = SQL_WLONGVARCHAR;
				}
					/* Note that we always have SQL_C_WCHAR as input even if it is a binary field as it won't make sense
					 * to use a STRING_32 to store binary data, so we will assume that input has been converted to hexa decimal before. */
				l_con->rc = SQLBindParameter(l_con->hstmt[no_desc], seriNumber, direction, SQL_C_WCHAR, l_sql_data_type, value_count, DB_SIZEOF_WCHAR, value, 0, &(l_con->pcbValue[no_desc][seriNumber - 1]));
				break;
			case EIF_C_INTEGER_32_TYPE:
				l_con->rc = SQLBindParameter(l_con->hstmt[no_desc], seriNumber, direction, SQL_C_SLONG, l_sql_data_type, value_count, DB_SIZEOF_INT, value, 0, &(l_con->pcbValue[no_desc][seriNumber - 1]));
				break;
			case EIF_C_INTEGER_16_TYPE:
				l_con->rc = SQLBindParameter(l_con->hstmt[no_desc], seriNumber, direction, SQL_C_SSHORT, l_sql_data_type, value_count, DB_SIZEOF_SHORT, value, 0, &(l_con->pcbValue[no_desc][seriNumber - 1]));
				break;
			case EIF_C_INTEGER_64_TYPE:
				l_con->rc = SQLBindParameter(l_con->hstmt[no_desc], seriNumber, direction, SQL_C_SBIGINT, l_sql_data_type, value_count, DB_SIZEOF_BIGINT, value, 0, &(l_con->pcbValue[no_desc][seriNumber - 1]));
				break;
			case EIF_C_REAL_64_TYPE:
				/* See example: http://msdn.microsoft.com/en-us/library/ms710963%28v=VS.85%29.aspx */
				l_con->rc = SQLBindParameter(l_con->hstmt[no_desc], seriNumber, direction, SQL_C_DOUBLE, l_sql_data_type, l_param_size, l_decimal_digits , value, 0, &(l_con->pcbValue[no_desc][seriNumber - 1]));
				break;
			case EIF_C_REAL_32_TYPE:
				/* See example: http://msdn.microsoft.com/en-us/library/ms710963%28v=VS.85%29.aspx */
				l_con->rc = SQLBindParameter(l_con->hstmt[no_desc], seriNumber, direction, SQL_C_FLOAT, l_sql_data_type, l_param_size, l_decimal_digits, value, 0, &(l_con->pcbValue[no_desc][seriNumber - 1]));
				break;
			case EIF_C_BOOLEAN_TYPE:
				l_con->rc = SQLBindParameter(l_con->hstmt[no_desc], seriNumber, direction, SQL_C_BIT, l_sql_data_type, value_count, DB_SIZEOF_INT, value, 0, &(l_con->pcbValue[no_desc][seriNumber - 1]));
				break;
			case EIF_C_DATE_TYPE:
				len = l_con->pcbValue[no_desc][seriNumber-1] = sizeof(TIMESTAMP_STRUCT);
				l_con->rc = SQLBindParameter(l_con->hstmt[no_desc], seriNumber, direction, SQL_C_TIMESTAMP, l_sql_data_type, 23, 3, value, 0, &(l_con->pcbValue[no_desc][seriNumber - 1]));
				break;
			case EIF_C_DECIMAL_TYPE:
				l_num = (SQL_NUMERIC_STRUCT *)value;
				l_con->rc = SQLBindParameter(l_con->hstmt[no_desc], seriNumber, direction, SQL_C_NUMERIC, l_sql_data_type, l_num->precision, l_num->scale, value, 0, &(l_con->pcbValue[no_desc][seriNumber - 1]));

				/* Modify the fields in the implicit application parameter descriptor */
				/* See example in: http://support.microsoft.com/default.aspx?scid=http://support.microsoft.com:80/support/kb/articles/q181/2/54.asp&NoWebContent=1 */
				SQLGetStmtAttr(l_con->hstmt[no_desc], SQL_ATTR_APP_PARAM_DESC, &hdesc, 0, NULL);
				SQLSetDescField(hdesc, seriNumber, SQL_DESC_TYPE, (SQLPOINTER) SQL_C_NUMERIC, 0);
				SQLSetDescField(hdesc, seriNumber, SQL_DESC_PRECISION, (SQLPOINTER) l_num->precision, 0);
				SQLSetDescField(hdesc, seriNumber, SQL_DESC_SCALE, (SQLPOINTER) l_num->scale, 0);
				SQLSetDescField(hdesc, seriNumber, SQL_DESC_DATA_PTR, (SQLPOINTER) l_num, 0);
				break;
			case EIF_C_NULL_TYPE:
				l_con->pcbValue[no_desc][seriNumber-1] = SQL_NULL_DATA;
					/* We use SQL_C_DEFAULT, since we are just storing NULL. */
				l_con->rc = SQLBindParameter(l_con->hstmt[no_desc], seriNumber, direction, SQL_C_DEFAULT, l_sql_data_type, l_param_size, l_decimal_digits, NULL, 0, &(l_con->pcbValue[no_desc][seriNumber - 1]));
				break;
			default:
				odbc_error_handler(l_con, NULL, 204);
				ATCSTXTCAT(&l_con->error_message, "\nInvalid Data Type in odbc_set_parameter");
				odbc_error_handler(l_con, NULL, 110);
				return;
		}
	}
	if (l_con->rc) {
		odbc_error_handler(l_con, l_con->hstmt[no_desc], l_con->rc);
	}
	return;
}

/*****************************************************************/
/*                                                               */
/*                     ROUTINE  DESCRIPTION                      */
/*                                                               */
/* NAME: odbc_hide_qualifier                                     */
/* PARAMETER: buf -- the content of a SQL command                */
/* DESCRIPTION:                                                  */
/*   When "qualifier" is used to identify an database object,    */
/* we have to hide ":" in the qualifier first, otherwise, it     */
/* will be misinterpreted by feature SQL_SCAN::parse.            */
/*                                                               */
/*****************************************************************/
SQLTCHAR *odbc_hide_qualifier(SQLTCHAR *buf, int char_count) {
	size_t i;
	size_t len = (size_t)char_count;

	for (i=0; i < len; i++) {
		if (buf[i] == TXTC(':') && i > 0 && ((buf[i-1] >= TXTC('a') && buf[i-1] <= TXTC('z')) || (buf[i-1] >=TXTC('A') && buf[i-1] <= TXTC('Z'))))
			buf[i] = 0x1 ;
	}
	return buf;
}

/*****************************************************************/
/*                                                               */
/*                     ROUTINE  DESCRIPTION                      */
/*                                                               */
/* NAME: odbc_unhide_qualifier                                   */
/* PARAMETER: buf -- the content of a SQL command                */
/* DESCRIPTION:                                                  */
/*   When "qualifier" is used to identify an database object,    */
/* we have to hide ":" in the qualifier first, otherwise, it     */
/* will be misinterpreted by feature SQL_SCAN::parse.  After     */
/* the command has been parsed, we should recover the original   */
/* ":" in the qualifier.                                         */
/*                                                               */
/*****************************************************************/
void odbc_unhide_qualifier(SQLTCHAR *buf, int char_count) {
	size_t i;
	size_t len = char_count;

	for (i=0; i < len; i++) {
		if (buf[i] == 0x1 && i > 0 && ((buf[i-1] >= TXTC('a') && buf[i-1] <= TXTC('z')) || (buf[i-1] >=TXTC('A') && buf[i-1] <= TXTC('Z'))))
			buf[i] = TXTC(':') ;
	}
}

/*****************************************************************/
/*                                                               */
/*                     ROUTINE  DESCRIPTION                      */
/*                                                               */
/* NAME: odbc_qualifier_quoter                                   */
/* DESCRIPTION:                                                  */
/*   Return the string used to quote identifiers in SQL command, */
/* For example, if the quoter is `, and we want to select on     */
/* table "my table", we should express the query as:             */
/* select * from `My table`                                      */
/*                                                               */
/*****************************************************************/
SQLTCHAR *odbc_identifier_quoter() {
	return idQuoter;
}

/*****************************************************************/
/*                                                               */
/*                     ROUTINE  DESCRIPTION                      */
/*                                                               */
/* NAME: odbc_qualifier_separator                                */
/* DESCRIPTION:                                                  */
/*   When "qualifier" and "owner" are used to identifier a       */
/* database object, they should be separated by a string called  */
/* "qualifier separator".                                        */
/*                                                               */
/*****************************************************************/
SQLTCHAR *odbc_qualifier_separator() {
	return quaNameSep;
}

/*****************************************************************/
/*                                                               */
/*                     ROUTINE  DESCRIPTION                      */
/*                                                               */
/* NAME: odbc_set_qualifier                                      */
/* PARAMETER: qfy -- the content of qualifier                    */
/* DESCRIPTION:                                                  */
/*   Set qualifier to a global variable. The function is used    */
/* to implement command "SQLTable(table_name)" conveniently.     */
/*                                                               */
/*****************************************************************/
void odbc_set_qualifier(void *con, SQLTCHAR *qfy, int len) {
	CON_CONTEXT *l_con = (CON_CONTEXT *)con;
	RESET_STRING (&l_con->odbc_qualifier);
	if (qfy != NULL) {
		SQLTCSCAT(&l_con->odbc_qualifier, qfy, len);
	}
}

/*****************************************************************/
/*                                                               */
/*                     ROUTINE  DESCRIPTION                      */
/*                                                               */
/* NAME: odbc_set_owner                                          */
/* PARAMETER: owner- the owner                                   */
/* DESCRIPTION:                                                  */
/*   Set owner to     a global variable. The function is used    */
/* to implement command "SQLTable(table_name)" conveniently.     */
/*                                                               */
/*****************************************************************/
void odbc_set_owner(void *con, SQLTCHAR *owner, int len) {
	CON_CONTEXT *l_con = (CON_CONTEXT *)con;
	RESET_STRING (&l_con->odbc_owner);
	if (owner != NULL) {
		SQLTCSCAT(&l_con->odbc_owner, owner, len);
	}
}

/*****************************************************************/
/*The following are the function related with DATABASE CONTROL   */
/*****************************************************************/

/*****************************************************************/
/*                                                               */
/*                     ROUTINE  DESCRIPTION                      */
/*                                                               */
/* NAME: odbc_connect(name,passwd,role,rolePassWd,group,baseName) */
/* PARAMETERS:                                                   */
/*   name - data base user name.                                 */
/*   passwd - data base user's password(no use for ODBC  ).      */
/*   role - data base role name.                                 */
/*   rolePassWd - data base role's password.                     */
/*   group - data base group name.                               */
/*   baseName - the  ODBC  data base which will be used in the   */
/*              current connection.                              */
/* DESCRIPTION:                                                  */
/*   Connect to an  ODBC  database.                              */
/* NOTE: Only the name is mandatory.                             */
/*                                                               */
/*****************************************************************/
void odbc_connect (void *con, SQLTCHAR *name, int name_count, SQLTCHAR *passwd, int passwd_count, SQLTCHAR *dsn, int dsn_count)
{
	CON_CONTEXT *l_con = (CON_CONTEXT *)con;

	odbc_clear_error (con);

	l_con->rc = SQLAllocHandle(SQL_HANDLE_DBC,henv, &l_con->hdbc);
	if (l_con->rc) {
		odbc_error_handler(con, NULL,11);
		return;
	}

	l_con->rc = SQLConnect(l_con->hdbc, dsn, (SQLSMALLINT)dsn_count, name, (SQLSMALLINT)name_count, passwd, (SQLSMALLINT)passwd_count);
	if (l_con->rc<0) {
		odbc_error_handler(con, NULL,12);
		l_con->rc = SQLFreeHandle(SQL_HANDLE_DBC,l_con->hdbc);
		return;
	}

	odbc_fetch_connection_info (con);

}

/*****************************************************************/
/*The following are the function related with DATABASE CONTROL   */
/*****************************************************************/

/*****************************************************************/
/*                                                               */
/*                     ROUTINE  DESCRIPTION                      */
/*                                                               */
/* NAME: odbc_connect_by_string(a_string)						 */
/* PARAMETERS:                                                   */
/*   a_string - connect string.	                                 */
/*              current connection.                              */
/* DESCRIPTION:                                                  */
/*   Connect to an  ODBC  database.                              */
/*                                                               */
/*****************************************************************/
void odbc_connect_by_connection_string (void *con, SQLTCHAR *a_string, int str_count)
{
	CON_CONTEXT *l_con = (CON_CONTEXT *)con;

	odbc_clear_error (con);

	l_con->rc = SQLAllocHandle(SQL_HANDLE_DBC,henv, &l_con->hdbc);
	if (l_con->rc) {
		odbc_error_handler(con, NULL,11);
		return;
	}

	l_con->rc = SQLDriverConnect( // SQL_NULL_HDBC
               l_con->hdbc,
               NULL,
               a_string,
               (SQLSMALLINT)str_count,
               NULL,
               0,
               NULL,
               SQL_DRIVER_NOPROMPT);
	if (l_con->rc<0) {
		odbc_error_handler(con, NULL,12);
		l_con->rc = SQLFreeHandle(SQL_HANDLE_DBC,l_con->hdbc);
		return;
	}

	odbc_fetch_connection_info (con);

}

/*****************************************************************/
/*                                                               */
/*                     ROUTINE  DESCRIPTION                      */
/*                                                               */
/* NAME: odbc_get_connection_info()                              */
/* DESCRIPTION:                                                  */
/*   Get connection info after connection						 */
/*                                                               */
/*****************************************************************/

void odbc_fetch_connection_info (void *con)
{
	SQLSMALLINT indColName;
	CON_CONTEXT *l_con = (CON_CONTEXT *)con;

	l_con->rc = SQLGetInfo(l_con->hdbc, SQL_PROCEDURES, storedProc, sizeof(storedProc), &indColName);
	l_con->rc = SQLGetInfo(l_con->hdbc, SQL_PROCEDURE_TERM, CreateStoredProc, sizeof(CreateStoredProc), &indColName);
	l_con->rc = SQLGetInfo(l_con->hdbc, SQL_DBMS_NAME, dbmsName, sizeof(dbmsName), &indColName);
	l_con->rc = SQLGetInfo(l_con->hdbc, SQL_DBMS_VER, dbmsVer, sizeof(dbmsVer), &indColName);
	l_con->rc = SQLGetInfo(l_con->hdbc, SQL_IDENTIFIER_QUOTE_CHAR, idQuoter, sizeof(idQuoter), &indColName);
	l_con->rc = SQLGetInfo(l_con->hdbc, SQL_QUOTED_IDENTIFIER_CASE, &odbc_case, sizeof(odbc_case), &indColName);
	l_con->rc = SQLGetInfo(l_con->hdbc, SQL_INFO_SCHEMA_VIEWS, &odbc_info_schema, sizeof(odbc_info_schema), &indColName);

	if (indColName == 1 && idQuoter[0] == TXTC(' ')) {
		idQuoter[0] = (SQLTCHAR)0;
	} else {
		idQuoter[indColName] = (SQLTCHAR)0;
	}

	l_con->rc = SQLGetInfo(l_con->hdbc, SQL_CATALOG_NAME_SEPARATOR, quaNameSep, sizeof(quaNameSep), &indColName);
	if (indColName == 1 && quaNameSep[0] == TXTC(' ')) {
		quaNameSep[0] = (SQLTCHAR)0;
	} else {
		quaNameSep[indColName] = (SQLTCHAR)0;
	}
}

/*****************************************************************/
/*                                                               */
/*                     ROUTINE  DESCRIPTION                      */
/*                                                               */
/* NAME: odbc_disconnect()                                       */
/* DESCRIPTION:                                                  */
/*   Disconnect the current connection with an  ODBC  database.  */
/*                                                               */
/*****************************************************************/
void odbc_disconnect (void *con)
{
	int count;
	CON_CONTEXT *l_con = (CON_CONTEXT *)con;

	odbc_clear_error (con);

	/* Call SQLEndTran on connection level rather than environment level.
	* Because we don't want to EndTran on other connections in current enviroment */
	l_con->rc = SQLEndTran(SQL_HANDLE_DBC, l_con->hdbc, SQL_COMMIT);
	if (l_con->rc) {
		odbc_error_handler(con, NULL,13);
	}
	for (count = 0; count < MAX_DESCRIPTOR; count++)
	{
		odbc_terminate_order(con, count);
	}

	l_con->rc = SQLDisconnect(l_con->hdbc);
	if (l_con->rc) {
		odbc_error_handler(con, NULL,14);
	}

	/* odbc_tranNumber was originally set to 0 only if l_con->number_connection <= 1:
	 * this is not consistent with EiffelStore  so all transactions are ended
	 * when disconnecting. Anyway, odbc_tranNumber <= 1.
	 * Cedric */
	l_con->odbc_tranNumber = 0;
}

/*****************************************************************/
/*                                                               */
/*                     ROUTINE  DESCRIPTION                      */
/*                                                               */
/* NAME: odbc_free_connection()                                  */
/* DESCRIPTION:                                                  */
/*   Free odbc connection, if there is no more connection,       */
/*	 free the odbc environment.									 */
/*                                                               */
/*****************************************************************/
void odbc_free_connection (void *con)
{
	CON_CONTEXT *l_con = (CON_CONTEXT *)con;

	/* Error is not accessible by Eiffel */
	SQLFreeHandle (SQL_HANDLE_DBC, l_con->hdbc);
	number_connection--;

	FREE_STRING (&l_con->error_message);
	FREE_STRING (&l_con->warn_message);
	FREE_STRING (&l_con->odbc_qualifier);
	FREE_STRING (&l_con->odbc_owner);
	ODBC_C_FREE(l_con);

	/* When there is no connection any more, we free the environment handle */
	if (number_connection <= 0) {
		/* Error is not accessible by Eiffel */
		SQLFreeHandle (SQL_HANDLE_ENV, henv);
	}
}

/*****************************************************************/
/*                                                               */
/*                     ROUTINE  DESCRIPTION                      */
/*                                                               */
/* NAME: odbc_rollback()                                          */
/* DESCRIPTION:                                                  */
/*   Roll back the current transaction .                         */
/*                                                               */
/*****************************************************************/
void odbc_rollback (void *con)
{
	int count;
	CON_CONTEXT *l_con = (CON_CONTEXT *)con;

	odbc_clear_error (con);
	l_con->rc = SQLEndTran(SQL_HANDLE_DBC, l_con->hdbc, SQL_ROLLBACK);
	if (l_con->rc) {
		odbc_error_handler(con, NULL,17);
	}
	/* Command ROLLBACK closes all open cursors; discards all statements */
	/* that were prepared in the current transaction.                    */
	for (count = 0; count < MAX_DESCRIPTOR; count++)
	{
		odbc_terminate_order(con, count);
	}
	l_con->odbc_tranNumber = 0;

	l_con->rc = SQLSetConnectAttr(l_con->hdbc, SQL_ATTR_AUTOCOMMIT, (SQLPOINTER) SQL_AUTOCOMMIT_ON, 0);
	if (l_con->rc) {
		odbc_error_handler(con, NULL, 12);
	}
}

/*****************************************************************/
/*                                                               */
/*                     ROUTINE  DESCRIPTION                      */
/*                                                               */
/* NAME: odbc_commit()                                            */
/* DESCRIPTION:                                                  */
/*   Commit the current transaction.                             */
/*                                                               */
/*****************************************************************/
void odbc_commit (void *con)
{
	int count;
	CON_CONTEXT *l_con = (CON_CONTEXT *)con;

	odbc_clear_error (con);
	l_con->rc = SQLEndTran(SQL_HANDLE_DBC, l_con->hdbc, SQL_COMMIT);
	if (l_con->rc) {
		odbc_error_handler(con, NULL,18);
	}
	/* Command  COMMIT  closes all open cursors; discards all statements */
	/* that were prepared in the current transaction.                    */
	for (count = 0; count < MAX_DESCRIPTOR; count++)
	{
		odbc_terminate_order(con, count);
	}
	l_con->odbc_tranNumber = 0;

	l_con->rc = SQLSetConnectAttr(l_con->hdbc, SQL_ATTR_AUTOCOMMIT, (SQLPOINTER) SQL_AUTOCOMMIT_ON, 0);
	if (l_con->rc) {
		odbc_error_handler(con, NULL, 12);
	}
}

/*****************************************************************/
/*                                                               */
/*                     ROUTINE  DESCRIPTION                      */
/*                                                               */
/* NAME: odbc_begin()                                             */
/* DESCRIPTION:                                                  */
/*   Begin a data base transaction.                              */
/*                                                               */
/*****************************************************************/
void odbc_begin (void *con)
{
	CON_CONTEXT *l_con = (CON_CONTEXT *)con;
	odbc_clear_error (con);

	l_con->rc = SQLSetConnectAttr(l_con->hdbc, SQL_ATTR_AUTOCOMMIT, (SQLPOINTER) SQL_AUTOCOMMIT_OFF, 0);
	if (l_con->rc) {
		odbc_error_handler(con, NULL, 12);
	}
}

/*****************************************************************/
/*                                                               */
/*                     ROUTINE  DESCRIPTION                      */
/*                                                               */
/* NAME: odbc_trancount()                                         */
/* DESCRIPTION:                                                  */
/*   Return the number of transactions now active.               */
/*                                                               */
/*****************************************************************/
int odbc_trancount (void *con)
{
	CON_CONTEXT *l_con = (CON_CONTEXT *)con;
	return l_con->odbc_tranNumber;
}

/*****************************************************************/
/* Remove trailing spaces				                         */
/*****************************************************************/
/*                                                               */
void string_right_adjust (COUNTABLE_STRING *buf) {
	size_t j;

	if (buf != NULL) {
		for(j=buf->char_count-1;j>=0 && (buf->string)[j]==TXTC(' '); j--);
		j++;
		buf->char_count = j;
	}
}

/*****************************************************************/
/* Set precision and scale when reading from the decimal from ODBC */
/*****************************************************************/
/*                                                               */
void odbc_set_decimal_presicion_and_scale (void *con, int precision, int scale)
{
	CON_CONTEXT *l_con = (CON_CONTEXT *)con;
	l_con->default_precision = precision;
	l_con->default_scale = scale;
}

int odbc_get_count (void *con, int no_des)
{
	CON_CONTEXT *l_con = (CON_CONTEXT *)con;
	if (l_con->odbc_descriptor[no_des] == NULL)
		return -1;

	return GetColNum(l_con->odbc_descriptor[no_des]);
}

SQLTCHAR *odbc_col_name (void *con, int no_des, int index)
{
	CON_CONTEXT *l_con = (CON_CONTEXT *)con;
	int i = index - 1;
	return (((l_con->odbc_descriptor[no_des])->sqlvar)[i]).sqlname.string;
}

size_t odbc_col_name_len (void *con, int no_des, int index)
{
	CON_CONTEXT *l_con = (CON_CONTEXT *)con;
	int i = index - 1;
	return (((l_con->odbc_descriptor[no_des])->sqlvar)[i]).sqlname.char_count;
}

SQLULEN odbc_get_col_len (void *con, int no_des, int index)
{
	CON_CONTEXT *l_con = (CON_CONTEXT *)con;
	int i = index - 1;
	SQLULEN length = GetDbColLength(l_con->odbc_descriptor[no_des], i);

	return length;
}

SQLULEN odbc_get_data_len (void *con, int no_des, int index)
{
  int i = index - 1;
  CON_CONTEXT *l_con = (CON_CONTEXT *)con;
  int type = GetDbCType(l_con->odbc_descriptor[no_des], i);
  SQLULEN length = GetDbColLength(l_con->odbc_descriptor[no_des], i);

  switch (type)
    {
    case SQL_C_TCHAR:
		if (l_con->odbc_indicator[no_des][i] == SQL_NULL_DATA) {
			return 0;
		}
		else {
			return l_con->odbc_indicator[no_des][i];
 		}
	case SQL_C_GUID:
		return 36; /* Length of this format: "958F6235-7877-433A-A1A7-809913122C1E" */
    default:
      return length;
    }
}

int odbc_conv_type (int typeCode)
{
	int type=typeCode;

	switch (type) {
		case SQL_CHAR:
		case SQL_VARCHAR:
		case SQL_LONGVARCHAR:
		case SQL_BINARY:
		case SQL_VARBINARY:
		case SQL_LONGVARBINARY:
		case SQL_SS_XML:
		case SQL_C_GUID:
			return EIF_C_STRING_TYPE;
		case SQL_WCHAR:
		case SQL_WVARCHAR:
		case SQL_WLONGVARCHAR:
			return EIF_C_WSTRING_TYPE;
		case SQL_DECIMAL:
		case SQL_NUMERIC:
			return EIF_C_DECIMAL_TYPE;
		case SQL_FLOAT:
		case SQL_DOUBLE:
			return EIF_C_REAL_64_TYPE;
		case SQL_REAL:
			return EIF_C_REAL_32_TYPE;
		case SQL_TINYINT:
		case SQL_SMALLINT:
			return EIF_C_INTEGER_16_TYPE;
		case SQL_INTEGER:
			return EIF_C_INTEGER_32_TYPE;
		case SQL_BIGINT:
			return EIF_C_INTEGER_64_TYPE;
		case SQL_BIT:
			return EIF_C_BOOLEAN_TYPE;
		case SQL_DATE:
		case SQL_TYPE_DATE:
		case SQL_TIME:
		case SQL_TYPE_TIME:
		case SQL_TIMESTAMP:
		case SQL_TYPE_TIMESTAMP:
			return EIF_C_DATE_TYPE;
		default:
			return EIF_C_UNKNOWN_TYPE;
	}
}


/*****************************************************************/
/*                                                               */
/*                     ROUTINE  DESCRIPTION                      */
/*                                                               */
/* NAME: odbc_row_count()                                         */
/* DESCRIPTION:                                                  */
/*   SQLRowCount returns the number of rows affected by an UPDATE, */
/*   INSERT, or DELETE statement; an SQL_ADD,                     */
/*   SQL_UPDATE_BY_BOOKMARK, or SQL_DELETE_BY_BOOKMARK operation */ 
/*   in SQLBulkOperations; or an SQL_UPDATE or SQL_DELETE 
/*	 operation in SQLSetPos..    					             */
/*                                                                */
/*****************************************************************/

SQLLEN odbc_row_count(void *con, int no_desc){
	SQLLEN  RowCount;
	CON_CONTEXT *l_con = (CON_CONTEXT *)con;
	l_con->rc = SQLRowCount(l_con->hstmt[no_desc], &RowCount); 
	return RowCount;
}


int odbc_get_col_type (void *con, int no_des, int index)
{
	CON_CONTEXT *l_con = (CON_CONTEXT *)con;
	int i = index - 1;

	return odbc_conv_type (GetDbColType(l_con->odbc_descriptor[no_des], i));
}

SQLULEN odbc_put_data (void *con, int no_des, int index, char **result)
{
  int i = index -1;
  SQLGUID *g;
  SQLLEN odbc_tmp_indicator;
  CON_CONTEXT *l_con = (CON_CONTEXT *)con;
  ODBCSQLDA * dap = l_con->odbc_descriptor[no_des];
  int data_type = GetDbCType (dap, i);

  odbc_tmp_indicator = l_con->odbc_indicator[no_des][i];
  if (odbc_tmp_indicator == SQL_NULL_DATA) {
	return 0;
  }

  switch (data_type) {
		case SQL_C_GUID:
			g = (SQLGUID *)GetDbColPtr(dap, i);
				/* We allocate 37 because `snprintf' will add a null terminating character. */
			*result = (char *)malloc(37);
			snprintf (*result, 37,
				"%08lX-%04X-%04X-%02X%02X-%02X%02X%02X%02X%02X%02X",
				(unsigned long) g->Data1,
				g->Data2, g->Data3,
				g->Data4[0], g->Data4[1], g->Data4[2], g->Data4[3],
				g->Data4[4], g->Data4[5], g->Data4[6], g->Data4[7]);
			return 36; /* Length of format "958F6235-7877-433A-A1A7-809913122C1E" */
		default:
			*result = malloc(odbc_tmp_indicator);
			memcpy(*result, GetDbColPtr(dap, i), odbc_tmp_indicator);
			return(odbc_tmp_indicator);
  }
}

SQLINTEGER odbc_get_integer_data (void *con, int no_des, int index)
{
  int i  = index - 1;
  int result;
  CON_CONTEXT *l_con = (CON_CONTEXT *)con;
  ODBCSQLDA * dbp = l_con->odbc_descriptor[no_des];
  long  lint;
  int data_type;

	data_type = GetDbCType(dbp, i);

	if (l_con->odbc_indicator[no_des][i] == SQL_NULL_DATA) {
	/* the retrieved value is NULL, we use 0 to be NULL value */
		return 0;
	}

	switch (data_type) {
		case SQL_C_SLONG:
			memcpy((char *)(&lint), GetDbColPtr(dbp, i), DB_SIZEOF_LONG);
			result = lint;
			return result;
		default:
			ATCSTXTCAT(&l_con->error_message, "\nError INTEGER type or data length in odbc_get_integer_data. ");
			if (l_con->error_number) {
				return 0;
			}
			else {
				l_con->error_number = -DB_ERROR-1;
				return 0;
			}
	}
}

SQLSMALLINT odbc_get_integer_16_data (void *con, int no_des, int index)
{
  int i  = index - 1;
  SQLSMALLINT result;
  CON_CONTEXT *l_con = (CON_CONTEXT *)con;
  ODBCSQLDA * dbp = l_con->odbc_descriptor[no_des];
  SQLSMALLINT sint = 0;
  int data_type;

	data_type = GetDbCType(dbp, i);

	if (l_con->odbc_indicator[no_des][i] == SQL_NULL_DATA) {
	/* the retrieved value is NULL, we use 0 to be NULL value */
		return 0;
	}

	switch (data_type) {
		case SQL_C_STINYINT:
			result = *((char *)(dbp->sqlvar)[i].sqldata);
			return result;
		case SQL_C_SSHORT:
			memcpy((char *)(&sint), GetDbColPtr(dbp, i), DB_SIZEOF_SHORT);
			result = sint;
			return result;
		default:
			ATCSTXTCAT(&l_con->error_message, "\nError INTEGER_16 type or data length in odbc_get_integer_data. ");
			if (l_con->error_number) {
				return 0;
			}
			else {
				l_con->error_number = -DB_ERROR-1;
				return 0;
			}
	}
}

EIF_INTEGER_64 odbc_get_integer_64_data (void *con, int no_des, int index)
{
  int i  = index - 1;
  EIF_INTEGER_64 result;
  CON_CONTEXT *l_con = (CON_CONTEXT *)con;
  ODBCSQLDA * dbp = l_con->odbc_descriptor[no_des];
  EIF_INTEGER_64 bint;
  int data_type;

	data_type = GetDbCType(dbp, i);

	if (l_con->odbc_indicator[no_des][i] == SQL_NULL_DATA) {
	/* the retrieved value is NULL, we use 0 to be NULL value */
		return 0;
	}

	switch (data_type) {
		case SQL_C_SBIGINT:
			memcpy((char *)(&bint), GetDbColPtr(dbp, i), DB_SIZEOF_BIGINT);
			result = bint;
			return result;
		default:
			ATCSTXTCAT(&l_con->error_message, "\nError INTEGER_64 type or data length in odbc_get_integer_data. ");
			if (l_con->error_number) {
				return 0;
			}
			else {
				l_con->error_number = -DB_ERROR-1;
				return 0;
			}
	}
}

int odbc_get_boolean_data (void *con, int no_des, int index)
{
  int i = index - 1;
  CON_CONTEXT *l_con = (CON_CONTEXT *)con;
  ODBCSQLDA * dbp = l_con->odbc_descriptor[no_des];
  int data_type = GetDbCType (dbp,i);

  if (data_type == SQL_C_BIT) {
	if (l_con->odbc_indicator[no_des][i] == SQL_NULL_DATA) {
	/* the retrived value is NULL, we use false to be NULL value */
		return 0;
	}
	return *((char *)(GetDbColPtr(dbp, i))) != 0;
    }
  ATCSTXTCAT(&l_con->error_message, "\nError BOOLEAN type in odbc_get_boolean_data. ");
  if (l_con->error_number) {
		return 0;
  }
  else {
		l_con->error_number = -DB_ERROR-2;
		return 0;
  }
}

double odbc_get_float_data (void *con, int no_des, int index)
{
	int i = index - 1;
	double result_double;
	CON_CONTEXT *l_con = (CON_CONTEXT *)con;
	ODBCSQLDA * dbp = l_con->odbc_descriptor[no_des];
	SQL_NUMERIC_STRUCT NumStr;
	int data_type;

	data_type = GetDbCType (dbp, i);

	if ( data_type == SQL_C_DOUBLE ) {
		if (l_con->odbc_indicator[no_des][i] == SQL_NULL_DATA) {
			/* the retrieved value is NULL, we use 0.0 to be NULL value and we indicate it*/
			return 0.0;
		}
		memcpy((char *)(&result_double), GetDbColPtr(dbp, i), DB_SIZEOF_DOUBLE);
		/* result = *(double *)(dbp->sqlvar)[i].sqldata; */
		return  result_double;
	} else if (data_type == SQL_C_NUMERIC){
		if (l_con->odbc_indicator[no_des][i] == SQL_NULL_DATA) {
			/* the retrieved value is NULL, we use 0.0 to be NULL value and we indicate it*/
			return 0.0;
		}
		memcpy((char *)(&NumStr), GetDbColPtr(dbp, i), sizeof (SQL_NUMERIC_STRUCT));
		return c_numeric_to_real_64(&NumStr);
	}
	ATCSTXTCAT(&l_con->error_message, "\nError  FLOAT  type in odbc_get_float_data. ");
	if (l_con->error_number) {
		return 0.0;
	}
	else {
		l_con->error_number = -DB_ERROR-3;
		return 0.0;
	}
}

float odbc_get_real_data (void *con, int no_des, int index)
{
  int i = index - 1;
  float result_real;
  CON_CONTEXT *l_con = (CON_CONTEXT *)con;
  ODBCSQLDA * dbp = l_con->odbc_descriptor[no_des];
  int data_type;

  data_type = GetDbCType (dbp, i);
  if (data_type == SQL_C_FLOAT)  {
	if (l_con->odbc_indicator[no_des][i] == SQL_NULL_DATA) {
	/* the retrieved value is NULL, we use 0.0 to be NULL value */
		return 0.0;
	}
	memcpy((char *)(&result_real), GetDbColPtr(dbp, i), DB_SIZEOF_REAL);
	/* result_real = *(float *)(dbp->sqlvar)[i].sqldata; */
	return   result_real;
  }
  ATCSTXTCAT(&l_con->error_message, "\nError  REAL   type in odbc_get_real_data. ");
  if (l_con->error_number) {
		return 0.0;
  }
  else {
		l_con->error_number = -DB_ERROR-4;
		return 0.0;
  }
}

/* The following function tell whether the retrieved data is null or not */
int odbc_is_null_data(void *con, int no_des, int index)
{
	CON_CONTEXT *l_con = (CON_CONTEXT *)con;
	return (l_con->odbc_indicator[no_des][index-1] == SQL_NULL_DATA);
}

/*****************************************************************/
/*  The following function deal with the DATE data of  ODBC      */
/*****************************************************************/

int odbc_get_date_data (void *con, int no_des, int index)
{
  int i = index - 1;
  CON_CONTEXT *l_con = (CON_CONTEXT *)con;
  ODBCSQLDA   * dbp = l_con->odbc_descriptor[no_des];
  DATE_STRUCT *dateP;
  TIMESTAMP_STRUCT *stampP;
  TIME_STRUCT *timeP;
  int data_type;

  data_type = GetDbCType(dbp, i);
  /* if (data_type == SQL_C_DATE || data_type == SQL_C_TIMESTAMP || data_type == SQL_C_TIME) */
  if (data_type == SQL_C_TYPE_DATE || data_type == SQL_C_TYPE_TIMESTAMP || data_type == SQL_C_TYPE_TIME)
    {
	if (l_con->odbc_indicator[no_des][i] == SQL_NULL_DATA) {
	/* the retrived value is NULL, we use 01/01/1991 0:0:0 to be NULL value
		l_con->odbc_date.year = 1991;
		l_con->odbc_date.month = 1;
		l_con->odbc_date.day = 1;
		l_con->odbc_date.hour = 0;
		l_con->odbc_date.minute = 0;
		l_con->odbc_date.second = 0;
	*/
		return 0;
	}
	/* if (data_type == SQL_C_DATE) { */
	if (data_type == SQL_C_TYPE_DATE) {
		dateP = (DATE_STRUCT *)(GetDbColPtr(dbp, i));
		l_con->odbc_date.year = dateP->year;
		l_con->odbc_date.month = dateP->month;
		l_con->odbc_date.day = dateP->day;
		l_con->odbc_date.hour = 0;
		l_con->odbc_date.minute = 0;
		l_con->odbc_date.second = 0;
		return 1;
	}
	/* if (data_type == SQL_C_TIMESTAMP) { */
	if (data_type == SQL_C_TYPE_TIMESTAMP) {
		stampP = (TIMESTAMP_STRUCT *)(GetDbColPtr(dbp, i));
		l_con->odbc_date.year = stampP->year;
		l_con->odbc_date.month = stampP->month;
		l_con->odbc_date.day = stampP->day;
		l_con->odbc_date.hour = stampP->hour;
		l_con->odbc_date.minute = stampP->minute;
		l_con->odbc_date.second = stampP->second;
		return 1;
	}
	/* if (data_type == SQL_C_TIME) { */
	if (data_type == SQL_C_TYPE_TIME) {
		timeP = (TIME_STRUCT *)(GetDbColPtr(dbp, i));
		l_con->odbc_date.year = 1991;
		l_con->odbc_date.month = 1;
		l_con->odbc_date.day = 1;
		l_con->odbc_date.hour = timeP->hour;
		l_con->odbc_date.minute = timeP->minute;
		l_con->odbc_date.second = timeP->second;
		return 1;
	}

    }
  ATCSTXTCAT(&l_con->error_message, "\nError DATE type in odbc_get_date_data. ");
  if (l_con->error_number) {
		return 0;
  }
  else {
		l_con->error_number = -DB_ERROR-5;
		return 0;
  }
}

int odbc_get_decimal (void *con, int no_des, int index, void *p)
{
	int i = index - 1;
	CON_CONTEXT *l_con = (CON_CONTEXT *)con;
	ODBCSQLDA   * dbp = l_con->odbc_descriptor[no_des];
	int data_type;

	data_type = GetDbCType(dbp, i);
	if (data_type == SQL_C_NUMERIC) {
		memcpy((char *)p, GetDbColPtr(dbp, i), sizeof (SQL_NUMERIC_STRUCT));
		return 1;
	}

	ATCSTXTCAT(&l_con->error_message, "\nError DECIMAL type in odbc_get_decimal. ");
	if (l_con->error_number) {
		return 0;
	}
	else {
		l_con->error_number = -DB_ERROR-5;
		return 0;
	}
}

int odbc_get_year(void *con)
{
	return ((CON_CONTEXT *)con)->odbc_date.year;
}

int odbc_get_month(void *con)
{
	return ((CON_CONTEXT *)con)->odbc_date.month;
}

int odbc_get_day(void *con)
{
	return ((CON_CONTEXT *)con)->odbc_date.day;
}

int odbc_get_hour(void *con)
{
	return ((CON_CONTEXT *)con)->odbc_date.hour;
}

int odbc_get_min(void *con)
{
	return ((CON_CONTEXT *)con)->odbc_date.minute;
}

int odbc_get_sec(void *con)
{
	return ((CON_CONTEXT *)con)->odbc_date.second;
}

/*****************************************************************/
/*  The following functions are related with the error processing*/
/*****************************************************************/

int odbc_get_error_code (void *con)
{
	return ((CON_CONTEXT *)con)->error_number;
}

SQLTCHAR * odbc_get_error_message (void *con)
{
	return ((CON_CONTEXT *)con)->error_message.string;
}

SQLTCHAR * odbc_get_warn_message (void *con)
{
	return ((CON_CONTEXT *)con)->warn_message.string;
}

size_t odbc_get_error_message_count (void *con)
{
	return ((CON_CONTEXT *)con)->error_message.char_count;
}

size_t odbc_get_warn_message_count (void *con)
{
	return ((CON_CONTEXT *)con)->warn_message.char_count;
}


void odbc_clear_error (void *con)
{
	CON_CONTEXT *l_con = (CON_CONTEXT *)con;
	l_con->error_number = 0;
	RESET_STRING(&l_con->error_message);
	RESET_STRING(&l_con->warn_message);
}

void odbc_error_handler(CON_CONTEXT *con, HSTMT h_err_stmt, int code) {
	CON_CONTEXT *l_con = con;
	char charBuf[255];

	if (h_err_stmt == NULL) {
		l_con->error_number = DB_ERROR;
		snprintf(charBuf, sizeof(charBuf), "ODBC ERROR: <%d>, Inter code: <%d>\n", l_con->error_number, code);
		ATCSTXTCAT(&l_con->error_message, charBuf);

		if (code == 12) {
			ATCSTXTCAT(&l_con->error_message, "\n Can't Connect to the assigned Data Source!");
			ATCSTXTCAT(&l_con->error_message, "\n The name may be misspelled or \n The data source is being used by someone else exclusively!");
		}
		return;
	}

	switch(l_con->rc) {
	case SQL_INVALID_HANDLE:
		l_con->error_number = DB_SQL_INVALID_HANDLE;
		snprintf(charBuf, sizeof(charBuf), "ODBC ERROR: <%d>, Inter code: <%d>", l_con->error_number, code);
		ATCSTXTCAT(&l_con->error_message, charBuf);

		ATCSTXTCAT(&l_con->error_message, "\n An Application programming error occurred: maybe passed ");
		ATCSTXTCAT(&l_con->error_message, "\n invalid environment, connection or statement handle to ");
		ATCSTXTCAT(&l_con->error_message, "\n Driver Manager of ODBC. \n");

		break;
	case SQL_ERROR:
		l_con->error_number = DB_SQL_ERROR;
		snprintf(charBuf, sizeof(charBuf), "ODBC ERROR: <%d>, Inter code: <%d>", l_con->error_number, code);
		ATCSTXTCAT(&l_con->error_message, charBuf);
		odbc_retrieve_error_message (con, h_err_stmt, &l_con->error_message);
		break;
	case SQL_SUCCESS_WITH_INFO:
		snprintf(charBuf, sizeof(charBuf), "\nODBC WARNING Inter code: <%d>", code);
		ATCSTXTCAT(&l_con->warn_message, charBuf);
		odbc_retrieve_error_message (con, h_err_stmt, &l_con->warn_message);
		break;
	default:
		snprintf(charBuf, sizeof(charBuf), "\nODBC WARNING Inter code: <%d>", code);
		RESET_STRING(&l_con->warn_message);
		ATCSTXTCAT(&l_con->warn_message, charBuf);
		break;
	}
}

/* Retrieve message into `error', by calling `SQLGetDiagRec', when there is an error or a warning */
void odbc_retrieve_error_message (CON_CONTEXT *con, HSTMT h_err_stmt, COUNTABLE_STRING *error_string)
{
	SQLSMALLINT msg_number = 1;
	SQLINTEGER nErr;
	COUNTABLE_STRING msg_buf;
	SQLSMALLINT cbMsg;
	SQLTCHAR tmpSQLSTATE[6]; /* five-character SQLSTATE */
	char charBuf[255];

	memset(&msg_buf, 0, sizeof(COUNTABLE_STRING));
	while (SQLGetDiagRec(SQL_HANDLE_STMT, h_err_stmt, msg_number, tmpSQLSTATE, &nErr, NULL, 0, &cbMsg) != SQL_NO_DATA) {
		ENSURE_STRING_REMAINING_SIZE (&msg_buf, cbMsg);
		SQLGetDiagRec(SQL_HANDLE_STMT, h_err_stmt, msg_number, tmpSQLSTATE, &nErr, msg_buf.string, (SQLSMALLINT)msg_buf.capacity, &cbMsg);
		msg_buf.char_count = cbMsg;
		snprintf(charBuf, sizeof(charBuf), "\n Native Err#=%d , SQLSTATE=", (int) nErr);
		ATCSTXTCAT(error_string, charBuf);
		SQLTCSCAT(error_string, tmpSQLSTATE, TXTLEN(tmpSQLSTATE)); /* tmpSQLSTATE does not contain %U character, TXTLEN is safe */
		ATCSTXTCAT(error_string, ", Error_Info='");

		CSTXTCAT(error_string, &msg_buf);
		ATCSTXTCAT(error_string, "'");
		msg_number++;
	}
	ATCSTXTCAT(error_string, "\n");
	FREE_STRING (&msg_buf);
}

SQLSMALLINT odbc_c_type(SQLSMALLINT odbc_type) {
	switch(odbc_type) {
		case SQL_CHAR:
		case SQL_VARCHAR:
		case SQL_LONGVARCHAR:
		case SQL_SS_XML:
			return SQL_C_CHAR;
		case SQL_WCHAR:
		case SQL_WVARCHAR:
		case SQL_WLONGVARCHAR:
			return SQL_C_WCHAR;
		/* case SQL_DATE: */
		case SQL_TYPE_DATE:
			/* return SQL_C_DATE; */
			return SQL_C_TYPE_DATE;
		/* case SQL_TIME: */
		case SQL_TYPE_TIME:
			/* return SQL_C_TIME; */
			return SQL_C_TYPE_TIME;
		/* case SQL_TIMESTAMP:*/
		case SQL_TYPE_TIMESTAMP:
			/* return SQL_C_TIMESTAMP; */
			return SQL_C_TYPE_TIMESTAMP;
		case SQL_BIT:
			return SQL_C_BIT;
		case SQL_TINYINT:
			return SQL_C_STINYINT;
		case SQL_SMALLINT:
			return SQL_C_SSHORT;
		case SQL_INTEGER:
			return SQL_C_SLONG;
		case SQL_BIGINT:
			return SQL_C_SBIGINT;
		case SQL_REAL:
			return SQL_C_FLOAT;
		case SQL_DOUBLE:
		case SQL_FLOAT:
			return SQL_C_DOUBLE;
		case SQL_DECIMAL:
		case SQL_NUMERIC:
			return SQL_C_NUMERIC;
		case SQL_BINARY:
		case SQL_VARBINARY:
		case SQL_LONGVARBINARY:
			return SQL_C_BINARY;
		case SQL_GUID:
			return SQL_C_GUID;
		default:
			return SQL_C_DEFAULT;
	}
}

rt_private void change_to_low (SQLTCHAR *buf, size_t length) {
	/* Do not care about non-ASCII characters. */
	size_t i = length;
	for (i = length; i >= 0 && i <= length; i--)
		buf[i] = (buf[i] > 0xFF) ? buf[i] : (SQLTCHAR) tolower(buf[i]);
}

size_t sqlstrlen(const SQLTCHAR *str)
{
	int i;
	for (i=0; str[i]!=(SQLTCHAR)0; i++){};
	return (size_t)i;
}

/* Copy ASCII chars from strSource into wide strDestination, starting from `pos' of strDestination. */
/* Note: `pos' must be valid to strDestination */
rt_private SQLTCHAR *sqlstrcpy(SQLTCHAR *strDestination, int pos, const char *strSource)
{
	int i;
	for (i=0;strSource[i]!=(char)0;i++)
	{
		strDestination[i+pos] = (SQLTCHAR)strSource[i];
	}
	strDestination[i+pos] = (SQLTCHAR)0;
	return strDestination;
}

/* Find name paranthesed in `sqlStat', copy the name into `buf' */
/* Return: non-zero length if found */
rt_private int find_name (SQLTCHAR *buf, int buf_count, SQLTCHAR * sqlStat, int sqlStat_count)
{
	int i, j;
	for (i=COMPARED_LENGTH; sqlStat[i] != TXTC('(') && i < sqlStat_count - 1; i++);
	if (i < sqlStat_count - 1 && sqlStat[i] == TXTC('(')) {
		i++;
	} else {
		buf[0] = (SQLTCHAR)0;
		return 0; /* Did not find '(', and we don't care the last character here. */
	}
	j = i; /* The next position to '(' */
	for (; sqlStat[i] != TXTC('\'') && i < sqlStat_count; i++);
	if (i >= sqlStat_count) {
		i = j; /* Did not find '\'', Go back to the next position to '(' */
	} else {
		i++; /* Move to the next position to '\''. It is possible to move off, it will be handled in the following loop. */
	}
	for (j=0; sqlStat[i] != TXTC(')') && j < buf_count - 1 && i < sqlStat_count && sqlStat[i] != TXTC('\''); i++, j++) {
		buf[j] = sqlStat[i];
	}
	buf[j] = (SQLTCHAR)0;
	return j;
}

/* Convert little endian mode of `NumStr' to a real 64-bit using the same rounding errors as converting
 * a string value to a REAL_64 as done in class {STRING_TO_REAL_CONVERTOR}.parse_string_with_type.
 * Currently it means converting the hex representation into a digit sequence and then converting it to
 * a REAL_64. */
rt_private EIF_REAL_64 c_numeric_to_real_64 (SQL_NUMERIC_STRUCT *NumStr)
{
	EIF_NATURAL_64 value, last, current;
		/* 20 digits max in a NATURAL_64 plus NULL terminating character.*/
	char l_buffer[21];
	EIF_REAL_64 l_fractional_part, l_natural_part, l_divisor, l_result;
	int len;
	int i = 1;

	value = 0; last = 1; 

		/* Currently we cannot represent more than 64-bit. */
	for (i = 0; i <= 0x07; i++) {
		current = (EIF_NATURAL_64)NumStr->val[i];
		value += last*current;
		last = last * 256;
	}

	len = snprintf(l_buffer, 21, "%" EIF_NATURAL_64_DISPLAY, value);
	if (len > 0) {
		l_natural_part = 0.0;
		l_fractional_part = 0.0;
		l_divisor = 1.0;
			/* Read the natural part. */
		for (i = 0; i < len - NumStr->scale; i++) {
			l_natural_part = l_natural_part * 10.0 + (l_buffer[i] - 48);
		}
			/* Read the fractional part. */
		for (i = len - NumStr->scale; i < len; i++) {
			l_fractional_part = l_fractional_part * 10.0 + (l_buffer[i] - 48);
			l_divisor = l_divisor * 10.0;
		}
		l_result = l_natural_part + l_fractional_part / l_divisor;
	} else {
			/* An error occurred. We convert using the poor method which is different
			 * from the Eiffel class. */
		l_result = (double) value / pow (10.0, NumStr->scale);
	}
	
	if (NumStr->sign) {
		return l_result;
	} else {
		return -l_result;
	}
}

rt_public EIF_NATURAL_64 strhextoval(SQL_NUMERIC_STRUCT *NumStr)
{
	EIF_NATURAL_64 value, last, current;
	int i = 1;

	value = 0; last = 1;

		/* Currently we cannot represent more than 64-bit. */
	for (i = 0; i <= 0x07; i++) {
		current = (EIF_NATURAL_64)NumStr->val[i];
		value += last*current;
		last = last * 256;
	}
	return value;
}



