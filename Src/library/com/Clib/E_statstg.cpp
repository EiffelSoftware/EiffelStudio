//--------------------------------------------------------------------------
//
//  EiffelCOM
//  Copyright (C) Interactive Software Engineering, 2001.
//
//  File:   E_statstg.cpp
//
//  Contents:   Struct STATSTG wrapping class.
//
//--------------------------------------------------------------------------

#include "E_statstg.h"

//--------------------------------------------------------------------------
E_STATSTG::~E_STATSTG()
{
  if (pSTATSTG->pwcsName != NULL)
    CoTaskMemFree (pSTATSTG->pwcsName);
  free (pSTATSTG);
};
//--------------------------------------------------------------------------

E_STATSTG::E_STATSTG(STATSTG * p_statstg)

{
  pSTATSTG = p_statstg;
};
//--------------------------------------------------------------------------

LPWSTR E_STATSTG::ccom_name ()

// Points to a NULL-terminated string containing the name. 
{
  return pSTATSTG->pwcsName;
};
//--------------------------------------------------------------------------
int E_STATSTG::ccom_is_same_name(LPWSTR other_name)

// Compare Current name and the other_name
{
  int result;
  if (memcmp(pSTATSTG->pwcsName, other_name, wcslen(pSTATSTG->pwcsName)) == 0)
    result = 1;
  else
    result = 0;
  
  return result;
};
//--------------------------------------------------------------------------

DWORD E_STATSTG::ccom_type()

// Indicates the type of storage object. This is one of the 
// values from the STGTY enumeration. 
{
  return pSTATSTG->type;
};
//-------------------------------------------------------------------------

ULARGE_INTEGER * E_STATSTG::ccom_size ()

// Specifies the size in bytes 
{
  return &(pSTATSTG->cbSize);
};
//-------------------------------------------------------------------------

FILETIME * E_STATSTG::ccom_modification_t ()

// Indicates the last modification time 
{
  return &(pSTATSTG->mtime);
};
//-------------------------------------------------------------------------

FILETIME * E_STATSTG::ccom_creation_t ()

// Indicates the creation time 
{
  return &(pSTATSTG->ctime);
};
//------------------------------------------------------------------------
FILETIME * E_STATSTG::ccom_access_t ()

// Indicates the last access time 
{
  return &(pSTATSTG->atime);
};
//-----------------------------------------------------------------------
DWORD E_STATSTG::ccom_mode ()

// Indicates the access mode specified when the object was opened. 
{
  return pSTATSTG->grfMode;
};
//-----------------------------------------------------------------------
DWORD E_STATSTG::ccom_locks_supported ()

// Indicates the types of region locking supported by the stream 
// or byte array. See the LOCKTYPES enumeration for the values 
// available. This member is not used for storage objects. 
{
  return pSTATSTG->grfLocksSupported;
};
//-----------------------------------------------------------------------
CLSID * E_STATSTG::ccom_clsid ()

// Indicates the class identifier for the storage object; 
// set to CLSID_NULL for new storage objects. 
{
  return &(pSTATSTG->clsid);
};
//-----------------------------------------------------------------------

