/*
 #####    ####    ####   #        ####    #####  #####           #    #
 #    #  #    #  #    #  #       #          #    #    #          #    #
 #####   #    #  #    #  #        ####      #    #    #          ######
 #    #  #    #  #    #  #            #     #    #####    ###    #    #
 #    #  #    #  #    #  #       #    #     #    #   #    ###    #    #
 #####    ####    ####   ######   ####      #    #    #   ###    #    #

	Externals for class BOOL_STRING.
*/

#ifndef _eif_boolstr_h_
#define _eif_boolstr_h_

#ifdef __cplusplus
extern "C" {
#endif

RT_LNK char *bl_str_set(char *a1, int s, int n);
RT_LNK char *bl_str_and(char *a1, char *a2, char *a3, int s);
RT_LNK char *bl_str_or(char *a1, char *a2, char *a3, int s);
RT_LNK char *bl_str_xor(char *a1, char *a2, char *a3, int s);
RT_LNK char *bl_str_not(char *a1, char *a2, int s);
RT_LNK char *bl_str_shiftr(char *a1, char *a2, int s, int n);
RT_LNK char *bl_str_shiftl(char *a1, char *a2, int s, int n);

#ifdef __cplusplus
}
#endif

#endif

