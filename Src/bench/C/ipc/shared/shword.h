/*

  ####   #    #  #    #   ####   #####   #####           #    #
 #       #    #  #    #  #    #  #    #  #    #          #    #
  ####   ######  #    #  #    #  #    #  #    #          ######
      #  #    #  # ## #  #    #  #####   #    #   ###    #    #
 #    #  #    #  ##  ##  #    #  #   #   #    #   ###    #    #
  ####   #    #  #    #   ####   #    #  #####    ###    #    #

	Shell word parsing of a command string.

	From UNIX - should be checked for more complex expressions such as:

		command args "'a'"
		command args "'hello" "'godbye"
*/

#ifndef _shword_h
#define _shword_h

extern void shfree(void);				/* Free structure used by argv[] */
extern char **shword(char *cmd);			/* Parse command string and split into words */

#endif /* _shword_h */
