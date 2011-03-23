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

#include <stdio.h>
#include <string.h>
#include "odbc.h"
#include <ctype.h>

void odbc_error_handler (HSTMT,int);
void odbc_clear_error (void);
void odbc_unhide_qualifier(SQLTCHAR *);
int	 odbc_c_type(int odbc_type);

void odbc_close_cursor (int no_des);
EIF_NATURAL_64 strhextoval(SQL_NUMERIC_STRUCT *NumStr);
rt_private SQLTCHAR *sqlstrcpy(SQLTCHAR *strDestination, int pos, const char *strSource);
rt_private int find_name (SQLTCHAR *buf, SQLTCHAR * sqlStat);
void setup_result_space (int no_desc);
void free_sqldata (ODBCSQLDA *dap);

/* Safe allocation and memory reset */\
#define ODBC_SAFE_CLEAN_ALLOC(p,function,size) \
	ODBC_SAFE_ALLOC(p,function); \
	if (p) {memset (p, 0, size);}

/*
SQLTXTCMP	- SQL text cmp
SQLTXTCPY	- SQL text copy
ATSTXTCPY	- ASCII to SQL text copy
SQLTXTCAT	- SQL text cat
ATSTXTCAT	- ASCII to SQL text cat
*/

#define SQLTXTCMP(x1,x2) 	(memcmp(x1, x2, TXTLEN(x2)*sizeof(SQLTCHAR)))
#define SQLTXTCPY(s1,s2)	 (memcpy(s1, s2, (TXTLEN(s2)+1)*sizeof(SQLTCHAR)))
#define ATSTXTCPY(s1,s2)	 (sqlstrcpy(s1, 0, s2))
#define SQLTXTCAT(s1,s2)	(SQLTXTCPY((SQLTCHAR *)s1+TXTLEN(s1), s2))
#define ATSTXTCAT(s1,s2)	(sqlstrcpy(s1, TXTLEN(s1), s2))

#define TXTC(x)  ((SQLTCHAR) x)


ODBCSQLDA * odbc_descriptor[MAX_DESCRIPTOR];
short   flag[MAX_DESCRIPTOR];
SQLHSTMT   hstmt[MAX_DESCRIPTOR];
SQLHDESC	hdesc = NULL;
SQLLEN *pcbValue[MAX_DESCRIPTOR];
HENV    henv;
HDBC    hdbc;
SQLLEN *odbc_indicator[MAX_DESCRIPTOR];
SQLLEN odbc_tmp_indicator;
RETCODE rc;
TIMESTAMP_STRUCT odbc_date;
SQLTCHAR odbc_date_string[DB_DATE_LEN];

SQLTCHAR odbc_qualifier[DB_MAX_QUALIFIER_LEN];
SQLTCHAR odbc_owner[DB_MAX_USER_NAME_LEN];
SQLTCHAR idQuoter[DB_QUOTER_LEN];
SQLTCHAR quaNameSep[DB_NAME_SEP_LEN];
long odbc_case;
long odbc_info_schema;
SQLTCHAR storedProc[2];
SQLTCHAR CreateStoredProc[DB_MAX_NAME_LEN];
SQLTCHAR dbmsName[DB_MAX_NAME_LEN];
SQLTCHAR dbmsVer[DB_MAX_NAME_LEN];
// Added for multiple connection
short number_connection=0;

/* Messages: Are not exported to Eiffel due to
merge with Oracle variables when using both files.
Wrapping functions are used.*/
rt_private SQLTCHAR *error_message = NULL;
rt_private SQLTCHAR *warn_message = NULL;
rt_private int error_number = 0;

static int data_type = 0, size = 0, max_size = 0;
SQLTCHAR odbc_user_name[40];

short odbc_tranNumber=0; /* number of transaction opened at present */

rt_private void change_to_low(SQLTCHAR *buf, int length);

int is_null_data;

char charBuf[255];

/* each function return 0 in case of success */
/* and database error code ( >= 1) else */

/*****************************************************************/
/* initialise ODBC   c-module                                    */
/*****************************************************************/

