/*

 ######  #####   #####    ####   #####           #    #
 #       #    #  #    #  #    #  #    #          #    #
 #####   #    #  #    #  #    #  #    #          ######
 #       #####   #####   #    #  #####    ###    #    #
 #       #   #   #   #   #    #  #   #    ###    #    #
 ######  #    #  #    #   ####   #    #   ###    #    #

*/

extern void esys();				/* Raise 'Operating system error' exception */
extern void eio();				/* Raise 'I/O error' exception */
extern char *error_tag();		/* English description out of errno code */

#ifdef HAS_SYS_ERRLIST
	extern int sys_nerr;            /* Size of sys_errlist[] */
	extern char *sys_errlist[];     /* Maps error code to string */
#endif

