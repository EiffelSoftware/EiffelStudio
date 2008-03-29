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

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sybfront.h>
#include <sybdb.h>
#include "sybase.h"

int CS_PUBLIC err_handler ();
int CS_PUBLIC msg_handler ();
void clear_error ();
#define PRIVATE_DESCRIPTOR 0

LOGINREC  * login = NULL;

DBPROCESS * descriptor[MAX_DESCRIPTOR];
DBPROCESS *dbproc;
static int error_number, old_error_number;
static int data_type, size, max_size, * past_time;
static char * error_message;
static char date_string[30];
static char * tmp_st;

/* Prototypes. */
int syb_get_integer_data (int no_des, int i);
int syb_first_descriptor_available ();

void * safe_alloc (void *ptr)
{
  if (ptr == NULL)
    {
      enomem ();
    }
  return ptr;
}

/* each function return 0 in case of success */
/* and database error code ( >= 1) else */

/******************************/
/* initialise sybase c-module */
/******************************/

int c_syb_make (int m_size)
{
  int count;
  
  error_message = (char *) malloc (sizeof (char) * (m_size + ERROR_MESSAGE_SIZE));
  clear_error ();
  max_size = m_size;
  
  if (dbinit () == FAIL)
    {
      return error_number;
      //exit(ERREXIT);
    }
  
  dberrhandle ((EHANDLEFUNC)err_handler);
  dbmsghandle ((MHANDLEFUNC)msg_handler);
  
  if (login == NULL)
    {
    login = safe_alloc (dblogin());
    }
 
  for (count = 0; count < MAX_DESCRIPTOR; count++)
    {
      descriptor[count] = NULL;
    }
  
  return error_number;
}

int syb_new_descriptor ()
{
  int result = syb_first_descriptor_available ();
  
  if (result != NO_MORE_DESCRIPTOR)
    {
    descriptor[result] = safe_alloc (dbopen (login, NULL));
	}
  return result;
}

