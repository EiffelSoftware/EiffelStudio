//--------------------------------------------------------------------------
//
//  EiffelCOM
//  Copyright (C) Interactive Software Engineering, 2001.
//
//  File:   E_ITypeLib.cpp
//
//  Contents:   ITypeLib interface implementation class.
//        
//--------------------------------------------------------------------------

#include "E_ITypeLib.h"
#include "E_bstr.h"


// Commands
//---------------------------------------------------------------------
E_IType_Lib::E_IType_Lib(ITypeLib * p_i)
{
  pTypeLib = p_i;
};
//---------------------------------------------------------------------
E_IType_Lib::E_IType_Lib(OLECHAR * file_name)
{
  HRESULT hr = 0;
  pTypeLib = 0;

  hr = LoadTypeLib (file_name, &pTypeLib);
  if (hr != S_OK)
  {
    com_eraise (f.c_format_message (hr), EN_PROG);
  }
};
//---------------------------------------------------------------------
E_IType_Lib::~E_IType_Lib ()
{
  if (pTypeLib != NULL)
    pTypeLib->Release();
};
//---------------------------------------------------------------------

// Queries

EIF_REFERENCE E_IType_Lib::ccom_find_name (OLECHAR * szName, EIF_INTEGER count)

// Finds occurences of type description in type library.
// May be used to quickly verify that name exists in type library.
//    Parameters
// szName - name to search for
// count  - indicates how many instances to look for
{
  HRESULT hr =0;
  MEMBERID * rgMemId = NULL;
  ITypeInfo ** ppTInfo = NULL;
  unsigned short cFound = 0;
  EIF_OBJ Result = NULL;
  EIF_OBJ type_info = NULL;
  EIF_PROC eif_res_make = NULL, eif_type_info_make = NULL;
  EIF_PROC eif_put_member_ids = NULL;
  EIF_PROC eif_put_type_info = NULL;
  EIF_TYPE_ID type_id_res = -1, type_id_type_info= -1;
  int i = 0;

  eif_disable_visible_exception();

  rgMemId = (MEMBERID *)malloc (count * sizeof (MEMBERID));
  ppTInfo = (ITypeInfo **)malloc (count * sizeof (ITypeInfo *));
  *ppTInfo = NULL;
  cFound = count;

  hr = pTypeLib->FindName (szName, 0, ppTInfo, rgMemId, &cFound);
  if (hr != S_OK)
  {
    com_eraise (f.c_format_message (hr), EN_PROG);
  }

  type_id_res = eif_type_id ("ECOM_TYPE_LIB_FIND_NAME_RESULT");
  if (type_id_res == EIF_NO_TYPE)
    eif_panic ("ECOM_TYPE_LIB_FIND_NAME_RESULT is not in system");
  eif_res_make = eif_proc ("make", type_id_res);
  if (eif_res_make == NULL)
    com_eraise ("don't know make", 24);
  eif_put_member_ids = eif_proc ("put_member_ids", type_id_res);
  if (eif_put_member_ids == NULL)
    com_eraise ("don't know put_member_ids", 24);
  eif_put_type_info = eif_proc ("put_type_info", type_id_res);
  if (eif_put_type_info == NULL)
    com_eraise ("don't know put_type_info", 24);

  type_id_type_info = eif_type_id ("ECOM_TYPE_INFO");
  if (type_id_type_info == EIF_NO_TYPE)
    eif_panic ("ECOM_TYPE_INFO is not in system");
  eif_type_info_make = eif_proc ("make_from_pointer", type_id_type_info);
  if (eif_type_info_make == NULL)
    com_eraise ("don't know make_from_pointer", 24);

  Result = eif_create (type_id_res);
  eif_res_make (eif_access (Result), (EIF_INTEGER)cFound);

  for (i = 0; i < cFound; i++)
  {
    eif_put_member_ids (eif_access (Result), (EIF_INTEGER)rgMemId [i], i + 1);
    
    type_info = eif_create (type_id_type_info);
    eif_type_info_make (eif_access (type_info), ppTInfo [i]);
    eif_put_type_info (eif_access (Result), eif_access (type_info), i + 1);
    eif_wean (type_info);
  }
  free (rgMemId);
  free (ppTInfo);
  return eif_wean (Result);
};
//---------------------------------------------------------------------

EIF_REFERENCE E_IType_Lib::ccom_get_documentation (EIF_INTEGER index)

