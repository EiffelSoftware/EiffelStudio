/*

 #####   #####    ####        #  ######   ####    #####          #    #
 #    #  #    #  #    #       #  #       #    #     #            #    #
 #    #  #    #  #    #       #  #####   #          #            ######
 #####   #####   #    #       #  #       #          #     ###    #    #
 #       #   #   #    #  #    #  #       #    #     #     ###    #    #
 #       #    #   ####    ####   ######   ####      #     ###    #    #

Dummy declarations for variables and routines called in the run-time but
generated in a system

*/

#ifdef __cplusplus
extern "C" {
#endif

extern int bit_dtype;			/* Dynamic type of BIT, E1/plug.c */
extern void einit();			/* System-dependent initializations, E1/einit.c */
extern void tabinit();			/* E1/einit.c */
extern int32 rcdt;				/* E1/einit.c */
extern int32 rcorigin;			/* E1/einit.c */
extern int32 rcoffset;			/* E1/einit.c */
extern int rcarg;				/* E1/einit.c */
extern EIF_BOOLEAN exception_stack_managed;	/* Is the stack managed (always True in workbench mode) */

#ifdef __cplusplus
}
#endif

