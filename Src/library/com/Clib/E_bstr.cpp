//--------------------------------------------------------------------------
//
//  EiffelCOM
//  Copyright (C) Interactive Software Engineering, 2001.
//
//  File:   E_bstr.cpp
//
//  Contents:   BSTR handling.
//        
//--------------------------------------------------------------------------

#include "E_bstr.h"

EIF_OBJ bstr_to_eif_obj (BSTR BstrName)

// Transform BSTR into Eiffel STRING object
{
  EIF_GET_CONTEXT
  EIF_OBJ name;
  EIF_TYPE_ID eif_string_id;
  EIF_PROC string_make;
  size_t bstr_size;
  char * str_name;

  if (BstrName != NULL)
  {
    bstr_size = SysStringLen (BstrName);
    str_name = (char *) malloc (bstr_size + 1);

    wcstombs (str_name, BstrName, bstr_size);
    str_name [bstr_size] = '\0';

    name = henter (RTMS (str_name));
    free (str_name);
  }
  else
  {
    eif_string_id = eif_type_id ("STRING");
    string_make = eif_proc ("make", eif_string_id);
    nstcall = 0;
    name = eif_create (eif_string_id);
    string_make (eif_access (name), 0);
  }
  return name;
};
//----------------------------------------------------------------------------


