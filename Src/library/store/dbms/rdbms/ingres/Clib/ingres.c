# include "C:\OPING\ingres\files\eqdef.h"
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
#include <stdio.h>
#include <string.h>
#include "ingres.h"
#define tMAL_IND
#define tWARN_MSG	
#define tTEST_INGRES	
# include "C:\OPING\ingres\files\eqsqlca.h"
    __declspec(dllimport) IISQLCA sqlca;   /* SQL Communications Area */
# include "C:\OPING\ingres\files\eqsqlda.h"
int ing_err_handler ();
void ing_clear_error ();
void ing_set_warn(int, char *);
void ing_disp_rec(int);  
IISQLDA * ing_descriptor[MAX_DESCRIPTOR];
#ifdef MAL_IND
short *ing_indicator[MAX_DESCRIPTOR];
#else
short ing_indicator[MAX_DESCRIPTOR][IISQ_MAX_COLS+1];
#endif
short ing_tmp_indicator;
  char dateString[DB_DATE_LEN + 1];
  char cursorName[CURSOR_NAME_LEN];
  char stateName[CURSOR_NAME_LEN];
  char *dbCommand, *dbVariable, *dbName, *dbGroup;
  static int error_number, old_error_number, tmp_int;
  static int data_type, size, max_size, *past_time;
  static char *error_message;
  static char *warn_message;
  static char *tmp_st;
  char ing_user_name[40];
