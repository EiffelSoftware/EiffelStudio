/////////////////////////////////////////////////////////////////////////////
//
// ULARGE_INTEGER support
//
/////////////////////////////////////////////////////////////////////////////

#include "eifole.h"
#include "eif_cecil.h"
#ifndef _WINDOWS_
#include <windows.h>
#endif

/////////////////////////////////////////////////////////////////////////////
//
// eole2_large_integer_allocate
//
// Purpose:
//    Allocate a real ULARGE_INTEGER structure.
//
// Parameters:
//    None.
//
// Return Value:
//    Pointer to alocated ULARGE_INTEGER data structure.
//

extern "C" EIF_POINTER eole2_large_integer_allocate (void) {
   return (EIF_POINTER)malloc (sizeof (ULARGE_INTEGER));
}


/////////////////////////////////////////////////////////////////////////////
//
// eole2_large_integer_set_low_part
//
// Purpose:
//    Set the 'LowPart' member of the ULARGE_INTEGER structure to the specified value.
//
// Parameters:
//    _this    EIF_POINTER pointer to the ULARGE_INTEGER structure
//    low_part       EIF_INTEGER value to set.
//
// Return Value:
//    None.
//

extern "C" void eole2_large_integer_set_low_part (EIF_POINTER _this, EIF_INTEGER low_part) {
#ifdef EIF_BORLAND
   ((ULARGE_INTEGER FAR *)_this)->u.LowPart = (ULONG)low_part;
#else
   ((ULARGE_INTEGER FAR *)_this)->LowPart = (ULONG)low_part;
#endif /* EIF_BORLAND */
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_large_integer_set_high_part
//
// Purpose:
//    Set the 'HighPart' member of the ULARGE_INTEGER structure to the specified value.
//
// Parameters:
//    _this    EIF_POINTER pointer to the ULARGE_INTEGER structure
//    high_part       EIF_INTEGER value to set.
//
// Return Value:
//    None.
//

extern "C" void eole2_large_integer_set_high_part (EIF_POINTER _this, EIF_INTEGER high_part) {
#ifdef EIF_BORLAND
   ((ULARGE_INTEGER FAR *)_this)->u.HighPart = (LONG)high_part;
#else
   ((ULARGE_INTEGER FAR *)_this)->HighPart = (LONG)high_part;
#endif /* EIF_BORLAND */
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_large_integer_get_low_part
//
// Purpose:
//    Obtain the value of 'LowPart' member of the ULARGE_INTEGER structure.
//
// Parameters:
//    _this    EIF_POINTER pointer to the ULARGE_INTEGER structure.
//
// Return Value:
//    Value of the 'LowPart' member
//

extern "C" EIF_INTEGER eole2_large_integer_get_low_part (EIF_POINTER _this) {
#ifdef EIF_BORLAND
   return (EIF_INTEGER)(((ULARGE_INTEGER FAR *)_this)->u.LowPart);
#else
   return (EIF_INTEGER)(((ULARGE_INTEGER FAR *)_this)->LowPart);
#endif /* EIF_BORLAND */
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_large_integer_get_high_part
//
// Purpose:
//    Obtain the value of 'HighPart' member of the ULARGE_INTEGER structure.
//
// Parameters:
//    _this    EIF_POINTER pointer to the ULARGE_INTEGER structure.
//
// Return Value:
//    Value of the 'HighPart' member
//

extern "C" EIF_INTEGER eole2_large_integer_get_high_part (EIF_POINTER _this) {
#ifdef EIF_BORLAND
   return (EIF_INTEGER)(((ULARGE_INTEGER FAR *)_this)->u.HighPart);
#else
   return (EIF_INTEGER)(((ULARGE_INTEGER FAR *)_this)->HighPart);
#endif /* EIF_BORLAND */
}

