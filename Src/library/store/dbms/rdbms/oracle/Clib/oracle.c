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
   Database: "ora"
*/
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#include "oracle.h"

#define MAX_BINDS 12
/*
#define MAX_ITEM_BUFFER_SIZE 255
#define MAX_SELECT_LIST_SIZE 255
*/

#define MAX_ITEM_BUFFER_SIZE 500
#define MAX_SELECT_LIST_SIZE 255

#define MAX_SQL_IDENTIFIER 31
#define PARSE_NO_DEFER 0
#define PARSE_V7_LNG 2
#define DESC_LEN 255
 struct describe
{
	sb4 dbsize;
	sb2 dbtype;
	sb1 buf[MAX_ITEM_BUFFER_SIZE];
	sb4 buflen;
	sb4 dsize;
	sb2 precision;
	sb2 scale;
	sb2 nullok;
};

struct define
{
	ub1 buf[MAX_ITEM_BUFFER_SIZE];
	float flt_buf;
	sword int_buf; //removable in current case.
	sb2 indp;
	ub2 col_retlen, col_retcode;
};

struct describe desc[MAX_SELECT_LIST_SIZE] [MAX_SELECT_LIST_SIZE];
struct define def [MAX_DESCRIPTOR] [MAX_SELECT_LIST_SIZE];

Cda_Def *cda[MAX_DESCRIPTOR];

ub4	hda[HDA_SIZE/(sizeof(ub4))];
Lda_Def lda;
int ncol [MAX_DESCRIPTOR];
text bind_values[MAX_BINDS][MAX_ITEM_BUFFER_SIZE];
text descrip[MAX_SELECT_LIST_SIZE];
ub2 descrip_len[MAX_SELECT_LIST_SIZE];
ub2 descrip_rc[MAX_SELECT_LIST_SIZE];
ub4 descrip_cs = (ub4) MAX_SELECT_LIST_SIZE;
sb2 descrip_indp[MAX_SELECT_LIST_SIZE];

/* Globals */
static text sql_statement[2048];
static sword sql_function;
static sword numwidth = 8;
static int error_number;
static int max_size;
static text error_message[512];

short ora_tranNumber=0; /* number of transaction opened at present */


/* each function return 0 in case of success */
/* and database error code ( >= 1) else */

/*****************************************************************/
/* initialise ora   c-module                                     */
/*****************************************************************/