void c_odbc_make (int m_size)
{
  int count;

  if (error_message == NULL) {
	 ODBC_SAFE_ALLOC(error_message, (SQLTCHAR *) malloc (sizeof (SQLTCHAR) * (m_size + ERROR_MESSAGE_SIZE)));
	 ODBC_SAFE_ALLOC(warn_message, (SQLTCHAR *) malloc (sizeof (SQLTCHAR) * (m_size + WARN_MESSAGE_SIZE)));
  }

  odbc_clear_error ();
  max_size = m_size;

  for (count = 0; count < MAX_DESCRIPTOR; count++)
      odbc_descriptor[count] = NULL;
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
int odbc_new_descriptor ()
{
  int result = odbc_first_descriptor_available ();

  if (result != NO_MORE_DESCRIPTOR)
    {
      //rc = SQLAllocStmt(hdbc, &(hstmt[result]));
      rc = SQLAllocHandle (SQL_HANDLE_STMT, hdbc, &(hstmt[result]));
      if (rc) {
		odbc_error_handler(NULL, 0);
		return NO_MORE_DESCRIPTOR;
      }

      /* malloc area for the descriptor and then initialize it */
	  /* Initially allocate head size plus one var size. 
	   * Previously we set odbc_descriptor[result] as arbitary pointer 0x1 which is not good */
      ODBC_SAFE_ALLOC(odbc_descriptor[result], (ODBCSQLDA *) calloc(IISQDA_HEAD_SIZE + IISQDA_VAR_SIZE, 1));
	  SetVarNum(odbc_descriptor[result], 1);
	  ODBC_C_FREE (pcbValue[result]);
      pcbValue[result] = NULL;
	  ODBC_C_FREE (odbc_indicator[result]);
      odbc_indicator[result] = NULL;
      flag[result] = ODBC_SQL;
    }
  else {
	odbc_error_handler(NULL, 201);
	ATSTXTCPY(error_message, " No available descriptor\n");
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
int odbc_first_descriptor_available (void)
{
  int no_descriptor;


  for (no_descriptor = 0;
       no_descriptor < MAX_DESCRIPTOR &&
       odbc_descriptor[no_descriptor] != NULL;
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
int odbc_available_descriptor ()
{
  return odbc_first_descriptor_available () != NO_MORE_DESCRIPTOR;
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
void odbc_pre_immediate(int no_desc, int argNum) {


	odbc_clear_error();

	if (no_desc < 0 || no_desc > MAX_DESCRIPTOR) {
		odbc_error_handler(NULL, 202);
		ATSTXTCAT(error_message, "\nInvalid Descriptor Number!");
		return;
	}
	if (argNum > 0) {
		/* Reset memory to be safe */
		ODBC_SAFE_ALLOC(pcbValue[no_desc], (SQLLEN *) calloc(argNum, sizeof(SQLLEN)));
	} else {
		ODBC_C_FREE (pcbValue[no_desc]);
		pcbValue[no_desc] = NULL;
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
void odbc_exec_immediate (int no_desc, SQLTCHAR *order)
{


	odbc_unhide_qualifier(order);
	odbc_tranNumber = 1;
	warn_message[0] = (SQLTCHAR)0;

	rc = SQLExecDirect(hstmt[no_desc], order, SQL_NTS);
	free_sqldata (odbc_descriptor[no_desc]);
	odbc_descriptor[no_desc] = NULL;
	if (rc) {
		odbc_error_handler(hstmt[no_desc], 2);
	}
	//rc = SQLFreeStmt(hstmt[no_desc], SQL_DROP);
	rc = SQLFreeHandle (SQL_HANDLE_STMT, hstmt[no_desc]);
	if (rc) {
		odbc_error_handler(hstmt[no_desc],3);
	}
	free_sqldata (odbc_descriptor[no_desc]);
	odbc_descriptor[no_desc] = NULL;
	if (pcbValue[no_desc] != NULL) {
		ODBC_C_FREE(pcbValue[no_desc]);
		pcbValue[no_desc] = NULL;
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
/*   1. get the SQL statement PREPAREd; and check if there are   */
/*      warning message for the SQL statement;                   */
/*   2. DESCRIBE the SQL statement and get enough information to */
/*      allocate enough memory space for the corresponding       */
/*      ODBCSQLDA.                                               */
/*   3. return error number.                                     */
/*                                                               */
/*****************************************************************/
void odbc_init_order (int no_desc, SQLTCHAR *order, int argNum)
{
	int is_as_primary = 0;
	size_t order_count, buf_count;

#define COMPARED_BTYES	(9 * sizeof (SQLTCHAR))
#define COMPARED_LENGTH	(9)

	SQLTCHAR tmpBuf[DB_MAX_TABLE_LEN + 1];
	SQLTCHAR sqltab[30];
	SQLTCHAR sqlcol[30];
	SQLTCHAR sqlproc[30];
	SQLTCHAR sqlpk[30];
	SQLTCHAR sqlfk[30];
	SQLTCHAR sqlfk_as_primary[30];

	ATSTXTCPY(sqltab, "sqltables");
	ATSTXTCPY(sqlcol, "sqlcolumns");
	ATSTXTCPY(sqlproc, "sqlprocedu");
	ATSTXTCPY(sqlpk, "sqlprimary");
	ATSTXTCPY(sqlfk, "sqlforeign");
	ATSTXTCPY(sqlfk_as_primary, "sqlforeignkeysprimary");


	if (no_desc < 0 || no_desc > MAX_DESCRIPTOR) {
		odbc_error_handler(NULL, 203);
		ATSTXTCAT(error_message, "\nInvalid Descriptor Number!");
		return;
	}
	odbc_unhide_qualifier(order);
	odbc_tranNumber = 1;
	odbc_clear_error();
	warn_message[0] = (SQLTCHAR)0;


	flag[no_desc] = ODBC_SQL;
	order_count = TXTLEN(order);
	buf_count = (DB_MAX_TABLE_LEN > order_count ? order_count : DB_MAX_TABLE_LEN);

	if (order_count >= COMPARED_LENGTH) {
		memcpy(tmpBuf, order, buf_count * sizeof (SQLTCHAR));
		tmpBuf[buf_count] = (SQLTCHAR)0;
		change_to_low(tmpBuf, buf_count);
		if (memcmp(tmpBuf, sqltab, COMPARED_BTYES) == 0)
		{
			flag[no_desc] = ODBC_CATALOG_TAB;
			if (find_name (tmpBuf, order))
			{
				if (TXTLEN(odbc_qualifier) > 0 && TXTLEN(odbc_owner) > 0)
					rc = SQLTables(hstmt[no_desc], odbc_qualifier, SQL_NTS, odbc_owner, SQL_NTS, tmpBuf, SQL_NTS, NULL, 0);
				if (TXTLEN(odbc_qualifier) == 0 && TXTLEN(odbc_owner) > 0)
					rc = SQLTables(hstmt[no_desc], NULL, 0, odbc_owner, SQL_NTS, tmpBuf, SQL_NTS, NULL, 0);
				if (TXTLEN(odbc_qualifier) > 0 && TXTLEN(odbc_owner) == 0)
					rc = SQLTables(hstmt[no_desc], odbc_qualifier, SQL_NTS, NULL, 0, tmpBuf, SQL_NTS, NULL, 0);
				if (TXTLEN(odbc_qualifier) == 0 && TXTLEN(odbc_owner) == 0)
					rc = SQLTables(hstmt[no_desc], NULL, 0, NULL, 0, tmpBuf, SQL_NTS, NULL, 0);
			}
			else
			{
				rc = SQLTables(hstmt[no_desc], NULL, 0, NULL, 0, NULL, 0, NULL, 0);
				odbc_qualifier[0] = (SQLTCHAR)0;
				odbc_owner[0] =(SQLTCHAR)0;
			}
		}
		else
		{
			if (memcmp(tmpBuf, sqlcol, COMPARED_BTYES) == 0)
			{
				flag[no_desc] = ODBC_CATALOG_COL;
				if (find_name (tmpBuf, order)) {
					rc = SQLColumns(hstmt[no_desc], NULL, 0, NULL, 0, tmpBuf, SQL_NTS, NULL, 0);
				} else {
					rc = SQLColumns(hstmt[no_desc], NULL, 0, NULL, 0, NULL, 0, NULL, 0);
				}
			}
			else
			{
				if (memcmp(tmpBuf, sqlproc, COMPARED_BTYES) == 0)
				{
					flag[no_desc] = ODBC_CATALOG_PROC;
					if (find_name (tmpBuf, order)){
						rc = SQLProcedures(hstmt[no_desc], NULL, 0, NULL, 0, tmpBuf, SQL_NTS);
					}
					else{
						rc = SQLProcedures(hstmt[no_desc], NULL, 0, NULL, 0, NULL, 0);
					}
				}
				else
				{
					if (memcmp(tmpBuf, sqlpk, COMPARED_BTYES) == 0)
					{
						flag[no_desc] = ODBC_PK;
						if (find_name (tmpBuf, order)) {
							rc = SQLPrimaryKeys(hstmt[no_desc], NULL, 0, NULL, 0, tmpBuf, SQL_NTS);
						}
						else {
							rc = SQLPrimaryKeys(hstmt[no_desc], NULL, 0, NULL, 0, NULL, 0);
						}
					}
					else {
						if (memcmp(tmpBuf, sqlfk, COMPARED_BTYES) == 0) {
							is_as_primary = (memcmp(tmpBuf, sqlfk_as_primary, 21) ? 0 : 1);
							flag[no_desc] = ODBC_FK;
							find_name (tmpBuf, order);
								/* Now let's find what type of primary keys we are looking for. */
							if (is_as_primary) {
								rc = SQLForeignKeys(hstmt[no_desc], NULL, 0, NULL, 0, tmpBuf, SQL_NTS, NULL, 0, NULL, 0, NULL, 0);
							} else {
								rc = SQLForeignKeys(hstmt[no_desc], NULL, 0, NULL, 0, NULL, 0, NULL, 0, NULL, 0, tmpBuf, SQL_NTS);
							}
						}
					}
				}
 			}
		}
	}

	if (rc) {
		odbc_error_handler(hstmt[no_desc],100);
		if (error_number) {
			free_sqldata (odbc_descriptor[no_desc]);
			odbc_descriptor[no_desc] = NULL;
			//rc = SQLFreeStmt(hstmt[no_desc], SQL_DROP);
			rc = SQLFreeHandle (SQL_HANDLE_STMT, hstmt[no_desc]);
		}
	}



	if (flag[no_desc] == ODBC_SQL) {
	/* Process general ODBC SQL statements    */

		rc = SQLPrepare(hstmt[no_desc], order, SQL_NTS);
		if (rc) {
			odbc_error_handler(hstmt[no_desc],4);
			if (error_number) {
				free_sqldata (odbc_descriptor[no_desc]);
				odbc_descriptor[no_desc] = NULL;
				//rc = SQLFreeStmt(hstmt[no_desc], SQL_DROP);
				rc = SQLFreeHandle (SQL_HANDLE_STMT, hstmt[no_desc]);
				return;
			}
		}
	}

	if (argNum > 0) {
		/* Reset memory to be safe */
		ODBC_SAFE_ALLOC(pcbValue[no_desc], (SQLLEN *) calloc(argNum, sizeof(SQLLEN)));
	} else {
		ODBC_C_FREE (pcbValue[no_desc]);
		pcbValue[no_desc] = NULL;
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

void odbc_start_order (int no_desc)
{
	short colNum = 0;

	// Added by Jacques. 5/14/98
	SQLTCHAR     szCatalog[DB_REP_LEN], szSchema[DB_REP_LEN];
	SQLTCHAR     szTableName[DB_REP_LEN], szColumnName[DB_REP_LEN];
	SQLTCHAR     szTypeName[DB_REP_LEN];
	SQLINTEGER  ColumnSize, BufferLength;
	SQLSMALLINT DataType, DecimalDigits, NumPrecRadix, Nullable;

	SQLINTEGER cbCatalog, cbSchema, cbTableName, cbColumnName;
	SQLINTEGER cbDataType, cbTypeName, cbColumnSize, cbBufferLength;
	SQLINTEGER cbDecimalDigits, cbNumPrecRadix, cbNullable;

	if (flag[no_desc] == ODBC_CATALOG_COL) {
			SQLBindCol(hstmt, 1, SQL_C_TCHAR, szCatalog, DB_REP_LEN,&cbCatalog);
			SQLBindCol(hstmt, 2, SQL_C_TCHAR, szSchema, DB_REP_LEN, &cbSchema);
			SQLBindCol(hstmt, 3, SQL_C_TCHAR, szTableName, DB_REP_LEN,&cbTableName);
			SQLBindCol(hstmt, 4, SQL_C_TCHAR, szColumnName, DB_REP_LEN, &cbColumnName);
			SQLBindCol(hstmt, 5, SQL_C_SSHORT, &DataType, 0, &cbDataType);
			SQLBindCol(hstmt, 6, SQL_C_TCHAR, szTypeName, DB_REP_LEN, &cbTypeName);
			SQLBindCol(hstmt, 7, SQL_C_SLONG, &ColumnSize, 0, &cbColumnSize);
			SQLBindCol(hstmt, 8, SQL_C_SLONG, &BufferLength, 0, &cbBufferLength);
			SQLBindCol(hstmt, 9, SQL_C_SSHORT, &DecimalDigits, 0, &cbDecimalDigits);
			SQLBindCol(hstmt, 10, SQL_C_SSHORT, &NumPrecRadix, 0, &cbNumPrecRadix);
			SQLBindCol(hstmt, 11, SQL_C_SSHORT, &Nullable, 0, &cbNullable);
			while(1) {
				rc = SQLFetch(hstmt);
				if (rc == SQL_ERROR || rc == SQL_SUCCESS_WITH_INFO) {
					odbc_error_handler(hstmt[no_desc],7);
					if (error_number > 0) {
						free_sqldata (odbc_descriptor[no_desc]);
						odbc_descriptor[no_desc] = NULL;
						if (pcbValue[no_desc] != NULL) {
							ODBC_C_FREE(pcbValue[no_desc]);
							pcbValue[no_desc] = NULL;
						}
						rc = SQLFreeHandle (SQL_HANDLE_STMT, hstmt[no_desc]);
						return;
					}
				}
				if (rc == SQL_SUCCESS || rc == SQL_SUCCESS_WITH_INFO){
					rc = SQLNumResultCols(hstmt[no_desc], &colNum);
					if (rc) {
						odbc_error_handler(hstmt[no_desc],5);
						if (error_number) {
							free_sqldata (odbc_descriptor[no_desc]);
							odbc_descriptor[no_desc] = NULL;
							if (pcbValue[no_desc] != NULL) {
								ODBC_C_FREE(pcbValue[no_desc]);
								pcbValue[no_desc] = NULL;
							}
							rc = SQLFreeHandle (SQL_HANDLE_STMT, hstmt[no_desc]);
							return;
						}
					}

				}
				else if (rc == SQL_ROW_UPDATED) {
						break;
				}
				else if (rc == SQL_ROW_DELETED) {
						break;
				}
				else if (rc == SQL_ROW_ADDED) {
						break;
				}
				else if (rc == SQL_ROW_NOROW) {
						break;
				}
				else {
					break;
				}
			}
	}



	if (flag[no_desc] == ODBC_SQL) {
	/* Process general ODBC SQL statements    */
		rc = SQLExecute(hstmt[no_desc]);
		if (rc) {
			odbc_error_handler(hstmt[no_desc],7);
			if (error_number > 0) {
				free_sqldata (odbc_descriptor[no_desc]);
				odbc_descriptor[no_desc] = NULL;
				if (pcbValue[no_desc] != NULL) {
					ODBC_C_FREE(pcbValue[no_desc]);
					pcbValue[no_desc] = NULL;
				}
				//rc = SQLFreeStmt(hstmt[no_desc], SQL_DROP);
				rc = SQLFreeHandle (SQL_HANDLE_STMT, hstmt[no_desc]);
				return;
			}
		}
	}
	setup_result_space (no_desc);
}

/* Setup/describe result space and fill some necessary info. */
void setup_result_space (int no_desc)
{
	ODBCSQLDA *dap=odbc_descriptor[no_desc];
	short colNum = 0;
	short oldVarNum = 0;
	int i;
	long l_length;
	//int j;
	SQLSMALLINT type;
	SQLSMALLINT indColName;
	SQLSMALLINT tmpScale;
	SQLSMALLINT tmpNullable;
	char *dataBuf;
	
	/* Save old val numbers */
	oldVarNum = GetVarNum(dap);

	/* Get the old number of var */
	rc = SQLNumResultCols(hstmt[no_desc], &colNum);
	if (rc) {
		odbc_error_handler(hstmt[no_desc],5);
		if (error_number) {
			free_sqldata (odbc_descriptor[no_desc]);
			odbc_descriptor[no_desc] = NULL;
			if (pcbValue[no_desc] != NULL) {
				ODBC_C_FREE(pcbValue[no_desc]);
				pcbValue[no_desc] = NULL;
			}
			//rc = SQLFreeStmt(hstmt[no_desc], SQL_DROP);
			rc = SQLFreeHandle (SQL_HANDLE_STMT, hstmt[no_desc]);
			return;
		}
	}


	if (colNum > DB_MAX_COLS) {
		if (error_number) {
			ATSTXTCAT(error_message, "\n Number of selected columns exceed max number(300) ");
		}
		else {
			ATSTXTCPY(error_message, "\n Number of selected columns exceed max number(300) ");
			error_number = -DB_TOO_MANY_COL;
		}
		free_sqldata (odbc_descriptor[no_desc]);
		odbc_descriptor[no_desc] = NULL;
		if (pcbValue[no_desc] != NULL) {
			ODBC_C_FREE(pcbValue[no_desc]);
			pcbValue[no_desc] = NULL;
		}
		//rc = SQLFreeStmt(hstmt[no_desc], SQL_DROP);
		rc = SQLFreeHandle (SQL_HANDLE_STMT, hstmt[no_desc]);
		return;
	}

	if (colNum > 0)
		i = colNum;
	else
		i = 1;
	/* Reallocate the DESCRIPTOR area.   */
	ODBC_SAFE_ALLOC(odbc_descriptor[no_desc], (ODBCSQLDA *) realloc(odbc_descriptor[no_desc], IISQDA_HEAD_SIZE + i * IISQDA_VAR_SIZE));
	/* If there is resizing, we only clean up the new space, because some memory referenced by old space for var can be reused.*/
	if (i > oldVarNum)	{
		memset (odbc_descriptor[no_desc]->sqlvar + oldVarNum, 0, (i - oldVarNum) * IISQDA_VAR_SIZE);
	}

	dap = odbc_descriptor[no_desc];
	SetVarNum(dap,i);
	SetColNum(dap, colNum);

	/* For numeric type */
	SQLGetStmtAttr(hstmt[no_desc], SQL_ATTR_APP_ROW_DESC,&hdesc, 0, NULL);

	for (i=0; i < colNum && !error_number; i++) {
	/* fill in the describing information for each column, and calculate */
	/* the total length of the data buffer                               */
		rc = SQLDescribeCol(
					hstmt[no_desc],
					(SQLSMALLINT) i+1,
					(dap->sqlvar)[i].sqlname.sqlnamec,
					DB_MAX_NAME_LEN,
					&indColName,
					&((dap->sqlvar)[i].sqltype),
					&((dap->sqlvar)[i].sqllen),
					&tmpScale,
					&tmpNullable);
		if (rc)
			odbc_error_handler(hstmt[no_desc],6);
		if (error_number == 0) {
			(dap->sqlvar)[i].sqlname.sqlnamec[indColName] = (SQLTCHAR)0;
			(dap->sqlvar)[i].sqlname.sqlnamel = TXTLEN((dap->sqlvar)[i].sqlname.sqlnamec);
			dap->sqlvar[i].c_type = odbc_c_type(dap->sqlvar[i].sqltype);
			type = dap->sqlvar[i].c_type;
			switch(type) {
				//case SQL_C_DATE:
				case SQL_C_TYPE_DATE:
					SetDbColLength(dap, i, sizeof(DATE_STRUCT));
					break;
				//case SQL_C_TIME:
				case SQL_C_TYPE_TIME:
					SetDbColLength(dap, i, sizeof(TIME_STRUCT));
					break;
				//case SQL_C_TIMESTAMP:
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
					SQLSetDescField (hdesc,i+1,SQL_DESC_TYPE,(VOID*)SQL_C_NUMERIC,0);
					SQLSetDescField (hdesc,i+1,SQL_DESC_PRECISION,(VOID*) 19,0); /* presision of 64bits */
					SQLSetDescField (hdesc,i+1,SQL_DESC_SCALE,(VOID*) 8,0); /* presision of 64bits */
					SetDbColLength(dap, i, sizeof (SQL_NUMERIC_STRUCT));
					break;
				default:
					break;
			}
			type = GetDbColType(dap, i);
			switch (type) {
				case SQL_LONGVARBINARY:
				case SQL_LONGVARCHAR:
				case SQL_WLONGVARCHAR:
					SetDbColLength(dap, i, DB_MAX_STRING_LEN);
					break;
			}
		}
	}


	if (error_number) {
		free_sqldata(dap);
		odbc_descriptor[no_desc] = NULL;
		if (pcbValue[no_desc] != NULL) {
			ODBC_C_FREE(pcbValue[no_desc]);
			pcbValue[no_desc] = NULL;
		}
		//rc = SQLFreeStmt(hstmt[no_desc], SQL_DROP);
		rc = SQLFreeHandle (SQL_HANDLE_STMT, hstmt[no_desc]);
		return;
	}

	if (colNum) {
			/* Allocate for each column the buffer that will hold its value. */
		for (i=0; i<colNum; i++) {
			l_length = GetDbColLength(dap, i);
			dataBuf = GetDbColPtr(dap, i);
			ODBC_SAFE_ALLOC(dataBuf, (char *) realloc(dataBuf, l_length + sizeof (SQLTCHAR)));
			SetDbColPtr(dap, i, dataBuf);
		}
	}

	/* allocate buffer for INDICATORs of the output fields, reuse old memory if possible. */
	ODBC_SAFE_ALLOC(odbc_indicator[no_desc], (SQLLEN *) realloc(odbc_indicator[no_desc], (colNum+1)*sizeof(SQLLEN)));
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
void odbc_terminate_order (int no_des)
{
	ODBCSQLDA *dap = odbc_descriptor[no_des];

	if (dap) {
		free_sqldata (dap);
		odbc_descriptor[no_des] = NULL;
		ODBC_C_FREE (odbc_indicator[no_des]);
		odbc_indicator[no_des] = NULL;
		if (pcbValue[no_des] != NULL) {
			ODBC_C_FREE(pcbValue[no_des]);
			pcbValue[no_des] = NULL;
		}
		//rc = SQLFreeStmt(hstmt[no_des], SQL_DROP);
		rc = SQLFreeHandle (SQL_HANDLE_STMT, hstmt[no_des]);
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
void odbc_close_cursor (int no_des)
{
    rc = SQLFreeStmt(hstmt[no_des], SQL_CLOSE);
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

int odbc_next_row (int no_des)
     /* move to the next row of selection */
     /* return 0 if there is a next row, 1 if no row left */
{

	ODBCSQLDA *dap = odbc_descriptor[no_des];
	short colNum = GetColNum(dap);
	UWORD i;


	odbc_clear_error ();
	rc = SQLFetch(hstmt[no_des]);
	if (rc && rc != NO_MORE_ROWS) {
		SQLTCHAR tmpSQLSTATE[6];
		if
			(SQLGetDiagRec(SQL_HANDLE_STMT, hstmt[no_des], 1, tmpSQLSTATE,
				NULL, NULL, 0, NULL) != SQL_NO_DATA)
		{
				/* If `tmpSQLSTATE' is 24000, we try to go to next result set. */
			if
				((tmpSQLSTATE[0] == TXTC('2')) && (tmpSQLSTATE[1] == TXTC('4')) && (tmpSQLSTATE[2] == TXTC('0')) &&
				(tmpSQLSTATE[3] == TXTC('0')) && (tmpSQLSTATE[4] == TXTC('0')))
			{
				rc = SQLMoreResults(hstmt[no_des]);

				while (rc != SQL_SUCCESS && rc != SQL_SUCCESS_WITH_INFO && rc != SQL_NO_DATA && rc != SQL_ERROR)
				{
					rc = SQLMoreResults(hstmt[no_des]);
				};
				if (rc != SQL_NO_DATA && rc != SQL_ERROR)
				{
					setup_result_space (no_des);
					dap = odbc_descriptor[no_des];
					colNum = GetColNum(dap);
					rc = SQLFetch(hstmt[no_des]);
				}
				if (rc == SQL_NO_DATA)
				{
					/* We do the same thing later as SQLFetch returns NO_MORE_ROWS
					 * if SQLMoreResults returns SQL_NO_DATA
					 */
					rc = NO_MORE_ROWS;
				}
			}
		}
		if (rc && rc != NO_MORE_ROWS)
		{
			odbc_error_handler(hstmt[no_des],8);
			if (error_number) {
				odbc_terminate_order(no_des);
				return 1;
			}
		}
	}


	if (rc == NO_MORE_ROWS) /* NO_MORE_ROWS */ {
		return 1;
	}
	else {
		for (i=0; i<colNum && error_number == 0; i++) {
			SQLINTEGER old_length = GetDbColLength(dap, i) + sizeof (SQLTCHAR);
			char *l_buffer = GetDbColPtr(dap, i);
			odbc_indicator[no_des][i] = 0;
			if (GetDbCType(dap, i) == SQL_C_NUMERIC){
				/* Use SQL_ARD_TYPE to force the driver to use data in the row descriptor */
				rc = SQLGetData(hstmt[no_des], i+1, SQL_ARD_TYPE, l_buffer, old_length, &(odbc_indicator[no_des][i]));
			} else {
				rc = SQLGetData(hstmt[no_des], i+1, GetDbCType(dap, i), l_buffer, old_length, &(odbc_indicator[no_des][i]));
			}
			if (rc) {
					/* Check if it failed because we did not have enough space to store the data. */
				if (rc == SQL_SUCCESS_WITH_INFO) {
					SQLTCHAR tmpSQLSTATE[6];
					if
						(SQLGetDiagRec(SQL_HANDLE_STMT, hstmt[no_des], 1, tmpSQLSTATE,
							NULL, NULL, 0, NULL) != SQL_NO_DATA)
					{
							/* If `tmpSQLSTATE' is 01004 then we just make our buffer bigger and
							 * reissue the call. */
						if
							((tmpSQLSTATE[0] == TXTC('0')) && (tmpSQLSTATE[1] == TXTC('1')) && (tmpSQLSTATE[2] == TXTC('0')) &&
							(tmpSQLSTATE[3] == TXTC('0')) && (tmpSQLSTATE[4] == TXTC('4')))
						{
							SQLINTEGER additional_length = odbc_indicator[no_des][i] - old_length + 1;
							/* Reuse old memory if possible */
							ODBC_SAFE_ALLOC(l_buffer, (char *) realloc (l_buffer, old_length + additional_length));
							SetDbColPtr(dap, i, l_buffer);
							SetDbColLength(dap, i, old_length + additional_length - 1);
								/* Reissue the call, this time starting from the end of `l_buf_namefer' since we want to get
								 * the remaining data. */
							rc = SQLGetData(hstmt[no_des], i+1, GetDbCType(dap, i), l_buffer + old_length - 1,
								additional_length + 1, NULL);
						}
					}
				}
			}
			if (rc) {
				SQLTCHAR	  SqlState[6], Msg[SQL_MAX_MESSAGE_LENGTH];
				SQLINTEGER    NativeError;
				SQLSMALLINT   MsgLen;

				/* Get the status records. */
				if ((SQLGetDiagRec(SQL_HANDLE_STMT, hstmt[no_des], 1, SqlState, &NativeError,
					Msg, sizeof(Msg), &MsgLen)) != SQL_NO_DATA) {
						/* DisplayError(SqlState,NativeError,Msg,MsgLen); */
				}

				odbc_error_handler(hstmt[no_des],9);
			}
		}
		if (error_number)
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
/* NAME: odbc_support_create_proc()                              */
/* DESCRIPTION:                                                  */
/*  to determine if the current ODBC Data Source/Driver support  */
/* stored procedure creation: 1-- yes, 0-- no                    */
/*                                                               */
/*****************************************************************/

int odbc_support_create_proc() {
	int i;
	int j;
	SQLTCHAR tmpStr[DB_MAX_NAME_LEN];

	ATSTXTCPY (tmpStr, "stored procedure");
	i = SQLTXTCMP(CreateStoredProc, tmpStr);
	ATSTXTCPY (tmpStr, "Stored Procedure");
	j = SQLTXTCMP(CreateStoredProc, tmpStr);
	if (i==0||j==0)
		return 1;
	else
		return 0;
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
		 * or SQL_IC_SENSITIVE. If it is SQL_IC_UNKNOWN (that is to say none of the above), then we consider 
		 * it is case sensitive. */
	return (odbc_case == SQL_IC_SENSITIVE) || (odbc_case == SQL_IC_UNKNOWN);
}

int odbc_insensitive_mixed() {
	return odbc_case == SQL_IC_MIXED;
}

void odbc_set_parameter(int no_desc, int seri, int dir, int eifType, int collen, int value_count, void *value) {

	int seriNumber = seri;
	SQLSMALLINT direction = dir;
	SQLLEN len;

	pcbValue[no_desc][seriNumber-1] = len = value_count;
	rc = 0;
	direction = SQL_PARAM_INPUT;
	switch (eifType) {
		case CHARACTER_TYPE:
		case STRING_TYPE:
			rc = SQLBindParameter(hstmt[no_desc], seriNumber, direction, SQL_C_CHAR, SQL_CHAR, value_count, DB_SIZEOF_CHAR, value, value_count, &(pcbValue[no_desc][seriNumber-1]));
			break;
		case WSTRING_TYPE:
			rc = SQLBindParameter(hstmt[no_desc], seriNumber, direction, SQL_C_WCHAR, SQL_WCHAR, value_count, DB_SIZEOF_WCHAR, value, 0, &(pcbValue[no_desc][seriNumber-1]));
			break;
		case INTEGER_TYPE:
			rc = SQLBindParameter(hstmt[no_desc], seriNumber, direction, SQL_C_SLONG, SQL_INTEGER, value_count, DB_SIZEOF_INT, value, 0, &(pcbValue[no_desc][seriNumber-1]));
			break;
		case INTEGER_16_TYPE:
			rc = SQLBindParameter(hstmt[no_desc], seriNumber, direction, SQL_C_SSHORT, SQL_SMALLINT, value_count, DB_SIZEOF_SHORT, value, 0, &(pcbValue[no_desc][seriNumber-1]));
			break;
		case INTEGER_64_TYPE:
			rc = SQLBindParameter(hstmt[no_desc], seriNumber, direction, SQL_C_SBIGINT, SQL_BIGINT, value_count, DB_SIZEOF_BIGINT, value, 0, &(pcbValue[no_desc][seriNumber-1]));
			break;
		case FLOAT_TYPE:
			/* See example: http://msdn.microsoft.com/en-us/library/ms710963%28v=VS.85%29.aspx */
			rc = SQLBindParameter(hstmt[no_desc], seriNumber, direction, SQL_C_DOUBLE, SQL_DOUBLE, 0, 0, value, 0, &(pcbValue[no_desc][seriNumber-1]));
			break;
		case REAL_TYPE:
			/* See example: http://msdn.microsoft.com/en-us/library/ms710963%28v=VS.85%29.aspx */
			rc = SQLBindParameter(hstmt[no_desc], seriNumber, direction, SQL_C_FLOAT, SQL_REAL, 0, 0, value, 0, &(pcbValue[no_desc][seriNumber-1]));
			break;
		case BOOLEAN_TYPE:
			rc = SQLBindParameter(hstmt[no_desc], seriNumber, direction, SQL_C_BIT, SQL_BIT, value_count, DB_SIZEOF_INT, value, 0, &(pcbValue[no_desc][seriNumber-1]));
			break;
		case DATE_TYPE:
			len = pcbValue[no_desc][seriNumber-1] = sizeof(TIMESTAMP_STRUCT);
			rc = SQLBindParameter(hstmt[no_desc], seriNumber, direction, SQL_C_TIMESTAMP, SQL_TYPE_TIMESTAMP, 23, 3, value, 0, &(pcbValue[no_desc][seriNumber-1]));
			break;
		default:
			odbc_error_handler(NULL, 204);
			ATSTXTCAT(error_message, "\nInvalid Data Type in odbc_set_parameter");
			odbc_error_handler(NULL, 110);
			return;
	}
	if (rc) {
		odbc_error_handler(hstmt[no_desc], rc);
		return;
	}
}

/*****************************************************************/
/*                                                               */
/*                     ROUTINE  DESCRIPTION                      */
/*                                                               */
/* NAME: odbc_set_col_flag()                                     */
/* PARAMETER: no_desc - the index of descriptor                  */
/* DESCRIPTION:                                                  */
/*   to indicate the statement for descriptor 'no_desc' is to    */
/* get column(s) (of a special table or whole data source).      */
/*                                                               */
/*****************************************************************/
void odbc_set_col_flag(int no_desc) {
	flag[no_desc] = ODBC_CATALOG_COL;
}

/*****************************************************************/
/*                                                               */
/*                     ROUTINE  DESCRIPTION                      */
/*                                                               */
/* NAME: odbc_set_tab_flag()                                     */
/* PARAMETER: no_desc - the index of descriptor                  */
/* DESCRIPTION:                                                  */
/*   to indicate the statement for descriptor 'no_desc' is to    */
/* get  table(s) in the current Data Source.                     */
/*                                                               */
/*****************************************************************/
void odbc_set_tab_flag(int no_desc) {
	flag[no_desc] = ODBC_CATALOG_TAB;
}

/*****************************************************************/
/*                                                               */
/*                     ROUTINE  DESCRIPTION                      */
/*                                                               */
/* NAME: odbc_set_proc_flag()                                    */
/* PARAMETER: no_desc - the index of descriptor                  */
/* DESCRIPTION:                                                  */
/*   to indicate the statement for descriptor 'no_desc' is to    */
/* get stored procedure(s) in the current Data Source.           */
/*                                                               */
/*****************************************************************/
void odbc_set_proc_flag(int no_desc) {
	flag[no_desc] = ODBC_CATALOG_PROC;
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
SQLTCHAR *odbc_hide_qualifier(SQLTCHAR *buf) {
	int i;
	int len = TXTLEN(buf);

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
void odbc_unhide_qualifier(SQLTCHAR *buf) {
	int i;
	int len = TXTLEN(buf);


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
/* NAME: odbc_qualifier_seperator                                */
/* DESCRIPTION:                                                  */
/*   When "qualifier" and "owner" are used to identifier a       */
/* database object, they should be seperated by a string called  */
/* "qualifier seperator".                                        */
/*                                                               */
/*****************************************************************/
SQLTCHAR *odbc_qualifier_seperator() {
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
/* to implement command "SQLTable(tanle_name)" conviently.       */
/*                                                               */
/*****************************************************************/
void odbc_set_qualifier(SQLTCHAR *qfy) {
	if (qfy == NULL)
		odbc_qualifier[0] = (SQLTCHAR)0;
	else
		SQLTXTCPY(odbc_qualifier, qfy);
}

/*****************************************************************/
/*                                                               */
/*                     ROUTINE  DESCRIPTION                      */
/*                                                               */
/* NAME: odbc_set_owner                                          */
/* PARAMETER: owner- the owner                                   */
/* DESCRIPTION:                                                  */
/*   Set owner to     a global variable. The function is used    */
/* to implement command "SQLTable(tanle_name)" conviently.       */
/*                                                               */
/*****************************************************************/
void odbc_set_owner(SQLTCHAR *owner) {
	if (owner == NULL)
		odbc_owner[0] = (SQLTCHAR)0;
	else
		SQLTXTCPY(odbc_owner, owner);

}

/*****************************************************************/
/*                                                               */
/*                     ROUTINE  DESCRIPTION                      */
/*                                                               */
/* NAME: odbc_unset_catalog_flag()                               */
/* PARAMETER: no_desc - the index of descriptor                  */
/* DESCRIPTION:                                                  */
/*   to indicate the statement for descriptor 'no_desc' is  a    */
/* general ODBC SQL statement.                                   */
/*                                                               */
/*****************************************************************/
void odbc_unset_catalog_flag(int no_desc) {
	flag[no_desc] = ODBC_SQL;
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
void odbc_connect (SQLTCHAR *name, SQLTCHAR *passwd, SQLTCHAR *dsn)
{
	SQLSMALLINT indColName;
	//int i;

	odbc_clear_error ();
	SQLTXTCPY(odbc_user_name, name);
	rc = SQLAllocHandle(SQL_HANDLE_ENV,SQL_NULL_HANDLE,&henv);
	if (rc) {
		odbc_error_handler(NULL,10);
		return;
	}
	//rc = SQLSetEnvAttr(henv,SQL_ATTR_ODBC_VERSION,(SQLPOINTER)SQL_OV_ODBC2,0);
	rc = SQLSetEnvAttr(henv,SQL_ATTR_ODBC_VERSION,(SQLPOINTER)SQL_OV_ODBC3,0);
	if (rc) {
		odbc_error_handler(NULL,910);
		rc = SQLFreeHandle(SQL_HANDLE_ENV,henv);
		return;
	}
	rc = SQLAllocHandle(SQL_HANDLE_DBC,henv, &hdbc);
	if (rc) {
		odbc_error_handler(NULL,11);
		rc = SQLFreeHandle(SQL_HANDLE_ENV,henv);
		return;
	}

	rc = SQLConnect(hdbc, dsn, SQL_NTS, name, SQL_NTS, passwd, SQL_NTS);
	if (rc<0) {
		odbc_error_handler(NULL,12);
		rc = SQLFreeHandle(SQL_HANDLE_DBC,hdbc);
		rc = SQLFreeHandle(SQL_HANDLE_ENV,henv);
		return;
	}
	// Added for multiple connection
	number_connection = number_connection + 1;
	//odbc_tranNumber=odbc_tranNumber + 1;
	rc = SQLGetInfo(hdbc, SQL_PROCEDURES, dbmsName, sizeof(dbmsName), &indColName);
	SQLTXTCPY(storedProc, dbmsName);
	rc = SQLGetInfo(hdbc, SQL_PROCEDURE_TERM, dbmsName, sizeof(dbmsName), &indColName);
	SQLTXTCPY(CreateStoredProc, dbmsName);
	rc = SQLGetInfo(hdbc, SQL_DBMS_NAME, dbmsName, sizeof(dbmsName), &indColName);
	rc = SQLGetInfo(hdbc, SQL_DBMS_VER, dbmsVer, sizeof(dbmsVer), &indColName);
	rc = SQLGetInfo(hdbc, SQL_IDENTIFIER_QUOTE_CHAR, idQuoter, sizeof(idQuoter), &indColName);
	rc = SQLGetInfo(hdbc, SQL_QUOTED_IDENTIFIER_CASE, &odbc_case, sizeof(odbc_case), &indColName);
	rc = SQLGetInfo(hdbc, SQL_INFO_SCHEMA_VIEWS, &odbc_info_schema, sizeof(odbc_info_schema), &indColName);

	if (indColName == 1 && idQuoter[0] == TXTC(' '))
		idQuoter[0] = (SQLTCHAR)0;
	else
		idQuoter[indColName] = (SQLTCHAR)0;

	//rc = SQLGetInfo(hdbc, SQL_QUALIFIER_NAME_SEPARATOR, quaNameSep, sizeof(quaNameSep), &indColName);
	rc = SQLGetInfo(hdbc, SQL_CATALOG_NAME_SEPARATOR, quaNameSep, sizeof(quaNameSep), &indColName);
	if (indColName == 1 && quaNameSep[0] == TXTC(' '))
		quaNameSep[0] = (SQLTCHAR)0;
	else
		quaNameSep[indColName] = (SQLTCHAR)0;

/*
	for (i=0; i< MAX_DESCRIPTOR && error_number == 0; i++) {
		rc = SQLAllocStmt(hdbc, &(hstmt[i]));
		if (rc) {
			odbc_error_handler(NULL, 101);
		}
	}
*/
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
void odbc_disconnect ()
{
  int count;

  odbc_clear_error ();
  //rc = SQLTransact(henv, SQL_NULL_HDBC, SQL_COMMIT);
  rc = SQLEndTran(SQL_HANDLE_ENV, henv, SQL_COMMIT);
  if (rc) {
	odbc_error_handler(NULL,13);
  }
  for (count = 0; count < MAX_DESCRIPTOR; count++)
    {
      odbc_terminate_order (count);
    }
  rc = SQLDisconnect(hdbc);

  // Added for multiple connection
  number_connection=number_connection-1;
  // odbc_tranNumber was originally set to 0 only if number_connection <= 1:
  // this is not consistent with EiffelStore  so all transactions are ended
  // when disconnecting. Anyway, odbc_tranNumber <= 1.
  // Cedric
  odbc_tranNumber = 0;
  if (number_connection <= 1) {
	  if (rc)
		odbc_error_handler(NULL,14);
	  //rc = SQLFreeConnect(hdbc);
	  rc = SQLFreeHandle (SQL_HANDLE_DBC, hdbc);
	  if (rc)
		odbc_error_handler(NULL,15);
	  //rc = SQLFreeEnv(henv);
	  rc = SQLFreeHandle (SQL_HANDLE_ENV, henv);
	  if (rc)
		odbc_error_handler(NULL,16);
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
void odbc_rollback ()
{
  int count;

  odbc_clear_error ();
  //rc = SQLTransact(SQL_NULL_HENV, hdbc, SQL_ROLLBACK);
  rc = SQLEndTran(SQL_HANDLE_DBC, hdbc, SQL_ROLLBACK);
  if (rc)
odbc_error_handler(NULL,17);
  /* Command ROLLBACK closes all open cursors; discards all statements */
  /* that were prepared in the current transaction.                    */
  for (count = 0; count < MAX_DESCRIPTOR; count++)
    {
      odbc_terminate_order (count);
    }
  odbc_tranNumber = 0;

  rc = SQLSetConnectOption(hdbc, SQL_AUTOCOMMIT, SQL_AUTOCOMMIT_ON);
  if (rc)
odbc_error_handler(NULL, 12);
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
void odbc_commit ()
{
  int count;
  odbc_clear_error ();
  //rc = SQLTransact(SQL_NULL_HENV, hdbc, SQL_COMMIT);
  rc = SQLEndTran(SQL_HANDLE_DBC, hdbc, SQL_COMMIT);
  if (rc)
odbc_error_handler(NULL,18);
  /* Command  COMMIT  closes all open cursors; discards all statements */
  /* that were prepared in the current transaction.                    */
  for (count = 0; count < MAX_DESCRIPTOR; count++)
    {
      odbc_terminate_order (count);
    }
  odbc_tranNumber = 0;

  rc = SQLSetConnectOption(hdbc, SQL_AUTOCOMMIT, SQL_AUTOCOMMIT_ON);
  if (rc)
odbc_error_handler(NULL, 12);
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
void odbc_begin ()
{
  odbc_clear_error ();

  rc = SQLSetConnectOption(hdbc, SQL_AUTOCOMMIT, SQL_AUTOCOMMIT_OFF);
  if (rc)
odbc_error_handler(NULL, 12);

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
int odbc_trancount ()
{
  return odbc_tranNumber;
}

/*****************************************************************/
/* The following functions are used to get data from structure   */
/* ODBCSQLDA  filled  by FETCH clause.                           */
/*****************************************************************/
/*                                                               */
void cut_tail_blank(SQLTCHAR *buf) {
	int j;

	if (buf != NULL) {
		for(j=TXTLEN(buf)-1;j>=0 && buf[j]==TXTC(' '); j--);
		j++;
		buf[j] = (SQLTCHAR)0;
	}
}

int odbc_get_user  (SQLTCHAR *result)
{
	size = TXTLEN(odbc_user_name);
	memcpy(result, odbc_user_name, size * sizeof (SQLTCHAR));
	return(size);
}

int odbc_get_count (int no_des)
{
	if (odbc_descriptor[no_des] == NULL)
		return -1;

	return GetColNum(odbc_descriptor[no_des]);
}

int odbc_put_col_name (int no_des, int index, SQLTCHAR *result)
{
	int i = index - 1;
	SQLTCHAR buf[DB_MAX_NAME_LEN+1];

	size = (((odbc_descriptor[no_des])->sqlvar)[i]).sqlname.sqlnamel;
	memcpy(buf, (((odbc_descriptor[no_des])->sqlvar)[i]).sqlname.sqlnamec, size * sizeof (SQLTCHAR));
	buf[size] = (SQLTCHAR)0;
	cut_tail_blank(buf);
	size = TXTLEN(buf);
	memcpy(result, buf, size * sizeof (SQLTCHAR));
	return(size);
}

int odbc_get_col_len (int no_des, int index)
{
	int i = index - 1;
	int length = GetDbColLength(odbc_descriptor[no_des], i);


	return length;
}

int odbc_get_data_len (int no_des, int index)
{
  int i = index - 1;
  int type = GetDbCType(odbc_descriptor[no_des], i);
  int length = GetDbColLength(odbc_descriptor[no_des], i);

  switch (type)
    {
    case SQL_C_TCHAR:
		if (odbc_indicator[no_des][i] == SQL_NULL_DATA) {
			return 0;
		}
		else {
			return odbc_indicator[no_des][i];
 		}
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
			return STRING_TYPE;
		case SQL_WCHAR:
		case SQL_WVARCHAR:
		case SQL_WLONGVARCHAR:
			return WSTRING_TYPE;
		case SQL_DECIMAL:
		case SQL_NUMERIC:	
		case SQL_FLOAT:
		case SQL_DOUBLE:
			return FLOAT_TYPE;
		case SQL_REAL:
			return REAL_TYPE;
		case SQL_TINYINT:
		case SQL_SMALLINT:
			return INTEGER_16_TYPE;
		case SQL_INTEGER:
			return INTEGER_TYPE;
		case SQL_BIGINT:
			return INTEGER_64_TYPE;
		case SQL_BIT:
			return BOOLEAN_TYPE;
		case SQL_DATE:
		case SQL_TYPE_DATE:
		case SQL_TIME:
		case SQL_TYPE_TIME:
		case SQL_TIMESTAMP:
		case SQL_TYPE_TIMESTAMP:
			return DATE_TYPE;
		default:
			return UNKNOWN_TYPE;
	}
}

int odbc_get_col_type (int no_des, int index)
{
  int i = index - 1;

  return odbc_conv_type (GetDbColType(odbc_descriptor[no_des], i));
}

int odbc_put_data (int no_des, int index, char **result)
{
  int i = index -1;
  ODBCSQLDA * dap = odbc_descriptor[no_des];
  data_type = GetDbCType (dap, i);

  memcpy((char *)(&odbc_tmp_indicator), (char *)(&(odbc_indicator[no_des][i])), DB_SIZEOF_UDWORD);
  if ((is_null_data = (odbc_tmp_indicator == SQL_NULL_DATA))) {
	return 0;
  }

  *result = malloc(odbc_tmp_indicator);
  memcpy(*result, GetDbColPtr(dap, i), odbc_tmp_indicator);
  return(odbc_tmp_indicator);
}

SQLINTEGER odbc_get_integer_data (int no_des, int index)
{
  int i  = index - 1;
  int result;
  ODBCSQLDA * dbp = odbc_descriptor[no_des];
  long  lint;

	data_type = GetDbCType(dbp, i);

	memcpy((char *)(&odbc_tmp_indicator), (char *)(&(odbc_indicator[no_des][i])), DB_SIZEOF_UDWORD);
	if ((is_null_data = (odbc_tmp_indicator == SQL_NULL_DATA))) {
	/* the retrieved value is NULL, we use 0 to be NULL value */
		return 0;
	}

	switch (data_type) {
		case SQL_C_SLONG:
			memcpy((char *)(&lint), GetDbColPtr(dbp, i), DB_SIZEOF_LONG);
			result = lint;
			return result;
		default:
			ATSTXTCAT(error_message, "\nError INTEGER type or data length in odbc_get_integer_data. ");
			if (error_number) {
				return 0;
			}
			else {
				error_number = -DB_ERROR-1;
				return 0;
			}
	}
}

SQLSMALLINT odbc_get_integer_16_data (int no_des, int index)
{
  int i  = index - 1;
  SQLSMALLINT result;
  ODBCSQLDA * dbp = odbc_descriptor[no_des];
  SQLSMALLINT sint = 0;

	data_type = GetDbCType(dbp, i);

	memcpy((char *)(&odbc_tmp_indicator), (char *)(&(odbc_indicator[no_des][i])), DB_SIZEOF_UDWORD);
	if ((is_null_data = (odbc_tmp_indicator == SQL_NULL_DATA))) {
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
			ATSTXTCAT(error_message, "\nError INTEGER_16 type or data length in odbc_get_integer_data. ");
			if (error_number) {
				return 0;
			}
			else {
				error_number = -DB_ERROR-1;
				return 0;
			}
	}
}

EIF_INTEGER_64 odbc_get_integer_64_data (int no_des, int index)
{
  int i  = index - 1;
  EIF_INTEGER_64 result;
  ODBCSQLDA * dbp = odbc_descriptor[no_des];
  EIF_INTEGER_64 bint;

	data_type = GetDbCType(dbp, i);

	memcpy((char *)(&odbc_tmp_indicator), (char *)(&(odbc_indicator[no_des][i])), DB_SIZEOF_UDWORD);
	if ((is_null_data = (odbc_tmp_indicator == SQL_NULL_DATA))) {
	/* the retrieved value is NULL, we use 0 to be NULL value */
		return 0;
	}

	switch (data_type) {
		case SQL_C_SBIGINT:
			memcpy((char *)(&bint), GetDbColPtr(dbp, i), DB_SIZEOF_BIGINT);
			result = bint;
			return result;
		default:
			ATSTXTCAT(error_message, "\nError INTEGER_64 type or data length in odbc_get_integer_data. ");
			if (error_number) {
				return 0;
			}
			else {
				error_number = -DB_ERROR-1;
				return 0;
			}
	}
}

int odbc_get_boolean_data (int no_des, int index)
{
  int i = index - 1;
  ODBCSQLDA * dbp = odbc_descriptor[no_des];

  data_type = GetDbCType (dbp,i);

  if (data_type == SQL_C_BIT)
    {
	memcpy((char *)(&odbc_tmp_indicator), (char *)(&(odbc_indicator[no_des][i])), DB_SIZEOF_UDWORD);
	if ((is_null_data = (odbc_tmp_indicator == SQL_NULL_DATA))) {
	/* the retrived value is NULL, we use false to be NULL value */
		return 0;
	}
	return *((char *)(GetDbColPtr(dbp, i))) != 0;
    }
  ATSTXTCAT(error_message, "\nError BOOLEAN type in odbc_get_boolean_data. ");
  if (error_number) {
		return 0;
  }
  else {
		error_number = -DB_ERROR-2;
		return 0;
  }
}

double odbc_get_float_data (int no_des, int index)
{
	int i = index - 1;
	double result_double;
	ODBCSQLDA * dbp = odbc_descriptor[no_des];
	SQL_NUMERIC_STRUCT NumStr;
	int j,sign =1;
	EIF_NATURAL_64 myvalue, divisor;
	double final_val;

	data_type = GetDbCType (dbp, i);

	if ( data_type == SQL_C_DOUBLE ) {
		memcpy((char *)(&odbc_tmp_indicator), (char *)(&(odbc_indicator[no_des][i])), DB_SIZEOF_UDWORD);
		if ((is_null_data = (odbc_tmp_indicator == SQL_NULL_DATA))) {
			/* the retrieved value is NULL, we use 0.0 to be NULL value and we indicate it*/
			return 0.0;
		}
		memcpy((char *)(&result_double), GetDbColPtr(dbp, i), DB_SIZEOF_DOUBLE);
		/* result = *(double *)(dbp->sqlvar)[i].sqldata; */
		return  result_double;
	} else if (data_type == SQL_C_NUMERIC){
		memcpy((char *)(&odbc_tmp_indicator), (char *)(&(odbc_indicator[no_des][i])), DB_SIZEOF_UDWORD);
		if ((is_null_data = (odbc_tmp_indicator == SQL_NULL_DATA))) {
			/* the retrieved value is NULL, we use 0.0 to be NULL value and we indicate it*/
			return 0.0;
		}
		memcpy((char *)(&NumStr), GetDbColPtr(dbp, i), sizeof (SQL_NUMERIC_STRUCT));
		myvalue = strhextoval(&NumStr);
		divisor = 1;
		if(NumStr.scale > 0){
			for (j=0;j< NumStr.scale; j++)	
				divisor = divisor * 10;
		}
		final_val =  myvalue /(double) divisor;
		if(!NumStr.sign) 
			sign = -1;
		else 
			sign  = 1;
		final_val *= sign;
		return final_val;
	}
	ATSTXTCAT(error_message, "\nError  FLOAT  type in odbc_get_float_data. ");
	if (error_number) {
		return 0.0;
	}
	else {
		error_number = -DB_ERROR-3;
		return 0.0;
	}
}

float odbc_get_real_data (int no_des, int index)
{
  int i = index - 1;
  float result_real;
  ODBCSQLDA * dbp = odbc_descriptor[no_des];

  data_type = GetDbCType (dbp, i);
  if (data_type == SQL_C_FLOAT)  {
	memcpy((char *)(&odbc_tmp_indicator), (char *)(&(odbc_indicator[no_des][i])), DB_SIZEOF_UDWORD);
	if ((is_null_data = (odbc_tmp_indicator == SQL_NULL_DATA))) {
	/* the retrieved value is NULL, we use 0.0 to be NULL value */
		return 0.0;
	}
	memcpy((char *)(&result_real), GetDbColPtr(dbp, i), DB_SIZEOF_REAL);
	/* result_real = *(float *)(dbp->sqlvar)[i].sqldata; */
	return   result_real;
  }
  ATSTXTCAT(error_message, "\nError  REAL   type in odbc_get_real_data. ");
  if (error_number) {
		return 0.0;
  }
  else {
		error_number = -DB_ERROR-4;
		return 0.0;
  }
}

// The following function tell whether the retrieved data is null or not

int odbc_is_null_data(int no_des, int index)
{
  return (odbc_indicator[no_des][index-1] == SQL_NULL_DATA);
}

/*****************************************************************/
/*  The following function deal with the DATE data of  ODBC      */
/*****************************************************************/

int odbc_get_date_data (int no_des, int index)
{
  int i = index - 1;
  ODBCSQLDA   * dbp = odbc_descriptor[no_des];
  DATE_STRUCT *dateP;
  TIMESTAMP_STRUCT *stampP;
  TIME_STRUCT *timeP;

  data_type = GetDbCType(dbp, i);
  //if (data_type == SQL_C_DATE || data_type == SQL_C_TIMESTAMP || data_type == SQL_C_TIME)
  if (data_type == SQL_C_TYPE_DATE || data_type == SQL_C_TYPE_TIMESTAMP || data_type == SQL_C_TYPE_TIME)
    {
	memcpy((char *)(&odbc_tmp_indicator), (char *)(&(odbc_indicator[no_des][i])), DB_SIZEOF_UDWORD);
	if ((is_null_data = (odbc_tmp_indicator == SQL_NULL_DATA))) {
	/* the retrived value is NULL, we use 01/01/1991 0:0:0 to be NULL value */
		//odbc_date.year = 1991;
		//odbc_date.month = 1;
		//odbc_date.day = 1;
		//odbc_date.hour = 0;
		//odbc_date.minute = 0;
		//odbc_date.second = 0;
		return 0;
	}
	//if (data_type == SQL_C_DATE) {
	if (data_type == SQL_C_TYPE_DATE) {
		dateP = (DATE_STRUCT *)(GetDbColPtr(dbp, i));
		odbc_date.year = dateP->year;
		odbc_date.month = dateP->month;
		odbc_date.day = dateP->day;
		odbc_date.hour = 0;
		odbc_date.minute = 0;
		odbc_date.second = 0;
		return 1;
	}
	//if (data_type == SQL_C_TIMESTAMP) {
	if (data_type == SQL_C_TYPE_TIMESTAMP) {
		stampP = (TIMESTAMP_STRUCT *)(GetDbColPtr(dbp, i));
		odbc_date.year = stampP->year;
		odbc_date.month = stampP->month;
		odbc_date.day = stampP->day;
		odbc_date.hour = stampP->hour;
		odbc_date.minute = stampP->minute;
		odbc_date.second = stampP->second;
		return 1;
	}
	//if (data_type == SQL_C_TIME) {
	if (data_type == SQL_C_TYPE_TIME) {
		timeP = (TIME_STRUCT *)(GetDbColPtr(dbp, i));
		odbc_date.year = 1991;
		odbc_date.month = 1;
		odbc_date.day = 1;
		odbc_date.hour = timeP->hour;
		odbc_date.minute = timeP->minute;
		odbc_date.second = timeP->second;
		return 1;
	}

    }
  ATSTXTCAT(error_message, "\nError DATE type in odbc_get_date_data. ");
  if (error_number) {
		return 0;
  }
  else {
		error_number = -DB_ERROR-5;
		return 0;
  }
}

int odbc_get_year()
{
	return odbc_date.year;
}

int odbc_get_month()
{
	return odbc_date.month;
}

int odbc_get_day()
{
	return odbc_date.day;
}

int odbc_get_hour()
{
	return odbc_date.hour;
}

int odbc_get_min()
{
	return odbc_date.minute;
}

int odbc_get_sec()
{
	return odbc_date.second;
}

int odbc_str_len(SQLTCHAR *val) {
	return TXTLEN(val);
}

SQLTCHAR *odbc_str_value(SQLTCHAR *val) {
    	SQLTXTCPY(odbc_date_string, val);
	return odbc_date_string;
}

/*****************************************************************/
/*  The following functions are related with the error processing*/
/*****************************************************************/

int odbc_get_error_code ()
{
	return error_number;
}

SQLTCHAR * odbc_get_error_message ()
{
	return error_message;
}

SQLTCHAR * odbc_get_warn_message ()
{
	return warn_message;
}

void odbc_clear_error ()
{
  error_number = 0;
  error_message[0] = (SQLTCHAR)0;
  warn_message[0] = (SQLTCHAR)0;
}

void odbc_error_handler(HSTMT h_err_stmt, int code) {
	SQLINTEGER nErr;
	SQLTCHAR msg[MAX_ERROR_MSG +1];
	SQLTCHAR tmpMsg[2 * MAX_ERROR_MSG];
	SQLSMALLINT cbMsg;
	SQLTCHAR tmpSQLSTATE[6];
	SQLSMALLINT msg_number;

	if (h_err_stmt == NULL) {
		error_number = DB_ERROR;
		sprintf(charBuf, "ODBC ERROR: <%d>, Inter code: <%d>\n", error_number, code);
		ATSTXTCPY(msg, charBuf);
		SQLTXTCPY(error_message, msg);

		if (code == 12) {
			ATSTXTCAT(error_message, "\n Can't Connect to the assigned Data Source!");
			ATSTXTCAT(error_message, "\n The name may be misspelled or \n The data source is being used by someone else exclusively!");
		}
		return ;
	}

	switch(rc) {
	case SQL_INVALID_HANDLE:
		error_number = DB_SQL_INVALID_HANDLE;
		sprintf(charBuf, "ODBC ERROR: <%d>, Inter code: <%d>", error_number, code);
		ATSTXTCPY(msg, charBuf);
		SQLTXTCAT(error_message, msg);
		ATSTXTCAT(error_message, "\n An Application programming error occurred: maybe passed ");
		ATSTXTCAT(error_message, "\n invalid environment, connection or statement handle to ");
		ATSTXTCAT(error_message, "\n Driver Manager of ODBC. \n");

		break;
	case SQL_ERROR:
		error_number = DB_SQL_ERROR;
		sprintf(charBuf, "ODBC ERROR: <%d>, Inter code: <%d>", error_number, code);
		ATSTXTCPY(msg, charBuf);
		SQLTXTCAT(error_message, msg);
		msg_number = 1;
		while (SQLGetDiagRec(SQL_HANDLE_STMT, h_err_stmt, msg_number++, tmpSQLSTATE, &nErr, msg, sizeof(msg), &cbMsg) != SQL_NO_DATA) {
			sprintf (charBuf, "\n Native Err#=%d , SQLSTATE=", (int) nErr);
			ATSTXTCPY (tmpMsg, charBuf);
			SQLTXTCAT (tmpMsg, tmpSQLSTATE);
			ATSTXTCAT (tmpMsg, ", Error_Info='");
			SQLTXTCAT (tmpMsg, msg);
			ATSTXTCAT (tmpMsg, "'");
	
			if (TXTLEN(error_message) + TXTLEN(tmpMsg) + 8 > ERROR_MESSAGE_SIZE) {
				if (TXTLEN(error_message) + 8 <= ERROR_MESSAGE_SIZE) {
					ATSTXTCAT(error_message, "......");
				}
			}
			else {
				SQLTXTCAT(error_message, tmpMsg);
			}
		}
		ATSTXTCAT(error_message, "\n");
		break;
	case SQL_SUCCESS_WITH_INFO:
		sprintf (charBuf, "\nODBC WARNING Inter code: <%d>", code);
		ATSTXTCPY (msg, charBuf);
		SQLTXTCAT(warn_message, msg);
		msg_number = 1;
		while (SQLGetDiagRec(SQL_HANDLE_STMT, h_err_stmt, msg_number++, tmpSQLSTATE, &nErr, msg, sizeof(msg), &cbMsg) != SQL_NO_DATA) {
			sprintf (charBuf, "\n Native Err#=%d , SQLSTATE=", (int) nErr);
			ATSTXTCPY (tmpMsg, charBuf);
			SQLTXTCAT (tmpMsg, tmpSQLSTATE);
			ATSTXTCAT (tmpMsg, ", Error_Info='");
			SQLTXTCAT (tmpMsg, msg);
			ATSTXTCAT (tmpMsg, "'");

			if (TXTLEN(warn_message) + TXTLEN(tmpMsg) + 8 > WARN_MESSAGE_SIZE) {
				if (TXTLEN(warn_message) + 8 <= WARN_MESSAGE_SIZE) {
					ATSTXTCAT(warn_message, "......");
				}
			}
			else {
				SQLTXTCAT(warn_message, tmpMsg);
			}
		}
		ATSTXTCAT(warn_message,"\n");
		break;
	default:
		sprintf (charBuf, "\nODBC WARNING Inter code: <%d>", code);
		ATSTXTCPY (msg, charBuf);
		SQLTXTCAT(warn_message, msg);
		break;
	}
}

 /* make a copy of a string */
SQLTCHAR *odbc_str_from_str(SQLTCHAR *ptr) {
	SQLTCHAR *val;
	ODBC_SAFE_ALLOC(val, (SQLTCHAR *) malloc(TXTLEN(ptr) + sizeof (SQLTCHAR)));
	SQLTXTCPY(val, ptr);
	return val;
}

int odbc_c_type(int odbc_type) {
	switch(odbc_type) {
		case SQL_CHAR:
		case SQL_VARCHAR:
		case SQL_LONGVARCHAR:
			return SQL_C_CHAR;
		case SQL_WCHAR:
		case SQL_WVARCHAR:
		case SQL_WLONGVARCHAR:
			return SQL_C_WCHAR;
		//case SQL_DATE:
		case SQL_TYPE_DATE:
			//return SQL_C_DATE;
			return SQL_C_TYPE_DATE;
		//case SQL_TIME:
		case SQL_TYPE_TIME:
			//return SQL_C_TIME;
			return SQL_C_TYPE_TIME;
		//case SQL_TIMESTAMP:
		case SQL_TYPE_TIMESTAMP:
			//return SQL_C_TIMESTAMP;
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
		default:
			return SQL_C_DEFAULT;
	}
}

rt_private void change_to_low (SQLTCHAR *buf, int length) {
	/* Do not care about non-ASCII characters. */
	for (; length >= 0; length--)
		buf[length] = (buf[length] > 0xFF) ? buf[length] : tolower(buf[length]);
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
/* Return: non-zero if found */
rt_private int find_name (SQLTCHAR *buf, SQLTCHAR * sqlStat)
{
	int i, j;
	for (i=COMPARED_LENGTH; sqlStat[i] != TXTC('(') && sqlStat[i] != (SQLTCHAR)0; i++);
	if (sqlStat[i] == TXTC('('))
		i++;
	j = i;
	for (; sqlStat[i] != TXTC('\'') && sqlStat[i] != (SQLTCHAR)0; i++);
	if (sqlStat[i] == (SQLTCHAR)0)
		i = j;
	else
		i++;
	for (j=0; sqlStat[i] != TXTC(')') && sqlStat[i] != (SQLTCHAR)0 && sqlStat[i] != TXTC('\''); i++, j++) {
		buf[j] = sqlStat[i];
	}
	buf[j] = (SQLTCHAR)0;
	return j;
}

EIF_NATURAL_64 strhextoval(SQL_NUMERIC_STRUCT *NumStr)
{
	EIF_NATURAL_64 val,value,last,current,a,b;
	int i=1;

	val=0;value=0;last=1;a=0;b=0;

    for(i=0;i<=15;i++){
		current = (EIF_NATURAL_64) NumStr->val[i];
		a= current % 16; //Obtain LSD
		b= current / 16; //Obtain MSD

		value += last* a;	
		last = last * 16;
		value += last* b;
		last = last * 16;
	}
	return value;
}
