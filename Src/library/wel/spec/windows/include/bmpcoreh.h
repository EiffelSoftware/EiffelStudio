/*
 * BMPCOREH.H
 */

#ifndef __WEL_BITMAPCOREHEADER__
#define __WEL_BITMAPCOREHEADER__

#ifndef __WEL__
#	include <wel.h>
#endif

#ifdef __cplusplus
extern "C" {
#endif

#define cwel_bitmapcoreheader_set_size(_ptr_, _value_) (((BITMAPCOREHEADER *) _ptr_)->bcSize = (DWORD) (_value_))
#define cwel_bitmapcoreheader_set_width(_ptr_, _value_) (((BITMAPCOREHEADER *) _ptr_)->bcWidth = (WORD) (_value_))
#define cwel_bitmapcoreheader_set_height(_ptr_, _value_) (((BITMAPCOREHEADER *) _ptr_)->bcHeight = (WORD) (_value_))
#define cwel_bitmapcoreheader_set_planes(_ptr_, _value_) (((BITMAPCOREHEADER *) _ptr_)->bcPlanes = (WORD) (_value_))
#define cwel_bitmapcoreheader_set_bitcount(_ptr_, _value_) (((BITMAPCOREHEADER *) _ptr_)->bcBitCount = (WORD) (_value_))

// #define cwel_bitmapcoreheader_get_size(_ptr_) ((((BITMAPCOREHEADER *) _ptr_)->bcSize))
#define cwel_bitmapcoreheader_get_width(_ptr_) ((((BITMAPCOREHEADER *) _ptr_)->bcWidth))
#define cwel_bitmapcoreheader_get_height(_ptr_) ((((BITMAPCOREHEADER *) _ptr_)->bcHeight))
#define cwel_bitmapcoreheader_get_planes(_ptr_) ((((BITMAPCOREHEADER *) _ptr_)->bcPlanes))
#define cwel_bitmapcoreheader_get_bitcount(_ptr_) ((((BITMAPCOREHEADER *) _ptr_)->bcBitCount))

#ifdef __cplusplus
}
#endif

#endif /* __WEL_BITMAPCOREHEADER__ */

/*
--|-------------------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1995-1997, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
*/
