/*
 * eif_mysql.h:	Eiffel MySQL stub library
 *
 * Author: $Author$
 * Revision: $Revision$
 * Date: $Date$
 *
 * Copyright:	(C) 2008 - 2010 by ITPassion Ltd, Eiffel Software and others
 *
 */

#ifndef __eif_mysql_h__
#define __eif_mysql_h__
#include <mysql.h>

#include "eif_macros.h"

/* Type macros */
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

#ifndef my_bool
#ifdef bool
#define my_bool bool /* needed with MySQL 8, as it uses directly "bool" and not anymore "my_bool" */
#endif
#endif

/* Public functions */
extern int eif_mysql_column_data(MYSQL_ROW row_ptr, int ind, char *ar,
	int len);
extern unsigned long eif_mysql_column_length (MYSQL_RES *result_ptr, int ind);
extern int eif_mysql_column_name(MYSQL_RES *result_ptr, int ind, char *ar, int a_max_len);
extern int eif_mysql_column_type (MYSQL_RES *result_ptr, int ind);
extern MYSQL *eif_mysql_connect(const char *user, const char *pass, const char *host, int port, const char *base);
extern unsigned long eif_mysql_data_length (MYSQL_RES *result_ptr, int ind);
extern int eif_mysql_date_data (MYSQL_ROW row_ptr, int ind, char *ar);
extern void eif_mysql_disconnect(MYSQL *mysql_ptr);
extern MYSQL_RES *eif_mysql_execute(MYSQL *mysql_ptr, const char *command);
extern double eif_mysql_float_data(MYSQL_ROW row_ptr, int ind);
extern void eif_mysql_free_result(MYSQL *mysql_ptr, MYSQL_RES *result_ptr);
extern int eif_mysql_get_error_code(MYSQL *mysql_ptr);
extern char *eif_mysql_get_error_message(MYSQL *mysql_ptr);
extern char *eif_mysql_get_warn_message(MYSQL *mysql_ptr);
extern long eif_mysql_integer_data(MYSQL_ROW row_ptr, int ind);
extern int eif_mysql_integer_16_data(MYSQL_ROW row_ptr, int ind);
extern EIF_NATURAL_64 eif_mysql_integer_64_data(MYSQL_ROW row_ptr, int ind);
extern EIF_BOOLEAN eif_mysql_is_null_data(MYSQL_ROW row_ptr, int ind);
extern MYSQL_ROW eif_mysql_next_row(MYSQL_RES *result_ptr);
extern int eif_mysql_num_fields(MYSQL_RES *result_ptr);
extern float eif_mysql_real_data(MYSQL_ROW row_ptr, int ind);
extern my_bool eif_mysql_autocommit(MYSQL *mysql_ptr, my_bool mode);
extern void eif_mysql_enable_multi_statements (MYSQL *mysql_ptr);
extern void eif_mysql_disable_multi_statements (MYSQL *mysql_ptr);

#endif /* __eif_mysql_h__ */

