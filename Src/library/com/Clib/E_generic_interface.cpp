//--------------------------------------------------------------------------
//
//  EiffelCOM
//  Copyright (C) Interactive Software Engineering, 2001.
//
//  File:   E_generic_interface.cpp
//
//  Contents: Generic interface implementation.
//
//
//--------------------------------------------------------------------------

#include "E_generic_interface.h"

//--------------------------------------------------------------------------

E_generic_interface::E_generic_interface (IUnknown * other)

// Test if `other' COM interface.
{
  HRESULT hr;
  hr = other->QueryInterface (IID_IUnknown, (void**)&item);
  if (FAILED (hr))
  {
    com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
  }
};
//--------------------------------------------------------------------------

E_generic_interface::~E_generic_interface ()

// Release interface;
{
  if (item != NULL)
    item->Release ();
  item = NULL;
};
//--------------------------------------------------------------------------

EIF_POINTER E_generic_interface::ccom_item ()

// Return pointer to interface.
{
  return (EIF_POINTER)item;
};
//--------------------------------------------------------------------------

