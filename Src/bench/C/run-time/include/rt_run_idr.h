/*
--|----------------------------------------------------------------
--| Eiffel runtime header file
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|     http://www.eiffel.com
--|----------------------------------------------------------------
*/

/*
	Internal data representation.
*/

#include "../idrs/idrs.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef EIF_THREADS
extern void eif_run_idr_thread_init (void);
#else
extern char *idr_temp_buf;				/*temporary buffer for idr float and double */
#endif

extern void run_idr_init (size_t idrf_size, int type);
extern void run_idr_destroy (void);
extern void check_capacity (IDR *bu, size_t size);
extern void idr_flush (void);
extern void ridr_multi_char (EIF_CHARACTER *obj, size_t num);
extern void widr_multi_char (EIF_CHARACTER *obj, size_t num);
extern void ridr_multi_any (char *obj, size_t num);
extern void widr_multi_any (char *obj, size_t num);
extern void ridr_multi_int8 (EIF_INTEGER_8 *obj, size_t num);
extern void widr_multi_int8 (EIF_INTEGER_8 *obj, size_t num);
extern void ridr_multi_int16 (EIF_INTEGER_16 *obj, size_t num);
extern void widr_multi_int16 (EIF_INTEGER_16 *obj, size_t num);
extern void ridr_multi_int32 (EIF_INTEGER_32 *obj, size_t num);
extern void widr_multi_int32 (EIF_INTEGER_32 *obj, size_t num);
extern void ridr_multi_int64 (EIF_INTEGER_64 *obj, size_t num);
extern void widr_multi_int64 (EIF_INTEGER_64 *obj, size_t num);
extern void ridr_norm_int (uint32 *obj);
extern void widr_norm_int (uint32 *obj);
extern void ridr_multi_float (EIF_REAL_32 *obj, size_t num);
extern void widr_multi_float (EIF_REAL_32 *obj, size_t num);
extern void ridr_multi_double (EIF_REAL_64 *obj, size_t num);
extern void widr_multi_double (EIF_REAL_64 *obj, size_t num);
extern void ridr_multi_bit (struct bit *obj, size_t num, size_t elm_siz);
extern void widr_multi_bit (struct bit *obj, size_t num, uint32 len, size_t elm_siz);
extern int idr_read_line(char *bu, size_t max_size);

#ifdef __cplusplus
}
#endif

