//--------------------------------------------------------------------------
//
//  EiffelCOM
//  Copyright (C) Interactive Software Engineering, 2001.
//
//  File:   E_automation_interface.cpp
//
//  Contents: Generic interface implementation.
//
//
//--------------------------------------------------------------------------

#include "E_automation_interface.h"

//--------------------------------------------------------------------------

E_automation_interface::E_automation_interface (IDispatch * other)

// Test if `other' COM interface.
{
  HRESULT hr;
  hr = other->QueryInterface (IID_IDispatch, (void**)&item);
  if (FAILED (hr))
  {
    com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
  }
};
//--------------------------------------------------------------------------

E_automation_interface::~E_automation_interface ()

// Release interface;
{
  if (item != NULL)
    item->Release ();
  item = NULL;
};
//--------------------------------------------------------------------------

EIF_POINTER E_automation_interface::ccom_item ()

// Return pointer to interface.
{
  return (EIF_POINTER)item;
};
//--------------------------------------------------------------------------

