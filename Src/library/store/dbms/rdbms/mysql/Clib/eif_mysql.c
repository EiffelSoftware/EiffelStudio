/*
 * eif_mysql.c:	Eiffel MySQL stub library
 *
 * Author:		$Author$
 * Revision:	$Revision$
 * Date:		$Date$
 *
 * Copyright:	(C) 2010 by ITPassion, Eiffel Software and others
 *
 */

/* System Include Files */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <mysql.h>

/* Project Include File */
#include "eif_except.h"
#include "eif_mysql.h"

/*
 * Function:	int eif_mysql_column_data(MYSQL_ROW row_ptr, int ind,
 *					char *ar, int len)
 * Description:	Retrieve the column data of the column with index `ind' in
 *				`row_ptr', store it in `ar' and return the number of bytes
 *				in `ar'
 * Arguments:	MYSQL_ROW row_ptr:	Pointer to MySQL Result structure
 *				int ind:			Index of the column of which the data
 *									should be returned
 *				char *ar:			Resulting data
 *				int len:			Length of the data
 * Returns:		The length of the column data
 */
int eif_mysql_column_data(MYSQL_ROW row_ptr, int ind, char *ar, int len)
{
	int length;

	if(row_ptr[ind - 1] == NULL)
		return 0;
	else {
		ar = memcpy(ar, row_ptr[ind - 1], len);
		return len;
	}
}

/*
 * Function:	unsigned long eif_mysql_column_length(MYSQL_RES *result_ptr,
 *					int ind)
 * Description:	Get the length of column `ind' in `result_ptr', as per table
 *				definition
 * Arguments:	MYSQL_RES *result_ptr:	Pointer to MySQL Result structure
 *				int ind:				Index of the column of which the length
 *										should be returned
 * Returns:		The length of indicated column
 */
unsigned long eif_mysql_column_length(MYSQL_RES *result_ptr, int ind)
{
	MYSQL_FIELD *field = (MYSQL_FIELD *) 0;
	unsigned long result;

	field = mysql_fetch_field_direct(result_ptr, ind - 1);
	result = field->length;

	return result;
}

/*
 * Function:	int eif_mysql_column_name(MYSQL_RES *result_ptr, int ind,
 *					char *ar)
 * Description:	Retrieve the column name of the column with index `ind' in
 *				`result_ptr', store it in `ar' and return the number of bytes
 *				in `ar'
 * Arguments:	MYSQL_RES *result_ptr:	Pointer to MySQL Result structure
 *				int ind:				Index of the column of which the name
 *										should be returned
 *				char *ar:				The name of the column
 * Returns:		The length of the column name
 */
int eif_mysql_column_name(MYSQL_RES *result_ptr, int ind, char *ar)
{
	MYSQL_FIELD *field = (MYSQL_FIELD *) 0;
	char *name = (char *) 0;
	int result;

	field = mysql_fetch_field_direct(result_ptr, ind - 1);
	name = field->name;
	result = field->name_length;

	ar = memcpy(ar, name, result);

	return result;
}

/*
 * Function:	int eif_mysql_column_type(MYSQL_RES *result_ptr,
 *					int ind)
 * Description:	Get the type of column `ind' in `result_ptr', as per table
 *				definition
 * Arguments:	MYSQL_RES *result_ptr:	Pointer to MySQL Result structure
 *				int ind:				Index of the column of which the length
 *										should be returned
 * Returns:		The type of indicated column
 */
int eif_mysql_column_type(MYSQL_RES *result_ptr, int ind)
{
	MYSQL_FIELD *field = (MYSQL_FIELD *) 0;
	int result = 0;
	int type = 0;

	field = mysql_fetch_field_direct(result_ptr, ind - 1);
	type = field->type;

	switch(type) {
		case MYSQL_TYPE_VARCHAR:
		case MYSQL_TYPE_VAR_STRING:
		case MYSQL_TYPE_STRING:
			result = EIF_MYSQL_C_STRING_TYPE;
			break;
		case MYSQL_TYPE_DATETIME:
			result = EIF_MYSQL_C_DATE_TYPE;
			break;
		case MYSQL_TYPE_FLOAT:
			result = EIF_MYSQL_C_REAL_TYPE;
			break;
		case MYSQL_TYPE_DOUBLE:
			result = EIF_MYSQL_C_DOUBLE_TYPE;
			break;
		case MYSQL_TYPE_BLOB:
			result = EIF_MYSQL_C_STRING_TYPE;
			break;
		default:
			result = EIF_MYSQL_C_INTEGER_TYPE;
			break;
	}

	return result;
}