void c_ora_make (int m_size)
{
	int count;

	ora_clear_error ();
	max_size = m_size;

	for (count = 0; count < MAX_DESCRIPTOR; count++)
		cda[count] = NULL;
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
/* NAME: ora_new_descriptor()                                    */
/* DESCRIPTION:                                                  */
/* This routine allocate a DESCRIPTOR in the following way:      */
/* 1. find a free cell in vector 'descriptor' to store a pointer */
/*    to oraSQLDA                                               */
/* 2. allocate a minimum space for the oraSQLDA(with space for  */
/*    only one table field). The space will be adjusted later(in */
/*    ora_init_order(), when the oraSQLDA will be actually used*/
/*    and enough information has obtained for allocating proper  */
/*    size of memory space).                                     */
/*                                                               */
/*****************************************************************/
int ora_new_descriptor (void)
{
	int result = ora_first_descriptor_available ();

	if (result != NO_MORE_DESCRIPTOR) {
		Cda_Def *new_cursor;
		new_cursor = (Cda_Def *) malloc (sizeof(Cda_Def));
		cda[result] = new_cursor;
		if (oopen(cda[result], &lda, (text *) 0, -1, -1, (text *) 0, -1)) {
			ora_error_handler(cda[result]);
			return NO_MORE_DESCRIPTOR;
		}
	} else {
	//ora_error_handler(NULL, 201);
	strcpy((char *) error_message, "No available descriptor\n");
	}
	return result;
}

/*****************************************************************/
/*                                                               */
/*                     ROUTINE  DESCRIPTION                      */
/* NAME: ora_first_descriptor_available()                        */
/* DESCRIPTION:                                                  */
/*   The routine decide if there free cell in vector 'descriptor'*/
/*If exist, return the index of the cell in the vector, otherwise*/
/*return NO_MORE_DESCRIPTOR.                                     */
/*                                                               */
/*****************************************************************/
int ora_first_descriptor_available (void)
{
	int no_descriptor;

	for (no_descriptor = 0; no_descriptor < MAX_DESCRIPTOR && cda[no_descriptor] != NULL; no_descriptor++);

	if (no_descriptor < MAX_DESCRIPTOR) {
		return no_descriptor;
	} else {
		return NO_MORE_DESCRIPTOR;
	}
}

/*****************************************************************/
/*                                                               */
/*                     ROUTINE  DESCRIPTION                      */
/*                                                               */
/* NAME: ora_available_descriptor()                              */
/* DESCRIPTION:                                                  */
/*   To decide if there is free cell in vector 'descriptor',     */
/* if answer is YES, return 1; otherwise return 0.               */
/*                                                               */
/*****************************************************************/
int ora_available_descriptor (void)
{
  return ora_first_descriptor_available () != NO_MORE_DESCRIPTOR;
}

/*****************************************************************/
/*                                                               */
/*                     ROUTINE  DESCRIPTION                      */
/*                                                               */
/* NAME: ora_max_descriptor()                                    */
/* DESCRIPTION:                                                  */
/*   Return the max number of cells in vector 'descriptor'.      */
/*                                                               */
/*****************************************************************/
int ora_max_descriptor (void)
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
/* NAME: ora_exec_immediate(order)                              */
/* PARAMETERS: order - a SQL statement to be performed.          */
/* DESCRIPTION:                                                  */
/*   In IMMEDIATE EXECUTE mode perform the SQL statement, and    */
/* then check if there is warning message for the execution,     */
/* and finally return error number.                              */
/*                                                               */
/*****************************************************************/
void ora_exec_immediate (int no_desc, text order[1024])
{
	ora_tranNumber = 1;
	ora_clear_error ();
	if (oparse(cda[no_desc], (text *) order, (sb4) -1, (sword) PARSE_NO_DEFER, (ub4) PARSE_V7_LNG)) {
		ora_error_handler(cda[no_desc]);
		/*if (error_number) {
			return error_number;
		}*/
	}
	//if (ora_init_order (order, no_desc))
	//	error_number=1;
	//if (ora_start_order (no_desc))
	//	error_number=1;
	if (oexec(cda[no_desc])){
		ora_error_handler(cda[no_desc]);
		/*if (error_number) {
				return error_number;
		}*/
	}
	//if (ora_terminate_order (no_desc))
	//	error_number=1;
	if (oclose(cda[no_desc])){
		ora_error_handler(cda[no_desc]);
		/*if (error_number) {
			return error_number;
		}*/
	// Change by David S : Need to free the descriptor after the ora_exec_immediate
	// but to do now in Eiffel file
//	free (cda [no_des]);
//	cda [no_des] = NULL;
	}
	/*return error_number;*/
}

/*****************************************************************/
/*                                                               */
/*                     ROUTINE  DESCRIPTION                      */
/*                                                               */
/* NAME: ora_init_order(no_des, order)                           */
/* PARAMETERS: order - a SQL statement to be performed.          */
/*             no_des- index in descriptor vector.               */
/* DESCRIPTION:                                                  */
/*   In DYNAMICALLY EXECUTE mode perform the SQL statement. But  */
/* this routine only get things ready for dynamic execution:     */
/*   1. get the SQL statement PREPAREd; and check if there are   */
/*      warning message for the SQL statement;                   */
/*   2. DESCRIBE the SQL statement and get enough information to */
/*      allocate enough memory space for the corresponding       */
/*      oraSQLDA.                                               */
/*   3. return error number.                                     */
/*                                                               */
/*****************************************************************/
void ora_init_order (text order[1024], int no_desc)
{
	/* Process general ora SQL statements    */
		strcpy((char *) sql_statement, (char *) order);
		if (oparse(cda[no_desc], (text *) sql_statement, (sb4) -1, (sword) PARSE_NO_DEFER, (ub4) PARSE_V7_LNG)) {
			ora_error_handler(cda[no_desc]);
			/*if (error_number) {
				return error_number;
			}*/
		}
	sql_function = cda[no_desc]->ft;
	/*return error_number;*/
}

 /* Describe select–list items. */
sword describe_define(Cda_Def *tmp, int no_desc) {
	sword col, deflen, deftyp;
	static ub1 *defptr;
	/* Describe the select–list items. */
	for (col = 0; col < MAX_SELECT_LIST_SIZE; col++) {
		desc [no_desc] [col].buflen = MAX_ITEM_BUFFER_SIZE;
		if (odescr(tmp, col + 1, &desc [no_desc] [col].dbsize,
				   &desc [no_desc] [col].dbtype, &desc [no_desc] [col].buf[0],
				   &desc [no_desc] [col].buflen, &desc [no_desc] [col].dsize,
				   &desc [no_desc] [col].precision, &desc [no_desc] [col].scale,
				   &desc [no_desc] [col].nullok)) {
			/* Break on end of select list. */
			if (tmp->rc == VAR_NOT_IN_LIST) {
				break;
			} else {
				ora_error_handler(tmp);
				return -1;
			}
		}/* adjust sizes and types for display */
		switch (desc [no_desc] [col].dbtype) {
		case NUMBER_TYPE:
			desc [no_desc] [col].dbsize = numwidth;
			/* Handle NUMBER with scale as float. */
//			if (desc [no_desc] [col].scale != 0) {
				defptr = (ub1 *) &def [no_desc] [col].flt_buf;
				deflen = (sword) sizeof(float);
				deftyp = FLOAT_TYPE;
				desc [no_desc] [col].dbtype = FLOAT_TYPE;
//  			} else {
//  				defptr = (ub1 *) &def [no_desc] [col].int_buf;
//  				deflen = (sword) sizeof(sword);
//  				deftyp = INT_TYPE;
//  				desc [no_desc] [col].dbtype = INT_TYPE;
//  			}

			break;

		default:
			if (desc [no_desc] [col].dbtype == DATE_TYPE)
				desc [no_desc] [col].dbsize = 19;
			if (desc [no_desc] [col].dbtype == ROWID_TYPE)
				desc [no_desc] [col].dbsize = 18;
			defptr = def [no_desc] [col].buf;
			deflen = desc [no_desc] [col].dbsize > MAX_ITEM_BUFFER_SIZE ?
				MAX_ITEM_BUFFER_SIZE : desc [no_desc] [col].dbsize + 1;
			deftyp = STRING_TYPE;
			break;
		}
		if (odefin(tmp, col + 1, defptr, deflen, deftyp, -1, &def [no_desc] [col].indp, (text*) 0, -1, -1,
				   &def [no_desc] [col].col_retlen, &def [no_desc] [col].col_retcode)) {
			ora_error_handler(tmp);
			return -1;
		}
	}

	return col;
}




void print_header(sword ncols, int no_desc) {
	sword col, n;
	//fputc('\n', stdout);
	for (col = 0; col < ncols; col++) {
		n = desc [no_desc] [col].dbsize - desc [no_desc] [col].buflen;
		if (desc [no_desc] [col].dbtype == ORA_EIF_FLOAT_TYPE ||
			desc [no_desc] [col].dbtype == INT_TYPE) {
			printf("%*c", n, ' ');
			printf("%*.*s", desc [no_desc] [col].buflen,
				   desc [no_desc] [col].buflen, desc [no_desc] [col].buf);
		} else {
			printf("%*.*s", desc [no_desc] [col].buflen,
				   desc [no_desc] [col].buflen, desc [no_desc] [col].buf);printf("%*c", n, ' ');
		}
		//fputc(' ', stdout);
	}
	//fputc('\n', stdout);
	for (col = 0; col < ncols; col++) {
		for (n = desc [no_desc] [col].dbsize; --n >= 0; );
		//	fputc('-', stdout);
		//fputc(' ', stdout);
	}
	//fputc('\n', stdout);
}

void print_rows(Cda_Def *tmp, sword ncols, int no_desc) {
	sword col, n;
	for (;;) {
		//fputc('\n', stdout);
		/* Fetch a row. Break on end of fetch,
		   disregard null fetch ”error”. */
		if (ofetch(tmp)) {
			if (tmp->rc == NO_DATA_FOUND)
				break;
			if (tmp->rc != NULL_VALUE_RETURNED)
				//ora_error_handler(tmp);
				break;
		}

		for (col = 0; col < ncols ; col++) {
			/* Check col. return code for null. If
			   null, print n spaces, else print value. */
			if (def [no_desc] [col].indp < 0) {
				printf("%*c", desc [no_desc] [col].dbsize, ' ');
			} else {
				switch (desc [no_desc] [col].dbtype) {
				case ORA_EIF_FLOAT_TYPE:
					printf("%*.*f", numwidth, 2, def [no_desc] [col].flt_buf);
					break;
				case INT_TYPE:
					printf("%*d", numwidth, def [no_desc] [col].int_buf);
					break;
				default:
					printf("%s", def [no_desc] [col].buf);
					n = desc [no_desc] [col].dbsize - strlen((char *)
															 def [no_desc] [col].buf);
					if (n > 0)
						printf("%*c", n, ' ');
					break;
				}
			}
			//fputc(' ', stdout);
		}
	} /* end for (;;) */
}


int ora_put_data (int no_des, int index, char *result) {
	int size;
	size = strlen ((char *) def [no_des] [index-1].buf);
	//	switch (desc [no_des] [index].dbtype)
	//	{
	//		case FLOAT_TYPE:
	//			memcpy((char *)(result), (char *)(def [no_des] [index].flt_buf), size);
	//		case INT_TYPE:
	//			memcpy((char *)(result), (char *)(def [no_des] [index].int_buf), size);
	//		default:
	memcpy((char *)(result), (char *)(def [no_des] [index-1].buf), size);
	//		break;
	//	}
	// if (ora_tmp == "") {
	/* the retrived value is NULL, we use empty string to represent NULL */
	//		result[0] = '\0';
	//			return 0;

	//			  }

	//   memcpy(result, def [no_des] [i], odbc_tmp_indicator);
	/*result[odbc_tmp_indicator] = '\0';*/
	return (size);
}

int ora_put_select_name (int no_des, int i, char *result) {
	char *tmp_st;
	int size;

	tmp_st = (char *) desc [no_des] [i-1].buf;
	size = strlen (tmp_st);
	memcpy (result, tmp_st, size);
	return size;
}

/*****************************************************************/
/*                                                               */
/*                     ROUTINE  DESCRIPTION                      */
/*                                                               */
/* NAME: ora_start_order(no_des)                              */
/* PARAMETERS: no_des- index in descriptor vector.               */
/* DESCRIPTION:                                                  */
/*   Finish execution of a SQL statement in DYNAMICLLY EXECUTION */
/* mode:                                                         */
/*   1. if the PREPARED SQL statement is a NON_SELECT statement, */
/*      just EXECUTE it; otherwise, DEFINE a CURSOR for it and   */
/*      OPEN the CURSOR. In the process, if error occurs, do some*/
/*      clearence;                                               */
/*   3. return error number.                                     */
/*                                                               */
/*****************************************************************/

void ora_start_order (int no_desc) {
	/* Process user’s SQL statements. */
	//for (;;)
	//{

	/* Save the SQL function code right after parse. */

/* If the statement is a query, describe and define
all select–list items before doing the oexec. */
	if (sql_function == FT_SELECT) {
		if ((ncol [no_desc] = describe_define(cda[no_desc], no_desc)) == -1) {
			(cda[no_desc]);
			//continue;
		}
	}

	/* Execute the statement. */
	if (oexec(cda[no_desc])) {
		ora_error_handler(cda[no_desc]);
		//	continue;
	}
	/* Fetch and display the rows for the query. */
	/*	if (sql_function == FT_SELECT)
		{
		print_header(ncol [no_desc], no_desc);
		print_rows(cda[no_desc], ncol [no_desc], no_desc);
		}*/
	/* Print the rows–processed count. */
	/*if (sql_function == FT_SELECT ||
	  sql_function == FT_UPDATE ||
	  sql_function == FT_DELETE ||
	  sql_function == FT_INSERT)
	  printf("\n%d row%c processed.\n", cda[no_desc].rpc,
	  cda[no_desc].rpc == 1 ? '\0' : 's');
	  else
	  printf("\nStatement processed.\n");*/
	//	} /* end for (;;) */
	/*return 0;*/
}

/*****************************************************************/
/*                                                               */
/*                     ROUTINE  DESCRIPTION                      */
/*                                                               */
/* NAME: ora_terminate_order(no_des)                             */
/* PARAMETERS: no_des- index in descriptor vector.               */
/* DESCRIPTION:                                                  */
/*   A SQL has been performed in DYNAMIC EXECUTION mode, so the  */
/* routine is to do some clearence:                              */
/*   1. if the DYNAMICLLY EXECUTED SQL statement is a NON_SELECT */
/*      statement, just free the memory for oraSQLDA and clear the*/
/*      cell in 'descriptor' to NULL; otherwise, CLOSE the CURSOR*/
/*      and then do the same clearence.                          */
/*   2. return error number.                                     */
/*                                                               */
/*****************************************************************/
void ora_terminate_order (int no_des)
{
	if (cda [no_des]) {
		if (oclose(cda[no_des]))
			ora_error_handler(cda[no_des]);
		free (cda [no_des]);
		cda [no_des] = NULL;
	}
	/*return 0;*/
}

/*****************************************************************/
/*                                                               */
/*                     ROUTINE  DESCRIPTION                      */
/*                                                               */
/* NAME: ora_next_row(no_des)                                    */
/* PARAMETERS: no_des- index in descriptor vector.               */
/* DESCRIPTION:                                                  */
/*   A SELECT statement is now being executed in DYNAMIC EXECU-  */
/* TION mode,  the  routine is to FETCH a new tuple from database*/
/* and if a new tuple is fetched, return 1 otherwise return 0.   */
/*                                                               */
/*****************************************************************/
int ora_next_row (int no_des)
{
	Cda_Def *dap = cda[no_des];
	int col;
	//ncol = describe_define (dap);

//	for (;;)
//	{
		//fputc('\n', stdout);
/* Fetch a row. Break on end of fetch,
disregard null fetch ”error”. */

		if (ofetch(dap))
		{
			if (dap->rc == NO_DATA_FOUND)
				return 1;
			if (dap->rc != NULL_VALUE_RETURNED)  {
				ora_error_handler(dap);
				return 1;  }
			else
				return 0;

		} else {
			return 0;
		}
//	}

}




/*****************************************************************/
/*                                                               */
/*                     ROUTINE  DESCRIPTION                      */
/*                                                               */
/* NAME: ora_inseneitive_upper()                                */
/*       ora_insensitive_lower()                                */
/*       ora_insensitive_mixed()				 */
/*       ora_sensitive_mixed()					 */
/* DESCRIPTION:                                                  */
/*   Decide if the underlying driver is sensitive to upper/lower */
/* cases, and what format is stored in database.                 */
/*                                                               */
/*****************************************************************/


void ora_set_parameter(int no_desc, text *stmt_buf, text *ph, char *value) {

	//text bind_values[MAX_BINDS][MAX_ITEM_BUFFER_SIZE];

//	sword i, in_literal, n;

/* Find and bind input variables for placeholders. */
//	for (i = 0, in_literal = FALSE, cp = stmt_buf;
//	*cp && i < MAX_BINDS; cp++)
//	{
//		if (*cp == '\'')
//			in_literal = ~in_literal;
//		if (*cp == ':' && !in_literal)
//		{
//			for (ph = ++cp, n = 0;
//			*cp && (isalnum(*cp) || *cp == '_')
//			&& n < MAX_SQL_IDENTIFIER;cp++, n++);
//			*cp = '\0';
//			strcpy((char *) &bind_values[i][0], (char *) value);
/* Do the bind, using obndrv().
NOTE: the bind variable address must be static.
This would not work if bind_values were an
auto on the do_binds stack. */
			if (strcmp ((char *) ph, "result_out")==0) {
				if (obndra (cda[no_desc], (text *) ":result_out", -1, (ub1 *) descrip, DESC_LEN,
						VARCHAR2_TYPE, -1, descrip_indp, descrip_len, descrip_rc, (ub4) MAX_SELECT_LIST_SIZE, &descrip_cs, (text *) 0, -1, -1))
				{
					ora_error_handler(cda[no_desc]);
					/*return 1;*/
				}
			}
			if (obndrv(cda[no_desc], ph, -1, (ub1 *) value, -1,
			VARCHAR2_TYPE, -1, (sb2 *) 0, (text *) 0, -1, -1))
			{
				ora_error_handler(cda[no_desc]);
				/*return 1;*/
			}
		//	i++;
	//	} /* end if (*cp == ...) */
//	} /* end for () */
/*return 0;*/
}



/*****************************************************************/
/*The following are the function related with DATABASE CONTROL   */
/*****************************************************************/

/*****************************************************************/
/*                                                               */
/*                     ROUTINE  DESCRIPTION                      */
/*                                                               */
/* NAME: ora_connect(name,passwd,role,rolePassWd,group,baseName) */
/* PARAMETERS:                                                   */
/*   name - data base user name.                                 */
/*   passwd - data base user's password(no use for ora  ).      */
/* DESCRIPTION:                                                  */
/*   Connect to an  ora  database.                              */
/* NOTE: Only the name is mandatory.                             */
/*                                                               */
/*****************************************************************/
void ora_connect (text *name, text *passwd)
{
		Cda_Def cursor;
		char *sql_stat = "ALTER SESSION SET NLS_DATE_FORMAT = 'MM/DD/YYYY HH24:MI:SS'";

		if (olog (&lda, (ub1 *)hda, name, -1, passwd, -1,
				(text *) 0, -1, OCI_LM_DEF))
		{
			ora_error_handler(&lda);
			/*return 1;*/
		}
		//connections++
		oopen (&cursor, &lda, (text *) 0, -1, -1, (text *) 0, -1);
		oparse (&cursor, (text *) sql_stat, -1, 1, 2);
		oexec(&cursor);
		/*return 0;*/
}

/*****************************************************************/
/*                                                               */
/*                     ROUTINE  DESCRIPTION                      */
/*                                                               */
/* NAME: ora_disconnect()                                       */
/* DESCRIPTION:                                                  */
/*   Disconnect the current connection with an  ora  database.  */
/*                                                               */
/*****************************************************************/
void ora_disconnect (void)
{
  int count;

  ora_clear_error ();
  for (count = 0; count < MAX_DESCRIPTOR; count++)
      ora_terminate_order (count);
  if (ologof(&lda)) {
	ora_error_handler(&lda);
	}

  ora_tranNumber = 0;
  /*return error_number;*/
}

/*****************************************************************/
/*                                                               */
/*                     ROUTINE  DESCRIPTION                      */
/*                                                               */
/* NAME: ora_rollback()                                          */
/* DESCRIPTION:                                                  */
/*   Roll back the current transaction .                         */
/*                                                               */
/*****************************************************************/
void ora_rollback (void)
{
  int count;

  ora_clear_error ();
  if (orol(&lda))
	ora_error_handler(&lda);
  /* Command ROLLBACK closes all open cursors; discards all statements */
  /* that were prepared in the current transaction.                    */
  for (count = 0; count < MAX_DESCRIPTOR; count++)
      ora_terminate_order (count);
  ora_tranNumber = 0;
  /*return error_number;*/
}

/*****************************************************************/
/*                                                               */
/*                     ROUTINE  DESCRIPTION                      */
/*                                                               */
/* NAME: ora_commit()                                            */
/* DESCRIPTION:                                                  */
/*   Commit the current transaction.                             */
/*                                                               */
/*****************************************************************/
void ora_commit (void)
{
  int count;

  ora_clear_error ();
  if (ocom(&lda))
	ora_error_handler(&lda);
  /* Command  COMMIT  closes all open cursors; discards all statements */
  /* that were prepared in the current transaction.                    */

  for (count = 0; count < MAX_DESCRIPTOR; count++)
      ora_terminate_order (count);
  ora_tranNumber = 0;
  /*return error_number;*/
}

/*****************************************************************/
/*                                                               */
/*                     ROUTINE  DESCRIPTION                      */
/*                                                               */
/* NAME: ora_trancount()                                         */
/* DESCRIPTION:                                                  */
/*   Return the number of transactions now active.               */
/*                                                               */
/*****************************************************************/
int ora_trancount (void)
{
  return ora_tranNumber;
}

/*****************************************************************/
/* The following functions are used to get data from structure   */
/* oraSQLDA  filled  by FETCH clause.                           */
/*****************************************************************/
/*                                                               */


/*****************************************************************/
/*  The following function deal with the DATE data of  ora      */
/*****************************************************************/
int ora_get_integer_data (int no_desc, int i) {
	return (int) def [no_desc] [i-1].int_buf;
}

double ora_get_float_data (int no_desc, int i) {
	return (double) def [no_desc] [i-1].flt_buf;
}

float ora_get_real_data (int no_desc, int i) {
	return (float) def [no_desc] [i-1].flt_buf;
}

int ora_get_boolean_data (int no_desc, int i) {
	return (int) def [no_desc] [i-1].int_buf;
}

int ora_is_null_data(int no_desc, int i) {
	return (def [no_desc] [i-1].col_retcode == NULL_VALUE_RETURNED );
}


char date[19];
char d[2];
char y[4];

static char *default_date = "11/11/1111 11:11:11";

int ora_get_date_data (int no_des, int i)
{
	int size;

	if (desc [no_des] [i-1].dbtype == DATE_TYPE)
	{
		size = desc [no_des] [i-1].buflen;
		if (*(def [no_des] [i-1].buf) == '\0')
		{
			//memcpy (&date, default_date, sizeof(date));
			return 0;
		}
		else
			memcpy (&date, def [no_des] [i-1].buf, sizeof(date));
		return 1;

	}
	return 0;
}

char *ora_get_year(void)
{
	strncpy ((char *) &y, &date[6], 4);
	return y;
}

char *ora_get_month(void)
{
	strncpy ((char *) &d, &date[0], 2);
	return d;
}

char *ora_get_day(void)
{
	strncpy ((char *) &d, &date[3], 2);
	return d;
}

char *ora_get_hour(void)
{
	strncpy ((char *) &d, &date[11], 2);
	return d;
}

char *ora_get_min(void)
{
	strncpy ((char *) &d, &date[14], 2);
	return d;
}

char *ora_get_sec(void)
{
	strncpy ((char *) &d, &date[17], 2);
	return d;
}

char * ora_get_warn_message (void)
{
		return "";
}

int ora_get_data_len (int no_des, int i)
{
	  return desc [no_des] [i-1].buflen;
}

int ora_conv_type (int i)
	/*char syb_conv_type (int i)*/
{
	switch (i)
	{
		case VARCHAR2_TYPE:
		case STRING_TYPE:
		case CHAR_TYPE:
		case LONG_TYPE:
			return ORA_EIF_STRING_TYPE;
		case INT_TYPE:
			return ORA_EIF_INTEGER_TYPE;
		case NUMBER_TYPE:
			return ORA_EIF_REAL_TYPE;
		case FLOAT_TYPE:
			return ORA_EIF_FLOAT_TYPE;
		case DATE_TYPE:
			return ORA_EIF_DATE_TYPE;
		default:
			return i; /*ORA_EIF_UNKNOWN_TYPE;*/
																    }
}

int ora_get_col_type (int no_des, int i) {
	return ora_conv_type(desc [no_des] [i - 1].dbtype);
}

int ora_get_count (int no_des) {
	return ncol [no_des];
}

int ora_get_col_len (int no_des, int i) {
	return desc [no_des] [i - 1].dsize;
}

int ora_c_string_type ()
{
	  return ORA_EIF_STRING_TYPE;
}

int ora_c_character_type ()
{
	  return ORA_EIF_CHARACTER_TYPE;
}

int ora_c_integer_type ()
{
	  return ORA_EIF_INTEGER_TYPE;
}

int ora_c_float_type ()
{
	  return ORA_EIF_FLOAT_TYPE;
}


int ora_c_real_type ()
{
	  return ORA_EIF_REAL_TYPE;
}


int ora_c_boolean_type ()
{
	  return ORA_EIF_BOOLEAN_TYPE;
}

int ora_c_date_type ()
{
	  return ORA_EIF_DATE_TYPE;
}

/*****************************************************************/
/*  The following functions are related with the error processing*/
/*****************************************************************/


void ora_clear_error (void)
{
  error_number = 0;
  error_message[0] = '\0';
}


char *ora_get_error_message (void)
{
  return (char *) error_message;
}

int ora_get_error_code (void)
{
  return error_number;
}

void ora_c_free(char *ptr) {
	free(ptr);
}

/***************/
/* eiffel_type */
/***************/


/* EOF ora.c */


void ora_error_handler(Cda_Def *cursor)
{
	sword n;

	printf("\n-- ora error--\n");
	printf("\n");
	n = oerhms (&lda, cursor->rc, error_message, (sword) sizeof (error_message));
	fprintf(stderr, "%.*s", n, error_message);
	error_number = cursor->rc;
	if (cursor->fc > 0)
		fprintf(stderr, "Processing OCI function %s",
			oci_func_tab[cursor->fc]);
}


