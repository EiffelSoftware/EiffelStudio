/*
--|----------------------------------------------------------------
--| EiffelStore: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1995, Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------

	Routines to implement class EXT_INTERNAL
*/
/*
	Date: "$Date$"
	Revision: "$Revision$"
*/
#include "eiffel.h"
#include "config.h"
#include "malloc.h"
#include "garcol.h"
#include "struct.h"
#include "out.h"
#include "macros.h"         /* For macro LNGOFF */
#include "plug.h"

#ifndef TRUE
#define TRUE 1
#endif
#ifndef FALSE
#define FALSE 0
#endif

/*
 * Routine definitions
 */
void c_mark (obj)
     EIF_OBJ obj;
{
	union overhead *zone = HEADER(obj);
	uint32 flags;

	flags = zone->ov_flags;
	flags |= EO_STORE;
	zone->ov_flags = flags;
}

void c_nullmark (obj)
     EIF_OBJ obj;
{
	union overhead *zone = HEADER(obj);
	uint32 flags;

	flags = zone->ov_flags;
	flags &= ~EO_STORE;
	zone->ov_flags = flags;
}

EIF_BOOLEAN c_is_marked (obj)
     EIF_OBJ obj;
{
	union overhead *zone = HEADER(obj);
	uint32 flags;

	flags = zone->ov_flags;
	return ((flags & EO_STORE)?TRUE:FALSE);
}

extern int scount;

EIF_INTEGER c_nb_classes ()
{
	return (scount);
}

EIF_BOOLEAN c_is_ref_array (obj)
EIF_OBJ obj;
{
	union overhead *zone = HEADER(obj);
	uint32 flags;

	flags = zone -> ov_flags;
	return (EIF_BOOLEAN) ((flags & EO_REF)?TRUE:FALSE);
}
