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

RT_LNK int str_left(register char *str, int length);
RT_LNK void str_ljustify(register char *str, int length, int capacity);
RT_LNK void str_rjustify(register char *str, int length, int capacity);
RT_LNK void str_cjustify(register char *str, int length, int capacity);
RT_LNK int str_right(register char *str, int length);
RT_LNK int str_search(char *str, char c, int start, int len);
RT_LNK int str_last_search (char *str, char c, int start_index_from_end);
RT_LNK void str_replace(char *str, char *new_str, int string_length, int new_len, int start, int end);
RT_LNK void str_insert(char *str, char *new_str, int string_length, int new_len, int idx);
RT_LNK EIF_INTEGER str_code(EIF_CHARACTER *str, EIF_INTEGER i);
RT_LNK void str_blank(char *str, int n);
RT_LNK void str_fill(char *str, int n, char c);
RT_LNK void str_tail(register char *str, register int n, int l);
RT_LNK void str_take(char *str, char *new_str, long int start, long int end);
RT_LNK void str_lower(register char *str, int l);
RT_LNK void str_lower(register char *str, int l);
RT_LNK void str_upper(register char *str, int l);
RT_LNK int str_cmp(register char *str1, register char *str2, int l1, int l2);
RT_LNK void str_cpy(char *to, char *from, int len);
RT_LNK void str_cprepend(char *str, char c, int l);
RT_LNK void str_append(char *str, char *new_str, int string_length, int new_len);
RT_LNK void str_rmchar(char *str, int l, int i);
RT_LNK int str_rmall(char *str, char c, int l);
RT_LNK void str_mirror(register char *str, register char *new_str, register int len);
RT_LNK void str_reverse(register char *str, int len);
RT_LNK long str_atoi(char *str, int length);
RT_LNK float str_ator(char *str, int length);
RT_LNK double str_atod(char *str, int length);
RT_LNK EIF_BOOLEAN str_isi(char *str, EIF_INTEGER length);
RT_LNK EIF_BOOLEAN str_isr(char *str, EIF_INTEGER length);
RT_LNK EIF_BOOLEAN str_isd(char *str, EIF_INTEGER length);
RT_LNK long str_len(char *str);

#ifdef __cplusplus
}
#endif

#endif

