/*

  ####   #####    #####     #     ####   #    #           ####
 #    #  #    #     #       #    #    #  ##   #          #    #
 #    #  #    #     #       #    #    #  # #  #          #
 #    #  #####      #       #    #    #  #  # #   ###    #
 #    #  #          #       #    #    #  #   ##   ###    #    #
  ####   #          #       #     ####   #    #   ###     ####

		Option queries in workbench mode
*/

#include "config.h"
#include "struct.h"
#include "option.h"
#ifdef I_STRING
#include <string.h>
#else
#include <strings.h>
#endif

public int is_debug(st_type, key)
int st_type;
char *key;
{
	/* Is the debug option of the class of type `st_type' consistent
	 * with `key'.
	 */

	struct dbg_opt *debug_opt = &(eoption[st_type].debug_level);
	int i;
	int16 nb_keys;
	char **keys;

	if (debug_opt->debug_level == DB_NO)
		return 0;

	if (debug_opt->nb_keys == 0)
		return 1;

	if ((char *) 0 == key)
		return 0;
	else {
		nb_keys = debug_opt->nb_keys;
		keys = debug_opt->keys;
		for (i=0; i<nb_keys; i++)
			if (strcmp(key,keys[i]) == 0)
				return 1;
		return 0;
	}
}