/*
 * Function:	eif_mysql_connect(const char *user, const char *pass,
 *					const char *host, int port, const char *base)
 * Description:	Connect to the given MySQL server, using the user and password
 *				information, and select the database, so that querying etc
 *				is immediately available
 * Arguments:	const char *user:	Username to connect as
 *				const char *pass:	Password for identification
 *				const char *host:	MySQL Server hostname
 *				int port:			Port to connect to MySQL Server
 *				const char *base:	Database to be selected
 * Returns:		Pointer to MYSQL structure as returned by mysql_init(...)
 */
MYSQL *eif_mysql_connect(const char *user, const char *pass, const char *host, int port, const char *base)
{
	MYSQL *res1 = (MYSQL *) 0;
	MYSQL *res2 = (MYSQL *) 0;

	res1 = mysql_init((MYSQL *) 0);

	res2 = mysql_real_connect(res1, host, user, pass, base, port,
		(const char *) 0, CLIENT_REMEMBER_OPTIONS | CLIENT_MULTI_RESULTS);

	/* It is determined, that, in case mysql_real_connect a NULL pointer
	 * returns, res1 is the actual object through which the errors can
	 * be obtained.
	 * In case mysql_real_connect returns a MYSQL * other than NULL,
	 * that pointer is the same as res1 (the pointer returned by
	 * mysql_init(...). So we always return res1, regardless.
	 * All in all, res2 is just a place holder to catch the NULL pointer.
	 */

	return res1;
}

/*
 * Function:	unsigned long eif_mysql_data_length (MYSQL_RES *result_ptr,
 *					int ind)
 * Description:	Get the length of column `ind' in `result_ptr'
 * Arguments:	MYSQL_RES *result_ptr:	Pointer to MySQL Result structure
 *				int ind:				Index of the column of which the length
 *										should be returned
 * Returns:		The length of indicated column
 */
unsigned long eif_mysql_data_length (MYSQL_RES *result_ptr, int ind)
{
	unsigned long *lengths;
	lengths = mysql_fetch_lengths(result_ptr);

	return lengths[ind - 1];
}

/*
 * Function:	int eif_mysql_date_data (MYSQL_ROW row_ptr, int ind, char *ar)
 * Description:	Retrieve the date in column `ind' from `row_ptr' into `ar'
 *				and return 1 indicating success
 * Arguments:	MYSQL_ROW row_ptr:	Pointer to MYSQL structure
 *				int ind:			Column index
 *				char *ar:			Area to copy the date into
 * Returns:		0:	Failure
 *				1:	Success
 */
int eif_mysql_date_data (MYSQL_ROW row_ptr, int ind, char *ar)
{
	int length = 19;

	if(row_ptr[ind - 1] == NULL)
		return 0;
	else {
		ar = memcpy(ar, row_ptr[ind - 1], length);
		return 1;
	}
}

/*
 * Function:	void eif_mysql_disconnect(MYSQL *mysql_ptr)
 * Description:	Disconnect from the given MySQL Server
 * Arguments:	MYSQL *mysql_ptr:		Pointer to MYSQL structure
 * Returns:		<none>
 */
void eif_mysql_disconnect(MYSQL *mysql_ptr)
{
	mysql_close(mysql_ptr);
}

/*
 * Function:	MYSQL_RES *eif_mysql_execute(MYSQL *mysql_ptr,
 *					const char *command)
 * Description:	Execute the given command and return the MYSQL_RES pointer to
 *				Eiffel
 * Arguments:	MYSQL *mysql_ptr:		Pointer to MYSQL structure
 *				const char *command:	Command to be executed
 * Returns:		Pointer to a MYSQL_RES as returned by mysql_store_result
 */
MYSQL_RES *eif_mysql_execute(MYSQL *mysql_ptr, const char *command)
{
	int res = 0;
	MYSQL_RES *result = (MYSQL_RES *) 0;
	size_t c_len = 0;


	c_len = strlen(command);
	res = mysql_real_query(mysql_ptr, command, c_len + 1);
	if(res == 0) {
		result = mysql_store_result(mysql_ptr);
		if(result == (MYSQL_RES *) 0) {
			fprintf(stderr, "MySQL error code: %d; MySQL error msg: '%s'\n",
				mysql_errno(mysql_ptr), mysql_error(mysql_ptr));
		}
	} else {
		fprintf(stderr, "mysql_real_query returned non-zero!\n");
		fprintf(stderr, "Error Code: %d; Error Msg: '%s'\n",
			mysql_errno(mysql_ptr), mysql_error(mysql_ptr));
		fprintf(stderr, "Command: %s\n", command);
	}

	return result;
}

/*
 * Function:	double eif_mysql_float_data(MYSQL_ROW row_ptr, int ind)
 * Description:	Get the double at field ind in row_ptr
 * Arguments:	MYSQL_ROW row_ptr:	Pointer to the current row
 *				int ind:			Column index
 * Returns:		The double in that field
 */
