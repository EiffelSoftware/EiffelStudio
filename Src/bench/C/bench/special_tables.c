#include <stdio.h>
#include <stdlib.h>
#include "special_tables.h"

/* Feature computed has a polymorphic call in current context*/
#define IS_POLYMORPHIC	0x03

/* Feature computed has a static call in current context*/
#define NOT_POLYMORPHIC	0x02

/* Feature which is deferred */
#define IS_DEFERRED		0x01

#ifdef DEBUG
struct poly_debug {
	int size;
	unsigned char* area;
};
#endif

/* Allocate table */
unsigned char *table_malloc (int nb_classes) {
	unsigned char *area;
	int logical_size;
#ifdef DEBUG
	struct poly_debug *my_poly_table;
	my_poly_table = (struct poly_debug *) malloc (sizeof (struct poly_debug));
#endif

	logical_size = ((nb_classes >> 2) + 1) * sizeof (unsigned char);
	area = (unsigned char *) malloc (logical_size);
	area = (unsigned char *) memset ((void *) area, 0, logical_size);

#ifdef debug
	my_poly_table->area = area;
	my_poly_table->size = logical_size;
	return (unsigned char *) my_poly_table;
#else
	return area;
#endif
}

void table_free (unsigned char *area)
{
	if (area) {
#ifdef DEBUG
		free (((struct poly_debug *)area)->area);
		free ((struct poly_debug *) area);
#else
		free (area);
#endif
	}
}
	
#define set_status(area,type_id,flag)	\
	area[type_id >> 2] |= ((unsigned char) flag << ((type_id & 0x00000003) << 1))

#define get_status(area, type_id)	\
	((unsigned char) ((area [type_id >> 2]) >> ((type_id & 0x00000003) << 1)))

void put_value (unsigned char *area, int type_id, EIF_BOOLEAN v)
{
		/* Now we compute the mask to which is going to be used to set the entry
		 * area[index] to mark the status of the `type_id'
		 * where `index = type_id >> 2' position of `type_id' in in `area'
		 * 
		 * (type_id & 0x00000003 is the rest of `type_id / 4'
		 * when we do << 1 we multiply by two (because we are saving two informations
		 * at the same time 
		 * 
		 * Then we shift IS_POLYMORPHIC or NOT_POLYMORPHIC to be in front of the
		 * correct offset in area[index] and we add the new value to area[index]
		 */
	if (v == EIF_TRUE)
			/* It is a polymorphic call */
		set_status (area, type_id, IS_POLYMORPHIC);
	else
		set_status (area, type_id, NOT_POLYMORPHIC);

#ifdef DEBUG
	if ((type_id >> 2) > (((struct poly_debug *) area)->size))
		printf ("Access error: size max is %d, accessed item is %d\n", (((struct poly_debug *) area)->size, type_id >> 2));
#endif
}


EIF_INTEGER get_value (unsigned char *area, int type_id)
{
	register unsigned char item = area [type_id >> 2];
	register int offset = (type_id & 0x00000003) << 1;

#ifdef DEBUG
	if ((type_id >> 2) > (((struct poly_debug *) area)->size))
		printf ("Access error: size max is %d, accessed item is %d\n", (((struct poly_debug *) area)->size, type_id >> 2));
#endif

	if (item & (1 << (offset + 1))) {
		if (item & (1 << offset))
			return (int) IS_POLYMORPHIC;
		else
			return (int) NOT_POLYMORPHIC;
	} else
			/* Not yet computed in the table */
		return -1;
}
