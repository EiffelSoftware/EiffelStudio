/*

  ####   ######    ##    #####    ####   #    #           ####
 #       #        #  #   #    #  #    #  #    #          #    #
  ####   #####   #    #  #    #  #       ######          #
      #  #       ######  #####   #       #    #   ###    #
 #    #  #       #    #  #   #   #    #  #    #   ###    #    #
  ####   ######  #    #  #    #   ####   #    #   ###     ####

	Search table (like an H table, but no value array).
*/

#include "config.h"
#include "portable.h"
#include "search.h"
#include "tools.h"
#include "except.h"	/* for xcalloc(),cmalloc(),xfree(),enomem() */

#ifdef I_STRING
#include <string.h>
#else
#include <strings.h>
#endif

rt_public struct s_table *s_create(uint32 size)
{
	/* Returns new search table of size `size'. */

	uint32 real_size;
	char **keys;
	struct s_table *result;

	real_size = nprime(4 * size / 3);
	keys = (char **) xcalloc(real_size, sizeof(char *));
	if (keys == (char **) 0)
		enomem();
	result = (struct s_table *) cmalloc(sizeof(struct s_table));
	if (result == (struct s_table *) 0)
		enomem();
	result->s_size = real_size;
	result->s_keys = keys;
	result->s_count = 0;
	return result;
}

rt_public int s_put(struct s_table *tbl, char *object)
{
	/* Insert `object' in `h_table'. Return `S_CONFLICT' if already in it,
	 * otherwise return `S_OK'.
	 */

	int32 pos; 		/* Table position */

	pos = s_search(tbl,object);
	if (pos == S_FOUND)
		return S_CONFLICT;
	else {
		if ((tbl->s_size * 80) <= (tbl->s_count * 100)) {
			s_resize(tbl);
			pos = s_search(tbl,object);
		}
		tbl->s_keys[pos] = object;
		tbl->s_count++;
		return S_OK;
	}
}

rt_public int32 s_search(struct s_table *tbl, char *object)
{
	/* Internal search of `object' in `tbl'. Return S_FOUND if found, otherwise
	 * position where to insert it.
	 */

	int key = ((int) object) - 1;					/* Key for `object' */
	register1 uint32 position;
	register2 uint32 increment;
	register4 uint32 size = tbl->s_size;			/* Table size */
	register3 char **keys = tbl->s_keys;			/* Table keys */
	char *old_key;

	increment = 1 + (key % (size - 1));
	for (position = key % size; ; position = (position + increment) % size)  {
		old_key = keys[position];
		if (old_key == (char *) 0)
			return position;			/* `object' not found */
		else if (old_key == object)
			return S_FOUND;				/* `object' found */
	}
}

rt_public void s_resize(register struct s_table *tbl)
{
	/* Resize `tbl' to a bigger size */

	int32 i, size;
	register3 struct s_table *new;
	register2 char *one_key;
	register1 char **keys = tbl->s_keys;

	size = tbl->s_size;
	new = s_create(3 * size / 2);
	for(i = 0; i < size; i++) {			/* Iteration on keys of `tbl' */
		one_key = keys[i];
		if (one_key != (char *) 0)
			s_put(new,one_key);
	}
	xfree(tbl->s_keys);						/* Free old keys */
	bcopy(new,tbl,sizeof(struct s_table));	/* Copy new descriptor */
	xfree(new);								/* Free temporary descriptor */
}

