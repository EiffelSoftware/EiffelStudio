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

#define WIN32
#include <windows.h>

#include <stdio.h>
#include <string.h>
#include <sql.h>
#include <sqlext.h>
#include "odbc.h"
#include "eif_eiffel.h"


void odbc_error_handler (HSTMT,int);
void odbc_clear_error ();
void odbc_disp_rec(int);
void odbc_disp_c_type();
void odbc_unhide_qualifier(char *);
char *odbc_date_to_str(int, int, int, int, int, int, int);
int	 odbc_c_type(int odbc_type);

int odbc_close_cursor (int no_des);


ODBCSQLDA * odbc_descriptor[MAX_DESCRIPTOR];
short   flag[MAX_DESCRIPTOR];
SQLHSTMT   hstmt[MAX_DESCRIPTOR];
SDWORD  *pcbValue[MAX_DESCRIPTOR];
HENV    henv;
HDBC    hdbc;
SDWORD *odbc_indicator[MAX_DESCRIPTOR];
SDWORD odbc_tmp_indicator;
RETCODE rc;
TIMESTAMP_STRUCT odbc_date;
char odbc_date_string[DB_DATE_LEN];

char odbc_qualifier[DB_MAX_QUALIFIER_LEN];
char odbc_owner[DB_MAX_USER_NAME_LEN];
char idQuoter[DB_QUOTER_LEN];
char quaNameSep[DB_NAME_SEP_LEN];
long odbc_case;
char storedProc[2];
char CreateStoredProc[DB_MAX_NAME_LEN];
char dbmsName[DB_MAX_NAME_LEN];
char dbmsVer[DB_MAX_NAME_LEN];
// Added for multiple connection
short number_connection=0;

/* Messages: Are not exported to Eiffel due to
merge with Oracle variables when using both files.
Wrapping functions are used.*/
rt_private char *error_message = NULL;
rt_private char *warn_message = NULL;
rt_private int error_number = 0;

static int tmp_int = 0;
static int data_type = 0, size = 0, max_size = 0, * past_time = NULL;
static char *tmp_st = NULL;
char odbc_user_name[40];

short odbc_tranNumber=0; /* number of transaction opened at present */

rt_private int odbc_first_descriptor_available (void);
rt_private void change_to_low(char *buf, int length);

int is_null_data;

/* each function return 0 in case of success */
/* and database error code ( >= 1) else */

/*****************************************************************/
/* initialise ODBC   c-module                                    */
/*****************************************************************/

