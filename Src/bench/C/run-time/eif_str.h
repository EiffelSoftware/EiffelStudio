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

RT_LNK EIF_INTEGER str_left(register EIF_CHARACTER *str, EIF_INTEGER length);
RT_LNK void str_ljustify(register EIF_CHARACTER *str, EIF_INTEGER length, EIF_INTEGER capacity);
RT_LNK void str_rjustify(register EIF_CHARACTER *str, EIF_INTEGER length, EIF_INTEGER capacity);
RT_LNK void str_cjustify(register EIF_CHARACTER *str, EIF_INTEGER length, EIF_INTEGER capacity);
RT_LNK EIF_INTEGER str_right(register EIF_CHARACTER *str, EIF_INTEGER length);
RT_LNK EIF_INTEGER str_search(EIF_CHARACTER *str, EIF_CHARACTER c, EIF_INTEGER start, EIF_INTEGER len);
RT_LNK EIF_INTEGER str_last_search (EIF_CHARACTER *str, EIF_CHARACTER c, EIF_INTEGER start_index_from_end);
RT_LNK void str_replace(EIF_CHARACTER *str, EIF_CHARACTER *new_str, EIF_INTEGER string_length, EIF_INTEGER new_len, EIF_INTEGER start, EIF_INTEGER end);
RT_LNK void str_insert(EIF_CHARACTER *str, EIF_CHARACTER *new_str, EIF_INTEGER string_length, EIF_INTEGER new_len, EIF_INTEGER idx);
RT_LNK void str_blank(EIF_CHARACTER *str, EIF_INTEGER n);
RT_LNK void str_fill(EIF_CHARACTER *str, EIF_INTEGER n, EIF_CHARACTER c);
RT_LNK void str_tail(register EIF_CHARACTER *str, register EIF_INTEGER n, EIF_INTEGER l);
RT_LNK void str_take(EIF_CHARACTER *str, EIF_CHARACTER *new_str, EIF_INTEGER start, EIF_INTEGER end);
RT_LNK void str_lower(register EIF_CHARACTER *str, EIF_INTEGER l);
RT_LNK void str_lower(register EIF_CHARACTER *str, EIF_INTEGER l);
RT_LNK void str_upper(register EIF_CHARACTER *str, EIF_INTEGER l);
RT_LNK EIF_INTEGER str_cmp(register EIF_CHARACTER *str1, register EIF_CHARACTER *str2, EIF_INTEGER l1, EIF_INTEGER l2);
RT_LNK void str_cpy(EIF_CHARACTER *to, EIF_CHARACTER *from, EIF_INTEGER len);
RT_LNK void str_cprepend(EIF_CHARACTER *str, EIF_CHARACTER c, EIF_INTEGER l);
RT_LNK void str_append(EIF_CHARACTER *str, EIF_CHARACTER *new_str, EIF_INTEGER string_length, EIF_INTEGER new_len);
RT_LNK void str_rmchar(EIF_CHARACTER *str, EIF_INTEGER l, EIF_INTEGER i);
RT_LNK EIF_INTEGER str_rmall(EIF_CHARACTER *str, EIF_CHARACTER c, EIF_INTEGER l);
RT_LNK void str_mirror(register EIF_CHARACTER *str, register EIF_CHARACTER *new_str, register EIF_INTEGER len);
RT_LNK void str_reverse(register EIF_CHARACTER *str, EIF_INTEGER len);
RT_LNK EIF_INTEGER str_atoi(EIF_CHARACTER *str, EIF_INTEGER length);
RT_LNK EIF_REAL str_ator(EIF_CHARACTER *str, EIF_INTEGER length);
RT_LNK EIF_DOUBLE str_atod(EIF_CHARACTER *str, EIF_INTEGER length);
RT_LNK EIF_BOOLEAN str_isi(EIF_CHARACTER *str, EIF_INTEGER length);
RT_LNK EIF_BOOLEAN str_isr(EIF_CHARACTER *str, EIF_INTEGER length);
RT_LNK EIF_BOOLEAN str_isd(EIF_CHARACTER *str, EIF_INTEGER length);

#ifdef __cplusplus
}
#endif

#endif

