//--------------------------------------------------------------------------
//
//  EiffelCOM
//  Copyright (C) Interactive Software Engineering, 2001.
//
//  File:   E_IStorage.cpp
//
//  Contents:   IStorage interface implementation class.
//        Wrapping of OLE compound file implementation 
//        of the IStorage interface.
//
//
//--------------------------------------------------------------------------

#include "E_IStorage.h"

// Commands
//---------------------------------------------------------------------
E_IStorage::E_IStorage(IStorage * p_i)
{
  HRESULT hr;

  hr = p_i->QueryInterface(IID_IStorage, (void **)&pStorage);
  if (hr != S_OK)
  {
    pStorage = NULL;
    com_eraise (f.c_format_message (hr), EN_PROG);
  }
};
//---------------------------------------------------------------------
E_IStorage::~E_IStorage ()
{
  if (pStorage != NULL)
    pStorage->Release();
};
//---------------------------------------------------------------------

EIF_POINTER E_IStorage::ccom_item()

/*-----------------------------------------------------------
  item.
-----------------------------------------------------------*/
{
  return (EIF_POINTER)pStorage;
};

//---------------------------------------------------------------------
void E_IStorage::ccom_create_doc_file (WCHAR * pwcsName, DWORD grfMode)

// Creates a new compound file storage object using the OLE-provided 
// compound file implementation for the IStorage interface. 
// Points pStorage to the new storage object.
//    Parameters
// - pwcsName points to the pathname of the compound file to create.
//  If it is NULL, a temporary compound file is allocated with a unique name. 
// - grfMode specifies the access mode to use when opening the new 
//  storage object. Must be one of the STGM enumeration values.
{
  HRESULT hr;
  DWORD mode;
   hr = StgCreateDocfile (pwcsName, grfMode, 0, &pStorage);
  if (hr != S_OK)
  {
    pStorage = NULL;
    com_eraise (f.c_format_message (hr), EN_PROG);
  }
};
//------------------------------------------------------------------

void E_IStorage::ccom_open_root_storage (WCHAR * pwcsName, DWORD grfMode)

// Opens an existing root storage object in the file system. 
// Points pRootStorage to the opened storage object.
//    Parameters
// - pwcsName points to the pathname of the compound file to create.
// - grfMode specifies the access mode to use when opening the new 
//  storage object. Must be one of the STGM enumeration values.
{
  HRESULT hr;
  hr = StgOpenStorage (pwcsName, NULL, grfMode, 
      NULL, 0, &pStorage);
  if (hr != S_OK)
  {
    pStorage = NULL;
    com_eraise (f.c_format_message (hr), EN_PROG);
  }
};
//------------------------------------------------------------------

void E_IStorage::ccom_initialize_storage (IStorage * pstgName)

// Points pRootStorage to known storage object pointed by pstgName
//    Parameters
// - pstgName points to open storage object
{
  pStorage = pstgName;
};
//------------------------------------------------------------------

IStream * E_IStorage::ccom_create_stream (WCHAR * pwcsName, DWORD grfMode)

// Creates and opens a stream object with the specified name 
// contained in root storage object.
// Returns pointer to the new IStream interface. 
//    Parameters
// - pwcsName points to the name of the newly created stream. 
// - grfMode specifies the access mode to use when opening 
//  the newly created stream. Must be one of the STGM enumeration values.
{
  HRESULT hr;
  IStream * pStream;
  hr = pStorage->CreateStream (pwcsName, grfMode, 0, 0, &pStream);
  if (hr != S_OK)
  {
    pStream = NULL;
    com_eraise (f.c_format_message (hr), EN_PROG);
  } 
  return pStream;
};
//-------------------------------------------------------------------

IStream * E_IStorage::ccom_open_stream (WCHAR * pwcsName, DWORD grfMode)

// Opens an existing stream object within root storage object 
// in the specified access mode. 
// Returns pointer to the newly-opened stream object. 
//    Parameters
// - pwcsName points to the name of the stream to open. 
// - grfMode specifies the access mode to be assigned to the open stream.
//  Must be one of the STGM enumeration values.
{
  HRESULT hr;
  IStream * pStream;
  hr = pStorage->OpenStream (pwcsName, NULL, grfMode, 0, &pStream); 
  if (hr != S_OK)
  {
    pStream = NULL;
    com_eraise (f.c_format_message (hr), EN_PROG);
  }
  return pStream;
};
//----------------------------------------------------------------------

IStorage * E_IStorage::ccom_create_storage (WCHAR * pwcsName, DWORD grfMode)

