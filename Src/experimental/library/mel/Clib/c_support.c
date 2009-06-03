/*
 * Functions to deal with low level C.
 */

#include "eif_macros.h"

EIF_BOOLEAN and_masks(EIF_INTEGER mask1, EIF_INTEGER mask2)
{
	return (EIF_BOOLEAN) ((int) mask1 & (int) mask2);
}