IISQLCA sqlca;
short ing_tranNumber=0; /* number of transaction opened at present */
void * safe_alloc (void *ptr)
{
  if (ptr == NULL)
    {
      enomem ();
    }
  return ptr;
}
void change_to_low(char *buf) {
    int i;
    if (buf != NULL) {
        i=strlen(buf)-1;
        for (;i>=0;i--)
            buf[i]=tolower(buf[i]);
    }
}
/* each function return 0 in case of success */
/* and database error code ( >= 1) else */
/*****************************************************************/
/* initialise Ingres c-module 									 */
/*****************************************************************/
int c_ing_make (int m_size)
{
  int count;
  if (error_message == NULL) {
 	 error_message = (char *) malloc (sizeof (char) * (m_size + ERROR_MESSAGE_SIZE));
 	 warn_message = safe_alloc (malloc (sizeof (char) * (m_size + WARN_MESSAGE_SIZE)));
  }
  ing_clear_error ();
  max_size = m_size;
/* # line 100 "ingres.sc" */	/* set_sql */
  {
    IILQshSetHandler(1,ing_err_handler);
  }
/* # line 102 "ingres.sc" */	/* host code */
  if (error_number) {
  	return error_number;
  }
  for (count = 0; count < MAX_DESCRIPTOR; count++)
    {
      ing_descriptor[count] = NULL;
    }
  return error_number;
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
/* NAME: ing_new_descriptor()                                    */
/* DESCRIPTION:                                                  */
/* This routine allocate a DESCRIPTOR in the following way:      */
/* 1. find a free cell in vector 'descriptor' to store a pointer */
/*    to IISQLDA                                                 */
/* 2. allocate a minimum space for the IISQLDA(with space for    */
/*    only one table field). The space will be adjusted later(in */
/*    ing_init_order(), when the IISQLDA will be actually used   */
/*    and enough information has obtained for allocating proper  */
/*    size of memory space).                                     */
/*                                                               */
/*****************************************************************/
int ing_new_descriptor (void)
{
  int result = ing_first_descriptor_available ();
  if (result != NO_MORE_DESCRIPTOR)
    {
	  /* malloc area for the descriptor and then initialize it */
      ing_descriptor[result] = (IISQLDA *)safe_alloc (malloc(IISQDA_HEAD_SIZE + IISQDA_VAR_SIZE));
	  SetVarNum(ing_descriptor[result], 1);
    }
  return result;
}
/*****************************************************************/
/*                                                               */
/*                     ROUTINE  DESCRIPTION                      */
/* NAME: ing_first_descriptor_available()                        */
/* DESCRIPTION:                                                  */
/*   The routine decide if there free cell in vector 'descriptor'*/
/*If exist, return the index of the cell in the vector, otherwise*/
/*return NO_MORE_DESCRIPTOR.                                     */
/*                                                               */
/*****************************************************************/
int ing_first_descriptor_available (void)
{
  int no_descriptor;	
  for (no_descriptor = 0;
       no_descriptor < MAX_DESCRIPTOR && 
       ing_descriptor[no_descriptor] != NULL;
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
/* NAME: ing_available_descriptor()                              */
/* DESCRIPTION:                                                  */
/*   To decide if there is free cell in vector 'descriptor',     */
/* if answer is YES, return 1; otherwise return 0.               */
/*                                                               */
/*****************************************************************/
int ing_available_descriptor (void)
{
  return ing_first_descriptor_available () != NO_MORE_DESCRIPTOR;
}
/*****************************************************************/
/*                                                               */
/*                     ROUTINE  DESCRIPTION                      */
/*                                                               */
/* NAME: ing_max_descriptor()                                    */
/* DESCRIPTION:                                                  */
/*   Return the max number of cells in vector 'descriptor'.      */
/*                                                               */
/*****************************************************************/
int ing_max_descriptor (void)
{
  return MAX_DESCRIPTOR;
}
/*****************************************************************/
/*  The following functions perform SQL statement in 2 ways:     */
/*  1. immediately ---- a mode to perform Insert, Update and     */
/*     and Delete.                                               */
/*  2. dynamicly   ---- a mode to perform all kinds of operations*/
/*****************************************************************/
/*****************************************************************/
/*                                                               */
/*                     ROUTINE  DESCRIPTION                      */
/*                                                               */
/* NAME: ing_exec_immediate(order)                               */
/* PARAMETERS: order - a SQL statement to be performed.          */
/* DESCRIPTION:                                                  */
/*   In IMMEDIATE EXECUTE mode perform the SQL statement, and    */
/* then check if there is warning message for the execution,     */
/* and finally return error number.                              */
/*                                                               */
/*****************************************************************/
int ing_exec_immediate (char *order)
{
	dbCommand = order;
	ing_tranNumber = 1;
	ing_clear_error();
	warn_message[0] = '\0';
#ifdef WARN_MSG
	strcpy(warn_message, "Lastest EXECUTE IMMEDIATELY: ");
	strcat(warn_message, order);
#endif
/* # line 244 "ingres.sc" */	/* execute */
  {
    IIsqInit(&sqlca);
    IIsqExImmed(dbCommand);
    IIsyncup((char *)0,0);
  }
/* # line 245 "ingres.sc" */	/* host code */
	ing_set_warn(-1,order);
	return error_number;
}
/*****************************************************************/
/*                                                               */
/*                     ROUTINE  DESCRIPTION                      */
/*                                                               */
/* NAME: ing_init_order(no_des, order)                           */
/* PARAMETERS: order - a SQL statement to be performed.          */
/*             no_des- index in descriptor vector.               */
/* DESCRIPTION:                                                  */
/*   In DYNAMICALLY EXECUTE mode perform the SQL statement. But  */
/* this routine only get things ready for dynamic execution:     */
/*   1. get trhe SQL statement PREPAREd; and check if there are  */
/*      warning message for the SQL statement;                   */
/*   2. DESCRIBE the SQL statement and get enough information to */
/*      allocate enough memory space for the corresponding       */
/*      IISQLDA.                                                 */
/*   3. return error number.                                     */
/*                                                               */
/*****************************************************************/
int ing_init_order (int no_des, char *order)
{
	IISQLDA *dap=ing_descriptor[no_des];
	int colNum;
	int i;
	int type;
	sprintf(cursorName, "ING_CURSOR%d",no_des);
	sprintf(stateName, "ING_STATE%d",no_des);
	warn_message[0] = '\0';
#ifdef WARN_MSG
	strcpy(warn_message, "Latest EXECUTE DYNAMICALLY--");
	strcat(warn_message, order);
#endif
	dbCommand = order;
	ing_tranNumber = 1;
	ing_clear_error();
/* # line 286 "ingres.sc" */	/* prepare */
  {
    IIsqInit(&sqlca);
    IIsqPrepare(0,stateName,dap,0,dbCommand);
  }
/* # line 287 "ingres.sc" */	/* host code */
	colNum = GetColNum(dap);
#ifdef MAL_IND
	ing_indicator[no_des] = (short *)safe_alloc(malloc(colNum*sizeof(short)));
#endif
	if (GetVarNum(dap) < colNum) {
	  if (colNum > IISQ_MAX_COLS) {
		if (error_number) {
			strcat(error_message, " Number of selected columns exceed max number(300) \n");
		}
		else {
			strcpy(error_message, " Number of selected columns exceed max number(300) \n");
			error_number = DB_TOO_MANY_COL;
		}
	  }
	  else {
		free(dap);
		ing_descriptor[no_des] = (IISQLDA *)safe_alloc (malloc(IISQDA_HEAD_SIZE + (colNum*IISQDA_VAR_SIZE)));
		dap = ing_descriptor[no_des];
		SetVarNum(dap,colNum);
		SetColNum(dap,colNum);
/* # line 307 "ingres.sc" */	/* describe */
  {
    IIsqInit(&sqlca);
    IIsqDescribe(0,stateName,dap,0);
  }
/* # line 308 "ingres.sc" */	/* host code */
	  }
	}
    if (error_number) {
		free(dap);
		ing_descriptor[no_des] = NULL;
#ifdef MAL_IND
		free(ing_indicator[no_des]);
		ing_indicator[no_des] = NULL;
#endif
       	return	error_number;
	}
   	for(i=0; i<colNum; i++) {
        type = abs(GetDbColType(dap, i));
        switch (type) {
            case IISQ_DTE_TYPE:
				if (GetDbColType(dap, i) > 0)
	                dap->sqlvar[i].sqltype = IISQ_CHA_TYPE;
				else
	                dap->sqlvar[i].sqltype = -IISQ_CHA_TYPE;
                dap->sqlvar[i].sqllen = DB_OUT_OF_INGRES_LIMIT;
                dap->sqlvar[i].sqldata = (char *)safe_alloc(malloc(IISQ_DTE_LEN+3));
                break;
            case IISQ_MNY_TYPE:
				if (GetDbColType(dap, i) > 0)
                	dap->sqlvar[i].sqltype = IISQ_FLT_TYPE;
				else
                	dap->sqlvar[i].sqltype = -IISQ_FLT_TYPE;
                dap->sqlvar[i].sqllen = DB_SIZEOF_MONEY; 
                dap->sqlvar[i].sqldata = (char *)safe_alloc(malloc(DB_SIZEOF_MONEY+1));
                break;
            default:
                dap->sqlvar[i].sqldata = (char *)safe_alloc(malloc(GetDbColLength(dap, i)+3));
        }
        dap->sqlvar[i].sqlind = &(ing_indicator[no_des][i]);
     }
	ing_set_warn(no_des,order);
	if (error_number>0) {
		for (i=0; i<colNum; i++) {
			if (GetDbColPtr(dap, i) != NULL)
				free(GetDbColPtr(dap, i));
		}
		free(dap);
		ing_descriptor[no_des] = NULL;
#ifdef MAL_IND
		free(ing_indicator[no_des]);
		ing_indicator[no_des] = NULL;
#endif
		return error_number;
	}
	if (colNum > 0) {
	/*means: the statement is a select statement */
	/*otherwise,  it is not   a select statement */
/* # line 369 "ingres.sc" */	/* host code */
	}
	if (error_number > 0) {
		for (i=0; i<colNum; i++) {
			if (GetDbColPtr(dap, i) != NULL)
				free(GetDbColPtr(dap, i));
		}
		free(dap);
		ing_descriptor[no_des] = NULL;
#ifdef MAL_IND
		free(ing_indicator[no_des]);
		ing_indicator[no_des] = NULL;
#endif
	}
	return error_number;
}
/*****************************************************************/
/*                                                               */
/*                     ROUTINE  DESCRIPTION                      */
/*                                                               */
/* NAME: ing_start_order(no_des)                                 */
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
int ing_start_order (int no_des)
{
	IISQLDA *dap = ing_descriptor[no_des];
	int colNum = GetColNum(dap);
	int i;
    sprintf(cursorName, "ING_CURSOR%d",no_des);
	sprintf(stateName, "ING_STATE%d",no_des);
  	ing_clear_error ();
	if (colNum == 0) {
	/* means: the statement is not a select statement */
/* # line 415 "ingres.sc" */	/* execute */
  {
    IIsqInit(&sqlca);
    IIsqExStmt(stateName,0);
    IIsyncup((char *)0,0);
  }
/* # line 416 "ingres.sc" */	/* host code */
		return error_number;
	}
/* # line 418 "ingres.sc" */	/* open */
  {
    IIsqInit(&sqlca);
    IIcsOpen(cursorName,0,0);
    IIwritio(1,(short *)0,1,32,0,stateName);
    IIcsQuery(cursorName,0,0);
  }
/* # line 420 "ingres.sc" */	/* host code */
    if (error_number > 0) {
		for (i=0; i<colNum; i++) {
			if (GetDbColPtr(dap, i) != NULL)
				free(GetDbColPtr(dap, i));
		}
        free(dap);
        ing_descriptor[no_des] = NULL;
#ifdef MAL_IND
		free(ing_indicator[no_des]);
		ing_indicator[no_des] = NULL;
#endif
    }
	return error_number;
}
/*****************************************************************/
/*                                                               */
/*                     ROUTINE  DESCRIPTION                      */
/*                                                               */
/* NAME: ing_terminate_order(no_des)                             */
/* PARAMETERS: no_des- index in descriptor vector.               */
/* DESCRIPTION:                                                  */
/*   A SQL has been performed in DYNAMIC EXECUTION mode, so the  */
/* routine is to do some clearence:                              */
/*   1. if the DYNAMICLLY EXECUTED SQL statement is a NON_SELECT */
/*      statement, just free the memory for IISQLDA and clear the*/
/*      cell in 'descriptor' to NULL; otherwise, CLOSE the CURSOR*/
/*      and then do the same clearence.                          */
/*   2. return error number.                                     */
/*                                                               */
/*****************************************************************/
int ing_terminate_order (int no_des)
{
	int i;
	IISQLDA *dap = ing_descriptor[no_des];
	int colNum;
    sprintf(cursorName, "ING_CURSOR%d",no_des);
	if (dap != NULL) {
		colNum = GetColNum(dap);
		if (colNum > 0) {
		/* means: the statement is not a select statement, so we have not opened  */
		/* the cursor at all.													  */
/* # line 466 "ingres.sc" */	/* close */
  {
    IIsqInit(&sqlca);
    IIcsClose(cursorName,0,0);
  }
/* # line 467 "ingres.sc" */	/* host code */
		}
		for (i=0; i<colNum; i++) {
			if (GetDbColPtr(dap, i) != NULL)
				free(GetDbColPtr(dap, i));
		}
		free(dap);
#ifdef MAL_IND
		free(ing_indicator[no_des]);
		ing_indicator[no_des] = NULL;
#endif
		ing_descriptor[no_des] = NULL;
	}
	return 0;
}
/*****************************************************************/
/*                                                               */
/*                     ROUTINE  DESCRIPTION                      */
/*                                                               */
/* NAME: ing_next_row(no_des)                                    */
/* PARAMETERS: no_des- index in descriptor vector.               */
/* DESCRIPTION:                                                  */
/*   A SELECT statement is now being executed in DYNAMIC EXECU-  */
/* TION mode,  the  routine is to FETCH a new tuple from database*/ 
/* and if a new tuple is fetched, return 1 otherwise return 0.   */
/*                                                               */
/*****************************************************************/
int ing_next_row (int no_des)
     /* move to the next row of selection */
     /* return 0 if there is a next row, 1 if no row left */
{
	IISQLDA *dap = ing_descriptor[no_des];
	short colNum = GetColNum(dap) - 1;
    sprintf(cursorName, "ING_CURSOR%d",no_des);
  	ing_clear_error ();
	for (; colNum>=0; colNum--)
		ing_indicator[no_des][colNum] = 0;
/* # line 507 "ingres.sc" */	/* fetch */
  {
    IIsqInit(&sqlca);
    if (IIcsRetrieve(cursorName,0,0) != 0) {
      IIcsDaGet(0,dap);
      IIcsERetrieve();
    } /* IIcsRetrieve */
  }
/* # line 509 "ingres.sc" */	/* host code */
	if (error_number) {
		ing_terminate_order(no_des);
		return 1;
	}
	if 	(sqlca.sqlcode == NO_MORE_ROWS) /* NO_MORE_ROWS */ {
		return 1;
	}
	else {
		return 0;
	}
}
/*****************************************************************/
/*The following are the function related with DATABASE CONTROL   */
/*****************************************************************/
/*****************************************************************/
/*                                                               */
/*                     ROUTINE  DESCRIPTION                      */
/*                                                               */
/* NAME: ing_connect(name,passwd,role,rolePassWd,group,baseName) */
/* PARAMETERS:                                                   */
/*   name - data base user name.                                 */
/*   passwd - data base user's password(no use for Ingres).      */
/*   role - data base role name.                                 */
/*   rolePassWd - data base role's password.                     */
/*   group - data base group name.                               */
/*   baseName - the Ingres data base which will be used in the   */
/*              current connection.                              */
/* DESCRIPTION:                                                  */
/*   Connect to an Ingres database.                              */
/* NOTE: Only the name is mandatory.                             */
/*                                                               */
/*****************************************************************/
int ing_connect (char *name, char *passwd, char *role, char *rolePassWd, char *group, char *baseName)
{
	char cmd[100];
	char tmp[100];
  	ing_clear_error ();
  	/* Ingres does not set password for each user; instead,	  	 */
	/* ingres supports such concepts: SESSION in transaction 	 */
	/* and concurrency control;									 */
	/* GROUP and ROLE in security. In order to be 		 		 */
	/* compatible with other RDBMS, we ignore such features here.*/
	/* Ingres supports multi database, in order to be compatible */
	/* with other DBMS, we use the master database: iidbdb 		 */
	strcpy(ing_user_name, name);
	dbName = baseName;
	if ((group!=NULL) && (strlen(group)>0))  {
		if ((role != NULL) && (strlen(role)>0)) {
			if ((rolePassWd!=NULL) && (strlen(rolePassWd)>0)) {
				sprintf(cmd, "-R%s/%s", role, rolePassWd);
				sprintf(tmp, "-G%s",  group);
			}
			else {
				sprintf(cmd, "-R%s", role);
				sprintf(tmp, "-G%s", group);
			}
			dbCommand = cmd;
			dbVariable = name;
			dbGroup = tmp;
/* # line 572 "ingres.sc" */	/* connect */
  {
    IIsqInit(&sqlca);
    IIsqUser(dbVariable);
    IIsqConnect(0,dbName,dbCommand,dbGroup,(char *)0, (char *)0, (char *)0, 
    (char *)0, (char *)0, (char *)0, (char *)0, (char *)0, (char *)0, 
    (char *)0, (char *)0);
  }
/* # line 573 "ingres.sc" */	/* host code */
		}
		else {
			sprintf(cmd, "-G%s", group);
			dbCommand = cmd;
			dbVariable = name;
/* # line 578 "ingres.sc" */	/* connect */
  {
    IIsqInit(&sqlca);
    IIsqUser(dbVariable);
    IIsqConnect(0,dbName,dbCommand,(char *)0, (char *)0, (char *)0, 
    (char *)0, (char *)0, (char *)0, (char *)0, (char *)0, (char *)0, 
    (char *)0, (char *)0, (char *)0);
  }
/* # line 579 "ingres.sc" */	/* host code */
		}
	}
	else {
		if ((role != NULL) && (strlen(role)>0)) {
			if ((rolePassWd!=NULL) && (strlen(rolePassWd)>0)) {
				sprintf(cmd, "-R%s/%s", role, rolePassWd);
			}
			else {
				sprintf(cmd, "-R%s", role);
			}
			dbCommand = cmd;
			dbVariable = name;
/* # line 591 "ingres.sc" */	/* connect */
  {
    IIsqInit(&sqlca);
    IIsqUser(dbVariable);
    IIsqConnect(0,dbName,dbCommand,(char *)0, (char *)0, (char *)0, 
    (char *)0, (char *)0, (char *)0, (char *)0, (char *)0, (char *)0, 
    (char *)0, (char *)0, (char *)0);
  }
/* # line 592 "ingres.sc" */	/* host code */
		}
		else {
			dbCommand = name;
/* # line 595 "ingres.sc" */	/* connect */
  {
    IIsqInit(&sqlca);
    IIsqUser(dbCommand);
    IIsqConnect(0,dbName,(char *)0, (char *)0, (char *)0, (char *)0, 
    (char *)0, (char *)0, (char *)0, (char *)0, (char *)0, (char *)0, 
    (char *)0, (char *)0, (char *)0);
  }
/* # line 596 "ingres.sc" */	/* host code */
		}
	}
  	return error_number;
}
/*****************************************************************/
/*                                                               */
/*                     ROUTINE  DESCRIPTION                      */
/*                                                               */
/* NAME: ing_disconnect()                                        */
/* DESCRIPTION:                                                  */
/*   Disconnect the current connection with an Ingres database.  */
/*                                                               */
/*****************************************************************/
int ing_disconnect (void)
{
  int count;
  ing_clear_error ();
  for (count = 0; count < MAX_DESCRIPTOR; count++)
    {
      ing_terminate_order (count);
    }
/* # line 620 "ingres.sc" */	/* disconnect */
  {
    IIsqInit(&sqlca);
    IIsqDisconnect();
  }
/* # line 621 "ingres.sc" */	/* host code */
  ing_tranNumber = 0;
  return error_number;
}
/*****************************************************************/
/*                                                               */
/*                     ROUTINE  DESCRIPTION                      */
/*                                                               */
/* NAME: ing_rollback()                                          */
/* DESCRIPTION:                                                  */
/*   Roll back the current transaction .                         */
/*                                                               */
/*****************************************************************/
int ing_rollback (void)
{
  int count;
  ing_clear_error ();
/* # line 640 "ingres.sc" */	/* rollback */
  {
    IIsqInit(&sqlca);
    IIxact(2);
  }
/* # line 641 "ingres.sc" */	/* host code */
  /* Command ROLLBACK closes all open cursors; discards all statements */
  /* that were prepared in the current transaction.                    */
  for (count = 0; count < MAX_DESCRIPTOR; count++)
    {
      ing_terminate_order (count);
    }
  ing_tranNumber = 0;
  return error_number;
}
/*****************************************************************/
/*                                                               */
/*                     ROUTINE  DESCRIPTION                      */
/*                                                               */
/* NAME: ing_commit()                                            */
/* DESCRIPTION:                                                  */
/*   Commit the current transaction.                             */
/*                                                               */
/*****************************************************************/
int ing_commit (void)
{
  int count;
  ing_clear_error ();
/* # line 664 "ingres.sc" */	/* commit */
  {
    IIsqInit(&sqlca);
    IIxact(3);
  }
/* # line 665 "ingres.sc" */	/* host code */
  /* Command  COMMIT  closes all open cursors; discards all statements */
  /* that were prepared in the current transaction.                    */
  for (count = 0; count < MAX_DESCRIPTOR; count++)
    {
      ing_terminate_order (count);
    }
  ing_tranNumber = 0;
  return error_number;
}
/*****************************************************************/
/*                                                               */
/*                     ROUTINE  DESCRIPTION                      */
/*                                                               */
/* NAME: ing_begin()                                             */
/* DESCRIPTION:                                                  */
/*   Begin a data base transaction.                              */
/*                                                               */
/*****************************************************************/
int ing_begin (void)
{
  ing_clear_error ();
 	/* Ingres has no explicit BEGIN TRANSACTION statement, */
   	/* an Ingres transaction begins from the last COMMIT,  */
	/* ROLLBACK or CONNECT command.						   */
  return error_number;
}
/*****************************************************************/
/*                                                               */
/*                     ROUTINE  DESCRIPTION                      */
/*                                                               */
/* NAME: ing_trancount()                                         */
/* DESCRIPTION:                                                  */
/*   Return the number of transactions now active.               */
/*                                                               */
/*****************************************************************/
int ing_trancount (void)
{
  return ing_tranNumber;
}
/*****************************************************************/
/* The following functions are used to get data from structure   */
/* IISQLDA  filled  by FETCH clause.                             */
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
int ing_get_user  (char *result)
{
	size = strlen(ing_user_name);
	memcpy(result, ing_user_name, size);
	return(size);
}
int ing_get_count (int no_des)
{
 	return GetColNum(ing_descriptor[no_des]);
}
int ing_put_col_name (int no_des, int index, char *result, int max_len)
{
	int i = index - 1;
	char buf[DB_INGRES_NAME_LEN+2];
	size = (((ing_descriptor[no_des])->sqlvar)[i]).sqlname.sqlnamel;
	if (size >= max_len)
		size = max_len -1;
	memcpy(buf, (((ing_descriptor[no_des])->sqlvar)[i]).sqlname.sqlnamec, size);
	buf[size] = '\0';
	cut_tail_blank(buf);
	size = strlen(buf);
	memcpy(result, buf, size);
	return(size);
}
int ing_get_col_len (int no_des, int index)
{
	int i = index - 1;
	int length = GetDbColLength(ing_descriptor[no_des], i);
	if (length == DB_OUT_OF_INGRES_LIMIT)
		return IISQ_DTE_LEN;
	else
	    return length;
}
int ing_get_data_len (int no_des, int index)
{
  int i = index - 1;
  int type = abs(GetDbColType(ing_descriptor[no_des], i));
  char *dataPtr = GetDbColPtr(ing_descriptor[no_des],i);
  int length = GetDbColLength(ing_descriptor[no_des], i);
  short tmp_short;
  switch (type)
    {
    case IISQ_VCH_TYPE:
#ifdef MAL_IND
  		memcpy((char *)(&ing_tmp_indicator), (char *)(&(ing_indicator[no_des][i])), DB_SIZEOF_SHORT);
  		if (ing_tmp_indicator) {
#else
  		if (ing_indicator[no_des][i]) {
#endif
			return 0;
		}
		else {
			memcpy((char *)(&tmp_short), dataPtr, DB_SIZEOF_SHORT);
			return tmp_short;
		}
    case IISQ_CHA_TYPE:
/*
    case IISQ_VCH_TYPE:
*/
    case IISQ_CHR_TYPE:
#ifdef MAL_IND
  		memcpy((char *)(&ing_tmp_indicator), (char *)(&(ing_indicator[no_des][i])), DB_SIZEOF_SHORT);
  		if (ing_tmp_indicator) {
#else
  		if (ing_indicator[no_des][i]) {
#endif
			return 0;
		}
		else {
			return strlen(dataPtr);
		}
    case IISQ_INT_TYPE:
    case IISQ_MNY_TYPE:
    case IISQ_DEC_TYPE:
    case IISQ_FLT_TYPE:
      	return length;
    case IISQ_TXT_TYPE:
	/* we use 1 byte TEXT of INGRES to express EIFFEL Boolean Type */
/*
	  return length;
*/
#ifdef MAL_IND
  		memcpy((char *)(&ing_tmp_indicator), (char *)(&(ing_indicator[no_des][i])), DB_SIZEOF_SHORT);
  		if (ing_tmp_indicator) {
#else
  		if (ing_indicator[no_des][i]) {
#endif
			if (length == 1) {
				return 1;
			}
			else {
 				return 0;
			}
		}
		else {
			return strlen(dataPtr);
		}
    default:
      return 0;
    }
}
int ing_conv_type (int indicator, int typeCode)
{
  int type=abs(typeCode);
  indicator = abs(indicator);
  switch (type)
    {
    case IISQ_CHA_TYPE:
    case IISQ_CHR_TYPE:
	/* We use CHAR of INGRES to express STRING, CHARACTER of EIFFEL. */
		switch (indicator) {
			case DB_OUT_OF_INGRES_LIMIT:
				return DATE_TYPE;
			case DB_SIZEOF_CHAR:
				return CHARACTER_TYPE;
			default:
				return STRING_TYPE;
		}
	/*
		if (indicator == DB_OUT_OF_INGRES_LIMIT) {
			return DATE_TYPE;
		}
		else {
		    return STRING_TYPE; 
		}
	*/
    case IISQ_INT_TYPE:
	    return INTEGER_TYPE;
    case IISQ_MNY_TYPE:
    case IISQ_DEC_TYPE:
    case IISQ_FLT_TYPE:
		if (indicator == DB_SIZEOF_REAL) {
			return REAL_TYPE;
		}
		else {
      		return FLOAT_TYPE;
		}
    case IISQ_VCH_TYPE:
    case IISQ_TXT_TYPE:
	/* INGRES return IISQ_VCH_TYPE to the descriptor for TEXT field. In fact,   */
	/* TEXT type is not seen, the visiable form is VARCHAR      				*/
		if (indicator == 1) {
		/* we use 1 byte TEXT of INGRES to express EIFFEL Boolean Type */
		  	return BOOLEAN_TYPE;
		} 
		else { 
			return STRING_TYPE;
		}
    case IISQ_DTE_TYPE:
      return DATE_TYPE;
    default:
      return UNKNOWN_TYPE;
    }
}
int ing_get_col_type (int no_des, int index)
{
  int i = index - 1;
  int length = GetDbColLength(ing_descriptor[no_des], i);
  return ing_conv_type (length, GetDbColType(ing_descriptor[no_des], i));
}
int ing_put_data (int no_des, int index, char *result, int max_len)
{
  int i = index -1;
  IISQLDA * dap = ing_descriptor[no_des];
  data_type = abs(GetDbColType (dap, i));
#ifdef MAL_IND
  memcpy((char *)(&ing_tmp_indicator), (char *)(&(ing_indicator[no_des][i])), DB_SIZEOF_SHORT);
  if (ing_tmp_indicator) {
#else
  		if (ing_indicator[no_des][i]) {
#endif
  /* the retrived value is NULL, we use empty string to represent NULL */
  /* string and blank(' ') to represent NULL character.                */
		if (GetDbColLength(dap, i) == 1) {
			result[0] = ' ';
result[1] = '\0';
			return 1;
		} 
		else  {
			result[0] = '\0';
			return 0;
		}
  }
  if ( (data_type == IISQ_CHA_TYPE) || (data_type == IISQ_CHR_TYPE) || (data_type == IISQ_TXT_TYPE) ) {
		size = strlen((dap->sqlvar)[i].sqldata);
		if (size >= max_len)
			size = max_len -1;
		memcpy(result, (dap->sqlvar)[i].sqldata, size);
		result[size] = '\0';
  }
  else {
		size = *((short *)((dap->sqlvar)[i].sqldata));
		if (size >= max_len)
			size = max_len -1;
		memcpy(result, GetDbColPtr(dap, i) + 2, size);
		result[size] = '\0';
  }
  return(size);
}
int ing_get_integer_data (int no_des, int index)
{
  int i  = index - 1;
  int result;
  IISQLDA * dbp = ing_descriptor[no_des];
  int length = GetDbColLength(dbp, i);
  short small;
  data_type = abs(GetDbColType(dbp, i));
  if ( data_type == IISQ_INT_TYPE )
    {
#ifdef MAL_IND
  		memcpy((char *)(&ing_tmp_indicator), (char *)(&(ing_indicator[no_des][i])), DB_SIZEOF_SHORT);
  		if (ing_tmp_indicator) {
#else
  		if (ing_indicator[no_des][i]) {
#endif
		  /* the retrived value is NULL, we use 0 to be NULL value */
				return 0;
		}
		switch (length) {
			case DB_SIZEOF_CHAR:
				result = *((char *)(dbp->sqlvar)[i].sqldata);
		     	return result;
			case DB_SIZEOF_SHORT:
				memcpy((char *)(&small), GetDbColPtr(dbp, i), DB_SIZEOF_SHORT);
				result = small;
/*				result = *((short *)(dbp->sqlvar)[i].sqldata); */
		     	return result;
			case DB_SIZEOF_INT:
/*				result = *((int *)(dbp->sqlvar)[i].sqldata); */ 
				memcpy((char *)(&result), GetDbColPtr(dbp, i), DB_SIZEOF_INT);
		     	return result;
			default:
				strcat(error_message, "\nError INTEGER type or data length in ing_get_integer_data. ");
				if (error_number) {
					return 0;
				}
				else {
					error_number = DB_ERROR;
					return 0;
				}
		}
    }
  strcat(error_message, "\nError INTEGER type in ing_get_integer_data. ");
  if (error_number) {
		return 0;
  }
  else {
		error_number = DB_ERROR;
		return 0;
  }
}
int ing_get_boolean_data (int no_des, int index)
{
  int i = index - 1;
  IISQLDA * dbp = ing_descriptor[no_des];
  data_type = abs(GetDbColType (dbp,i));
  if (data_type == IISQ_TXT_TYPE || data_type == IISQ_VCH_TYPE)
    {
#ifdef MAL_IND
  		memcpy((char *)(&ing_tmp_indicator), (char *)(&(ing_indicator[no_des][i])), DB_SIZEOF_SHORT);
  		if (ing_tmp_indicator) {
#else
  		if (ing_indicator[no_des][i]) {
#endif
		  /* the retrived value is NULL, we use false to be NULL value */
				return 0;
		}
		if ( (*((char *)(GetDbColPtr(dbp, i) + sizeof(short))) == '1') ||
			 (*((char *)(GetDbColPtr(dbp, i) + sizeof(short))) == 'T') || 
			 (*((char *)(GetDbColPtr(dbp, i) + sizeof(short))) == 't') ) {
			return 1;
		}
		else {
	     	return 0;
		}
    }
  strcat(error_message, "\nError BOOLEAN type in ing_get_boolean_data. ");
  if (error_number) {
		return 0;
  }
  else {
		error_number = DB_ERROR;
		return 0;
  }
}
double ing_get_float_data (int no_des, int index)
{
  int i = index - 1;
  double result_double;
  IISQLDA * dbp = ing_descriptor[no_des];
  data_type = abs(GetDbColType (dbp, i));
  if ( (data_type == IISQ_MNY_TYPE) || (data_type == IISQ_FLT_TYPE) || (data_type == IISQ_DEC_TYPE) )
    {
#ifdef MAL_IND
  		memcpy((char *)(&ing_tmp_indicator), (char *)(&(ing_indicator[no_des][i])), DB_SIZEOF_SHORT);
  		if (ing_tmp_indicator) {
#else
  		if (ing_indicator[no_des][i]) {
#endif
		  /* the retrived value is NULL, we use 0.0 to be NULL value */
				return 0.0;
		}
		memcpy((char *)(&result_double), GetDbColPtr(dbp, i), DB_SIZEOF_DOUBLE);
		/* result = *(double *)(dbp->sqlvar)[i].sqldata; */
      	return  result_double;
    }
  strcat(error_message, "\nError  FLOAT  type in ing_get_float_data. ");
  if (error_number) {
		return 0.0;
  }
  else {
		error_number = DB_ERROR;
		return 0.0;
  }
}
float ing_get_real_data (int no_des, int index)
{
  int i = index - 1;
  float result_real;
  IISQLDA * dbp = ing_descriptor[no_des];
  data_type = abs(GetDbColType (dbp, i));
  if (data_type ==IISQ_FLT_TYPE)
	{
#ifdef MAL_IND
  		memcpy((char *)(&ing_tmp_indicator), (char *)(&(ing_indicator[no_des][i])), DB_SIZEOF_SHORT);
  		if (ing_tmp_indicator) {
#else
  		if (ing_indicator[no_des][i]) {
#endif
		  /* the retrived value is NULL, we use 0.0 to be NULL value */
				return 0.0;
		}
		memcpy((char *)(&result_real), GetDbColPtr(dbp, i), DB_SIZEOF_REAL);
		/* result_real = *(float *)(dbp->sqlvar)[i].sqldata; */
      	return   result_real;
	}
  strcat(error_message, "\nError  REAL   type in ing_get_real_data. ");
  if (error_number) {
		return 0.0;
  }
  else {
		error_number = DB_ERROR;
		return 0.0;
  }
}
/*****************************************************************/
/*  The following function deal with the DATE data of Ingres     */
/*****************************************************************/
int ing_get_date_data (int no_des, int index)
{
  int i = index - 1;
  IISQLDA   * dbp = ing_descriptor[no_des];
  data_type = abs(GetDbColType(dbp, i));
  if (data_type == IISQ_DTE_TYPE || data_type == IISQ_CHA_TYPE)
    {
#ifdef MAL_IND
  		memcpy((char *)(&ing_tmp_indicator), (char *)(&(ing_indicator[no_des][i])), DB_SIZEOF_SHORT);
  		if (ing_tmp_indicator) {
#else
  		if (ing_indicator[no_des][i]) {
#endif
		  /* the retrived value is NULL, we use 1/1/1000 0:0:0 to be NULL value */
				dateString[0] = '\0';
				return 1;
		}
		strcpy(dateString, GetDbColPtr(dbp, i));
  		return 1;
    }
  strcat(error_message, "\nError DATE type in ing_get_date_data. ");
  if (error_number) {
		return 0;
  }
  else {
		error_number = DB_ERROR;
		return 0;
  }
}
int ing_get_year(void)
{
  int year;
	if (strlen(dateString) == 0) {
		return 1000;
	}
/* # line 1142 "ingres.sc" */	/* select */
  {
    IIsqInit(&sqlca);
    IIwritio(0,(short *)0,1,32,0,"select date_part('year', date(");
    IIputdomio((short *)0,1,32,0,dateString);
    IIwritio(0,(short *)0,1,32,0,"))");
    IIretinit((char *)0,0);
    if (IIerrtest() != 0) goto IIrtE1;
IIrtB1:
    while (IInextget() != 0) {
      IIgetdomio((short *)0,1,30,4,&year);
      if (IIerrtest() != 0) goto IIrtB1;
    } /* IInextget */
    IIflush((char *)0,0);
IIrtE1:;
  }
/* # line 1145 "ingres.sc" */	/* host code */
  	return year;
}
int ing_get_month(void)
{
  int month;
	if (strlen(dateString) == 0) {
		return 1;
	}
/* # line 1156 "ingres.sc" */	/* select */
  {
    IIsqInit(&sqlca);
    IIwritio(0,(short *)0,1,32,0,"select date_part('month', date(");
    IIputdomio((short *)0,1,32,0,dateString);
    IIwritio(0,(short *)0,1,32,0,"))");
    IIretinit((char *)0,0);
    if (IIerrtest() != 0) goto IIrtE2;
IIrtB2:
    while (IInextget() != 0) {
      IIgetdomio((short *)0,1,30,4,&month);
      if (IIerrtest() != 0) goto IIrtB2;
    } /* IInextget */
    IIflush((char *)0,0);
IIrtE2:;
  }
/* # line 1159 "ingres.sc" */	/* host code */
	if (month == 0)
		month = 1;
  	return month;
}
int ing_get_day(void)
{
  int day;
	if (strlen(dateString) == 0) {
		return 1;
	}
/* # line 1172 "ingres.sc" */	/* select */
  {
    IIsqInit(&sqlca);
    IIwritio(0,(short *)0,1,32,0,"select date_part('day', date(");
    IIputdomio((short *)0,1,32,0,dateString);
    IIwritio(0,(short *)0,1,32,0,"))");
    IIretinit((char *)0,0);
    if (IIerrtest() != 0) goto IIrtE3;
IIrtB3:
    while (IInextget() != 0) {
      IIgetdomio((short *)0,1,30,4,&day);
      if (IIerrtest() != 0) goto IIrtB3;
    } /* IInextget */
    IIflush((char *)0,0);
IIrtE3:;
  }
/* # line 1175 "ingres.sc" */	/* host code */
	if (day == 0)
		day = 1;
  	return day;
}
int ing_get_hour(void)
{
  int hour;
/* # line 1185 "ingres.sc" */	/* select */
  {
    IIsqInit(&sqlca);
    IIwritio(0,(short *)0,1,32,0,"select date_part('hour', date(");
    IIputdomio((short *)0,1,32,0,dateString);
    IIwritio(0,(short *)0,1,32,0,"))");
    IIretinit((char *)0,0);
    if (IIerrtest() != 0) goto IIrtE4;
IIrtB4:
    while (IInextget() != 0) {
      IIgetdomio((short *)0,1,30,4,&hour);
      if (IIerrtest() != 0) goto IIrtB4;
    } /* IInextget */
    IIflush((char *)0,0);
IIrtE4:;
  }
/* # line 1188 "ingres.sc" */	/* host code */
  	return hour;
}
int ing_get_min(void)
{
  int minute;
/* # line 1196 "ingres.sc" */	/* select */
  {
    IIsqInit(&sqlca);
    IIwritio(0,(short *)0,1,32,0,"select date_part('minute', date(");
    IIputdomio((short *)0,1,32,0,dateString);
    IIwritio(0,(short *)0,1,32,0,"))");
    IIretinit((char *)0,0);
    if (IIerrtest() != 0) goto IIrtE5;
IIrtB5:
    while (IInextget() != 0) {
      IIgetdomio((short *)0,1,30,4,&minute);
      if (IIerrtest() != 0) goto IIrtB5;
    } /* IInextget */
    IIflush((char *)0,0);
IIrtE5:;
  }
/* # line 1199 "ingres.sc" */	/* host code */
  	return minute;
}
int ing_get_sec(void)
{
  int second;
/* # line 1207 "ingres.sc" */	/* select */
  {
    IIsqInit(&sqlca);
    IIwritio(0,(short *)0,1,32,0,"select date_part('sec', date(");
    IIputdomio((short *)0,1,32,0,dateString);
    IIwritio(0,(short *)0,1,32,0,"))");
    IIretinit((char *)0,0);
    if (IIerrtest() != 0) goto IIrtE6;
IIrtB6:
    while (IInextget() != 0) {
      IIgetdomio((short *)0,1,30,4,&second);
      if (IIerrtest() != 0) goto IIrtB6;
    } /* IInextget */
    IIflush((char *)0,0);
IIrtE6:;
  }
/* # line 1210 "ingres.sc" */	/* host code */
  	return second;
}
/*****************************************************************/
/*  The following functions are related with the error processing*/
/*****************************************************************/
void ing_clear_error (void)
{
  error_number = 0;
  error_message[0] = '\0';
/*
  warn_message[0] = '\0';
*/
}
void ing_set_warn(int no_des, char *order)
{
/*
	if (no_des == -1) 
		strcpy(warn_message, "EXECUTE IMMEDIATELY: ");
	else
		warn_message[0]='\0';
	strcat(warn_message, order);
*/
	strcat(warn_message, "\n");
  	if (sqlca.sqlwarn.sqlwarn0 != 'W')
        warn_message[0] = '\0';
    else if (sqlca.sqlwarn.sqlwarn1 == 'W')
        strcat(warn_message, "sqlwarning: column was truncated.");
    else if (sqlca.sqlwarn.sqlwarn2 == 'W')
        strcat(warn_message, "sqlwarning: NULL values in aggregate (max, sum etc) function.");
    else if (sqlca.sqlwarn.sqlwarn3 == 'W')
        strcat(warn_message, "sqlwarning: into var count not equal column count.");
    else if (sqlca.sqlwarn.sqlwarn4 == 'W')
        strcat(warn_message, "sqlwarning: update or delete without where clause.");
    else if (sqlca.sqlwarn.sqlwarn5 == 'W')
        strcat(warn_message, "sqlwarning: ???.");
    else if (sqlca.sqlwarn.sqlwarn6 == 'W')
        strcat(warn_message, "sqlwarning: rollback required.");
    else if (sqlca.sqlwarn.sqlwarn7 == 'W')
        strcat(warn_message, "sqlwarning: ???.");
    sqlca.sqlwarn.sqlwarn0 = '\0';
	return;
}
int ing_err_handler (void)
{
/* # line 1263 "ingres.sc" */	/* inquire_sql */
  {
    IILQisInqSqlio((short *)0,1,30,4,&error_number,2);
    IILQisInqSqlio((short *)0,1,32,0,error_message,63);
  }
/* # line 1264 "ingres.sc" */	/* host code */
#ifdef TEST_INGRES
	printf("===============================  ERROR#: %d  ===============================\n",error_number);
	printf("MESSAGE:%s\n",error_message);
	printf("WARNING:%s\n",warn_message);
	printf("^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^\n");
#endif
	return DB_ERROR;
}
char * ing_get_error_message (void)
{
  return error_message;
}
char * ing_get_warn_message (void)
{
  return warn_message;
}
/***************/
/* eiffel_type */
/***************/
int c_string_type (void)
{
  return STRING_TYPE;
}
int c_character_type (void)
{
  return CHARACTER_TYPE;
}
int c_integer_type (void)
{
  return INTEGER_TYPE;
}
int c_float_type (void)
{
  return FLOAT_TYPE;
}
int c_real_type (void)
{
  return REAL_TYPE;
}
int c_boolean_type (void)
{
  return BOOLEAN_TYPE;
}
int c_date_type (void)
{
  return DATE_TYPE;
}
/* EOF Ingres.c */
#ifdef TEST_INGRES
void ing_disp_rec(int no_des)   {
	IISQLDA *dap = ing_descriptor[no_des]; 
	int i;
	int type;
  int year, day, month, hour, minute, sec;
  char date_Tyc[30];
	 printf("===================================================================\n");
	 printf("In SQLDA, var#: %d, col#: %d \n",dap->sqln,dap->sqld);
	 printf("In SQLDA, The columns are :\n");
	 for(i=0; i<dap->sqld; i++) {
		cut_tail_blank(dap->sqlvar[i].sqlname.sqlnamec);
		printf(" %d: type=%d, len=%d, name='%s', ",i, dap->sqlvar[i].sqltype,dap->sqlvar[i].sqllen,dap->sqlvar[i].sqlname.sqlnamec);
		type = dap->sqlvar[i].sqltype;
		type = abs(type);
		switch (type) {
		case IISQ_DTE_TYPE:
			strcpy(date_Tyc,  dap->sqlvar[i].sqldata);
			printf(" data=%s  length=%d, pos=%x",date_Tyc,strlen(date_Tyc),date_Tyc);
			break;
		case IISQ_VCH_TYPE:
			type = *((short *)dap->sqlvar[i].sqldata);
			dap->sqlvar[i].sqldata[type+sizeof(short)] = '\0';
			printf(" data=%s, len=%d, strlen=%d ",dap->sqlvar[i].sqldata+sizeof(short),type,strlen(dap->sqlvar[i].sqldata+sizeof(short)));
			break;
		case IISQ_CHA_TYPE:
		case IISQ_CHR_TYPE:
		case IISQ_TXT_TYPE:
			printf(" data=%s ",dap->sqlvar[i].sqldata);
			if (dap->sqlvar[i].sqllen == DB_OUT_OF_INGRES_LIMIT) {
				strcpy(date_Tyc,  dap->sqlvar[i].sqldata);
/* # line 1364 "ingres.sc" */	/* select */
  {
    IIsqInit(&sqlca);
    IIsqMods(1);
    IIwritio(0,(short *)0,1,32,0,"select date_part('year', date(");
    IIputdomio((short *)0,1,32,0,date_Tyc);
    IIwritio(0,(short *)0,1,32,0,"))");
    IIretinit((char *)0,0);
    if (IInextget() != 0) {
      IIgetdomio((short *)0,1,30,4,&year);
    } /* IInextget */
    IIsqFlush((char *)0,0);
  }
/* # line 1365 "ingres.sc" */	/* select */
  {
    IIsqInit(&sqlca);
    IIsqMods(1);
    IIwritio(0,(short *)0,1,32,0,"select date_part('month', date(");
    IIputdomio((short *)0,1,32,0,date_Tyc);
    IIwritio(0,(short *)0,1,32,0,"))");
    IIretinit((char *)0,0);
    if (IInextget() != 0) {
      IIgetdomio((short *)0,1,30,4,&month);
    } /* IInextget */
    IIsqFlush((char *)0,0);
  }
/* # line 1366 "ingres.sc" */	/* select */
  {
    IIsqInit(&sqlca);
    IIsqMods(1);
    IIwritio(0,(short *)0,1,32,0,"select date_part('day', date(");
    IIputdomio((short *)0,1,32,0,date_Tyc);
    IIwritio(0,(short *)0,1,32,0,"))");
    IIretinit((char *)0,0);
    if (IInextget() != 0) {
      IIgetdomio((short *)0,1,30,4,&day);
    } /* IInextget */
    IIsqFlush((char *)0,0);
  }
/* # line 1367 "ingres.sc" */	/* select */
  {
    IIsqInit(&sqlca);
    IIsqMods(1);
    IIwritio(0,(short *)0,1,32,0,"select date_part('hour', date(");
    IIputdomio((short *)0,1,32,0,date_Tyc);
    IIwritio(0,(short *)0,1,32,0,"))");
    IIretinit((char *)0,0);
    if (IInextget() != 0) {
      IIgetdomio((short *)0,1,30,4,&hour);
    } /* IInextget */
    IIsqFlush((char *)0,0);
  }
/* # line 1368 "ingres.sc" */	/* select */
  {
    IIsqInit(&sqlca);
    IIsqMods(1);
    IIwritio(0,(short *)0,1,32,0,"select date_part('minute', date(");
    IIputdomio((short *)0,1,32,0,date_Tyc);
    IIwritio(0,(short *)0,1,32,0,"))");
    IIretinit((char *)0,0);
    if (IInextget() != 0) {
      IIgetdomio((short *)0,1,30,4,&minute);
    } /* IInextget */
    IIsqFlush((char *)0,0);
  }
/* # line 1369 "ingres.sc" */	/* select */
  {
    IIsqInit(&sqlca);
    IIwritio(0,(short *)0,1,32,0,"select date_part('sec', date(");
    IIputdomio((short *)0,1,32,0,date_Tyc);
    IIwritio(0,(short *)0,1,32,0,"))");
    IIretinit((char *)0,0);
    if (IIerrtest() != 0) goto IIrtE7;
IIrtB7:
    while (IInextget() != 0) {
      IIgetdomio((short *)0,1,30,4,&sec);
      if (IIerrtest() != 0) goto IIrtB7;
    } /* IInextget */
    IIflush((char *)0,0);
IIrtE7:;
  }
/* # line 1372 "ingres.sc" */	/* host code */
				printf("date= %d\/%d\/%d:%d:%d:%d",month,day,year,hour,minute,sec);
			}
			else
				printf("\n");
			break;
		case IISQ_MNY_TYPE:
		case IISQ_DEC_TYPE:
		case IISQ_FLT_TYPE:
			if (dap->sqlvar[i].sqllen==sizeof(float)) 
				printf(" data=%f ",*((float  *)(dap->sqlvar[i].sqldata)));
			else
				printf(" data=%f ",*((double *)(dap->sqlvar[i].sqldata)));
			break;
		case IISQ_INT_TYPE:
			printf(" data=%d ",*((int *)(dap->sqlvar[i].sqldata)));
			break;
		default:
			printf("Error Datatype ");
		}
		if (ing_indicator[no_des][i]) 
			printf(" **************** NULL_VALUE **** indicator = %d \n", ing_indicator[no_des][i]);
		else
			printf("\n");
	 }
	 printf("===================================================================\n");
}
main() {
}
#endif