// Creates and opens a new storage object nested within root storage object. 
// Returns pointer to the newly-created storage object. 
//    Parameters
// - pwcsName points to the name of the newly created storage object. 
// - grfMode specifies the access mode to use when opening 
//  the newly created storage object. Must be one of the STGM enumeration values.
{
  HRESULT hr;
  IStorage * pSubStorage;
  hr = pStorage->CreateStorage (pwcsName, grfMode, 0, 0, &pSubStorage);
  if (hr != S_OK)
  {
    pSubStorage = NULL;
    com_eraise (f.c_format_message (hr), EN_PROG);
  }
  return pSubStorage;
};
//----------------------------------------------------------------------

IStorage * E_IStorage::ccom_open_storage (WCHAR * pwcsName, DWORD grfMode)

// Opens an existing storage object with the specified name in the 
// specified access mode. 
// Returns pointer to the opened storage object. 
//    Parameters
// - pwcsName points to the name of the storage object to open. 
// - grfMode specifies the access mode to use when opening the storage 
//  object. Must be one of the STGM enumeration values.
{
  HRESULT hr;
  IStorage * pSubStorage;
  hr = pStorage->OpenStorage(pwcsName, NULL, grfMode, 
      NULL, 0, &pSubStorage);
  if (hr != S_OK)
  {
    pSubStorage = NULL;
    com_eraise (f.c_format_message (hr), EN_PROG);
  }
  return pSubStorage;
};
//---------------------------------------------------------------------

void E_IStorage::ccom_copy_to (DWORD ciidExclude, IID * rgiidExclude, 
      IStorage * pstgDest)

// Copies the entire contents of an open storage object to another storage object. 
//    Parameters
// - ciidExclude the number of elements in the array pointed to by rgiidExclude. 
// - rgiidExclude An array of interface identifiers that either the caller 
//  knows about and does not want to be copied or that the storage object 
//  does not support but whose state the caller will later explicitly copy.
//  Passing NULL indicates that all interfaces on the object are to be copied.
// - pstgDest Points to the open storage object into which this 
//  storage object is to be copied. 
{
  HRESULT hr;
  hr = pStorage->CopyTo (ciidExclude, rgiidExclude, 
      NULL, pstgDest);
  if (hr != S_OK)
  {
    com_eraise (f.c_format_message (hr), EN_PROG);
  }
};
//----------------------------------------------------------------------

void E_IStorage::ccom_move_element_to (WCHAR * pwcsName, IStorage * pstgDest,
      LPWSTR pwcsNewName, DWORD grfFlags)

// Copies or moves a substorage or stream from root storage object 
//  to another storage object. 
//    Parameters
// - pwcsName Points to a string that contains the name of the element 
//  in root storage object to be moved or copied. 
// - pstgDest is the pointer to the destination storage object. 
// - pwcsNewName Points to a string that contains the new name for 
//  the element in its new storage object. 
// - grfFlags Specifies whether the operation should be a 
//  move (STGMOVE_MOVE) or a copy (STGMOVE_COPY).
{
  HRESULT hr;
  hr = pStorage->MoveElementTo(pwcsName, pstgDest, 
      pwcsNewName, grfFlags);
  if (hr != S_OK)
  {
    com_eraise (f.c_format_message (hr), EN_PROG);
  }
};
//----------------------------------------------------------------------

void E_IStorage::ccom_commit(DWORD grfCommitFlags)

// Ensures that any changes made to a storage object open in transacted 
// mode are reflected in the parent storage; for a root storage, reflects 
// the changes in the actual device, for example, a file on disk. 
// For a root storage object opened in direct mode, this method has no 
// effect except to flush all memory buffers to the disk. For non-root 
// storage objects in direct mode, this method has no effect. 
//    Parameters
// - grfCommitFlags Controls how the changes are committed to the 
//  storage object. 
{
  HRESULT hr;
  hr = pStorage->Commit (grfCommitFlags);
  if (hr != S_OK)
  {
    com_eraise (f.c_format_message (hr), EN_PROG);
  }
};
//--------------------------------------------------------------------

void E_IStorage::ccom_revert ()

// Discards all changes that have been made to the storage object since 
// the last commit. 
{
  HRESULT hr;
  hr = pStorage->Revert(); 
  if (hr != S_OK)
  {
    com_eraise (f.c_format_message (hr), EN_PROG);
  }
};
//---------------------------------------------------------------------

IEnumSTATSTG * E_IStorage::ccom_enum_elements ()

