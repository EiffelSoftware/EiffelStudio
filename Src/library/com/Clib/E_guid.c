//--------------------------------------------------------------------------
//
//  EiffelCOM
//  Copyright (C) Interactive Software Engineering, 2001.
//
//  File:   E_guid.c
//
//  Contents:
//
//
//--------------------------------------------------------------------------


#include "ecom_guid.h"
#ifdef __cplusplus
  extern "C" {
#endif

//------------------------------------------------------------------
void ccom_generate_guid (GUID *guid)
{
  CoCreateGuid (guid);
}

EIF_POINTER ccom_guid_to_wide_string (GUID * guid)

{
  WCHAR * wide_string;

  wide_string = (WCHAR *) malloc ((39) *(sizeof(WCHAR)));
  StringFromGUID2 (*guid, wide_string, 39);
  return (EIF_POINTER)wide_string;
};
//------------------------------------------------------------------

EIF_REFERENCE ccom_guid_to_defstring (GUID * guid)

// Crete Eiffel string in definition format.
{
  EIF_OBJECT result;
  char * tmp_string;

  tmp_string = (char *) malloc (68 * sizeof (char));
  sprintf (tmp_string, "{0x%.8x,0x%.4x,0x%.4x,{0x%.2x,0x%.2x,0x%.2x,0x%.2x,0x%.2x,0x%.2x,0x%.2x,0x%.2x}}",
      guid->Data1, guid->Data2, guid->Data3,
      guid->Data4[0], guid->Data4[1], guid->Data4[2], guid->Data4[3],
      guid->Data4[4], guid->Data4[5], guid->Data4[6], guid->Data4[7]);

  result = eif_protect (RTMS (tmp_string));
  free (tmp_string);
  return eif_wean (result);
};
//------------------------------------------------------------------
#ifdef __cplusplus
  }
#endif
