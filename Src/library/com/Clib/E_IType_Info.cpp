//--------------------------------------------------------------------------
//
//  EiffelCOM
//  Copyright (C) Interactive Software Engineering, 1999.
//
//  File:		E_ITypeInfo.cpp
//
//  Contents: 	ITypeLib interface implementation class.
//				
//--------------------------------------------------------------------------

#include "E_ITypeInfo.h"
#include "E_bstr.h"

// Commands
//---------------------------------------------------------------------
E_IType_Info::E_IType_Info(ITypeInfo * p_i)
{
	pTypeInfo = p_i;
};
//---------------------------------------------------------------------
E_IType_Info::~E_IType_Info ()
{
	if (pTypeInfo != NULL)
		pTypeInfo->Release();
};
//---------------------------------------------------------------------

void E_IType_Info::ccom_get_containing_type_lib ()

// Initializes `pContainingTypeLib' to containing type library
// and `index' to index of type description within type library
{
	HRESULT hr;
	hr = pTypeInfo->GetContainingTypeLib (&pContainingTypeLib, (unsigned int *)&index);
	if (hr != S_OK)
	{
		Formatter  f;
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	}
};
//---------------------------------------------------------------------

// Queries
EIF_POINTER E_IType_Info::ccom_address_of_member (EIF_INTEGER memid, EIF_INTEGER invkind)

// Retrieves addresses of static functions or variables.
//		Parameters
//	memid	- Member ID of static member whose address is to be retrieved.
//	invkind	- one of INVOKEKIND enumeration values
{
	HRESULT hr;
	void * Result;
	
	hr = pTypeInfo->AddressOfMember ((MEMBERID) memid, (INVOKEKIND) invkind, &Result);
	if (hr != S_OK)
	{
		Formatter  f;
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	}
	return (EIF_POINTER) Result;
};
//---------------------------------------------------------------------

EIF_POINTER E_IType_Info::ccom_create_instance (EIF_POINTER outer, EIF_POINTER refiid)

// Creates new instance of coclass
//		Parameters
//	outer	- pointer to controlling IUNknown
//	refiid	- interface ID
{
	HRESULT hr;
	void * Result;

	hr = pTypeInfo->CreateInstance ((IUnknown *) outer, (REFIID) refiid, &Result);
	if (hr != S_OK)
	{
		Formatter  f;
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	}
	return (EIF_POINTER) Result;	
};
//----------------------------------------------------------------------

ITypeLib * E_IType_Info::ccom_containing_type_lib ()

// Pointer to containing type library
{
	return pContainingTypeLib;
};
//----------------------------------------------------------------------

EIF_INTEGER E_IType_Info::ccom_index_type_lib ()

// Index of type description in containing type library
{
	return index;
};
//-----------------------------------------------------------------------

EIF_REFERENCE E_IType_Info::ccom_get_dll_entry (EIF_INTEGER memid, EIF_INTEGER invkind)

// Retrieves description of entry point function in DLL
{
	HRESULT hr;

	EIF_OBJECT Result;
	EIF_OBJECT dll_name, entry_point;
	
	EIF_TYPE_ID eif_dll_entry_id;
	EIF_PROCEDURE set_dll_name, set_entry_point, set_ordinal;

	BSTR bstr_dll_name;
	BSTR bstr_entry_point;
	unsigned short ordinal;

	hr = pTypeInfo->GetDllEntry ((MEMBERID) memid, (INVOKEKIND) invkind, 
				&bstr_dll_name, &bstr_entry_point, &ordinal);
	if (hr != S_OK)
	{
		Formatter  f;
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	}

	dll_name = bstr_to_eif_obj (bstr_dll_name);
	entry_point = bstr_to_eif_obj (bstr_entry_point);

	eif_dll_entry_id = eif_type_id ("ECOM_DLL_ENTRY");
	set_dll_name = eif_proc ("set_dll_name", eif_dll_entry_id);
	set_entry_point = eif_proc ("set_entry_point", eif_dll_entry_id);
	set_ordinal = eif_proc ("set_ordinal", eif_dll_entry_id);

	Result = eif_create (eif_dll_entry_id);
	set_dll_name (eif_access (Result), eif_access (dll_name));
	set_entry_point (eif_access (Result), eif_access (entry_point));
	set_ordinal (eif_access (Result), (EIF_INTEGER) ordinal);

	eif_wean (dll_name);
	eif_wean (entry_point);

	return eif_wean (Result);
};
//-----------------------------------------------------------------------

EIF_REFERENCE E_IType_Info::ccom_get_documentation (EIF_INTEGER memid)