// Retrieves a pointer to an enumerator object that can be used 
// to enumerate the storage and stream objects contained within 
// root storage object. 
{
  HRESULT hr;
  IEnumSTATSTG * pEnumSTATSTG;
  hr = pStorage->EnumElements(0, NULL, 0, &pEnumSTATSTG);
  if (hr != S_OK)
  {
    pEnumSTATSTG = NULL;
    com_eraise (f.c_format_message (hr), EN_PROG);
  }
  return pEnumSTATSTG;
};
//---------------------------------------------------------------------

void E_IStorage::ccom_destroy_element (WCHAR * pwcsName)

// Removes the specified storage or stream from this storage object. 
//    Parameters
// - pwcsName Points to a string that contains the name of the storage 
//  or stream to be removed. 
{
  HRESULT hr;
  hr = pStorage->DestroyElement(pwcsName); 
  if (hr != S_OK)
  {
    com_eraise (f.c_format_message (hr), EN_PROG);
  }
};
//-----------------------------------------------------------------------

void E_IStorage::ccom_rename_element (WCHAR * pwcsOldName, WCHAR * pwcsNewName)

// Renames the specified substorage or stream in this storage object. 
//    Parameters
// - pwcsOldName Points to a string that contains the name of the 
//  substorage or stream to be changed. 
// - pwcsNewName Points to a string that contains the new name for 
//  the specified sustorage or stream. 
{
  HRESULT hr;
  hr = pStorage->RenameElement(pwcsOldName, pwcsNewName);
  if (hr != S_OK)
  {
    com_eraise (f.c_format_message (hr), EN_PROG);
  }
};
//-----------------------------------------------------------------------

void E_IStorage::ccom_set_element_times (WCHAR * pwcsName, FILETIME * pctime, 
      FILETIME * patime, FILETIME * pmtime)

// Sets the modification, access, and creation times of the specified 
//  storage element, if supported by the underlying file system. 
//    Parameters
// - pwcsName The name of the storage object element whose times 
//  are to be modified. If NULL, the time is set on the root 
//  storage rather than one of its elements. 
// - pctime Either the new creation time for the element or NULL 
//  if the creation time is not to be modified. 
// - patime Either the new access time for the element or NULL 
//  if the access time is not to be modified. 
// - pmtime Either the new modification time for the element or 
//  NULL if the modification time is not to be modified. 
{
  HRESULT hr;
  hr = pStorage->SetElementTimes(pwcsName, pctime, 
      patime, pmtime);
  if (hr != S_OK)
  {
    com_eraise (f.c_format_message (hr), EN_PROG);
  }
};
//-----------------------------------------------------------------------

void E_IStorage::ccom_set_class (REFCLSID clsid)

// Assigns the specified CLSID to root storage object
//    Parameters
// - clsid The class identifier (CLSID) that is to be associated with 
//  the storage object. 
{
  HRESULT hr;
  hr = pStorage->SetClass(clsid);
  if (hr != S_OK)
  {
    com_eraise (f.c_format_message (hr), EN_PROG);
  }
};
//-----------------------------------------------------------------------

STATSTG * E_IStorage::ccom_stat (DWORD grfStatFlag)

// Retrieves the STATSTG structure for root open storage object. 
// Returns pointer to a STATSTG structure where this method places 
// information about the open storage object. 
//    Parameters
// - grfStatFlag Specifies that some of the fields in the STATSTG 
//  structure are not returned, thus saving a memory allocation 
//  operation. Values are taken from the STATFLAG enumeration. 
{
  HRESULT hr;
  STATSTG * pSTATSTG;
  pSTATSTG = (STATSTG *)malloc (sizeof(STATSTG));
  hr = pStorage->Stat(pSTATSTG, grfStatFlag);
  if (hr != S_OK)
  {
    if (pSTATSTG->pwcsName != NULL)
      CoTaskMemFree (pSTATSTG->pwcsName);
    free (pSTATSTG);
    pSTATSTG = NULL;
    com_eraise (f.c_format_message (hr), EN_PROG);
  }
  return pSTATSTG;
};

// Queries

//------------------------------------------------------------------------
IRootStorage * E_IStorage::ccom_root_storage()

// Returns pointer to IRootStorage interface if supported
// otherwize returns NULL
{
  HRESULT hr;
  IRootStorage * pIRootStorage;
  hr = pStorage->QueryInterface (IID_IRootStorage,(void **)&pIRootStorage);
  if (hr != S_OK)
  {
    pIRootStorage = NULL;
  }
  return (IRootStorage *)pIRootStorage;
};
//------------------------------------------------------------------------


