//--------------------------------------------------------------------------
//
//  EiffelCOM
//  Copyright (C) Interactive Software Engineering, 2001.
//
//  File:   E_Routines.cpp
//
//  Contents: Implementation of storage routines.
//
//
//--------------------------------------------------------------------------
  
#include "E_Routines.h"

//------------------------------------------------------------------

int E_Routines::ccom_is_compound_file (WCHAR * pwcsName)

// Indicates whether a particular disk file contains a storage object.
// - pwcsName points to the name of the disk file to be examined, 
//  passed uninterpreted to the underlying file system. 
{
  HRESULT hr;
  int result;

  hr = StgIsStorageFile (pwcsName);
  if (hr == S_OK)
    result = 1;
  else if (hr == S_FALSE)
    result = 0;
  else 
  {
    //Formatter  f;
    com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
  }
  return result;
};
//------------------------------------------------------------------

//------------------------------------------------------------------