// retrieves name of item, library's documentation string,
// complete help file name and path, and
// context identifier for library help topic in help file
{
	EIF_OBJECT Result;
	EIF_OBJECT name, doc_string, help_file;

	EIF_TYPE_ID eif_doc_id, eif_string_id;
	EIF_PROCEDURE put_name, put_doc_string, put_help_file, put_context;

	BSTR BstrName;
	BSTR BstrDocString;
	BSTR BstrHelpFile;

	unsigned long HelpContext;

	HRESULT hr;

	hr = pTypeInfo->GetDocumentation ((MEMBERID) memid, &BstrName, &BstrDocString,
			&HelpContext, &BstrHelpFile);
	if (hr != S_OK)
	{
		Formatter  f;
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	}

	name = bstr_to_eif_obj (BstrName);
	doc_string = bstr_to_eif_obj (BstrDocString);
	help_file = bstr_to_eif_obj (BstrHelpFile);

	eif_doc_id = eif_type_id ("ECOM_DOCUMENTATION");
	put_name = eif_proc ("set_name", eif_doc_id);
	put_doc_string = eif_proc ("set_doc_string", eif_doc_id);
	put_help_file = eif_proc ("set_help_file", eif_doc_id);
	put_context = eif_proc ("set_context_id", eif_doc_id);

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
//-----------------------------------------------------------------------

FUNCDESC * E_IType_Info::ccom_get_func_desc (EIF_INTEGER an_index)

//Retieves FUNCDESC structure with information about specified function.
{
	HRESULT hr;
	FUNCDESC * p_funcdesc;

	hr = pTypeInfo->GetFuncDesc (an_index, &p_funcdesc);
	if (hr != S_OK)
	{
		Formatter  f;
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	}
	return p_funcdesc;
};
//-----------------------------------------------------------------------

EIF_REFERENCE E_IType_Info::ccom_get_ids_of_names (EIF_POINTER names, EIF_INTEGER count)

// Maps between member names and member IDs, and
// parameter names and parameter IDs.
{
	HRESULT hr;
	MEMBERID * p_memid;

	EIF_OBJECT Result;
	EIF_TYPE_ID eif_array_id;
	EIF_PROCEDURE array_make, array_put;
	int i;

	p_memid = (MEMBERID *)malloc (count * sizeof(MEMBERID));

	hr = pTypeInfo->GetIDsOfNames ((OLECHAR **)names, count, p_memid);
	if (hr != S_OK)
	{
		Formatter  f;
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	}

	eif_array_id = eif_type_id ("ARRAY[INTEGER]");
	array_make = eif_proc ("make", eif_array_id);
	array_put = eif_proc ("put", eif_array_id);
	
	Result = eif_create (eif_array_id);
	array_make (eif_access (Result), 1, count);

	for (i = 0; i < count; i++)
	{
		array_put (eif_access (Result), p_memid[i], i + 1);
	}
	free (p_memid);
	return eif_wean (Result);
};
//-------------------------------------------------------------------------

EIF_INTEGER E_IType_Info::ccom_get_impl_type_flags (EIF_INTEGER an_index)

// Retrieves IMPLTYPEFLAGS enumeration for inteface in type description
{
	HRESULT  hr;
	EIF_INTEGER Result;

	hr = pTypeInfo->GetImplTypeFlags (an_index, (int *)&Result);
	if (hr != S_OK)
	{
		Formatter  f;
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	}
	return Result;
};
//-------------------------------------------------------------------------

EIF_REFERENCE E_IType_Info::ccom_get_mops (EIF_INTEGER memid)

// Retrieves marshaling information.
{
	HRESULT hr;
	EIF_OBJECT Result;
	BSTR mops;

	hr = pTypeInfo->GetMops ((MEMBERID)memid, &mops);
	if (hr != S_OK)
	{
		Formatter  f;
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	}
	Result = bstr_to_eif_obj (mops);
	return eif_wean (Result);
};
//-------------------------------------------------------------------------

EIF_REFERENCE E_IType_Info::ccom_get_names (EIF_INTEGER memid, EIF_INTEGER max_names)

// Retrieves variable with specified member ID
// or name of property or method and its parameters
//		Parameters
// memid 	 - ID of member whose name(s) is to be reurned
// max_names - maximum number of names 
{
	HRESULT hr;
	BSTR * p_bstr_names;
	unsigned int count;

	EIF_OBJECT Result, name;
	EIF_TYPE_ID eif_array_id;
	EIF_PROCEDURE array_make, array_put;
	int i;

	p_bstr_names = (BSTR *) malloc (max_names * sizeof(BSTR));
	hr = pTypeInfo->GetNames ((MEMBERID)memid, p_bstr_names, max_names, &count);
	if (hr != S_OK)
	{
		Formatter  f;
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	}
	
	eif_array_id = eif_type_id ("ARRAY[STRING]");
	array_make = eif_proc ("make", eif_array_id);
	array_put = eif_proc ("put", eif_array_id);
	
	Result = eif_create (eif_array_id);
	array_make (eif_access (Result), 1, count);

	for (i = 0; i < count; i++)
	{
		name = bstr_to_eif_obj (p_bstr_names [i]);
		array_put (eif_access (Result), eif_access(name), i + 1);
		eif_wean (name);
	}
	free (p_bstr_names);
	return eif_wean (Result);
};
//-------------------------------------------------------------------------

ITypeInfo * E_IType_Info::ccom_get_ref_type_info (EIF_INTEGER handle)

// Retrieves reference type description
// 	Parameters
// `handle' - handle to referenced type description to be returned
{
	HRESULT hr;
	ITypeInfo * pTInfo;

	hr = pTypeInfo->GetRefTypeInfo ((HREFTYPE)handle, &pTInfo);
	if (hr != S_OK)
	{
		Formatter  f;
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	}
	return pTInfo;
};
//-------------------------------------------------------------------------

EIF_INTEGER E_IType_Info::ccom_get_ref_type_of_impl_type (EIF_INTEGER an_index)

// Retrives handle of inmplemented interface type, which can be passed to 
//	`ccom_get_ref_type_info'
// 		Parameters
// `an_index' - index of implemented type whose handle is returned.
//		Valid range is 0 to `cImplTypes' field in TYPEATTR structure
//		(it correspondes to `count_implemented_types' of ECOM_TYPE_ATTR)	
{
	HRESULT hr;
	HREFTYPE ref_type;

	hr = pTypeInfo->GetRefTypeOfImplType (an_index, &ref_type);
	if (hr != S_OK)
	{
		Formatter  f;
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	}
	return (EIF_INTEGER)ref_type;
};
//--------------------------------------------------------------------------

TYPEATTR * E_IType_Info::ccom_get_type_attr ()

// Retrieves TYPEATTR structure of type description.
{
	HRESULT hr;
	TYPEATTR * p_type_attr;

	hr = pTypeInfo->GetTypeAttr (&p_type_attr);
	if (hr != S_OK)
	{
		Formatter  f;
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	}
	return p_type_attr;
};
//--------------------------------------------------------------------------

ITypeComp * E_IType_Info::ccom_get_type_comp ()

// Retrieves ITypeComp interface for type description.
{
	HRESULT hr;
	ITypeComp * p_type_comp;

	hr = pTypeInfo->GetTypeComp (&p_type_comp);
	if (hr != S_OK)
	{
		Formatter  f;
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	}
	return p_type_comp;
};
//--------------------------------------------------------------------------

VARDESC * E_IType_Info::ccom_get_var_desc (EIF_INTEGER an_index)

// Retrieves VARDESC structure of variable with index `an_index'
{
	HRESULT hr;
	VARDESC * p_var_desc;

	hr = pTypeInfo->GetVarDesc (an_index, &p_var_desc);
	if (hr != S_OK)
	{
		Formatter  f;
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	}
	return p_var_desc;
};
//--------------------------------------------------------------------------

void E_IType_Info::ccom_invoke (EIF_POINTER p_instance, EIF_INTEGER memid, 
			EIF_INTEGER flags, EIF_POINTER p_disp_params, EIF_POINTER p_result,
			EIF_POINTER p_except_info)

// Invokes method, or accesses property of object, implementing inteface described 
// by type description.
//		Parameters
// `p_instance' - pointer to instance, obtained through `ccom_create_instance'
// `memid' - member ID
// `flags' - see ECOM_METHOD_FLAGS for values
// `p_disp_params' - pointer to DISPPARAMS structure
// `p_result' - pointer to VARIANT structure 
// `p_except_info' - pointer to EXCEPINFO structure
{
	HRESULT hr;
	unsigned int arg_err;

	hr = pTypeInfo->Invoke ((void *)p_instance,
							(MEMBERID) memid,
							(unsigned short) flags,
							(DISPPARAMS *) p_disp_params,
							(VARIANT *) p_result,
							(EXCEPINFO *) p_except_info,
							(unsigned int *) &arg_err);
	if (hr != S_OK)
	{
		Formatter  f;
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	}
};
//-----------------------------------------------------------------------------

void E_IType_Info::ccom_release_func_desc (EIF_POINTER p_func_desc)

// Releases FUNCDESC structure previously returned by `ccom_get_func_desc'
{
	pTypeInfo->ReleaseFuncDesc ((FUNCDESC *)p_func_desc);
};
//-----------------------------------------------------------------------------

void E_IType_Info::ccom_release_type_attr (EIF_POINTER p_type_attr)

// Releases TYPEATTR structure previously returned by `ccom_get_type_attr'
{
	pTypeInfo->ReleaseTypeAttr ((TYPEATTR *) p_type_attr);
};
//-----------------------------------------------------------------------------

void E_IType_Info::ccom_release_var_desc (EIF_POINTER p_var_desc)

// Releases VARDESC structure previously returned by `ccom_get_var_desc'
{
	pTypeInfo->ReleaseVarDesc ((VARDESC *)p_var_desc);
};
//-----------------------------------------------------------------------------

