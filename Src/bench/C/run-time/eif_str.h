/*

 ######     #    ######           ####    #####  #####           #    #
 #          #    #               #          #    #    #          #    #
 #####      #    #####            ####      #    #    #          ######
 #          #    #                    #     #    #####    ###    #    #
 #          #    #               #    #     #    #   #    ###    #    #
 ######     #    #      #######   ####      #    #    #   ###    #    #

	Externals for class STRING
*/

#ifndef _eif_str_h_
#define _eif_str_h_

#ifdef __cplusplus
extern "C" {
#endif

#include "eif_portable.h"

extern int str_left(register char *str, int length);
extern void str_ljustify(register char *str, int length, int capacity);
extern void str_rjustify(register char *str, int length, int capacity);
extern void str_cjustify(register char *str, int length, int capacity);
extern int str_right(register char *str, int length);
extern int str_search(char *str, char c, int start, int len);
extern void str_replace(char *str, char *new, int string_length, int new_len, int start, int end);
extern void str_insert(char *str, char *new, int string_length, int new_len, int idx);
extern EIF_INTEGER str_code(EIF_CHARACTER *str, EIF_INTEGER i);
extern void str_blank(char *str, int n);
extern void str_fill(char *str, int n, char c);
extern void str_tail(register char *str, register int n, int l);
extern void str_take(char *str, char *new, long int start, long int end);
extern void str_lower(register char *str, int l);
extern void str_lower(register char *str, int l);
extern void str_upper(register char *str, int l);
extern int str_cmp(register char *str1, register char *str2, int l1, int l2);
extern void str_cpy(char *to, char *from, int len);
extern void str_cprepend(char *str, char c, int l);
extern void str_append(char *str, char *new, int string_length, int new_len);
extern void str_rmchar(char *str, int l, int i);
extern int str_rmall(char *str, char c, int l);
extern void str_mirror(register char *str, register char *new, register int len);
extern void str_reverse(register char *str, int len);
extern long str_atoi(char *str, int length);
extern float str_ator(char *str, int length);
extern double str_atod(char *str, int length);
extern EIF_BOOLEAN str_isi(char *str, EIF_INTEGER length);
extern EIF_BOOLEAN str_isr(char *str, EIF_INTEGER length);
extern EIF_BOOLEAN str_isd(char *str, EIF_INTEGER length);
extern long str_len(char *str);

#ifdef __cplusplus
}
#endif

#endif

