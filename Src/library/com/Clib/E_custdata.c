//--------------------------------------------------------------------------
//
//  EiffelCOM
//  Copyright (C) Interactive Software Engineering, 2001.
//
//  File:   E_custdata.cpp
//
//  Contents:
//
//
//--------------------------------------------------------------------------


#include "E_custdata.h"

//------------------------------------------------------------------

#ifdef __cplusplus
  extern "C" {
#endif

EIF_REFERENCE ccom_custdata_array (EIF_POINTER ptr)
{
  CUSTDATA *pCD = (CUSTDATA*)ptr;
  EIF_OBJ Result;
  EIF_OBJ Item;
  EIF_PROC eif_array_make;
  EIF_PROC eif_array_put;
  EIF_PROC eif_item_make;
  EIF_TYPE_ID eif_array_id;
  EIF_TYPE_ID eif_item_id;
  int i=1;
  DWORD dims = pCD->cCustData;

  eif_item_id = eif_type_id ("ECOM_CUST_DATA_ITEM");
  eif_array_id = eif_type_id ("ARRAY [ECOM_CUST_DATA_ITEM]");
  eif_array_make = eif_proc ("make", eif_array_id);
  eif_array_put = eif_proc ("put", eif_array_id);
  eif_item_make = eif_proc ("make_by_pointer", eif_item_id);
  Result = eif_create (eif_array_id);
  eif_array_make (eif_access (Result), 1, dims);
  while (i <= dims)
  {
    Item = eif_create (eif_item_id);
    eif_item_make (eif_access (Item), &(pCD->prgCustData[i-1]));
    eif_array_put (eif_access (Result), eif_access (Item), i);
    i++;
    eif_wean (Item);
    }
  return eif_wean (Result);
};

#ifdef __cplusplus
  }
#endif
