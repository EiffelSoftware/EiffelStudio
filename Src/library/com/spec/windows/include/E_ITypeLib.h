//--------------------------------------------------------------------------
//
//  EiffelCOM
//  Copyright (C) Interactive Software Engineering, 2001.
//
//  File:   E_ITypeLib.h
//
//  Contents: Declaration of ITypeLib interface implementation class.
//
//
//--------------------------------------------------------------------------

#ifndef __ECOM_E_ITYPELIB_H_INC__
#define __ECOM_E_ITYPELIB_H_INC__

#include <oaidl.h>
#include "eif_eiffel.h"
#include "eif_except.h"
#include "ecom_rt_globals.h"

#ifdef __cplusplus
extern "C" {
#endif

class E_IType_Lib
{
public:
  // Commands
  E_IType_Lib(){};
  E_IType_Lib(ITypeLib * p_i);
  E_IType_Lib (OLECHAR * file_name);
  ~E_IType_Lib();
  void ccom_release_tlib_attr (TLIBATTR * p_tlib_attr);
    
  
  // Queries
  EIF_REFERENCE ccom_find_name (OLECHAR * szName, EIF_INTEGER count);
  EIF_REFERENCE ccom_get_documentation (EIF_INTEGER index);
  TLIBATTR * ccom_get_lib_attr ();
  ITypeComp * ccom_get_type_comp ();
  ITypeInfo * ccom_get_type_info (int index);
  int ccom_get_type_info_count ();
  ITypeInfo * ccom_get_type_info_of_guid (EIF_POINTER guid);
  EIF_INTEGER ccom_get_type_info_type (int index);
  EIF_BOOLEAN ccom_is_name (OLECHAR * szName);
  ITypeLib * ccom_item(){return pTypeLib;};

private:
  ITypeLib * pTypeLib;  
};

#ifdef __cplusplus
}
#endif

#endif // !__ECOM_E_ITYPELIB_H_INC__

