//--------------------------------------------------------------------------
//
//  EiffelCOM
//  Copyright (C) Interactive Software Engineering, 2001.
//
//  File:   E_ITypeInfo.h
//
//  Contents: Declaration of ITypeInfo interface implementation class.
//
//
//--------------------------------------------------------------------------

#ifndef __ECOM_E_ITYPEINFO_H_INC__
#define __ECOM_E_ITYPEINFO_H_INC__

#include <oaidl.h>
#include "eif_eiffel.h"
#include "eif_except.h"
#include "ecom_rt_globals.h"

#ifdef __cplusplus
extern "C" {
#endif

struct FUNCDESCLISTITEM;
typedef struct FUNCDESCLISTITEM {
  FUNCDESC * item;
  struct FUNCDESCLISTITEM * next;
} FUNCDESCLISTITEM;

struct VARDESCLISTITEM;
typedef struct VARDESCLISTITEM {
  VARDESC * item;
  struct VARDESCLISTITEM * next;
} VARDESCLISTITEM;

typedef struct FUNCDESCLIST {
  FUNCDESCLISTITEM * head;
  FUNCDESCLISTITEM * tail;
} FUNCDESCLIST;

typedef struct VARDESCLIST {
  VARDESCLISTITEM * head;
  VARDESCLISTITEM * tail;
} VARDESCLIST;

class E_IType_Info
{
public:
  // Commands
  E_IType_Info(){};
  E_IType_Info(ITypeInfo * p_i);
  ~E_IType_Info();
  void ccom_get_containing_type_lib ();
  void ccom_release_type_attr (TYPEATTR * p_type_attr);
  void ccom_invoke (EIF_POINTER p_instance, EIF_INTEGER memid, 
        EIF_INTEGER flags, EIF_POINTER p_disp_params, 
        EIF_POINTER p_result,
        EIF_POINTER p_except_info);
  void ccom_release_func_desc (FUNCDESC * p_func_desc);
  void ccom_release_var_desc (VARDESC * p_var_desc);
  
  // Queries
  EIF_POINTER ccom_address_of_member (EIF_INTEGER memid, EIF_INTEGER invkind);
  EIF_POINTER ccom_create_instance (EIF_POINTER outer, EIF_POINTER refiid);
  ITypeLib * ccom_containing_type_lib ();
  EIF_INTEGER ccom_index_type_lib ();
  EIF_REFERENCE ccom_get_dll_entry (EIF_INTEGER memid, EIF_INTEGER invkind);
  EIF_REFERENCE ccom_get_documentation (EIF_INTEGER memid);
  FUNCDESC * ccom_get_func_desc (EIF_INTEGER an_index);
  EIF_REFERENCE ccom_get_ids_of_names (EIF_POINTER names, EIF_INTEGER count);
  EIF_INTEGER ccom_get_impl_type_flags (EIF_INTEGER an_index);
  EIF_REFERENCE ccom_get_mops (EIF_INTEGER memid);
  EIF_REFERENCE ccom_get_names (EIF_INTEGER memid, EIF_INTEGER max_names);
  ITypeInfo * ccom_get_ref_type_info (EIF_INTEGER handle);
  EIF_INTEGER ccom_get_ref_type_of_impl_type (EIF_INTEGER an_index);
  TYPEATTR * ccom_get_type_attr ();
  ITypeComp * ccom_get_type_comp ();
  VARDESC * ccom_get_var_desc (EIF_INTEGER an_index);

private:
  ITypeInfo * pTypeInfo;  
  ITypeLib * pContainingTypeLib;
  EIF_INTEGER index;
  TYPEATTR * pTypeAttr;
  FUNCDESCLIST FuncDescList;
  VARDESCLIST VarDescList;
  void save_func_desc (FUNCDESC *pFuncDesc);
  void save_var_desc (VARDESC *pVarDesc);
  void release_func_descs ();
  void release_var_descs ();
};

#ifdef __cplusplus
}
#endif

#endif // !__ECOM_E_ITYPEINFO_H_INC__

