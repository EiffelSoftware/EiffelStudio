//--------------------------------------------------------------------------
//
//  EiffelCOM
//  Copyright (C) Interactive Software Engineering, 2001.
//
//  File:   E_arraydesc.cpp
//
//  Contents:
//
//
//--------------------------------------------------------------------------


#include "E_arraydesc.h"

//------------------------------------------------------------------

#ifdef __cplusplus
  extern "C" {
#endif

EIF_REFERENCE ccom_arraydesc_bounds (EIF_POINTER ptr)
{
  ARRAYDESC *pAR = (ARRAYDESC*)ptr;
  EIF_OBJ Result;
  EIF_OBJ Bounds;
  EIF_PROC eif_array_make;
  EIF_PROC eif_array_put;
  EIF_PROC eif_bound_make;
  EIF_TYPE_ID eif_array_id;
  EIF_TYPE_ID eif_bound_id;
  int i=1;
  USHORT dims = pAR->cDims;

  eif_bound_id = eif_type_id ("ECOM_SAFE_ARRAY_BOUND");
  eif_array_id = eif_type_id ("ARRAY [ECOM_SAFE_ARRAY_BOUND]");
  eif_array_make = eif_proc ("make", eif_array_id);
  eif_array_put = eif_proc ("put", eif_array_id);
  eif_bound_make = eif_proc ("make_by_pointer", eif_bound_id);
  Result = eif_create (eif_array_id);
  eif_array_make (eif_access (Result), 1, dims);
  while (i <= dims)
  {
    Bounds = eif_create (eif_bound_id);
    eif_bound_make (eif_access (Bounds), &(pAR->rgbounds[i-1]));
    eif_array_put (eif_access (Result), eif_access (Bounds), i);
    i++;
    eif_wean (Bounds);
    }
  return eif_wean (Result);
};

#ifdef __cplusplus
  }
#endif
