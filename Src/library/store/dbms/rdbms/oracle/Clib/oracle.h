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
   Database: "ORACLE"
*/

#ifndef _ORACLE_H_
#define _ORACLE_H_

#include <ctype.h>

#include <ocidfn.h>
#include <ociapr.h>


#ifndef ORATYPES
#include <oratypes.h>
#endif /* ORATYPES */

#ifdef __cplusplus
extern "C" {
#endif

/* datatypes for Eiffel*/
#define EIF_C_NULL_TYPE			-1
#define EIF_C_UNKNOWN_TYPE		0
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

 /*  internal/external datatype codes */
#define VARCHAR2_TYPE				1
#define NUMBER_TYPE					2
#define INT_TYPE					3
#define FLOAT_TYPE					4
#define STRING_TYPE					5
#define LONG_TYPE					8
#define ROWID_TYPE					11
#define DATE_TYPE					12
#define CHAR_TYPE					96

/*  ORACLE error codes used in demonstration programs */
#define VAR_NOT_IN_LIST       1007
#define NO_DATA_FOUND         1403
#define NULL_VALUE_RETURNED   1405

/*  some SQL and OCI function codes */
#define FT_INSERT                3
#define FT_SELECT                4
#define FT_UPDATE                5
#define FT_DELETE                9

#define FC_OOPEN                14

/*
** Size of HDA area:
** 512 for 64 bit arquitectures
** 256 for 32 bit arquitectures
*/

#if (defined(__osf__) && defined(__alpha)) || defined(CRAY) || defined(KSR) || \
    defined(SS_64BIT_SERVER)
# define HDA_SIZE 512
#else
# define HDA_SIZE 256
#endif

/*
 *  OCI function code labels,
 *  corresponding to the fc numbers
 *  in the cursor data area.
 */
static CONST text  *oci_func_tab[] =  {(text *) "not used",
/* 1-2 */       (text *) "not used", (text *) "OSQL",
/* 3-4 */       (text *) "not used", (text *) "OEXEC, OEXN",
/* 5-6 */       (text *) "not used", (text *) "OBIND",
/* 7-8 */       (text *) "not used", (text *) "ODEFIN",
/* 9-10 */      (text *) "not used", (text *) "ODSRBN",
/* 11-12 */     (text *) "not used", (text *) "OFETCH, OFEN",
/* 13-14 */     (text *) "not used", (text *) "OOPEN",
/* 15-16 */     (text *) "not used", (text *) "OCLOSE",
/* 17-18 */     (text *) "not used", (text *) "not used",
/* 19-20 */     (text *) "not used", (text *) "not used",
/* 21-22 */     (text *) "not used", (text *) "ODSC",
/* 23-24 */     (text *) "not used", (text *) "ONAME",
/* 25-26 */     (text *) "not used", (text *) "OSQL3",
/* 27-28 */     (text *) "not used", (text *) "OBNDRV",
/* 29-30 */     (text *) "not used", (text *) "OBNDRN",
/* 31-32 */     (text *) "not used", (text *) "not used",
/* 33-34 */     (text *) "not used", (text *) "OOPT",
/* 35-36 */     (text *) "not used", (text *) "not used",
/* 37-38 */     (text *) "not used", (text *) "not used",
/* 39-40 */     (text *) "not used", (text *) "not used",
/* 41-42 */     (text *) "not used", (text *) "not used",
/* 43-44 */     (text *) "not used", (text *) "not used",
/* 45-46 */     (text *) "not used", (text *) "not used",
/* 47-48 */     (text *) "not used", (text *) "not used",
/* 49-50 */     (text *) "not used", (text *) "not used",
/* 51-52 */     (text *) "not used", (text *) "OCAN",
/* 53-54 */     (text *) "not used", (text *) "OPARSE",
/* 55-56 */     (text *) "not used", (text *) "OEXFET",
/* 57-58 */     (text *) "not used", (text *) "OFLNG",
/* 59-60 */     (text *) "not used", (text *) "ODESCR",
/* 61-62 */     (text *) "not used", (text *) "OBNDRA"
};

/* the following are some lengthes' definitions */
#define ERROR_MESSAGE_SIZE    512 /* the max length of error message */
#define WARN_MESSAGE_SIZE     450 /* the max length of warning message */
#define MAX_ERROR_MSG         200 /* the max length of tempory error message */
#define MAX_DESCRIPTOR        20  /* Max descriptor available simultaneously */


#define NO_MORE_ROWS          100 /* No more row is fetched by FETCH operation */

/* the following are some ERROR codes */
#define NO_MORE_DESCRIPTOR    			(-1)
void * ora_safe_alloc (void *ptr);
void change_to_low(char *buf);
void c_ora_make (int m_size);
int ora_new_descriptor(void); //
int ora_first_descriptor_available (void);
int ora_available_descriptor (void);
int ora_max_descriptor (void);
void ora_exec_immediate (int no_desc, text *order); //
void ora_init_order (text *order, int no_desc); //
sword describe_define(Cda_Def *cda, int no_desc);
void print_header(sword ncols, int no_desc);
void print_rows(Cda_Def *cda, sword ncols, int no_desc);
int ora_put_data (int no_des, int index, char *result);
int ora_put_select_name (int no_des, int i, char *result);
void ora_start_order (int no_desc); //
void ora_terminate_order (int no_des); //
int ora_next_row (int no_des); //
void ora_set_parameter(int no_desc, text *ph, char *value); //
void ora_connect (text *name, text *passwd); //
void ora_disconnect (void); //
void ora_rollback (void); //
void ora_commit (void); //
int ora_trancount (void);
int ora_get_integer_data (int, int);
int ora_get_integer_16_data (int, int);
EIF_NATURAL_64 ora_get_integer_64_data (int no_desc, int i);
double ora_get_float_data (int, int);
float ora_get_real_data (int, int);
int ora_get_boolean_data (int, int);
int ora_is_null_data();
int ora_get_date_data (int no_des, int i);
char *ora_get_year(void);
char *ora_get_month(void);
char *ora_get_day(void);
char *ora_get_hour(void);
char *ora_get_min(void);
char *ora_get_sec(void);
char * ora_get_warn_message (void);
int ora_get_data_len (int no_des, int i);
int ora_conv_type (int i);
int ora_get_col_type (int no_des, int i);
int ora_get_count (int no_des);
int ora_get_col_len (int no_des, int i);
void ora_clear_error (void);
char * ora_get_error_message (void);
int ora_get_error_code (void);
void ora_c_free(char *ptr);
void ora_error_handler(Cda_Def *cursor);
int ora_c_character_type (void);
int ora_c_integer_type (void);
int ora_c_integer_16_type (void);
int ora_c_integer_64_type (void);
int ora_c_float_type (void);
int ora_c_real_type (void);
int ora_c_boolean_type (void);
int ora_c_string_type (void);
int ora_c_wstring_type (void);
int ora_c_date_type (void);


#ifdef __cplusplus
}
#endif

#endif /* _ORACLE_H_ */