void c_odbc_make (int m_size)
{
  int count;

  if (error_message == NULL) {
	 ODBC_SAFE_ALLOC(error_message, (char *) malloc (sizeof (char) * (m_size + ERROR_MESSAGE_SIZE)));
	 ODBC_SAFE_ALLOC(warn_message, (char *) malloc (sizeof (char) * (m_size + WARN_MESSAGE_SIZE)));
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
      /* ODBC_SAFE_ALLOC(odbc_descriptor[result], (ODBCSQLDA *) malloc(IISQDA_HEAD_SIZE + IISQDA_VAR_SIZE));
      SetVarNum(odbc_descriptor[result], 1); */
      odbc_descriptor[result] = (ODBCSQLDA *)(0x1);
      pcbValue[result] = NULL;
      odbc_indicator[result] = NULL;
      flag[result] = ODBC_SQL;
    }
  else {
	odbc_error_handler(NULL, 201);
	strcpy(error_message, " No available descriptor\n");
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
		strcat(error_message, "\nInvalid Descriptor Number!");
	}
	if (argNum > 0) {
		ODBC_SAFE_ALLOC(pcbValue[no_desc], (SDWORD *) malloc(sizeof(SDWORD)*argNum));
	} else
	pcbValue[no_desc] = NULL;
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
void odbc_exec_immediate (int no_desc, char *order)
{


	odbc_unhide_qualifier(order);
	odbc_tranNumber = 1;
	warn_message[0] = '\0';

	rc = SQLExecDirect(hstmt[no_desc], order, SQL_NTS);
	odbc_descriptor[no_desc] = NULL;
	if (rc) {
		odbc_error_handler(hstmt[no_desc], 2);
	}
	//rc = SQLFreeStmt(hstmt[no_desc], SQL_DROP);
	rc = SQLFreeHandle (SQL_HANDLE_STMT, hstmt[no_desc]);
	if (rc)
		odbc_error_handler(hstmt[no_desc],3);
	odbc_descriptor[no_desc] = NULL;
	if (pcbValue[no_desc] != NULL) {
		free(pcbValue[no_desc]);
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
void odbc_init_order (int no_desc, char *order, int argNum)
{
	ODBCSQLDA *dap=odbc_descriptor[no_desc];
	//short colNum;
	int i, j;
	//int type;
	//SWORD indColName;
	//SWORD tmpNullable;
	//int bufSize;
	//char *dataBuf;

	char tmpBuf[DB_MAX_TABLE_LEN];
	char sqltab[30];
	char sqlcol[30];
	char sqlproc[30];

	strcpy(sqltab, "sqltables");
	strcpy(sqlcol, "sqlcolumns");
	strcpy(sqlproc, "sqlprocedu");


	if (no_desc < 0 || no_desc > MAX_DESCRIPTOR) {
		odbc_error_handler(NULL, 203);
		strcat(error_message, "\nInvalid Descriptor Number!");
	}
	odbc_unhide_qualifier(order);
	odbc_tranNumber = 1;
	odbc_clear_error();
	warn_message[0] = '\0';


	flag[no_desc] = ODBC_SQL;


	if (strlen(order) >= 9) {
		memcpy(tmpBuf, order, 9);
		tmpBuf[10] = '\0';
		change_to_low(tmpBuf, 10);
		if (memcmp(tmpBuf, sqltab, 9) == 0) {
			flag[no_desc] = ODBC_CATALOG_TAB;
			for (i=9; order[i] != '(' && order[i] != '\0'; i++);
			if (order[i] == '(')
				i++;
			j = i;
			for (; order[i] != '\'' && order[i] != '\0'; i++);
			if (order[i] == '\0')
				i = j;
			else
				i++;
			for (j=0; order[i] != ')' && order[i] != '\0' && order[i] != '\''; i++, j++)
				tmpBuf[j] = order[i];
			tmpBuf[j] = '\0';
			if (j) {
				if (strlen(odbc_qualifier) > 0 && strlen(odbc_owner) > 0)
					rc = SQLTables(hstmt[no_desc], odbc_qualifier, SQL_NTS, odbc_owner, SQL_NTS, tmpBuf, SQL_NTS, NULL, 0);
				if (strlen(odbc_qualifier) == 0 && strlen(odbc_owner) > 0)
					rc = SQLTables(hstmt[no_desc], NULL, 0, odbc_owner, SQL_NTS, tmpBuf, SQL_NTS, NULL, 0);
				if (strlen(odbc_qualifier) > 0 && strlen(odbc_owner) == 0)
					rc = SQLTables(hstmt[no_desc], odbc_qualifier, SQL_NTS, NULL, 0, tmpBuf, SQL_NTS, NULL, 0);
				if (strlen(odbc_qualifier) == 0 && strlen(odbc_owner) == 0)
					rc = SQLTables(hstmt[no_desc], NULL, 0, NULL, 0, tmpBuf, SQL_NTS, NULL, 0);
			}
			else
				rc = SQLTables(hstmt[no_desc], NULL, 0, NULL, 0, NULL, 0, NULL, 0);
			odbc_qualifier[0] = '\0';
			odbc_owner[0] ='\0';
		}
		else {
			if (memcmp(tmpBuf, sqlcol, 9) == 0) {
				flag[no_desc] = ODBC_CATALOG_COL;
				for (i=9; order[i] != '(' && order[i] != '\0'; i++);
				if (order[i] == '(')
					i++;
				j = i;
				for (; order[i] != '\'' && order[i] != '\0'; i++);
				if (order[i] == '\0')
					i = j;
				else
					i++;
				for (j=0; order[i] != ')' && order[i] != '\0' && order[i] != '\''; i++, j++)
					tmpBuf[j] = order[i];
				tmpBuf[j] = '\0';
				if (j)
					rc = SQLColumns(hstmt[no_desc], NULL, 0, NULL, 0, tmpBuf, SQL_NTS, NULL, 0);
				else
					rc = SQLColumns(hstmt[no_desc], NULL, 0, NULL, 0, NULL, 0, NULL, 0);
			}
			else {
				if (memcmp(tmpBuf, sqlproc, 9) == 0) {
					flag[no_desc] = ODBC_CATALOG_PROC;
					for (i=9; order[i] != '(' && order[i] != '\0'; i++);
					if (order[i] == '(')
						i++;
					j = i;
					for (; order[i] != '\'' && order[i] != '\0'; i++);
					if (order[i] == '\0')
						i = j;
					else
						i++;
					for (j=0; order[i] != ')' && order[i] != '\0' && order[i] != '\''; i++, j++)
						tmpBuf[j] = order[i];
					tmpBuf[j] = '\0';
					if (j)
						rc = SQLProcedures(hstmt[no_desc], NULL, 0, NULL, 0, tmpBuf, SQL_NTS);
					else
						rc = SQLProcedures(hstmt[no_desc], NULL, 0, NULL, 0, NULL, 0);
				}
 			}
		}
	}

	if (rc) {
		odbc_error_handler(hstmt[no_desc],100);
		if (error_number) {
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
				odbc_descriptor[no_desc] = NULL;
				//rc = SQLFreeStmt(hstmt[no_desc], SQL_DROP);
				rc = SQLFreeHandle (SQL_HANDLE_STMT, hstmt[no_desc]);
			}
		}
	}

	if (argNum > 0) {
		ODBC_SAFE_ALLOC(pcbValue[no_desc], (SDWORD *) malloc(sizeof(SDWORD)*argNum));
	} else
		pcbValue[no_desc] = NULL;
}


/*****************************************************************/
/*                                                               */
/*                     ROUTINE  DESCRIPTION                      */
/*                                                               */
/* NAME: odbc_start_order(no_des)                                 */
/* PARAMETERS: no_des- index in descriptor vector.               */
/* DESCRIPTION:                                                  */
/*   Finish execution of a SQL statement in DYNAMICLLY EXECUTION */
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
	ODBCSQLDA *dap=odbc_descriptor[no_desc];
	short colNum;
	int i;
	//int j;
	int type;
	SQLSMALLINT indColName;
	SQLSMALLINT tmpScale;
	SQLSMALLINT tmpNullable;
	int bufSize;
	char *dataBuf;
	// Added by Jacques. 5/14/98
	SQLCHAR     szCatalog[DB_REP_LEN], szSchema[DB_REP_LEN];
	SQLCHAR     szTableName[DB_REP_LEN], szColumnName[DB_REP_LEN];
	SQLCHAR     szTypeName[DB_REP_LEN];
	SQLINTEGER  ColumnSize, BufferLength;
	SQLSMALLINT DataType, DecimalDigits, NumPrecRadix, Nullable;

	SQLINTEGER cbCatalog, cbSchema, cbTableName, cbColumnName;
	SQLINTEGER cbDataType, cbTypeName, cbColumnSize, cbBufferLength;
	SQLINTEGER cbDecimalDigits, cbNumPrecRadix, cbNullable;

	if (flag[no_desc] == ODBC_CATALOG_COL) {
			SQLBindCol(hstmt, 1, SQL_C_CHAR, szCatalog, DB_REP_LEN,&cbCatalog);
			SQLBindCol(hstmt, 2, SQL_C_CHAR, szSchema, DB_REP_LEN, &cbSchema);
			SQLBindCol(hstmt, 3, SQL_C_CHAR, szTableName, DB_REP_LEN,&cbTableName);
			SQLBindCol(hstmt, 4, SQL_C_CHAR, szColumnName, DB_REP_LEN, &cbColumnName);
			SQLBindCol(hstmt, 5, SQL_C_SSHORT, &DataType, 0, &cbDataType);
			SQLBindCol(hstmt, 6, SQL_C_CHAR, szTypeName, DB_REP_LEN, &cbTypeName);
			SQLBindCol(hstmt, 7, SQL_C_SLONG, &ColumnSize, 0, &cbColumnSize);
			SQLBindCol(hstmt, 8, SQL_C_SLONG, &BufferLength, 0, &cbBufferLength);
			SQLBindCol(hstmt, 9, SQL_C_SSHORT, &DecimalDigits, 0, &cbDecimalDigits);
			SQLBindCol(hstmt, 10, SQL_C_SSHORT, &NumPrecRadix, 0, &cbNumPrecRadix);
			SQLBindCol(hstmt, 11, SQL_C_SSHORT, &Nullable, 0, &cbNullable);
			while(TRUE) {
				rc = SQLFetch(hstmt);
				if (rc == SQL_ERROR || rc == SQL_SUCCESS_WITH_INFO) {
					odbc_error_handler(hstmt[no_desc],7);
					if (error_number > 0) {
						odbc_descriptor[no_desc] = NULL;
						if (pcbValue[no_desc] != NULL) {
							free(pcbValue[no_desc]);
							pcbValue[no_desc] = NULL;
						}
						rc = SQLFreeHandle (SQL_HANDLE_STMT, hstmt[no_desc]);
					}
				}
				if (rc == SQL_SUCCESS || rc == SQL_SUCCESS_WITH_INFO){
					rc = SQLNumResultCols(hstmt[no_desc], &colNum);
					if (rc) {
						odbc_error_handler(hstmt[no_desc],5);
						if (error_number) {
							odbc_descriptor[no_desc] = NULL;
							if (pcbValue[no_desc] != NULL) {
								free(pcbValue[no_desc]);
								pcbValue[no_desc] = NULL;
							}
							rc = SQLFreeHandle (SQL_HANDLE_STMT, hstmt[no_desc]);
						}
					}
					/*memcpy( (SQL_C_CHAR *)(&(odbc_indicator[no_des][1]), (SQL_C_CHAR *)(&cbCatalog)), DB_SIZEOF_CHAR);
					memcpy( (SQL_C_CHAR *)(&(odbc_indicator[no_des][2]), (SQL_C_CHAR *)(&cbSchema)), DB_SIZEOF_CHAR);
					memcpy( (SQL_C_CHAR *)(&(odbc_indicator[no_des][3]), (SQL_C_CHAR *)(&cbTableName)), DB_SIZEOF_CHAR);
					memcpy( (SQL_C_CHAR *)(&(odbc_indicator[no_des][4]), (SQL_C_CHAR *)(&cbColumnName)), DB_SIZEOF_CHAR);
					memcpy( (SQL_C_SSHORT *)(&(odbc_indicator[no_des][5]), (SQL_C_SSHORT *)(&cbDataType)), DB_SIZEOF_SHORT);
					memcpy( (SQL_C_CHAR *)(&(odbc_indicator[no_des][6]), (SQL_C_CHAR *)(&cbTypeName)), DB_SIZEOF_CHAR);
					memcpy( (SQL_C_SLONG *)(&(odbc_indicator[no_des][7]), (SQL_C_SLONG *)(&cbColumnSize)), DB_SIZEOF_LONG);
					memcpy( (SQL_C_SLONG *)(&(odbc_indicator[no_des][8]), (SQL_C_SLONG *)(&cbBufferLength)), DB_SIZEOF_LONG);
					memcpy( (SQL_C_SSHORT *)(&(odbc_indicator[no_des][9]), (SQL_C_SSHORT *)(&cbDecimalDigits)), DB_SIZEOF_SHORT);
					memcpy( (SQL_C_SSHORT *)(&(odbc_indicator[no_des][10]), (SQL_C_SSHORT *)(&cbNumPrecRadix)), DB_SIZEOF_SHORT);
					memcpy( (SQL_C_SSHORT *)(&(odbc_indicator[no_des][11]), (SQL_C_SSHORT *)(&cbNullable)), DB_SIZEOF_SHORT);*/

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
				odbc_descriptor[no_desc] = NULL;
				if (pcbValue[no_desc] != NULL) {
					free(pcbValue[no_desc]);
					pcbValue[no_desc] = NULL;
				}
				//rc = SQLFreeStmt(hstmt[no_desc], SQL_DROP);
				rc = SQLFreeHandle (SQL_HANDLE_STMT, hstmt[no_desc]);
			}
		}

/*
		rc = SQLExecDirect(hstmt[no_desc], order, SQL_NTS);
		if (rc) {
			odbc_error_handler(hstmt[no_desc],7);
			if (error_number > 0) {
				odbc_descriptor[no_desc] = NULL;
				rc = SQLFreeStmt(hstmt[no_desc], SQL_DROP);
				return error_number;
			}
		}
*/
	}

	/* Get the number of output columns of the ODBC statement */
	rc = SQLNumResultCols(hstmt[no_desc], &colNum);
	if (rc) {
		odbc_error_handler(hstmt[no_desc],5);
		if (error_number) {
			odbc_descriptor[no_desc] = NULL;
			if (pcbValue[no_desc] != NULL) {
				free(pcbValue[no_desc]);
				pcbValue[no_desc] = NULL;
			}
			//rc = SQLFreeStmt(hstmt[no_desc], SQL_DROP);
			rc = SQLFreeHandle (SQL_HANDLE_STMT, hstmt[no_desc]);
		}
	}


	if (colNum > DB_MAX_COLS) {
		if (error_number) {
			strcat(error_message, "\n Number of selected columns exceed max number(300) ");
		}
		else {
			strcpy(error_message, "\n Number of selected columns exceed max number(300) ");
			error_number = -DB_TOO_MANY_COL;
		}
		odbc_descriptor[no_desc] = NULL;
		if (pcbValue[no_desc] != NULL) {
			free(pcbValue[no_desc]);
			pcbValue[no_desc] = NULL;
		}
		//rc = SQLFreeStmt(hstmt[no_desc], SQL_DROP);
		rc = SQLFreeHandle (SQL_HANDLE_STMT, hstmt[no_desc]);
	}

	if (colNum > 0)
		i = colNum;
	else
		i = 1;
	/* Reallocate the DESCRIPTOR area.   */
	ODBC_SAFE_ALLOC(odbc_descriptor[no_desc], (ODBCSQLDA *) malloc(IISQDA_HEAD_SIZE + i * IISQDA_VAR_SIZE));
	dap = odbc_descriptor[no_desc];
	SetVarNum(dap,i);
	SetColNum(dap, colNum);

	bufSize = 0;
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
			(dap->sqlvar)[i].sqlname.sqlnamec[indColName] = '\0';
			(dap->sqlvar)[i].sqlname.sqlnamel = strlen((dap->sqlvar)[i].sqlname.sqlnamec);
			dap->sqlvar[i].c_type = odbc_c_type(dap->sqlvar[i].sqltype);
			type = dap->sqlvar[i].c_type;
			switch(type) {
				//case SQL_C_DATE:
				case SQL_C_TYPE_DATE:
					SetDbColLength(dap, i, sizeof(DATE_STRUCT));
					/*bufSize += sizeof(DATE_STRUCT) + 1; */
					break;
				//case SQL_C_TIME:
				case SQL_C_TYPE_TIME:
					SetDbColLength(dap, i, sizeof(TIME_STRUCT));
					/*bufSize += sizeof(TIME_STRUCT) + 1; */
					break;
				//case SQL_C_TIMESTAMP:
				case SQL_C_TYPE_TIMESTAMP:
					SetDbColLength(dap, i, sizeof(TIMESTAMP_STRUCT));
					/*bufSize += sizeof(TIMESTAMP_STRUCT) + 1; */
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
				case SQL_C_FLOAT:
					SetDbColLength(dap, i, DB_SIZEOF_REAL);
					break;
				case SQL_C_DOUBLE:
					SetDbColLength(dap, i, DB_SIZEOF_DOUBLE);
					break;
				default:
					/*bufSize += GetDbColLength(dap, i) + 1;*/
					break;
			}
			type = GetDbColType(dap, i);
			switch (type) {
				case SQL_LONGVARBINARY:
				case SQL_LONGVARCHAR:
					SetDbColLength(dap, i, DB_MAX_STRING_LEN);
					break;
			}
			bufSize += GetDbColLength(dap, i) + 1;
		}
	}


	if (error_number) {
		free(dap);
		odbc_descriptor[no_desc] = NULL;
		if (pcbValue[no_desc] != NULL) {
			free(pcbValue[no_desc]);
			pcbValue[no_desc] = NULL;
		}
		//rc = SQLFreeStmt(hstmt[no_desc], SQL_DROP);
		rc = SQLFreeHandle (SQL_HANDLE_STMT, hstmt[no_desc]);
	}

	/* allocate the data  buffer, and then assign the data buffer to */
	/* each database table field.                                    */
	if (colNum) {
		ODBC_SAFE_ALLOC(dataBuf, (char *) malloc(bufSize+2));
	}
	for (i=0; i<colNum; i++) {
		SetDbColPtr(dap, i, dataBuf);
		dataBuf += GetDbColLength(dap, i) + 1;

	}

	/* allocate buffer for INDICATORs of the output fields           */
	ODBC_SAFE_ALLOC(odbc_indicator[no_desc], (SDWORD *) malloc((colNum+1)*sizeof(long)));
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
	//int i;
	ODBCSQLDA *dap = odbc_descriptor[no_des];
	int colNum;

		if (dap != NULL) {
	    	if (dap != (ODBCSQLDA *)(0x1)) {
			colNum = GetColNum(dap);
			if (colNum)
				free(GetDbColPtr(dap,0));
			free(dap);
			free(odbc_indicator[no_des]);
			odbc_indicator[no_des] = NULL;
		    }
	 	    odbc_descriptor[no_des] = NULL;
		    if (pcbValue[no_des] != NULL) {
		        free(pcbValue[no_des]);
			pcbValue[no_des] = NULL;
		    }
		    //rc = SQLFreeStmt(hstmt[no_des], SQL_DROP);
			rc = SQLFreeHandle (SQL_HANDLE_STMT, hstmt[no_des]);
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
int odbc_close_cursor (int no_des)
{
    rc = SQLFreeStmt(hstmt[no_des], SQL_CLOSE);
	return error_number;
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
		odbc_error_handler(hstmt[no_des],8);
		if (error_number) {
			odbc_terminate_order(no_des);
			return 1;
		}
	}


	if (rc == NO_MORE_ROWS) /* NO_MORE_ROWS */ {
		return 1;
	}
	else {
		for (i=0; i<colNum && error_number == 0; i++) {
			odbc_indicator[no_des][i] = 0;
			rc = SQLGetData(hstmt[no_des], i+1, GetDbCType(dap, i), GetDbColPtr(dap, i), GetDbColLength(dap, i)+1, &(odbc_indicator[no_des][i]));
			if (rc)
				odbc_error_handler(hstmt[no_des],9);
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
	return *storedProc == 'Y' || *storedProc == 'y';
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
	i=strcmp(CreateStoredProc, "stored procedure");
	j=strcmp(CreateStoredProc, "Stored Procedure");
	if (i==0||j==0)
		return 1;
	else
		return 0;
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

char * odbc_driver_name() {
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
	return odbc_case == SQL_IC_SENSITIVE;
}

int odbc_insensitive_mixed() {
	return odbc_case == SQL_IC_MIXED;
}


/* The following function has not been used by EiffelStore on ODBC now and has not been */
/* writen well.										*/

void odbc_set_parameter(int no_desc, int seri, int dir, int eifType, char *value) {

	UWORD seriNumber = seri;
	SWORD direction = dir;
	SDWORD len;
/*
char * da;
TIMESTAMP_STRUCT *dp;
*/

	if (eifType != DATE_TYPE) {
		pcbValue[no_desc][seriNumber-1] = len = strlen(value) ;
	}
	rc = 0;
	direction = SQL_PARAM_INPUT;

	switch (eifType) {
		case CHARACTER_TYPE:
		case STRING_TYPE:
			rc = SQLBindParameter(hstmt[no_desc], seriNumber, direction, SQL_C_CHAR, SQL_CHAR, len, 0, value, len, &(pcbValue[no_desc][seriNumber-1]));
			break;
		case INTEGER_TYPE:
			rc = SQLBindParameter(hstmt[no_desc], seriNumber, direction, SQL_C_SLONG, SQL_INTEGER, sizeof(long), 0, value, len, &(pcbValue[no_desc][seriNumber-1]));
			break;
		case FLOAT_TYPE:
			rc = SQLBindParameter(hstmt[no_desc], seriNumber, direction, SQL_C_DOUBLE, SQL_DOUBLE, 8, 0, value, len, &(pcbValue[no_desc][seriNumber-1]));
			break;
		case REAL_TYPE:
			rc = SQLBindParameter(hstmt[no_desc], seriNumber, direction, SQL_C_CHAR, SQL_REAL, sizeof(float), 0, value, len, &(pcbValue[no_desc][seriNumber-1]));
			break;
		case BOOLEAN_TYPE:
			rc = SQLBindParameter(hstmt[no_desc], seriNumber, direction, SQL_C_CHAR, SQL_BIT, sizeof(int), 0, value, len, &(pcbValue[no_desc][seriNumber-1]));
			break;
		case DATE_TYPE:
			len = pcbValue[no_desc][seriNumber-1] = sizeof(TIMESTAMP_STRUCT);
			rc = SQLBindParameter(hstmt[no_desc], seriNumber, direction, SQL_C_TYPE_TIMESTAMP, SQL_TYPE_TIMESTAMP, len, 0, value, len, &(pcbValue[no_desc][seriNumber-1]));
			break;
		default:
			odbc_error_handler(NULL, 204);
			strcat(error_message, "\nInvalid Data Type in odbc_set_parameter");
			odbc_error_handler(NULL, 110);
	}
	if (rc)
		odbc_error_handler(hstmt[no_desc], rc);
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
int odbc_set_col_flag(int no_desc) {
	flag[no_desc] = ODBC_CATALOG_COL;
	return error_number;

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
int odbc_set_tab_flag(int no_desc) {
	flag[no_desc] = ODBC_CATALOG_TAB;
	return error_number;
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
int odbc_set_proc_flag(int no_desc) {
	flag[no_desc] = ODBC_CATALOG_PROC;
	return error_number;
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
char *odbc_hide_qualifier(char *buf) {
	int i;
	int len = strlen(buf);

	for (i=0; i < len; i++) {
		if (buf[i] == ':' && i > 0 && ((buf[i-1] >= 'a' && buf[i-1] <= 'z') || (buf[i-1] >='A' && buf[i-1] <= 'Z')))
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
void odbc_unhide_qualifier(char *buf) {
	int i;
	int len = strlen(buf);


	for (i=0; i < len; i++) {
		if (buf[i] == 0x1 && i > 0 && ((buf[i-1] >= 'a' && buf[i-1] <= 'z') || (buf[i-1] >='A' && buf[i-1] <= 'Z')))
			buf[i] = ':' ;
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
char *odbc_identifier_quoter() {
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
char *odbc_qualifier_seperator() {
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
void odbc_set_qualifier(char *qfy) {
	if (qfy == NULL)
		odbc_qualifier[0] = '\0';
	else
		strcpy(odbc_qualifier, qfy);
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
void odbc_set_owner(char *owner) {
	if (owner == NULL)
		odbc_owner[0] = '\0';
	else
		strcpy(odbc_owner, owner);

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
int odbc_unset_catalog_flag(int no_desc) {
	flag[no_desc] = ODBC_SQL;
	return error_number;
}

/*****************************************************************/
/*                                                               */
/*                     ROUTINE  DESCRIPTION                      */
/*                                                               */
/* NAME: odbc_date_to_str(int y,m,d,hr,min,sec, mode             */
/* PARAMETER: mode -- 0: get time string                         */
/*                 -- 1: get date string                         */
/*                 -- others: get timestamp string               */
/* DESCRIPTION:                                                  */
/*   to change an Eiffel DATE data into a STRING in the following*/
/* format: 'yyyy-mm-dd hh:mm:ss'                                 */
/*                                                               */
/*****************************************************************/
char *odbc_date_to_str(int year, int month, int day, int hour, int minute, int sec, int type) {
	int mo1,mo2,d1,d2,h1,h2,m1,m2,s1,s2;

	mo1 = month / 10;
	mo2 = month % 10;
	d1 = day / 10;
	d2 = day % 10;
	h1 = hour / 10;
	h2 = hour % 10;
	m1 = minute / 10;
	m2 = minute % 10;
	s1 = sec / 10;
	s2 = sec % 10;
	switch (type) {
		case ODBC_TIME: /* TIME type */
			sprintf(odbc_date_string, "%d%d:%d%d:%d%d", h1,h2,m1,m2,s1,s2);
			break;
		case ODBC_DATE: /* DATE type */
			sprintf(odbc_date_string, "%d-%d%d-%d%d", year,mo1,mo2,d1,d2);
			break;
		default: /* TIMESTAMP type */
			sprintf(odbc_date_string, "%d-%d%d-%d%d %d%d:%d%d:%d%d", year,mo1,mo2,d1,d2,h1,h2,m1,m2,s1,s2);
	}
	return odbc_date_string;
}


/*****************************************************************/
/*                                                               */
/*                     ROUTINE  DESCRIPTION                      */
/*                                                               */
/* NAME: odbc_date(int year,month,day,hour,minute,sec;char *buf  */
/* DESCRIPTION:                                                  */
/*   to change an Eiffel DATE data into a STRING in the following*/
/* format: 'yyyy-mm-dd hh:mm:ss'                                 */
/*                                                               */
/*****************************************************************/
char *odbc_stru_of_date(int year, int month, int day, int hour, int minute, int sec, int type) {
	TIMESTAMP_STRUCT *res;

	ODBC_SAFE_ALLOC(res, (TIMESTAMP_STRUCT *) malloc(sizeof(TIMESTAMP_STRUCT)));
	res->year = year;
	res->month = month;
	res->day = day;
	res->hour = hour;
	res->minute = minute;
	res->second = sec;
	return (char *)res;
}

/* make a copy of a string */
char *odbc_str_from_str(char *ptr) {
	char *val;

	ODBC_SAFE_ALLOC(val, (char *) malloc(strlen(ptr) + 1));
	strcpy(val, ptr);
	return val;
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
int odbc_connect (char *name, char *passwd, char *dsn)
{
	SWORD indColName;
	//int i;
	SWORD passLen, nameLen, dsnLen;
	odbc_clear_error ();
	strcpy(odbc_user_name, name);
	rc = SQLAllocHandle(SQL_HANDLE_ENV,SQL_NULL_HANDLE,&henv);
	if (rc) {
		odbc_error_handler(NULL,10);
		return error_number;
	}
	//rc = SQLSetEnvAttr(henv,SQL_ATTR_ODBC_VERSION,(SQLPOINTER)SQL_OV_ODBC2,0);
	rc = SQLSetEnvAttr(henv,SQL_ATTR_ODBC_VERSION,(SQLPOINTER)SQL_OV_ODBC3,0);
	if (rc) {
		odbc_error_handler(NULL,910);
		rc = SQLFreeHandle(SQL_HANDLE_ENV,henv);
		return error_number;
	}
	rc = SQLAllocHandle(SQL_HANDLE_DBC,henv, &hdbc);
	if (rc) {
		odbc_error_handler(NULL,11);
		rc = SQLFreeHandle(SQL_HANDLE_ENV,henv);
		return error_number;
	}
	dsnLen = strlen(dsn);
	nameLen = strlen(name);
	passLen = strlen(passwd);
	rc = SQLConnect(hdbc, dsn, dsnLen, name, nameLen, passwd, passLen);
	if (rc<0) {
		odbc_error_handler(NULL,12);
		rc = SQLFreeHandle(SQL_HANDLE_DBC,hdbc);
		rc = SQLFreeHandle(SQL_HANDLE_ENV,henv);
		return error_number ;
	}
	// Added for multiple connection
	number_connection = number_connection + 1;
	//odbc_tranNumber=odbc_tranNumber + 1;
	rc = SQLGetInfo(hdbc, SQL_PROCEDURES, dbmsName, sizeof(dbmsName), &indColName);
	strcpy(storedProc, dbmsName);
	rc = SQLGetInfo(hdbc, SQL_PROCEDURE_TERM, dbmsName, sizeof(dbmsName), &indColName);
	strcpy(CreateStoredProc, dbmsName);
	rc = SQLGetInfo(hdbc, SQL_DBMS_NAME, dbmsName, sizeof(dbmsName), &indColName);
	rc = SQLGetInfo(hdbc, SQL_DBMS_VER, dbmsVer, sizeof(dbmsVer), &indColName);
	rc = SQLGetInfo(hdbc, SQL_IDENTIFIER_QUOTE_CHAR, idQuoter, sizeof(idQuoter), &indColName);
	rc = SQLGetInfo(hdbc, SQL_QUOTED_IDENTIFIER_CASE, &odbc_case, sizeof(odbc_case), &indColName);

	if (indColName == 1 && idQuoter[0] == ' ')
		idQuoter[0] = '\0';
	else
		idQuoter[indColName] = '\0';

	//rc = SQLGetInfo(hdbc, SQL_QUALIFIER_NAME_SEPARATOR, quaNameSep, sizeof(quaNameSep), &indColName);
	rc = SQLGetInfo(hdbc, SQL_CATALOG_NAME_SEPARATOR, quaNameSep, sizeof(quaNameSep), &indColName);
	if (indColName == 1 && quaNameSep[0] == ' ')
		quaNameSep[0] = '\0';
	else
		quaNameSep[indColName] = '\0';

/*
	for (i=0; i< MAX_DESCRIPTOR && error_number == 0; i++) {
		rc = SQLAllocStmt(hdbc, &(hstmt[i]));
		if (rc) {
			odbc_error_handler(NULL, 101);
		}
	}
*/
	return error_number;
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
int odbc_begin ()
{
  odbc_clear_error ();
  /*
  rc = SQLTransact(SQL_NULL_HENV, hdbc, SQL_BEGIN);
  if (rc)
	odbc_error_handler(NULL,19);
  */
  /* ODBC Has no explicit Transact_begin statement. */
  return error_number;
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
void cut_tail_blank(char *buf) {
	int j;

	if (buf != NULL) {
		for(j=strlen(buf)-1;j>=0 && buf[j]==' '; j--);
		j++;
		buf[j] = '\0';
	}
}

int odbc_get_user  (char *result)
{
	size = strlen(odbc_user_name);
	memcpy(result, odbc_user_name, size);
	return(size);
}

int odbc_get_count (int no_des)
{
	if (odbc_descriptor[no_des] == NULL)
		return -1;

	return GetColNum(odbc_descriptor[no_des]);
}

int odbc_put_col_name (int no_des, int index, char *result)
{
	int i = index - 1;
	char buf[DB_MAX_NAME_LEN+1];

	size = (((odbc_descriptor[no_des])->sqlvar)[i]).sqlname.sqlnamel;
	memcpy(buf, (((odbc_descriptor[no_des])->sqlvar)[i]).sqlname.sqlnamec, size);
	buf[size] = '\0';
	cut_tail_blank(buf);
	size = strlen(buf);
	memcpy(result, buf, size);
	return(size);
}

int odbc_get_col_len (int no_des, int index)
{
	int i = index - 1;
	int length = GetDbColLength(odbc_descriptor[no_des], i);


	return length;
}

UDWORD odbc_get_data_len (int no_des, int index)
{
  int i = index - 1;
  int type = abs(GetDbCType(odbc_descriptor[no_des], i));
  char *dataPtr = GetDbColPtr(odbc_descriptor[no_des],i);
  int length = GetDbColLength(odbc_descriptor[no_des], i);
  //short tmp_short;

  switch (type)
    {
    case SQL_C_CHAR:
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
		case SQL_DECIMAL:
		case SQL_NUMERIC:
		case SQL_FLOAT:
		case SQL_DOUBLE:
			return FLOAT_TYPE;
		case SQL_REAL:
			return REAL_TYPE;
		case SQL_SMALLINT:
		case SQL_INTEGER:
		case SQL_TINYINT:
		case SQL_BIGINT:
			return INTEGER_TYPE;
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

int odbc_put_data (int no_des, int index, char *result)
{
  int i = index -1;
  ODBCSQLDA * dap = odbc_descriptor[no_des];
  data_type = GetDbCType (dap, i);

  memcpy((char *)(&odbc_tmp_indicator), (char *)(&(odbc_indicator[no_des][i])), DB_SIZEOF_UDWORD);
  if (is_null_data = odbc_tmp_indicator == SQL_NULL_DATA) {
  /* the retrived value is NULL, we use empty string to represent NULL */
	result[0] = '\0';
	return 0;

  }

  memcpy(result, GetDbColPtr(dap, i), odbc_tmp_indicator);
  /*result[odbc_tmp_indicator] = '\0';*/
  return(odbc_tmp_indicator);
}

int odbc_get_integer_data (int no_des, int index)
{
  int i  = index - 1;
  int result;
  ODBCSQLDA * dbp = odbc_descriptor[no_des];
  int length = GetDbColLength(dbp, i);
  short sint;
  long  lint;

	data_type = GetDbCType(dbp, i);

	memcpy((char *)(&odbc_tmp_indicator), (char *)(&(odbc_indicator[no_des][i])), DB_SIZEOF_UDWORD);
	if (is_null_data = odbc_tmp_indicator == SQL_NULL_DATA) {
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
		case SQL_C_SLONG:
			memcpy((char *)(&lint), GetDbColPtr(dbp, i), DB_SIZEOF_LONG);
			result = lint;
			return result;
		default:
			strcat(error_message, "\nError INTEGER type or data length in odbc_get_integer_data. ");
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
	if (is_null_data = odbc_tmp_indicator == SQL_NULL_DATA) {
	/* the retrived value is NULL, we use false to be NULL value */
		return 0;
	}
	return *((char *)(GetDbColPtr(dbp, i))) != 0;
    }
  strcat(error_message, "\nError BOOLEAN type in odbc_get_boolean_data. ");
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

  data_type = GetDbCType (dbp, i);

  if ( data_type == SQL_C_DOUBLE )
    {
	memcpy((char *)(&odbc_tmp_indicator), (char *)(&(odbc_indicator[no_des][i])), DB_SIZEOF_UDWORD);
	if (is_null_data = odbc_tmp_indicator == SQL_NULL_DATA) {
	/* the retrieved value is NULL, we use 0.0 to be NULL value and we indicate it*/
		return 0.0;
	}
	memcpy((char *)(&result_double), GetDbColPtr(dbp, i), DB_SIZEOF_DOUBLE);
	/* result = *(double *)(dbp->sqlvar)[i].sqldata; */
	return  result_double;
    }
  strcat(error_message, "\nError  FLOAT  type in odbc_get_float_data. ");
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
	if (is_null_data = odbc_tmp_indicator == SQL_NULL_DATA) {
	/* the retrieved value is NULL, we use 0.0 to be NULL value */
		return 0.0;
	}
	memcpy((char *)(&result_real), GetDbColPtr(dbp, i), DB_SIZEOF_REAL);
	/* result_real = *(float *)(dbp->sqlvar)[i].sqldata; */
	return   result_real;
  }
  strcat(error_message, "\nError  REAL   type in odbc_get_real_data. ");
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
	if (is_null_data = odbc_tmp_indicator == SQL_NULL_DATA) {
	/* the retrived value is NULL, we use 01/01/1991 0:0:0 to be NULL value */
		//odbc_date.year = 1991;
		//odbc_date.month = 1;
		//odbc_date.day = 1;
		//odbc_date.hour = 0;
		//odbc_date.minute = 0;
		//odbc_date.second = 0;
		return 1;
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
  strcat(error_message, "\nError DATE type in odbc_get_date_data. ");
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

int odbc_str_len(char *val) {
	return strlen(val);
}

char *odbc_str_value(char *val) {
    	strcpy(odbc_date_string, val);
	return odbc_date_string;
}

/*****************************************************************/
/*  The following functions are related with the error processing*/
/*****************************************************************/

int odbc_get_error_code ()
{
	return error_number;
}

char * odbc_get_error_message ()
{
	return error_message;
}

char * odbc_get_warn_message ()
{
	return warn_message;
}

void odbc_clear_error ()
{
  error_number = 0;
  error_message[0] = '\0';
  warn_message[0] = '\0';
}

void odbc_error_handler(HSTMT h_err_stmt, int code) {
	SDWORD nErr;
	UCHAR msg[MAX_ERROR_MSG +1];
	UCHAR tmpMsg[2 * MAX_ERROR_MSG];
	SWORD cbMsg;
	UCHAR tmpSQLSTATE[6];
	SWORD msg_number;

	if (h_err_stmt == NULL) {
		error_number = DB_ERROR;
		sprintf(msg, "ODBC ERROR: <%d>, Inter code: <%d>\n", error_number, code);
		strcpy(error_message, msg);

		if (code == 12) {
			strcat(error_message, "\n Can't Connect to the assigned Data Source!");
			strcat(error_message, "\n The name may be misspelled or \n The data source is being used by someone else exclusively!");
		}
		return ;
	}

	switch(rc) {
	case SQL_INVALID_HANDLE:
		error_number = DB_SQL_INVALID_HANDLE;
		sprintf(msg, "ODBC ERROR: <%d>, Inter code: <%d>", error_number, code);
		strcat(error_message, msg);
		strcat(error_message, "\n An Application programming error occured: maybe passed ");
		strcat(error_message, "\n invalid environment, connection or statement handle to ");
		strcat(error_message, "\n Driver Manager of ODBC. \n");

		break;
       case SQL_ERROR:
		error_number = DB_SQL_ERROR;
		sprintf(msg, "ODBC ERROR: <%d>, Inter code: <%d>", error_number, code);
		strcat(error_message, msg);
		msg_number = 1;
		while (SQLGetDiagRec(SQL_HANDLE_STMT, h_err_stmt, msg_number++, tmpSQLSTATE, &nErr, msg, sizeof(msg), &cbMsg) != SQL_NO_DATA) {
		    sprintf(tmpMsg, "\n Native Err#=%d , SQLSTATE=%s, Error_Info='%s'",nErr, tmpSQLSTATE, msg);
		    if (strlen(error_message) + strlen(tmpMsg) + 8 > ERROR_MESSAGE_SIZE) {
			if (strlen(error_message) + 8 <= ERROR_MESSAGE_SIZE) {
				strcat(error_message, "......");
			}
		    }
		    else {
			strcat(error_message, tmpMsg);
		    }
		}
		strcat(error_message, "\n");
		break;
	case SQL_SUCCESS_WITH_INFO:
		sprintf(msg, "\nODBC WARNING Inter code: <%d>", code);
		strcat(warn_message, msg);
		msg_number = 1;
		while (SQLGetDiagRec(SQL_HANDLE_STMT, h_err_stmt, msg_number++, tmpSQLSTATE, &nErr, msg, sizeof(msg), &cbMsg) != SQL_NO_DATA) {
		    sprintf(tmpMsg, "\n Native Err#=%d , SQLSTATE=%s, Error_Info='%s'",nErr, tmpSQLSTATE, msg);
		    if (strlen(warn_message) + strlen(tmpMsg) + 8 > WARN_MESSAGE_SIZE) {
			if (strlen(warn_message) + 8 <= WARN_MESSAGE_SIZE) {
				strcat(warn_message, "......");
			}
		    }
		    else {
			strcat(warn_message, tmpMsg);
		    }
		}
		strcat(warn_message,"\n");
		break;
	default:
		sprintf(msg, "\nODBC Inter code: <%d>", code);
		strcat(warn_message, msg);
		break;
    }

}

int odbc_c_type(int odbc_type) {
	switch(odbc_type) {
		case SQL_CHAR:
		case SQL_VARCHAR:
		case SQL_LONGVARCHAR:
			return SQL_C_CHAR;
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
		case SQL_BIGINT:
			return SQL_C_SLONG;
		case SQL_REAL:
			return SQL_C_FLOAT;
		case SQL_DOUBLE:
		case SQL_FLOAT:
		case SQL_DECIMAL:
		case SQL_NUMERIC:
			return SQL_C_DOUBLE;
		case SQL_BINARY:
		case SQL_VARBINARY:
		case SQL_LONGVARBINARY:
			return SQL_C_BINARY;
		default:
			return SQL_C_DEFAULT;
	}
}


void odbc_disp_c_type() {
	printf("SQL_C_CHAR = %d\n", SQL_C_CHAR);
	printf("SQL_C_DATE = %d\n", SQL_C_DATE);
	printf("SQL_C_TIME = %d\n", SQL_C_TIME);
	printf("SQL_C_TIMESTAMP = %d\n", SQL_C_TIMESTAMP);
	printf("SQL_C_BIT = %d\n", SQL_C_BIT);
	printf("SQL_C_STINYINT = %d\n", SQL_C_STINYINT);
	printf("SQL_C_SSHORT = %d\n", SQL_C_SSHORT);
	printf("SQL_C_SLONG = %d\n", SQL_C_SLONG);
	printf("SQL_C_FLOAT = %d\n", SQL_C_FLOAT);
	printf("SQL_C_DOUBLE = %d\n", SQL_C_DOUBLE);
	printf("SQL_C_BINARY = %d\n", SQL_C_BINARY);
	printf("SQL_C_DEFAULT = %d\n", SQL_C_DEFAULT);
	return;
}

void odbc_disp_rec(int no_des) {
	int i=1,j, type;
	//SWORD indColName;
	//short colNum;
	//SWORD tmpScale;
	//SWORD tmpNullable;
	//TIME_STRUCT *timeP;
	//DATE_STRUCT *dateP;
	//TIMESTAMP_STRUCT *stampP;
	char buff[255];

	ODBCSQLDA *dap = odbc_descriptor[no_des];

	 printf("\n===================================================================\n");
	 printf("In SQLDA, var#: %d, col#: %d \n",dap->sqln,dap->sqld);
	 printf("In SQLDA, The columns are :\n");
	 for(i=0; i<dap->sqld; i++) {

		cut_tail_blank(dap->sqlvar[i].sqlname.sqlnamec);
		printf(" %d: c_type=%d, type=%d, len=%d, ptr=%x, name='%s', ",i,dap->sqlvar[i].c_type, dap->sqlvar[i].sqltype,dap->sqlvar[i].sqllen,GetDbColPtr(dap,i),dap->sqlvar[i].sqlname.sqlnamec);
		type = dap->sqlvar[i].c_type;
		switch (type) {
		//case SQL_C_TIME:
		case SQL_C_TYPE_TIME:
			j = odbc_get_date_data(no_des, i+1);
			printf(" TIME = %d:%d:%d ", odbc_get_hour(), odbc_get_min(), odbc_get_sec());
			break;
		//case SQL_C_DATE:
		case SQL_C_TYPE_DATE:
			j = odbc_get_date_data(no_des, i+1);
			printf(" DATE = %d/%d/%d ", odbc_get_month(), odbc_get_day(), odbc_get_year());
			break;
		//case SQL_C_TIMESTAMP:
		case SQL_C_TYPE_TIMESTAMP:
			j = odbc_get_date_data(no_des, i+1);
			printf(" TIMESTAMP = %d:%d:%d  %d/%d/%d ", odbc_get_hour(), odbc_get_min(), odbc_get_sec(), odbc_get_month(), odbc_get_day(), odbc_get_year());

			break;
		case SQL_C_BIT:
			printf(" data=%d ",odbc_get_boolean_data(no_des, i+1));
			break;
		case SQL_C_CHAR:
			j = odbc_put_data(no_des, i+1, buff);
			buff[j] = '\0';
			printf(" data='%s' ", buff);
			break;
		case SQL_C_STINYINT:
			printf(" data=%d ",odbc_get_integer_data(no_des, i+1));
			break;
		case SQL_C_SSHORT:
			printf(" data=%d ",odbc_get_integer_data(no_des, i+1));
			break;
		case SQL_C_SLONG:
			printf(" data=%d ",odbc_get_integer_data(no_des, i+1));
			break;
		case SQL_C_FLOAT:
			printf(" data=%f ",odbc_get_real_data(no_des, i+1));
			break;
		case SQL_C_DOUBLE:
			printf(" data=%f ",odbc_get_float_data(no_des, i+1));
			break;
		default:
			printf("Error Datatype:%d ", type);
		}
		if (odbc_indicator[no_des][i])
			printf(" **** indicator = %d \n", odbc_indicator[no_des][i]);
		else
			printf("\n");
	 }
	 printf("===================================================================\n");

}


rt_private void change_to_low (char *buf, int length) {
	for (; length >= 0; length--)
	    buf[length] = tolower(buf[length]);
}
