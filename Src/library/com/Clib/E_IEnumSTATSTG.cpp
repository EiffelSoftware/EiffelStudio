//--------------------------------------------------------------------------
//
//  EiffelCOM
//  Copyright (C) Interactive Software Engineering, 2001.
//
//  File:   E_IEnumSTATSTG.cpp
//
//  Contents:   IEnumSTATSTG interface  wrapping class.
//
//--------------------------------------------------------------------------

#include "E_IEnumSTATSTG.h"


E_IEnumSTATSTG::~E_IEnumSTATSTG()
{
  pIEnum->Release();
};
//-------------------------------------------------------------------------

E_IEnumSTATSTG::E_IEnumSTATSTG (IEnumSTATSTG * p)

// Points pIEnum to known enumerator object pointed by p.
//    Parameters
// - p points to enumerator object.
{
  pIEnum = p;
};
//-------------------------------------------------------------------------

STATSTG * E_IEnumSTATSTG::ccom_next_item ()

// Retrieves the next item in the enumeration sequence.
{
  HRESULT hr;
  STATSTG  * p_statstg;

  p_statstg = (STATSTG *)calloc (1, sizeof (STATSTG));
  hr = pIEnum->Next(1, p_statstg, NULL);
  if (hr != S_OK)
  {
    free (p_statstg);
    p_statstg = NULL;
  }
  return p_statstg;
};
//-------------------------------------------------------------------------

void E_IEnumSTATSTG::ccom_skip(ULONG n)

// Skips over the next `n' elements in the enumeration sequence.
{
  HRESULT hr;
  hr = pIEnum->Skip(n);
  if (hr != S_OK)
  {
    //Formatter  f;
    com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
  }
};
//-------------------------------------------------------------------------

void E_IEnumSTATSTG::ccom_reset()

// Resets the enumeration sequence to the beginning.
{
  HRESULT hr;
  hr = pIEnum->Reset();
  if (hr != S_OK)
  {
    //Formatter  f;
    com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
  }
};
//-------------------------------------------------------------------------

IEnumSTATSTG * E_IEnumSTATSTG::ccom_clone()

// Creates another enumerator that contains the same enumeration
// state as the current one. Using this function, a client can
// record a particular point in the enumeration sequence, and then
// return to that point at a later time. The new enumerator supports
// the same interface as the original one.
{
  HRESULT hr;
  IEnumSTATSTG * pIEnum_cloned;

  hr = pIEnum->Clone(&pIEnum_cloned);

  if (hr != S_OK)
  {
    //Formatter  f;
    com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
  }
  return pIEnum_cloned;
};
//-------------------------------------------------------------------------

IEnumSTATSTG * E_IEnumSTATSTG::ccom_item()

{
  return pIEnum;
};
