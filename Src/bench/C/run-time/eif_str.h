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

/* Numeric code of 'i'-th EIF_CHARACTER in 'str' */
#define str_code(str,i) (EIF_INTEGER) ((EIF_CHARACTER *) (str))[((EIF_INTEGER)(i))-1]

RT_LNK int str_left(register EIF_CHARACTER *str, int length);
RT_LNK void str_ljustify(register EIF_CHARACTER *str, int length, int capacity);
RT_LNK void str_rjustify(register EIF_CHARACTER *str, int length, int capacity);
RT_LNK void str_cjustify(register EIF_CHARACTER *str, int length, int capacity);
RT_LNK int str_right(register EIF_CHARACTER *str, int length);
RT_LNK int str_search(EIF_CHARACTER *str, EIF_CHARACTER c, int start, int len);
RT_LNK int str_last_search (EIF_CHARACTER *str, EIF_CHARACTER c, int start_index_from_end);
RT_LNK void str_replace(EIF_CHARACTER *str, EIF_CHARACTER *new_str, int string_length, int new_len, int start, int end);
RT_LNK void str_insert(EIF_CHARACTER *str, EIF_CHARACTER *new_str, int string_length, int new_len, int idx);
RT_LNK void str_blank(EIF_CHARACTER *str, int n);
RT_LNK void str_fill(EIF_CHARACTER *str, int n, EIF_CHARACTER c);
RT_LNK void str_tail(register EIF_CHARACTER *str, register int n, int l);
RT_LNK void str_take(EIF_CHARACTER *str, EIF_CHARACTER *new_str, long int start, long int end);
RT_LNK void str_lower(register EIF_CHARACTER *str, int l);
RT_LNK void str_lower(register EIF_CHARACTER *str, int l);
RT_LNK void str_upper(register EIF_CHARACTER *str, int l);
RT_LNK int str_cmp(register EIF_CHARACTER *str1, register EIF_CHARACTER *str2, int l1, int l2);
RT_LNK void str_cpy(EIF_CHARACTER *to, EIF_CHARACTER *from, int len);
RT_LNK void str_cprepend(EIF_CHARACTER *str, EIF_CHARACTER c, int l);
RT_LNK void str_append(EIF_CHARACTER *str, EIF_CHARACTER *new_str, int string_length, int new_len);
RT_LNK void str_rmchar(EIF_CHARACTER *str, int l, int i);
RT_LNK int str_rmall(EIF_CHARACTER *str, EIF_CHARACTER c, int l);
RT_LNK void str_mirror(register EIF_CHARACTER *str, register EIF_CHARACTER *new_str, register int len);
RT_LNK void str_reverse(register EIF_CHARACTER *str, int len);
RT_LNK long str_atoi(EIF_CHARACTER *str, int length);
RT_LNK float str_ator(EIF_CHARACTER *str, int length);
RT_LNK double str_atod(EIF_CHARACTER *str, int length);
RT_LNK EIF_BOOLEAN str_isi(EIF_CHARACTER *str, EIF_INTEGER length);
RT_LNK EIF_BOOLEAN str_isr(EIF_CHARACTER *str, EIF_INTEGER length);
RT_LNK EIF_BOOLEAN str_isd(EIF_CHARACTER *str, EIF_INTEGER length);

#ifdef __cplusplus
}
#endif

#endif

