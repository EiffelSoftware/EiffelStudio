//--------------------------------------------------------------------------
//
//  EiffelCOM
//  Copyright (C) Interactive Software Engineering, 1998.
//
//  File:		E_IRootStorage.cpp
//
//  Contents: 	IStorage interface implementation class.
//				Wrapping of OLE compound file implementation 
//				of the IStorage interface.
//
//
//--------------------------------------------------------------------------

#include "E_IRootStorage.h"

// Commands
//---------------------------------------------------------------------

E_IRootStorage::~E_IRootStorage ()
{
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
E_IRootStorage::E_IRootStorage (EIF_POINTER pstgName)

// Set `pIRootStorage' to known pointer to IRootStorage
{
	pIRootStorage = (IRootStorage *)pstgName;
};
//---------------------------------------------------------------------

EIF_POINTER E_IRootStorage::ccom_iroot_storage()
{
	return (EIF_POINTER)pIRootStorage;
};