// retrieves name of item, library's documentation string,
// complete help file name and path, and
// context identifier for library help topic in help file
{
  EIF_GET_CONTEXT
  EIF_OBJECT Result = NULL;
  EIF_OBJECT name = NULL;
  EIF_OBJECT doc_string = NULL;
  EIF_OBJECT help_file = NULL;

  EIF_TYPE_ID eif_doc_id = -1, eif_string_id = -1;
  EIF_PROC put_name = NULL, put_doc_string = NULL, put_help_file = NULL, put_context = NULL;

  BSTR BstrName = NULL;
  BSTR BstrDocString = NULL;
  BSTR BstrHelpFile = NULL;

  unsigned long HelpContext = 0;

  HRESULT hr = 0;

  hr = pTypeLib->GetDocumentation (index, &BstrName, &BstrDocString,
      &HelpContext, &BstrHelpFile);
  if (hr != S_OK)
  {
    com_eraise (f.c_format_message (hr), EN_PROG);
  }

  name = bstr_to_eif_obj (BstrName);
  if (BstrName != NULL)
  {
    SysFreeString (BstrName);
    BstrName = NULL;
  }
  
  doc_string = bstr_to_eif_obj (BstrDocString);
  if (BstrDocString != NULL)
  {
    SysFreeString (BstrDocString);
    BstrDocString = NULL;
  }
  
  help_file = bstr_to_eif_obj (BstrHelpFile);
  if (BstrHelpFile != NULL)
  {
    SysFreeString (BstrHelpFile);
    BstrHelpFile = NULL;
  }
  
  eif_doc_id = eif_type_id ("ECOM_DOCUMENTATION");
  put_name = eif_proc ("set_name", eif_doc_id);
  put_doc_string = eif_proc ("set_doc_string", eif_doc_id);
  put_help_file = eif_proc ("set_help_file", eif_doc_id);
  put_context = eif_proc ("set_context_id", eif_doc_id);

  nstcall = 0;
  Result = eif_create (eif_doc_id);
  put_name (eif_access (Result), eif_access (name));
  put_doc_string (eif_access (Result), eif_access (doc_string));
  put_help_file (eif_access (Result), eif_access (help_file));
  put_context (eif_access (Result), HelpContext);

  eif_wean (name);
  eif_wean (doc_string);
  eif_wean (help_file);
  return eif_wean (Result);
};
//---------------------------------------------------------------------

TLIBATTR * E_IType_Lib::ccom_get_lib_attr ()

// Retrieves structure that contains library's attributes.
{
  TLIBATTR * p_tlib_attr = NULL;
  HRESULT hr = 0;

  hr = pTypeLib->GetLibAttr (&p_tlib_attr);
  if (hr != S_OK)
  {
    com_eraise (f.c_format_message (hr), EN_PROG);
  }
  return p_tlib_attr;
};
//---------------------------------------------------------------------

ITypeComp * E_IType_Lib::ccom_get_type_comp ()

// Enables client compiler to bind librery's types, variables,
// constants, and global functions.
// Returns pointer to ItypeComp instance for this ITypelib.
{
  HRESULT hr = 0;
  ITypeComp * p_type_comp = NULL;

  hr = pTypeLib->GetTypeComp(&p_type_comp);
  if (hr != S_OK)
  {
    //Formatter  f;
    com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
  }
  return p_type_comp;
};
//--------------------------------------------------------------------

ITypeInfo * E_IType_Lib::ccom_get_type_info (int index)

// Retrieves specified type description in library
// `index' is index of ITypeInfo to be returned.
// Returnes pointer to ITypeInfo inteface.
{
  HRESULT hr = 0;
  ITypeInfo * p_type_info = NULL;
  
  hr = pTypeLib->GetTypeInfo (index, &p_type_info);
  if (hr != S_OK)
  {
    com_eraise (f.c_format_message (hr), EN_PROG);
  }
  return p_type_info;
};
//--------------------------------------------------------------------

int E_IType_Lib::ccom_get_type_info_count ()

// Returns number of type descriptions in type library.
{
  return pTypeLib->GetTypeInfoCount();
};
//-------------------------------------------------------------------

ITypeInfo * E_IType_Lib::ccom_get_type_info_of_guid (EIF_POINTER a_guid)

// Retrieves type description corresponding to specified GUID
{
  HRESULT hr = 0;
  ITypeInfo * p_type_info = NULL;
  GUID * guid = NULL;
  guid = (GUID *)a_guid;
  
  hr = pTypeLib->GetTypeInfoOfGuid (*guid, &p_type_info);
  if (hr != S_OK)
  {
    com_eraise (f.c_format_message (hr), EN_PROG);
  }
  return p_type_info;
};
//------------------------------------------------------------------

EIF_INTEGER E_IType_Lib::ccom_get_type_info_type (int index)

// Retrieves type of type description.
// `index' is index of type description within type library
{
  HRESULT hr =0;
  TYPEKIND type_kind;
  hr = pTypeLib->GetTypeInfoType (index, &type_kind);
  if (hr != S_OK)
  {
    com_eraise (f.c_format_message (hr), EN_PROG);
  }
  return (EIF_INTEGER) type_kind;
};
//------------------------------------------------------------------

EIF_BOOLEAN E_IType_Lib::ccom_is_name (OLECHAR * szName)

// Indicates whether a passed-in string contains name of type 
// or member described in library.
{
  HRESULT hr;
  BOOL local_b;
  
  hr = pTypeLib->IsName (szName, 0, &local_b);
  if (hr != S_OK)
  {
    com_eraise (f.c_format_message (hr), EN_PROG);
  }
  if (local_b)
    return EIF_TRUE;
  else
    return EIF_FALSE;
};
//-----------------------------------------------------------------

void E_IType_Lib::ccom_release_tlib_attr (TLIBATTR * p_tlib_attr)

// Releases specified TLIBATTR.
{
  
  //pTypeLib->ReleaseTLibAttr (p_tlib_attr);
  
  // Causes random crash.
  // Access violation in oleaut32.dll or ntdll.dll
  //structure is overwritten and freed (?) before.
  
};
//-----------------------------------------------------------------

