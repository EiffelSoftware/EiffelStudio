/*

  ####   ######  #       ######   ####    #####          #    #
 #       #       #       #       #    #     #            #    #
  ####   #####   #       #####   #          #            ######
      #  #       #       #       #          #     ###    #    #
 #    #  #       #       #       #    #     #     ###    #    #
  ####   ######  ######  ######   ####      #     ###    #    #

	Declarations for select functions.
*/

#ifndef _select_h_
#define _select_h_

/* List of error number which may be reported by the select routines. This list
 * must be kept in sync with the error arrays.
 */
#define S_FDESC		1				/* Invalid file descriptor */
#define S_CALBAK	2				/* Invalid call back address */
#define S_CALSET	3				/* A callback is already set */
#define S_NOCALBAK	4				/* No callback was set */
#define S_SELECT	5				/* Select system call failed */
#define S_NOFILE	6				/* No more file to select on */

extern int s_errno;					/* Error number */

/* Function declarations */
extern int add_input();				/* Add file descriptor input function */
extern void (*new_callback())();	/* Change call back for a given fd */
extern void (*rem_input())();		/* Remove input selection */
extern char *s_strerror();			/* Return description of last error */
extern char *s_strname();			/* Return symbolic name of last error */
extern int has_input();				/* Check whether file is still selected */
extern void clear_fd();				/* Clear selection in select result mask */
extern int do_select();				/* Run the select system call */

#endif
