/*

    #    #####   #####           #####   #    #  #    #         #
    #    #    #  #    #          #    #  #    #  ##   #         #
    #    #    #  #    #          #    #  #    #  # #  #         #
    #    #    #  #####           #####   #    #  #  # #  ###    #####
    #    #    #  #   #           #   #   #    #  #   ##  ###    #    #
    #    #####   #    # #######  #    #   ####   #    #  ###    #    #

	Internal data representation.

*/

#ifdef __cplusplus
extern "C" {
#endif
 
extern void run_idr_init ();
extern void run_idr_destroy ();
extern void check_capacity ();
extern void idr_flush ();
extern void ridr_multi_char ();
extern void widr_multi_char ();
extern void ridr_multi_any ();
extern void widr_multi_any ();
extern void ridr_multi_int ();
extern void widr_multi_int ();
extern void ridr_norm_int ();
extern void widr_norm_int ();
extern void ridr_multi_float ();
extern void widr_multi_float ();
extern void ridr_multi_double ();
extern void widr_multi_double ();
extern void ridr_multi_bit ();
extern void widr_multi_bit ();
extern char *idr_temp_buf;				/*temporary buffer for idr float and double */
extern int idr_read_line();

#ifdef __cplusplus
}
#endif

