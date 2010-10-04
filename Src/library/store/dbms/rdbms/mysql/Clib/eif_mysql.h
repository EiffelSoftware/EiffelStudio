/*
 * eif_mysql.h:	Eiffel MySQL stub library
 *
 * Author:		$Author$
 * Revision:	$Revision$
 * Date:		$Date$
 *
 * Copyright:	(C) 2008 - 2010 by ITPassion Ltd, Eiffel Software and others
 *
 */

#ifndef __eif_mysql_h__
#define __eif_mysql_h__

#include <mysql/mysql.h>

#include "eif_macros.h"

/* Type macros */
#define EIF_MYSQL_C_STRING_TYPE		1
#define EIF_MYSQL_C_INTEGER_TYPE	2
#define EIF_MYSQL_C_DATE_TYPE		3
#define EIF_MYSQL_C_REAL_TYPE		4
#define EIF_MYSQL_C_DOUBLE_TYPE		5
#define EIF_MYSQL_C_BOOLEAN_TYPE	6
#define EIF_MYSQL_C_CHARACTER_TYPE	7

/* Public functions */
extern int eif_mysql_column_data(MYSQL_ROW row_ptr, int ind, char *ar,
	int len);
extern unsigned long eif_mysql_column_length (MYSQL_RES *result_ptr, int ind);
extern int eif_mysql_column_name(MYSQL_RES *result_ptr, int ind, char *ar);
extern int eif_mysql_column_type (MYSQL_RES *result_ptr, int ind);
extern MYSQL *eif_mysql_connect(const char *user, const char *pass, const char *host, int port, const char *base);
extern unsigned long eif_mysql_data_length (MYSQL_RES *result_ptr, int ind);
extern int eif_mysql_date_data (MYSQL_ROW row_ptr, int ind, char *ar);
extern void eif_mysql_disconnect(MYSQL *mysql_ptr);
extern MYSQL_RES *eif_mysql_execute(MYSQL *mysql_ptr, const char *command);
extern double eif_mysql_float_data(MYSQL_ROW row_ptr, int ind);
extern void eif_mysql_free_result(MYSQL_RES *result_ptr);
extern int eif_mysql_get_error_code(MYSQL *mysql_ptr);
extern char *eif_mysql_get_error_message(MYSQL *mysql_ptr);
extern char *eif_mysql_get_warn_message(MYSQL *mysql_ptr);
extern long eif_mysql_integer_data(MYSQL_ROW row_ptr, int ind);
extern EIF_BOOLEAN eif_mysql_is_null_data(MYSQL_ROW row_ptr, int ind);
extern MYSQL_ROW eif_mysql_next_row(MYSQL_RES *result_ptr);
extern int eif_mysql_num_fields(MYSQL_RES *result_ptr);
extern float eif_mysql_real_data(MYSQL_ROW row_ptr, int ind);

#endif /* __eif_mysql_h__ */

