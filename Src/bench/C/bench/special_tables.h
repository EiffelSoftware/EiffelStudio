#include "eif_eiffel.h"

#ifdef DEBUG
struct poly_debug {
	int size;
	unsigned char* area;
};

#define AREA_TYPE struct poly_debug *
#else
#define AREA_TYPE unsigned char *
#endif

AREA_TYPE table_malloc (int nb_classes);
/* initialise the table of a poly_table */
/* arguments: maximum number of class_type_id in current polymorphic table */

void table_free (AREA_TYPE area);
/* free the structure */

void put_value (AREA_TYPE area, int type_id, EIF_BOOLEAN v);
/* put the flag `v' corresponding to the type_id */

EIF_INTEGER get_value (AREA_TYPE  area, int type_id);
/* give a boolean saying if the current call is a polymorphic one or not */
