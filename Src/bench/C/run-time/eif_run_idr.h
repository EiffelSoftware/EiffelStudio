/*

    #    #####   #####           #####   #    #  #    #         #    #
    #    #    #  #    #          #    #  #    #  ##   #         #    #
    #    #    #  #    #          #    #  #    #  # #  #         #    #
    #    #    #  #####           #####   #    #  #  # #  ###    ######
    #    #    #  #   #           #   #   #    #  #   ##  ###    #    #
    #    #####   #    #  ######  #    #   ####   #    #  ###    #    #

	Internal data representation.

*/

#include "../idrs/idrs.h"

#ifdef __cplusplus
extern "C" {
#endif

extern void run_idr_init (long idrf_size, int type);
extern void run_idr_destroy (void);
extern void check_capacity (IDR *bu, int size);
extern void idr_flush (void);
extern void ridr_multi_char (EIF_CHARACTER *obj, int num);
extern void widr_multi_char (EIF_CHARACTER *obj, int num);
extern void ridr_multi_any (char *obj, int num);
extern void widr_multi_any (char *obj, int num);
extern void ridr_multi_int8 (EIF_INTEGER_8 *obj, int num);
extern void widr_multi_int8 (EIF_INTEGER_8 *obj, int num);
extern void ridr_multi_int16 (EIF_INTEGER_16 *obj, int num);
extern void widr_multi_int16 (EIF_INTEGER_16 *obj, int num);
extern void ridr_multi_int32 (EIF_INTEGER_32 *obj, int num);
extern void widr_multi_int32 (EIF_INTEGER_32 *obj, int num);
extern void ridr_multi_int64 (EIF_INTEGER_64 *obj, int num);
extern void widr_multi_int64 (EIF_INTEGER_64 *obj, int num);
extern void ridr_norm_int (uint32 *obj);
extern void widr_norm_int (uint32 *obj);
extern void ridr_multi_float (EIF_REAL *obj, int num);
extern void widr_multi_float (EIF_REAL *obj, int num);
extern void ridr_multi_double (EIF_DOUBLE *obj, int num);
extern void widr_multi_double (EIF_DOUBLE *obj, int num);
extern void ridr_multi_bit (struct bit *obj, int num, long int elm_siz);
extern void widr_multi_bit (struct bit *obj, int num, uint32 len, int elm_siz);
extern char *idr_temp_buf;				/*temporary buffer for idr float and double */
extern int idr_read_line(char *bu, int max_size);

#ifdef __cplusplus
}
#endif

