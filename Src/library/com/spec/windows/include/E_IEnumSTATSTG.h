//--------------------------------------------------------------------------
//
//  EiffelCOM
//  Copyright (C) Interactive Software Engineering, 2001.
//
//  File:   E_IEnumSTATSTG.h
//
//  Contents: Declaration of IEnumSTATSTG interface implementation class.
//
//
//--------------------------------------------------------------------------

#ifndef __ECOM_E_IENUM_STATSTG_H_INC__
#define __ECOM_E_IENUM_STATSTG_H_INC__

#include <objidl.h>
#include <stdlib.h>
#include <malloc.h>
#include "eif_except.h"
#include "ecom_rt_globals.h"

#ifdef __cplusplus
extern "C" {
#endif

class E_IEnumSTATSTG
{
public:
  E_IEnumSTATSTG (IEnumSTATSTG * p);
  ~E_IEnumSTATSTG();

  STATSTG * ccom_next_item ();
  void ccom_skip (ULONG n);
  void ccom_reset();
  IEnumSTATSTG * ccom_clone();
  IEnumSTATSTG * ccom_item();
private:
  IEnumSTATSTG * pIEnum;
};

#ifdef __cplusplus
}
#endif

#endif // !__ECOM_E_IENUM_STATSTG_H_INC__
