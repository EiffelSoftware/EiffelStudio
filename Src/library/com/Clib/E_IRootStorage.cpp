//--------------------------------------------------------------------------
//
//  EiffelCOM
//  Copyright (C) Interactive Software Engineering, 2001.
//
//  File:   E_IRootStorage.cpp
//
//  Contents:   IStorage interface implementation class.
//        Wrapping of OLE compound file implementation 
//        of the IStorage interface.
//
//
//--------------------------------------------------------------------------

#include "E_IRootStorage.h"

// Commands
//---------------------------------------------------------------------

E_IRootStorage::~E_IRootStorage ()
{
  if (pIRootStorage != NULL)
  pIRootStorage->Release();
};
//---------------------------------------------------------------------
void E_IRootStorage::ccom_switch_to_file (EIF_POINTER filename)

// Copies the current file associated with the storage object 
// to a new file. The new file is then used for the storage 
// object and any uncommitted changes.
{
  HRESULT hr;
  hr = pIRootStorage->SwitchToFile ((WCHAR *)filename);
  if (hr != S_OK)
  {
    //Formatter  f;
    com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
  }
};

//---------------------------------------------------------------------
E_IRootStorage::E_IRootStorage (IUnknown * pstgName)

// Set `pIRootStorage' to known pointer to IRootStorage
{
  HRESULT hr;

  hr = pstgName->QueryInterface(IID_IRootStorage, (void **)&pIRootStorage);
  if (hr != S_OK)
  {
    pIRootStorage = NULL;
    com_eraise (f.c_format_message (hr), EN_PROG);
  } 
};
//---------------------------------------------------------------------

EIF_POINTER E_IRootStorage::ccom_item()
{
  return (EIF_POINTER)pIRootStorage;
};
