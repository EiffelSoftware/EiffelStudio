/////////////////////////////////////////////////////////////////////////////
//
//     FLAGS.H       Copyright (c) 1997 by ISE
//
//     Version:       0.00
//
//     Eiffel OLE 2 Library
//
//     Header file used in EOLE_FLAGS.
//

#include <oaidl.h>

#ifdef EIF_BORLAND
#	define TYPEFLAG_FAGGREGATABLE 1024 /* 0x400 */
#	define TYPEFLAG_FDISPATCHABLE 4096 /* 0x1000 */
#	define TYPEFLAG_FREPLACEABLE 2048 /* 0x800 */
#endif /* EIF_BORLAND */

#ifndef __FLAGS_H_INC__
#define __FLAGS_H_INC__

#define c_and(int1, int2) ((int)int1 && (int)int2)

#endif
/////// END OF FILE /////////////////////////////////////////////////////////