double eif_mysql_float_data(MYSQL_ROW row_ptr, int ind)
{
	double result = strtod(row_ptr[ind - 1], (char **) NULL);

	return result;
}

/*
 * Function:	void eif_mysql_free_result(MYSQL_RES *result_ptr)
 * Description:	Free the MySQL Result structure pointed to by result_ptr
 * Arguments:	MYSQL_RES *result_ptr:	Pointer to MySQL Result structure
 * Returns:		<none>
 */
void eif_mysql_free_result(MYSQL_RES *result_ptr)
{
	mysql_free_result(result_ptr);
}

/*
 * Function:	char *eif_mysql_get_error_code(MYSQL *mysql_ptr)
 * Description:	Return the last error code from the MySQL library
 * Arguments:	MYSQL *mysql_ptr:	Pointer to MYSQL structure
 * Returns:		The last error code from the MySQL library
 */
int eif_mysql_get_error_code(MYSQL *mysql_ptr)
{
	int result = (int) mysql_errno(mysql_ptr);

	return result;
}

/*
 * Function:	char *eif_mysql_get_error_message(MYSQL *mysql_ptr)
 * Description:	Return the last error message from the MySQL library
 * Arguments:	MYSQL *mysql_ptr:	Pointer to MYSQL structure
 * Returns:		The last error message from the MySQL library
 */
char *eif_mysql_get_error_message(MYSQL *mysql_ptr)
{
	char *result = (char *) mysql_error(mysql_ptr);

	return result;
}

/*
 * Function:	char *eif_mysql_get_warn_message(MYSQL *mysql_ptr)
 * Description:	Return the last warning message from the MySQL library
 * Arguments:	MYSQL *mysql_ptr:	Pointer to MYSQL structure
 * Returns:		The last warning message from the MySQL library
 */
char *eif_mysql_get_warn_message(MYSQL *mysql_ptr)
{
	char *result = (char *) mysql_error(mysql_ptr);

	return result;
}

/*
 * Function:	long eif_mysql_integer_data(MYSQL_ROW row_ptr, int ind)
 * Description:	Get the integer at field ind in row_ptr
 * Arguments:	MYSQL_ROW row_ptr:	Pointer to the current row
 *				int ind:			Column index
 * Returns:		The integer in that field
 */
long eif_mysql_integer_data(MYSQL_ROW row_ptr, int ind)
{
	int result = (long) atol(row_ptr[ind - 1]);

	return result;
}

/*
 * Function:	EIF_BOOLEAN eif_mysql_is_null_data(MYSQL_ROW row_ptr,
 *					int ind)
 * Description:	Is the data for column `ind' in `result_ptr' NULL?
 * Arguments:	MYSQL_ROW row_ptr:	Pointer to the current row
 *				int ind:			Column index
 * Returns:		EIF_FALSE:	No
 *				EIF_TRUE:	Yes
 */
EIF_BOOLEAN eif_mysql_is_null_data(MYSQL_ROW row_ptr, int ind)
{
	if(row_ptr[ind - 1] == NULL)
		return EIF_TRUE;
	else
		return EIF_FALSE;
}

/*
 * Function:	MYSQL_ROW *eif_mysql_next_row(MYSQL_RES *result_ptr)
 * Description:	Retrieve the next row from the MYSQL Result Set `result_ptr'
 * Arguments:	MYSQL_RES *result_ptr:	Pointer to the result set
 * Returns:		Pointer to the next row retrieved, or else (MYSQL_ROW *) 0
 */
MYSQL_ROW eif_mysql_next_row(MYSQL_RES *result_ptr)
{
	MYSQL_ROW result = (MYSQL_ROW) 0;

	result = mysql_fetch_row(result_ptr);

	return result;
}

/*
 * Function:	int eif_mysql_num_fields(MYSQL_RES *result_ptr)
 * Description:	Get the number of columns for `result_ptr'
 * Arguments:	MYSQL_RES *result_ptr:	Pointer to the result set
 * Returns:		Number of columns returned per row
 */
int eif_mysql_num_fields(MYSQL_RES *result_ptr)
{
	int result = 0;

	result = mysql_num_fields(result_ptr);

	return result;
}

/*
 * Function:	float eif_mysql_real_data(MYSQL_ROW row_ptr, int ind)
 * Description:	Get the float at field ind in row_ptr
 * Arguments:	MYSQL_ROW row_ptr:	Pointer to the current row
 *				int ind:			Column index
 * Returns:		The float in that field
 */
float eif_mysql_real_data(MYSQL_ROW row_ptr, int ind)
{
	float result = (float) atof(row_ptr[ind - 1]);

	return result;
}
