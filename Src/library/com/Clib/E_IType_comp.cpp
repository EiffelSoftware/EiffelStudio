//--------------------------------------------------------------------------
//
//  EiffelCOM
//  Copyright (C) Interactive Software Engineering, 2001.
//
//  File:   E_ITypeComp.cpp
//
//  Contents:   ITypeComp interface implementation class.
//        
//--------------------------------------------------------------------------

#include "E_ITypeComp.h"
#include "E_bstr.h"


// Commands
//---------------------------------------------------------------------
E_IType_Comp::E_IType_Comp(ITypeComp * p_i)
{
  pTypeComp = p_i;
};
//---------------------------------------------------------------------

E_IType_Comp::~E_IType_Comp ()
{
  if (pTypeComp != NULL)
    pTypeComp->Release();
};
//---------------------------------------------------------------------

//EIF_REFERENCE E_IType_Comp::ccom_bind (EIF_POINTER a_name, EIF_INTEGER flags)

// Maps a name to a member of a type, or binds global variables and 
//    functions contained in a type library.
//
// Parameters:
//    a_name 
//    Name to be bound. 
//    flags 
//    Flags word containing one or more of the Invoke flags defined in the
//    INVOKEKIND enumeration. Specifies whether the name was referenced as 
//    a method or a property. When binding to a variable, specify the flag 
//    INVOKE_PROPERTYGET. Specify zero to bind to any type of member. 
//{
//  HRESULT hr;
//
//  BINDPTR * P_bind_ptr;
//  DESCKIND * p_desc_kind;
//  ITypeInfo * p_TInfo;
//
//  if (hr != S_OK)
//  {
//    Formatter  f;
//    com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
//  }
//};
//---------------------------------------------------------------------

// Queries
