/*
 * Functions to deal with low level C stuff.
 */

#include "macros.h"

EIF_BOOLEAN and_masks(mask1, mask2)
EIF_INTEGER mask1;
EIF_INTEGER mask2;
{
	return (EIF_BOOLEAN) ((int) mask1 & (int) mask2);
}
