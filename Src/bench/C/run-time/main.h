/*

 #    #    ##       #    #    #          #    #
 ##  ##   #  #      #    ##   #          #    #
 # ## #  #    #     #    # #  #          ######
 #    #  ######     #    #  # #   ###    #    #
 #    #  #    #     #    #   ##   ###    #    #
 #    #  #    #     #    #    #   ###    #    #

*/

#ifdef __cplusplus
extern "C" {
#endif

extern void dinterrupt();
extern void dserver();
extern int in_assertion;
extern char *ename;				/* Name of the Eiffel program running */
extern int cc_for_speed;		/* Optimized for speed or for memory */
extern int scount;				/* Maximum dtype */

/* Prototypes of routines/variables needed in main.c */
#ifdef EIF_WIN_31
extern int _argc;
extern char **_argv;
#endif

#ifdef __cplusplus
}
#endif

