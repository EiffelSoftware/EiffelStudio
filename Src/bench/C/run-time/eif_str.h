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

#include "eif_portable.h"

#ifdef __cplusplus
extern "C" {
#endif

RT_LNK EIF_INTEGER str_left(register EIF_CHARACTER *str, EIF_INTEGER length);
RT_LNK void str_ljustify(register EIF_CHARACTER *str, EIF_INTEGER length, EIF_INTEGER capacity);
RT_LNK void str_rjustify(register EIF_CHARACTER *str, EIF_INTEGER length, EIF_INTEGER capacity);
RT_LNK void str_cjustify(register EIF_CHARACTER *str, EIF_INTEGER length, EIF_INTEGER capacity);
RT_LNK EIF_INTEGER str_right(register EIF_CHARACTER *str, EIF_INTEGER length);
RT_LNK void str_replace(EIF_CHARACTER *str, EIF_CHARACTER *new_str, EIF_INTEGER string_length, EIF_INTEGER new_len, EIF_INTEGER start, EIF_INTEGER end);
RT_LNK void str_insert(EIF_CHARACTER *str, EIF_CHARACTER *new_str, EIF_INTEGER string_length, EIF_INTEGER new_len, EIF_INTEGER idx);
RT_LNK void str_cprepend(EIF_CHARACTER *str, EIF_CHARACTER c, EIF_INTEGER l);
RT_LNK void str_rmchar(EIF_CHARACTER *str, EIF_INTEGER l, EIF_INTEGER i);
RT_LNK EIF_INTEGER str_rmall(EIF_CHARACTER *str, EIF_CHARACTER c, EIF_INTEGER l);
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

