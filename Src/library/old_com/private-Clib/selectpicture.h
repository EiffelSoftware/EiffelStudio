/////////////////////////////////////////////////////////////////////////////
//
//     SELECTPICTURE.H       Copyright (c) 1997 by ISE
//
//     Version:       0.00
//
//     EiffelCOM Library
//
//     Main header file
//
//     Notes:
//       None.
//

#ifndef SELECT_PICTURE
#define SELECT_PICTURE

#ifdef EIF_BORLAND

typedef UINT OLE_HANDLE;

#else
#	include <ocidl.h>
#endif /* EIF_BORLAND */

struct SelectPicture {
	HDC hdcOut;
	OLE_HANDLE hbmpOut;
};

#endif /* SELECT_PICTURE */