int syb_first_descriptor_available ()
{
  int no_descriptor;    
  
  for (no_descriptor = 0;
       no_descriptor < MAX_DESCRIPTOR && 
       descriptor[no_descriptor] != NULL;
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

int syb_available_descriptor ()
{
  return syb_first_descriptor_available () != NO_MORE_DESCRIPTOR;
}

int syb_max_descriptor ()
{
  return MAX_DESCRIPTOR;
}


int process_to_descriptor (DBPROCESS *dbp)
{
  int no_descriptor;    
  
  for (no_descriptor = 0;
       no_descriptor < MAX_DESCRIPTOR && 
       descriptor[no_descriptor] != dbp;
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

/**********************************/
/* execute SQL commandes functions */
/**********************************/

int syb_exec_immediate (char *order)
{
  DBPROCESS * dbp = descriptor[PRIVATE_DESCRIPTOR];
  clear_error ();
  dbcmd (dbp, order);
  dbsqlexec (dbp);
  return error_number;
}

int syb_init_order (int no_des, char *order)
{
  clear_error ();
  dbcmd (descriptor[no_des], order);
  return error_number;
}

int syb_start_order (int no_des)
{
  clear_error ();
  dbsqlexec (descriptor[no_des]);
  return error_number;
}

int syb_result_order (int no_des)
{
  clear_error ();
  dbresults (descriptor[no_des]);
  return error_number;
}

int syb_results_order (int no_des)
{
  DBPROCESS * dbp = descriptor[no_des];
  
  clear_error ();
  while (dbresults (dbp) != NO_MORE_RESULTS)
    {
      /* empty */
    }
  return error_number;
}

int syb_next_row (int no_des)
     /* move to the next row of selection */
     /* return 0 if there is a next row, 1 if no row left */
{
  clear_error ();
  error_number = dbnextrow (descriptor[no_des]);
  if (error_number == NO_MORE_ROWS)
    {
      return 1;
    }
  else
    {
      return 0;
    }
}

int syb_terminate_order (int no_des)
{
  if (descriptor[no_des] != NULL && no_des != PRIVATE_DESCRIPTOR)
    {
      dbclose (descriptor[no_des]);
      descriptor[no_des] = NULL;
    }
  return 0;
}

/*********************/
/* control functions */
/*********************/

int syb_connect (char *name, char *passwd, char *appl, char *host)
{

  clear_error ();
  
  DBSETLUSER (login, name);
  
  DBSETLPWD (login, passwd);
  
  if (strlen (appl) > 0)
    {
      DBSETLAPP (login, appl);
    }
  
  if (strlen (host) > 0)
    {
      DBSETLHOST (login, host);
    }
  
  descriptor[PRIVATE_DESCRIPTOR] = dbopen (login, NULL); /*for internal use*/
  
  return error_number;
}

int syb_disconnect ()
{
 int count;
  
  clear_error ();
  
  for (count = 0; count < MAX_DESCRIPTOR; count++)
    {
      syb_terminate_order (count);
    }
  return error_number;
}

int syb_rollback ()
{
  clear_error ();
  syb_exec_immediate ("rollback transaction");
  return error_number;
}

int syb_commit ()
{
  clear_error ();
  syb_exec_immediate ("commit transaction");
  return error_number;
}

int syb_begin ()
{
  clear_error ();
  syb_exec_immediate ("begin transaction");
  return error_number;
}

int syb_trancount ()
{
  syb_init_order (PRIVATE_DESCRIPTOR, "select @@trancount");
  syb_start_order (PRIVATE_DESCRIPTOR);
  syb_result_order (PRIVATE_DESCRIPTOR);
  clear_error ();
  syb_next_row (PRIVATE_DESCRIPTOR);
  return syb_get_integer_data (PRIVATE_DESCRIPTOR, 1);
}

/*******************/
/* retrieve result */
/*******************/

int syb_get_count (int no_des)
{
  return dbnumcols (descriptor[no_des]);
}

int syb_put_col_name (int no_des, int i, char *result)
{
  tmp_st = dbcolname (descriptor[no_des], i);
  size = strlen (tmp_st);
  memcpy (result, tmp_st, size);
  return size;
}

int syb_get_col_len (int no_des, int i)
{
  return dbcollen (descriptor[no_des], i);
}

int syb_get_data_len (int no_des, int i)
{
  return dbdatlen (descriptor[no_des], i);
}

int syb_conv_type (int i)
/*char syb_conv_type (int i)*/
{
  switch (i)
    {
    case SYBCHAR:
    case SYBVARCHAR:
    case SYBTEXT:
    case SYBBINARY:  
      return STRING_TYPE;
    case SYBINT1:
    case SYBINT2:
    case SYBINT4:
      return INTEGER_TYPE;
    case SYBREAL:
	return REAL_TYPE;
    case SYBFLT8:
    case SYBMONEY:
      return FLOAT_TYPE;
    case SYBBIT:
      return BOOLEAN_TYPE;
    case SYBDATETIME:
      return DATE_TYPE;
    default:
      return UNKNOWN_TYPE;
    }
}

int syb_get_col_type (int no_des, int i)
{
  return syb_conv_type (dbcoltype (descriptor[no_des], i));
}

int syb_put_data (int no_des, int i, char *result)
{
  DBPROCESS * dbp = descriptor[no_des];
  data_type = dbcoltype (dbp, i);
  
  if (data_type == SYBBINARY)
    { 
      /* Prefix the string by `Ox' for Hexa */
      result[0] = '0';
      result[1] = 'x';
      
      size = dbconvert (dbp, data_type, dbdata (dbp, i), dbdatlen (dbp, i),
			SYBCHAR, &(result[2]), max_size-2);
      if (size != -1)
	{
	  size += 2;
	} 
    }
  else
    {
      size = dbconvert (dbp, data_type, dbdata (dbp, i), dbdatlen (dbp, i),
			SYBCHAR, result, max_size);
    }
  if (size == -1)
    {
      return 0;
    }
  else
    {
      return size;
    }
}

int syb_get_integer_data (int no_des, int i)
{
  int result;
  DBPROCESS * dbp = descriptor[no_des];
  
  data_type = dbcoltype (dbp, i);
  if ( (data_type == SYBINT1) || (data_type == SYBINT2) || (data_type == SYBINT4) )
    {
      dbconvert (dbp, data_type, dbdata (dbp, i), dbdatlen (dbp, i),
		 SYBINT4, &result, sizeof (result));
      return (int) result;

    }
  return 0;
}

int syb_get_boolean_data (int no_des, int i)
{
  int result;
  DBPROCESS * dbp = descriptor[no_des];
  
  data_type = dbcoltype (dbp,i);
  if (data_type == SYBBIT)
    {
      dbconvert (dbp, data_type, dbdata (dbp, i), dbdatlen (dbp, i),
		 SYBINT4, &result, sizeof (result));
      return (int) result;

    }
  return 0;
}

double syb_get_float_data (int no_des, int i)
{
  double result;
  float result_real;
  
  DBPROCESS * dbp = descriptor[no_des];
  
  data_type = dbcoltype (dbp, i);
  if ( (data_type == SYBFLT8) || (data_type == SYBMONEY) )
    {
      dbconvert (dbp, data_type, dbdata (dbp, i), dbdatlen (dbp, i),
		 SYBFLT8, &result, sizeof (result));
      return result;

    }
  else if (data_type == SYBREAL)
	{
      dbconvert (dbp, data_type, dbdata (dbp, i), dbdatlen (dbp, i),
		 SYBREAL, &result_real, sizeof (result_real));
	  return result_real;
	}
  return 0.0;
}

float syb_get_real_data (int no_des, int i)
{
  float result_real;
  /*char result_real;*/
  DBPROCESS * dbp = descriptor[no_des];
  
  data_type = dbcoltype (dbp, i);
  if (data_type == SYBREAL)
	{
      dbconvert (dbp, data_type, dbdata (dbp, i), dbdatlen (dbp, i),
		 SYBREAL, &result_real, sizeof (result_real));
      return (float) result_real;
	}
  return 0.0;
}



DBDATEREC date;

int syb_get_date_data (int no_des, int i)
{
  DBPROCESS * dbp = descriptor[no_des];
  
  data_type = dbcoltype (dbp, i);
  if (data_type == SYBDATETIME)
    {
      if (dbdatecrack (dbp, &date, (DBDATETIME *) dbdata (dbp, i)) == FAIL)
	{
	  return 0;
	}
    }
  return 1;
}

int syb_get_year()
{
  return date.dateyear;
}

int syb_get_month()
{
  return date.datemonth + 1;
}

int syb_get_day()
{
  return date.datedmonth;
}

int syb_get_hour()
{
  return date.datehour;
}

int syb_get_min()
{
  return date.dateminute;
}

int syb_get_sec()
{
  return date.datesecond;
}

int syb_get_msecond()
{
  return date.datemsecond;
}

/****************/
/* error handle */
/****************/

int mes_flag = 0;

void clear_error ()
{
  error_number = 0;
  mes_flag = 0;
  error_message[0] = '\0';
}

int CS_PUBLIC err_handler (
	DBPROCESS *db_err_proc,
	int severity, int dberr, int oserr,
	char *dberrstr, char *oserrstr)
{
  if ((severity > 0) && (dberr != SYBESMSG))
    /* `sql server message': do by `msg_handler ()' */
    {
      error_number = dberr;
      if ((db_err_proc == NULL) || (DBDEAD (db_err_proc))) 
	{
	  if (mes_flag)
	    {
	      strcat (error_message, "\n");
	      strcat (error_message, "DB-Library error: unable to open database");
	    }
	  else
	    {
	      strcpy (error_message, "DB-Library error: unable to open database");
	    }
	}
      else
	{
	  if (mes_flag)
	    {
	      strcat (error_message, "\n");
	      strcat (error_message, "DB-Library error: ");
	    }
	  else
	    {
	      strcpy (error_message, "DB-Library error: ");
	    }
	  strcat (error_message, dberrstr);
	  if (oserr != DBNOERR)
	    {
	      strcat (error_message, "Operating-system error: ");
	      strcat (error_message, oserrstr);
	    }
	}
    }
  syb_terminate_order (process_to_descriptor (db_err_proc));
  return (INT_CANCEL);
  

}

char * syb_get_error_message ()
{
  return error_message;
}

char * syb_get_warn_message ()
{
	return "";
}

int CS_PUBLIC msg_handler(
	DBPROCESS *db_err_proc,
	DBINT msgno,
	int msgstate, int severity,
	char *msgtext, char *srvname, char *procname,
	//DBUSMALLINT line)
	int line)
{
  if (severity > 0)
    {
      dbstrcpy (db_err_proc, 0, max_size, error_message);
      strcat (error_message, "\n");
      mes_flag = 1;
      error_number = msgno;
      sprintf (error_message+strlen(error_message), "Msg %ld, Level %d, State %d ", 
	       msgno, severity, msgstate);
      if (strlen (srvname) > 0)
	{
	  sprintf (error_message+strlen (error_message), "Server '%s' ", srvname);
	  
	}
      if (strlen (procname) > 0)
	{
	  sprintf (error_message+strlen (error_message), "Procedure '%s' ", procname);

	}
      if (line > 0)
	{
	  sprintf (error_message+strlen (error_message), "Line %d ", line);
	}
      strcat (error_message, "database message: ");
      strcat (error_message, msgtext);
      
    }
  return INT_CANCEL;
}


/***************/
/* eiffel_type */
/***************/

int c_string_type ()
{
  return STRING_TYPE;
}

int c_character_type ()
{
  return CHARACTER_TYPE;
}

int c_integer_type ()
/*char c_integer_type ()*/
{
  return INTEGER_TYPE;
}

int c_float_type ()
{
  return FLOAT_TYPE;
}


int c_real_type ()
{
  return REAL_TYPE;
}


int c_boolean_type ()
{
  return BOOLEAN_TYPE;
}

int c_date_type ()
{
  return DATE_TYPE;
}

/* EOF sybase.c */
