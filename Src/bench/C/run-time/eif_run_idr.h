/*

    #    #####   #####           #####   #    #  #    #         #    #
    #    #    #  #    #          #    #  #    #  ##   #         #    #
    #    #    #  #    #          #    #  #    #  # #  #         #    #
    #    #    #  #####           #####   #    #  #  # #  ###    ######
    #    #    #  #   #           #   #   #    #  #   ##  ###    #    #
    #    #####   #    #  ######  #    #   ####   #    #  ###    #    #

	Internal data representation.

*/

#include "../idrs/idrs.h"		/* %%zs added */ /* %%zs review */

#ifdef __cplusplus
extern "C" {
#endif

extern void run_idr_init (long idrf_size, EIF_BOOLEAN is_limited_by_short);
extern void run_idr_destroy (void);
extern void check_capacity (IDR *bu, int size);
extern void idr_flush (void);
extern void ridr_multi_char (char *obj, int num);
extern void widr_multi_char (char *obj, int num);
extern void ridr_multi_any (char *obj, int num);
extern void widr_multi_any (char *obj, int num);
extern void ridr_multi_int (long int *obj, int num);
extern void widr_multi_int (long int *obj, int num);
extern void ridr_norm_int (uint32 *obj);
extern void widr_norm_int (uint32 *obj);
extern void ridr_multi_float (float *obj, int num);
extern void widr_multi_float (float *obj, int num);
extern void ridr_multi_double (double *obj, int num);
extern void widr_multi_double (double *obj, int num);
extern void ridr_multi_bit (struct bit *obj, int num, long int elm_siz);
extern void widr_multi_bit (struct bit *obj, int num, uint32 len, int elm_siz);
extern char *idr_temp_buf;				/*temporary buffer for idr float and double */
extern int idr_read_line(char *bu, int max_size);

#ifdef __cplusplus
}
#endif

