////////////////////////////////////////////////////////////////////////////
//
//     OLE2's Structured Storage and Compound Files support
//
//     Functions:
//
//        {{EOLE_ROOT_STORAGE method}}
//             eole2_switch_to_file
//        {{EOLE_STORAGE methods}}
//             eole2_create_compound_file
//             eole2_open_compound_file
//             eole2_is_compound_file
//             eole2_storage_create_stream
//             eole2_storage_open_stream
//             eole2_storage_create_substorage
//             eole2_storage_open_substorage
//             eole2_storage_destroy_element
//             eole2_storage_copy_to
//             eole2_storage_move_element_to
//             eole2_storage_enum_elements
//             eole2_storage_rename_element
//             eole2_enum_statstg_next
//             eole2_storage_set_class
//             eole2_storage_commit
//             eole2_storage_revert
//        {{EOLE_STREAM methods}}
//             eole2_stream_read
//             eole2_stream_read_string
//             eole2_stream_read_integer
//             eole2_stream_read_boolean
//             eole2_stream_read_character
//             eole2_stream_read_real
//             eole2_stream_write
//             eole2_stream_write_string
//             eole2_stream_write_integer
//             eole2_stream_write_boolean
//             eole2_stream_write_character
//             eole2_stream_write_real
//             eole2_stream_seek
//             eole2_stream_set_size
//             eole2_stream_copy_to
//             eole2_stream_commit
//             eole2_stream_revert
//             eole2_stream_stat
//             eole2_stream_lock_region
//             eole2_stream_unlock_region
//        {{EOLE_STATSTG methods}}
//             eole2_statstg_allocate
//             eole2_statstg_set_element_name
//             eole2_statstg_set_element_type
//             eole2_statstg_set_element_size
//             eole2_statstg_set_modification_time
//             eole2_statstg_set_creation_time
//             eole2_statstg_set_access_time
//             eole2_statstg_set_open_mode
//             eole2_statstg_set_locks_supported
//             eole2_statstg_set_clsid
//             eole2_statstg_set_state_bits
//             eole2_statstg_get_element_name
//             eole2_statstg_get_element_type
//             eole2_statstg_get_element_size
//             eole2_statstg_get_modification_time
//             eole2_statstg_get_creation_time
//             eole2_statstg_get_access_time
//             eole2_statstg_get_open_mode
//             eole2_statstg_get_locks_supported
//             eole2_statstg_get_clsid
//             eole2_statstg_get_state_bits
//        {{EOLE_FILETIME methods}}
//             eole2_filetime_allocate
//             eole2_filetime_set_high_date_time
//             eole2_filetime_set_low_date_time
//             eole2_filetime_get_high_date_time
//             eole2_filetime_get_low_date_time
//     Globals:
//       None.
//     Notes:
//       None.
//

#include "eifole.h"

/////////////////////////////////////////////////////////////////////////////
//
// eole2_switch_to_file
//
// Purpose:
//    Copy current in a new file
//
// Parameters:
//    filename    EIF_POINTER Eiffel string, specified the name of
//                            new file.
//
// Return Value:
//    None.
//

extern "C" void eole2_switch_to_file (EIF_POINTER pRootStorage, EIF_POINTER filename)
{
   LPOLESTR  pwcsName;

   pwcsName = Eif2OleString (filename);
   g_hrStatusCode = ((IRootStorage *)pRootStorage)->SwitchToFile (pwcsName);
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_create_compound_file
//
// Purpose:
//    Create compound file
//
// Parameters:
//    filename    EIF_POINTER Eiffel string, specified the name of
//                            compound file to be created.
//
//    mode        EIF_INTEGER Defines the access mode
// Return Value:
//    Pointer to the root IStorage object.
//

extern "C" EIF_POINTER eole2_create_compound_file (EIF_POINTER filename,
                                                          EIF_INTEGER mode) {
   LPOLESTR  pwcsName;
   LPSTORAGE pIStorage;

   pwcsName = Eif2OleString (filename);
   g_hrStatusCode = StgCreateDocfile (pwcsName, (DWORD)mode, 0, &pIStorage);
   return (EIF_POINTER)pIStorage;
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_open_compound_file
//
// Purpose:
//    Open existing compound file
//
// Parameters:
//    filename    EIF_POINTER Eiffel string, specified the name of
//                            compound file.
//    mode        EIF_INTEGER Defines the access mode
//
// Return Value:
//    Pointer to the root IStorage object.
//

extern "C" EIF_POINTER eole2_open_compound_file (EIF_POINTER filename,
                                                          EIF_INTEGER mode) {
   LPOLESTR  pwcsName;
   LPSTORAGE pIStorage;

   pwcsName = Eif2OleString (filename);
   g_hrStatusCode = StgOpenStorage (pwcsName, NULL, (DWORD)mode,
                                                        NULL, 0, &pIStorage);
   return (EIF_POINTER)pIStorage;
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_is_compound_file
//
// Purpose:
//    Determines whether a particular disk file contains an IStorage object.
//
// Parameters:
//    filename EIF_POINTER  Points to the Eiffel name of the disk
//                          file be examined.
//
// Return Value:
//    'True', if file contain IStorage object.
//    'False' otherwise.
//

extern "C" EIF_BOOLEAN eole2_is_compound_file (EIF_POINTER filename) {
   LPOLESTR pwcsName;

   pwcsName = Eif2OleString (filename);
   g_hrStatusCode = StgIsStorageFile (pwcsName);
   return S_OK == g_hrStatusCode ? (EIF_BOOLEAN)1 : (EIF_BOOLEAN)0;
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_storage_create_stream
//
// Purpose:
//    Creates and immediately opens a new IStream object contained
//    in 'pIStorageThis' storage object.
//
// Parameters:
//    pIStorageThis EIF_POINTER Pointer to the corresponding IStorage object
//    stream_name   EIF_POINTER Eiffel name of the stream object be created.
//    mode          EIF_INTEGER Defines the access mode.
//
// Return Value:
//    Pointer to the created IStream object.
//

extern "C" EIF_POINTER eole2_storage_create_stream (EIF_POINTER pIStorageThis,
                                                    EIF_POINTER stream_name,
                                                    EIF_INTEGER mode) {
   LPOLESTR pwcsName;
   LPSTREAM pIStream;

   pwcsName = Eif2OleString (stream_name);
   g_hrStatusCode = ((LPSTORAGE)pIStorageThis)->CreateStream (pwcsName,
                                               (DWORD)mode, 0, 0, &pIStream);
   return (EIF_POINTER)pIStream;
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_storage_open_stream
//
// Purpose:
//    Opens an existing named by 'stream_name' stream according
//    to the access mode 'mode'.
//
// Parameters:
//    pIStorageThis EIF_POINTER Pointer to the corresponding IStorage object.
//    stream_name   EIF_POINTER Eiffel name of the stream object be opened.
//    mode          EIF_INTEGER Defines the access mode.
//
// Return Value:
//    Pointer to the opened IStream object.
//

extern "C" EIF_POINTER eole2_storage_open_stream (EIF_POINTER pIStorageThis,
                                                  EIF_POINTER stream_name,
                                                  EIF_INTEGER mode) {
   LPOLESTR pwcsName;
   LPSTREAM pIStream;

   pwcsName = Eif2OleString (stream_name);
   g_hrStatusCode = ((LPSTORAGE)pIStorageThis)->OpenStream (pwcsName,
                                            NULL, (DWORD)mode, 0, &pIStream);
   return (EIF_POINTER)pIStream;
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_storage_create_substorage
//
// Purpose:
//    Creates and opens a new IStorage object within
//    pIStorageThis storage object.
//
// Parameters:
//    pIStorageThis EIF_POINTER Pointer to the corresponding IStorage object.
//    stg_name      EIF_POINTER Eiffel name of substorage to be created.
//    mode          EIF_INTEGER Defines the access mode.
// Return Value:
//    Pointer to the created substorage. (IStorage object)
//

extern "C" EIF_POINTER eole2_storage_create_substorage (EIF_POINTER pIStorageThis,
                                                        EIF_POINTER stg_name,
                                                        EIF_INTEGER mode) {
   LPOLESTR  pwcsName;
   LPSTORAGE pIStorage;

   pwcsName = Eif2OleString (stg_name);
   g_hrStatusCode = ((LPSTORAGE)pIStorageThis)->CreateStorage (pwcsName,
                                              (DWORD)mode, 0, 0, &pIStorage);
   return (EIF_POINTER)pIStorage;
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_storage_open_substorage
//
// Purpose:
//    Opens existing IStorage object within pIStorageThis storage object.
//
// Parameters:
//    pIStorageThis EIF_POINTER Pointer to the corresponding IStorage object.
//    stg_name      EIF_POINTER Eiffel name of substorage to be opened.
//    mode          EIF_INTEGER Defines the access mode.
// Return Value:
//    Pointer to the opened substorage. (IStorage object)
//

extern "C" EIF_POINTER eole2_storage_open_substorage (EIF_POINTER pIStorageThis,
                                                      EIF_POINTER stg_name,
                                                      EIF_INTEGER mode) {
   LPOLESTR  pwcsName;
   LPSTORAGE pIStorage;

   pwcsName = Eif2OleString (stg_name);
   g_hrStatusCode = ((LPSTORAGE)pIStorageThis)->OpenStorage (pwcsName,
                                     NULL, (DWORD)mode, NULL, 0, &pIStorage);
   return (EIF_POINTER)pIStorage;
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_storage_destroy_element
//
// Purpose:
//    Removes an element from this storage, subject to the transaction mode.
//
// Parameters:
//    pIStorageThis EIF_POINTER Pointer to the corresponding IStorage object.
//    element_name  EIF_POINTER Eiffel name of element to be destroyed.
//
// Return Value:
//    None.
//

extern "C" void eole2_storage_destroy_element (EIF_POINTER pIStorageThis,
                                               EIF_POINTER element_name) {

   g_hrStatusCode = ((LPSTORAGE)pIStorageThis) ->
                               DestroyElement (Eif2OleString (element_name));
   return;
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_storage_copy_to
//
// Purpose:
//    Copies the entire contents of an pIStorageThis object into the
//    storage object pIStoragegDest.
//
// Parameters:
//
//    pIStorageThis EIF_POINTER Pointer to the corresponding IStorage object.
//    pIStorageDest EIF_POINTER Pointer to the destination IStorage object.
//
// Return Value:
//    None.
//

extern "C" void eole2_storage_copy_to (EIF_POINTER pIStorageThis,
                                       EIF_POINTER pIStorageDest) {

   g_hrStatusCode = ((LPSTORAGE)pIStorageThis)->CopyTo (0, NULL,
                                             NULL, (LPSTORAGE)pIStorageDest);
   return;
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_storage_move_element_to
//
// Purpose:
//    Moves an IStorage element , specified by 'element_name' to the
//    indicated new destination container.
//
// Parameters:
//    pIStorageThis    EIF_POINTER Pointer to the corresponding IStorage
//                     object.
//    element_name     EIF_POINTER Eiffel name of element to be moved.
//    pIStorageDest    EIF_POINTER Pointer to the corresponding destination
//                     IStorage object.
//    new_element_name EIF_POINTER Eiffel name of element after moving.
//    mode             EIF_INTEGER Copy/Move switch.
//
// Return Value:
//    None.
//

extern "C" void  eole2_storage_move_element_to (EIF_POINTER pIStorageThis,
                                                EIF_POINTER element_name,
                                                EIF_POINTER pIStorageDest,
                                                EIF_POINTER new_element_name,
                                                EIF_INTEGER mode) {
   LPOLESTR pwcsName;
   LPOLESTR pwcsNewName;

   pwcsName = Eif2OleString (element_name);
   pwcsNewName = Eif2OleString (new_element_name);
   g_hrStatusCode = ((LPSTORAGE)pIStorageThis)->MoveElementTo (pwcsName,
                         (LPSTORAGE)pIStorageDest, pwcsNewName, (DWORD)mode);
   return;
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_storage_enum_elements
//
// Purpose:
//    Enumerates the elements immediately contained within this
//    storage object.
//
// Parameters:
//    pIStorageThis EIF_POINTER Pointer to the corresponding IStorage object.
//
// Return Value:
//    Pointer to the IEnumSTATSTG object.
//

extern "C" EIF_POINTER eole2_storage_enum_elements (EIF_POINTER pIStorageThis) {
   LPENUMSTATSTG pIEnumSTATSTG;

   g_hrStatusCode = ((LPSTORAGE)pIStorageThis)->EnumElements (0, NULL,
                                                          0, &pIEnumSTATSTG);
   return (EIF_POINTER)pIEnumSTATSTG;
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_storage_rename_element
//
// Purpose:
//    Renames an element contained in storage.
//
// Parameters:
//    pIStorageThis    EIF_POINTER Pointer to the corresponding
//                     IStorage object.
//    old_element_name EIF_POINTER Eiffel old name of the element
//    new_element_name EIF_POINTER Eiffel new name of the element
//
// Return Value:
//    None.
//

extern "C" void eole2_storage_rename_element (EIF_POINTER pIStorageThis,
                                              EIF_POINTER old_element_name,
                                              EIF_POINTER new_element_name) {
   LPOLESTR pwcsOldName;
   LPOLESTR pwcsNewName;

   pwcsOldName = Eif2OleString (old_element_name);
   pwcsNewName = Eif2OleString (new_element_name);
   g_hrStatusCode = ((LPSTORAGE)pIStorageThis) ->
                                    RenameElement (pwcsOldName, pwcsNewName);
   return;
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_enum_statstg_next
//
// Purpose:
//    Obtaines the next pointer to the STATSTG structure
//    via IEnumSTATSTG object.
//
// Parameters:
//    pIEnumSTATSTGT EIF_POINTER Pointer to the corresponding
//                   IEnumSTATSTG object.
//
// Return Value:
//    Pointer to the next obtained STATSTG structure.
//

extern "C" EIF_POINTER eole2_enum_statstg_next (EIF_POINTER pIEnumSTATSTG) {

   STATSTG FAR *pOleSTATSTG;

   pOleSTATSTG = (STATSTG FAR *)calloc (1, sizeof (STATSTG));
   g_hrStatusCode = ((LPENUMSTATSTG)pIEnumSTATSTG)->Next (1, pOleSTATSTG, NULL);
   if (g_hrStatusCode != S_OK) {
      free (pOleSTATSTG);
      return (EIF_POINTER)NULL;
   }
   return (EIF_POINTER)(pOleSTATSTG);
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_storage_set_class
//
// Purpose:
//    Persistently stores the object's CLSID.
//
// Parameters:
//    pIStorageThis EIF_POINTER Pointer to the corresponding IStorage object.
//    clsid         EIF_POINTER Eiffel string representing CLSID to store.
//
// Return Value:
//    None.
//

extern "C" void eole2_storage_set_class (EIF_POINTER pIStorageThis,
                                         EIF_POINTER clsid) {
   GUID tmpIID;

   EiffelStringToGuid (clsid, &tmpIID);
   g_hrStatusCode = ((LPSTORAGE)pIStorageThis)->SetClass (tmpIID);
   return;
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_storage_commit
//
// Purpose:
//    Commits any changes made to an IStorage object since
//    it was opened or last committed to persistent storage.
//
// Parameters:
//    pIStorageThis EIF_POINTER Pointer to the corresponding IStorage object.
//    mode          EIF_INTEGER Commit flags.
//
// Return Value:
//    None.
//

extern "C" void eole2_storage_commit (EIF_POINTER pIStorageThis,
                                      EIF_INTEGER mode) {
   g_hrStatusCode = ((LPSTORAGE)pIStorageThis)->Commit ((DWORD)mode);
   return;
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_storage_revert
//
// Purpose:
//    Discards all changes made since last commit.
//
// Parameters:
//    pIStorageThis EIF_POINTER Pointer to the corresponding IStorage object.
//
// Return Value:
//    None.
//

extern "C" void eole2_storage_revert (EIF_POINTER pIStorageThis) {
   g_hrStatusCode = ((LPSTORAGE)pIStorageThis)->Revert ();
   return;
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_stream_read
//
// Purpose:
//    Reads data from the stream starting at the current seek pointer.
//
// Parameters:
//    pIStreamThis EIF_POINTER Pointer to the corresponding IStream object.
//    pv           EIF_POINTER Points to the buffer into which the stream
//                             data should be stored.
//    cb           EIF_INTEGER Specifies the number of bytes of data
//                             to read from the stream.
//
// Return Value:
//    Number of bytes actually read from the stream.
//

extern "C" EIF_INTEGER eole2_stream_read (EIF_POINTER pIStreamThis,
                                          EIF_POINTER pv,
                                          EIF_INTEGER cb) {
   ULONG cbRead;

   g_hrStatusCode = ((LPSTREAM)pIStreamThis) ->
                           Read ((LPVOID)pv, (ULONG)cb, &cbRead);
   return (EIF_INTEGER)cbRead;
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_stream_read_string
//
// Purpose:
//    Reads the string from the stream starting at the current seek pointer.
//
// Parameters:
//    pIStreamThis EIF_POINTER Pointer to the corresponding IStream object.
//
// Return Value:
//    Eiffel string.
//
// Notes:
//    CURRENT SEEK POINTER MUST CONTAIN THE LENGTH OF THE STRING !!!!!
//

extern "C" EIF_REFERENCE eole2_stream_read_string (EIF_POINTER pIStreamThis) {
   LPSTREAM pIStream = (LPSTREAM)pIStreamThis;
   LPVOID   lpvString;
   ULONG    cbStrlen;
   ULONG    cbRead;

   g_hrStatusCode = pIStream -> Read ((LPVOID)&cbStrlen, (ULONG)sizeof (EIF_INTEGER), &cbRead);
   if (FAILED (g_hrStatusCode)) return (EIF_REFERENCE)0;
   lpvString = calloc (1, cbStrlen);
   g_hrStatusCode = pIStream -> Read (lpvString, cbStrlen, &cbRead);
   if (FAILED (g_hrStatusCode)) return (EIF_REFERENCE)0;
   if (cbRead < cbStrlen) g_hrStatusCode = S_FALSE;
   return EStringFromCString ((LPSTR) lpvString);
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_stream_read_integer
//
// Purpose:
//    Reads the integer from the stream starting at the current seek pointer.
//
// Parameters:
//    pIStreamThis EIF_POINTER Pointer to the corresponding IStream object.
//
// Return Value:
//    Eiffel integer.


extern "C" EIF_INTEGER eole2_stream_read_integer (EIF_POINTER pIStreamThis) {
   LPSTREAM pIStream = (LPSTREAM)pIStreamThis;
   EIF_INTEGER integer;
   ULONG    cbRead;

   g_hrStatusCode = pIStream -> Read ((LPVOID)&integer, (ULONG)sizeof (EIF_INTEGER), &cbRead);
   if (FAILED (g_hrStatusCode)) return (EIF_INTEGER)0;
   if (cbRead < sizeof (EIF_INTEGER)) g_hrStatusCode = S_FALSE;
   return integer;
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_stream_read_boolean
//
// Purpose:
//    Reads the boolean from the stream starting at the current seek pointer.
//
// Parameters:
//    pIStreamThis EIF_POINTER Pointer to the corresponding IStream object.
//
// Return Value:
//    Eiffel boolean.


extern "C" EIF_BOOLEAN eole2_stream_read_boolean (EIF_POINTER pIStreamThis) {
   LPSTREAM pIStream = (LPSTREAM)pIStreamThis;
   EIF_BOOLEAN boolean;
   ULONG    cbRead;

   g_hrStatusCode = pIStream -> Read ((LPVOID)&boolean, (ULONG)sizeof (EIF_BOOLEAN), &cbRead);
   if (FAILED (g_hrStatusCode)) return (EIF_INTEGER)0;
   if (cbRead < sizeof (EIF_BOOLEAN)) g_hrStatusCode = S_FALSE;
   return boolean;
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_stream_read_character
//
// Purpose:
//    Reads the character from the stream starting at the current seek pointer.
//
// Parameters:
//    pIStreamThis EIF_POINTER Pointer to the corresponding IStream object.
//
// Return Value:
//    Eiffel character.


extern "C" EIF_CHARACTER eole2_stream_read_character (EIF_POINTER pIStreamThis) {
   LPSTREAM pIStream = (LPSTREAM)pIStreamThis;
   EIF_CHARACTER character;
   ULONG    cbRead;

   g_hrStatusCode = pIStream -> Read ((LPVOID)&character, (ULONG)sizeof (EIF_CHARACTER), &cbRead);
   if (FAILED (g_hrStatusCode)) return (EIF_INTEGER)0;
   if (cbRead < sizeof (EIF_CHARACTER)) g_hrStatusCode = S_FALSE;
   return character;
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_stream_read_real
//
// Purpose:
//    Reads the real from the stream starting at the current seek pointer.
//
// Parameters:
//    pIStreamThis EIF_POINTER Pointer to the corresponding IStream object.
//
// Return Value:
//    Eiffel real.


extern "C" EIF_REAL eole2_stream_read_real (EIF_POINTER pIStreamThis) {
   LPSTREAM pIStream = (LPSTREAM)pIStreamThis;
   EIF_REAL real;
   ULONG    cbRead;

   g_hrStatusCode = pIStream -> Read ((LPVOID)&real, (ULONG)sizeof (EIF_REAL), &cbRead);
   if (FAILED (g_hrStatusCode)) return (EIF_INTEGER)0;
   if (cbRead < sizeof (EIF_REAL)) g_hrStatusCode = S_FALSE;
   return real;
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_stream_write
//
// Purpose:
//    Write data to the stream starting at the current seek pointer.
//
// Parameters:
//    pIStreamThis EIF_POINTER Pointer to the corresponding IStream object.
//    pv           EIF_POINTER Points to the buffer containing the data to be
//                             written to the stream.
//    cb           EIF_INTEGER Specifies the number of bytes of data
//                             to write to the stream.
//
// Return Value:
//    Number of bytes actually written to the stream.
//

extern "C" EIF_INTEGER eole2_stream_write (EIF_POINTER pIStreamThis,
                                           EIF_POINTER pv,
                                           EIF_INTEGER cb) {
   ULONG cbWritten;

   g_hrStatusCode = ((LPSTREAM)pIStreamThis) ->
                           Write ((LPVOID)pv, (ULONG)cb, &cbWritten);
   return (EIF_INTEGER)cbWritten;
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_stream_write_string
//
// Purpose:
//    Write a STRING to the stream starting at the current seek pointer.
//
// Parameters:
//    pIStreamThis EIF_POINTER Pointer to the corresponding IStream object.
//    pv           EIF_POINTER Points to the C string to be
//                             written to the stream.
//
// Return Value:
//    None.
//

extern "C" void eole2_stream_write_string (EIF_POINTER pIStreamThis,
                                           EIF_POINTER pv) {
   ULONG cbWritten;
   unsigned int* len;

   len = (unsigned int *)malloc (sizeof (unsigned int));
   *len = strlen ((char *)pv);
   g_hrStatusCode = ((LPSTREAM)pIStreamThis) ->
                           Write ((LPVOID)len, (ULONG)(sizeof (unsigned int)), &cbWritten);
   if (SUCCEEDED (g_hrStatusCode))
	   g_hrStatusCode = ((LPSTREAM)pIStreamThis) ->
                           Write ((LPVOID)pv, (ULONG)(*len), &cbWritten);
   if (cbWritten < *len)
	   g_hrStatusCode = S_FALSE;
   free (len);
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_stream_write_integer
//
// Purpose:
//    Write an INTEGER to the stream starting at the current seek pointer.
//
// Parameters:
//    pIStreamThis EIF_POINTER Pointer to the corresponding IStream object.
//    integer      EIF_INTEGER integer to be written to the stream.
//
// Return Value:
//    None.
//

extern "C" void eole2_stream_write_integer (EIF_POINTER pIStreamThis,
                                           EIF_INTEGER integer) {
   ULONG cbWritten;
   
   g_hrStatusCode = ((LPSTREAM)pIStreamThis) ->
                           Write ((LPVOID)&integer, (ULONG)(sizeof (EIF_INTEGER)), &cbWritten);
   if (cbWritten < sizeof (EIF_INTEGER))
	   g_hrStatusCode = S_FALSE;
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_stream_write_real
//
// Purpose:
//    Write a REAL to the stream starting at the current seek pointer.
//
// Parameters:
//    pIStreamThis EIF_POINTER Pointer to the corresponding IStream object.
//    real         EIF_REAL real to be written to the stream.
//
// Return Value:
//    None.
//

extern "C" void eole2_stream_write_real (EIF_POINTER pIStreamThis,
                                           EIF_REAL real) {
   ULONG cbWritten;
   
   g_hrStatusCode = ((LPSTREAM)pIStreamThis) ->
                           Write ((LPVOID)&real, (ULONG)(sizeof (EIF_REAL)), &cbWritten);
   if (cbWritten < sizeof (EIF_REAL))
	   g_hrStatusCode = S_FALSE;
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_stream_write_character
//
// Purpose:
//    Write a CHARACTER to the stream starting at the current seek pointer.
//
// Parameters:
//    pIStreamThis EIF_POINTER Pointer to the corresponding IStream object.
//    character    EIF_CHARACTER character to be written to the stream.
//
// Return Value:
//    None.
//

extern "C" void eole2_stream_write_character (EIF_POINTER pIStreamThis,
                                           EIF_CHARACTER character) {
   ULONG cbWritten;
   
   g_hrStatusCode = ((LPSTREAM)pIStreamThis) ->
                           Write ((LPVOID)&character, (ULONG)(sizeof (EIF_CHARACTER)), &cbWritten);
   if (cbWritten < sizeof (EIF_CHARACTER))
	   g_hrStatusCode = S_FALSE;
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_stream_write_boolean
//
// Purpose:
//    Write a CHARACTER to the stream starting at the current seek pointer.
//
// Parameters:
//    pIStreamThis EIF_POINTER Pointer to the corresponding IStream object.
//    boolean    EIF_CHARACTER boolean to be written to the stream.
//
// Return Value:
//    None.
//

extern "C" void eole2_stream_write_boolean (EIF_POINTER pIStreamThis,
                                           EIF_BOOLEAN boolean) {
   ULONG cbWritten;
   
   g_hrStatusCode = ((LPSTREAM)pIStreamThis) ->
                           Write ((LPVOID)&boolean, (ULONG)(sizeof (EIF_BOOLEAN)), &cbWritten);
   if (cbWritten < sizeof (EIF_BOOLEAN))
	   g_hrStatusCode = S_FALSE;
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_stream_seek
//
// Purpose:
//    Adjusts the location of the seek pointer on the stream.
//
// Parameters:
//    pIStreamThis EIF_POINTER Pointer to the corresponding IStream object.
//    offset       EIF_INTEGER Specifies the displacement to be added to the
//                 location indicated by origin.
//    origin       EIF_INTEGER Specifies the seek mode.
//
// Return Value:
//    None.
//

extern "C" void eole2_stream_seek (EIF_POINTER pIStreamThis,
                                   EIF_INTEGER offset,
                                   EIF_INTEGER origin) {
   LARGE_INTEGER dlibMove;

#ifdef EIF_BORLAND
   (dlibMove).u.HighPart = ((long)((DWORD)offset)) < 0 ? -1 : 0;
   (dlibMove).u.LowPart = ((DWORD)offset);
#else
   LISet32(dlibMove, (DWORD)offset);
#endif /* EIF_BORLAND */

   g_hrStatusCode = ((LPSTREAM)pIStreamThis) ->
                                       Seek (dlibMove, (DWORD)origin, NULL);
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_stream_set_size
//
// Purpose:
//    Changes the size of the stream.
//
// Parameters:
//    pIStreamThis EIF_POINTER Pointer to the corresponding IStream object.
//    new_size     EIF_INTEGER Specifies the new size of the stream.
//
// Return Value:
//    None.
//

extern "C" void eole2_stream_set_size (EIF_POINTER pIStreamThis,
                                       EIF_INTEGER new_size) {

   ULARGE_INTEGER libNewSize;

#ifdef EIF_BORLAND
   (libNewSize).u.HighPart = 0;
   (libNewSize).u.LowPart = (new_size);
#else
   ULISet32(libNewSize, new_size);
#endif /* EIF_BORLAND */
   g_hrStatusCode = ((LPSTREAM)pIStreamThis)->SetSize (libNewSize);
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_stream_copy_to
//
// Purpose:
//    Copies data from one stream to another stream,
//    starting at the current seek pointer in each stream.
//
// Parameters:
//    pIStreamThis EIF_POINTER Pointer to the corresponding IStream object.
//    pIStreamDest EIF_POINTER Pointer to the stream into which the data
//                 should be copied
//    cb           EIF_INTEGER Specifies the number of bytes to read
//                 from the source stream.
//
// Return Value:
//    None.
//

extern "C" void eole2_stream_copy_to (EIF_POINTER pIStreamThis,
                                      EIF_POINTER pIStreamDest,
                                      EIF_INTEGER cb) {
   ULARGE_INTEGER liNumBytes;

#ifdef EIF_BORLAND
   (liNumBytes).u.HighPart = 0;
   (liNumBytes).u.LowPart = ((DWORD)cb);
#else
   ULISet32(liNumBytes, (DWORD)cb);
#endif /* EIF_BORLAND */
   g_hrStatusCode = ((LPSTREAM)pIStreamThis) ->
                 CopyTo ((LPSTREAM)pIStreamDest, liNumBytes, NULL, NULL);
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_stream_commit
//
// Purpose:
//    Commits any changes made to the IStorage object containing the stream.
//
// Parameters:
//    pIStreamThis EIF_POINTER Pointer to the corresponding IStream object.
//    mode         EIF_INTEGER Commit flags.
//
// Return Value:
//    None.
//

extern "C" void eole2_stream_commit (EIF_POINTER pIStreamThis,
                                     EIF_INTEGER mode) {
   g_hrStatusCode = ((LPSTREAM)pIStreamThis) -> Commit ((DWORD)mode);
   return;
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_stream_revert
//
// Purpose:
//    Discards all changes made to the stream since it was opened
//    or last committed in transacted mode.
//
// Parameters:
//    pIStreamThis EIF_POINTER Pointer to the corresponding IStream object.
//
// Return Value:
//    None.
//

extern "C" void eole2_stream_revert (EIF_POINTER pIStreamThis) {
   g_hrStatusCode = ((LPSTREAM)pIStreamThis) -> Revert ();
   return;
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_stream_stat
//
// Purpose:
// Retrieves the STATSTG structure for this stream. 
//
// Parameters:
//    pIStreamThis EIF_POINTER Pointer to the corresponding IStream object.
//    grfStatFlag 
//       [in] Specifies that this method does not return some of the fields
//       in the STATSTG structure, thus saving a memory allocation operation.
//       Values are taken from the STATFLAG enumeration
//
// Return Value:
//    Pointer on STATSTG structure.
//

extern "C" EIF_POINTER eole2_stream_stat (EIF_POINTER pIStreamThis, EIF_INTEGER grfStatFlag) {
   STATSTG *pstatstg;

   g_hrStatusCode = ((LPSTREAM)pIStreamThis) -> Stat (pstatstg, (DWORD)grfStatFlag);
   return (EIF_POINTER)pstatstg;
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_stream_lock_region
//
// Purpose:
//    Restricts access to a specified range of bytes in the stream. Supporting
//    this functionality is optional since some file systems do not provide it. 
//
// Parameters:
//    pIStreamThis EIF_POINTER Pointer to the corresponding IStream object.
//    plibOffset 
//       [in] EIF_POINTER point on integer that specifies the byte offset for
//            the beginning of the range. 
//    pcb 
//       [in] EIF_POINTER point on integer that specifies the length of the
//            range, in bytes, to be restricted. 
//    dwLockType 
//       [in] EIF_INTEGER Specifies the restrictions being requested on
//            accessing the range. 
//
// Return Value:
//    None.
//

extern "C" void eole2_stream_lock_region (EIF_POINTER pIStreamThis, EIF_POINTER plibOffset,
										  EIF_POINTER pcb, EIF_INTEGER dwLockType) {
   
   ULARGE_INTEGER *plib = (ULARGE_INTEGER*)plibOffset;
   ULARGE_INTEGER *pc = (ULARGE_INTEGER*)pcb;
   g_hrStatusCode = ((LPSTREAM)pIStreamThis) -> LockRegion (*plib, *pc, (DWORD)dwLockType);
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_stream_unlock_region
//
// Purpose:
//    Removes the access restriction on a range of bytes previously 
//    restricted with eole2_stream_lock_region
//
// Parameters:
//    pIStreamThis EIF_POINTER Pointer to the corresponding IStream object.
//    plibOffset 
//       [in] EIF_POINTER point on integer that specifies the byte offset for
//            the beginning of the range. 
//    pcb 
//       [in] EIF_POINTER point on integer that specifies the length of the
//            range, in bytes, to be restricted. 
//    dwLockType  
//       [in] Specifies the access restrictions previously placed on the range. 
//
// Return Value:
//    None.
//

extern "C" void eole2_stream_unlock_region (EIF_POINTER pIStreamThis, EIF_POINTER plibOffset,
										  EIF_POINTER pcb, EIF_INTEGER dwLockType) {
   
   ULARGE_INTEGER* plib = (ULARGE_INTEGER*)plibOffset;
   ULARGE_INTEGER* pc = (ULARGE_INTEGER*)pcb;  
   g_hrStatusCode = ((LPSTREAM)pIStreamThis) -> UnlockRegion (*plib, *pc, (DWORD)dwLockType);
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_statstg_allocate
//
// Purpose:
//    Allocate a real STATSTG structure.
//
// Parameters:
//    None.
//
// Return Value:
//    Pointer to allocated STATSTG data structure.
//

extern "C" EIF_POINTER eole2_statstg_allocate (void) {
   return (EIF_POINTER)  calloc (1, sizeof (STATSTG));
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_statstg_set_element_name
//
// Purpose:
//    Set the 'pwcsName' member of STATSTG structure to the specified value.
//
// Parameters:
//    _this         EIF_POINTER pointer to the STATSTG structure.
//    element_name  EIF_POINTER pointer to the Eiffel string,
//                  specified element name.
//
// Return Value:
//    None.
//
// Note:
//    Since all OLE2 API deal with OLECHAR strings, we must always convert
//    Eiffel ASCIIZ string to OLECHAR by Eif2OleString function.
//

extern "C" void eole2_statstg_set_element_name (EIF_POINTER _this,
                                                EIF_POINTER element_name) {
   ((STATSTG FAR *)_this)->pwcsName = Eif2OleString (element_name);
   return;
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_statstg_set_element_type
//
// Purpose:
//    Set the 'type' member of STATSTG structure to the specified value.
//
// Parameters:
//    _this         EIF_POINTER pointer to the STATSTG structure.
//    element_type  EIF_INTEGER type of element.
//
// Return Value:
//    None.
//

extern "C" void eole2_statstg_set_element_type (EIF_POINTER _this,
                                                EIF_INTEGER element_type) {
   ((STATSTG FAR *)_this)->type = (DWORD)element_type;
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_statstg_set_element_size
//
// Purpose:
//    Set the 'cbSize' member of STATSTG structure to the specified value.
//
// Parameters:
//    _this         EIF_POINTER pointer to the STATSTG structure.
//    element_size  EIF_INTEGER size of element.
//
// Return Value:
//    None.
//

extern "C" void eole2_statstg_set_element_size (EIF_POINTER _this,
                                                EIF_INTEGER size) {
   STATSTG FAR * lpStg = (STATSTG FAR *)_this;

#ifdef EIF_BORLAND
   (lpStg->cbSize).u.HighPart = ((DWORD)size) < 0 ? -1 : 0;
   (lpStg->cbSize).u.LowPart = ((DWORD)size);
#else
   LISet32(lpStg->cbSize, (DWORD)size);
#endif
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_statstg_set_modification_time
//
// Purpose:
//    Set the 'mtime' member of STATSTG structure to the specified value.
//
// Parameters:
//    _this         EIF_POINTER pointer to the STATSTG structure.
//    mtime         EIF_POINTER pointer to the FILETIME structure.
//
// Return Value:
//    None.
//

extern "C" void eole2_statstg_set_modification_time (EIF_POINTER _this,
                                                     EIF_POINTER mtime) {
   LPFILETIME lpftMTime = (LPFILETIME)mtime;
   STATSTG FAR *  lpStatStg   = (STATSTG FAR *)_this;

   lpStatStg->mtime.dwLowDateTime = lpftMTime->dwLowDateTime;
   lpStatStg->mtime.dwHighDateTime = lpftMTime->dwHighDateTime;
   return;
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_statstg_set_creation_time
//
// Purpose:
//    Set the 'ctime' member of STATSTG structure to the specified value.
//
// Parameters:
//    _this         EIF_POINTER pointer to the STATSTG structure.
//    ctime         EIF_POINTER pointer to the FILETIME structure.
//
// Return Value:
//    None.
//

extern "C" void eole2_statstg_set_creation_time (EIF_POINTER _this,
                                                 EIF_POINTER ctime) {
   LPFILETIME lpftCTime = (LPFILETIME)ctime;
   STATSTG FAR *  lpStatStg   = (STATSTG FAR *)_this;

   lpStatStg->ctime.dwLowDateTime = lpftCTime->dwLowDateTime;
   lpStatStg->ctime.dwHighDateTime = lpftCTime->dwHighDateTime;
   return;
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_statstg_set_access_time
//
// Purpose:
//    Set the 'atime' member of STATSTG structure to the specified value.
//
// Parameters:
//    _this         EIF_POINTER pointer to the STATSTG structure.
//    atime         EIF_POINTER pointer to the FILETIME structure.
//
// Return Value:
//    None.
//

extern "C" void eole2_statstg_set_access_time (EIF_POINTER _this,
                                               EIF_POINTER atime) {
   LPFILETIME lpftATime = (LPFILETIME)atime;
   STATSTG FAR *  lpStatStg   = (STATSTG FAR *)_this;

   lpStatStg->atime.dwLowDateTime = lpftATime->dwLowDateTime;
   lpStatStg->atime.dwHighDateTime = lpftATime->dwHighDateTime;
   return;
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_statstg_set_open_mode
//
// Purpose:
//    Set the 'grfMode' member of STATSTG structure to the specified value.
//
// Parameters:
//    _this         EIF_POINTER pointer to the STATSTG structure.
//    mode          EIF_INTEGER mode element opened in.
//
// Return Value:
//    None.
//

extern "C" void eole2_statstg_set_open_mode (EIF_POINTER _this,
                                             EIF_INTEGER mode) {
   ((STATSTG FAR *)_this)->grfMode = (DWORD)mode;
   return;
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_statstg_set_locks_supported
//
// Purpose:
//    Set the 'grfLocksSupported' member of STATSTG structure
//    to the specified value.
//
// Parameters:
//    _this           EIF_POINTER pointer to the STATSTG structure.
//    locks_supported EIF_INTEGER locking region flags.
//
// Return Value:
//    None.
//

extern "C" void eole2_statstg_set_locks_supported (EIF_POINTER _this,
                                               EIF_INTEGER locks_supported) {
   ((STATSTG FAR *)_this)->grfLocksSupported = (DWORD)locks_supported;
   return;
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_statstg_set_clsid
//
// Purpose:
//    Set the 'clsid' member of STATSTG structure to the specified value.
//
// Parameters:
//    _this         EIF_POINTER pointer to the STATSTG structure.
//    element_name  EIF_POINTER pointer to the Eiffel string,
//                  specified element's CLSID.
//
// Return Value:
//    None.
//

extern "C" void eole2_statstg_set_clsid (EIF_POINTER _this,
                                         EIF_POINTER clsid) {
   STATSTG FAR * lpStatStg = (STATSTG FAR *)_this;
   GUID tmpIID;

   EiffelStringToGuid (clsid, &tmpIID);
   memcpy (&(lpStatStg->clsid), &tmpIID, sizeof (CLSID));
   return;
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_statstg_set_state_bits
//
// Purpose:
//    Set the 'grfSateBits' member of STATSTG structure
//    to the specified value.
//
// Parameters:
//    _this           EIF_POINTER pointer to the STATSTG structure.
//    state_bits      EIF_INTEGER current state.
//
// Return Value:
//    None.
//

extern "C" void eole2_statstg_set_state_bits (EIF_POINTER _this,
                                              EIF_INTEGER state_bits) {
   ((STATSTG FAR *)_this)->grfStateBits = (DWORD)state_bits;
   return;
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_statstg_get_element_name
//
// Purpose:
//    Obtain the 'pwcsName' member of the STATSTG structure.
//
// Parameters:
//    _this           EIF_POINTER pointer to the STATSTG structure.
//
// Return Value:
//    Eiffel string representing the element name.
//

extern "C" EIF_REFERENCE eole2_statstg_get_element_name (EIF_POINTER _this) {
   return Ole2EifString (((STATSTG FAR *)_this)->pwcsName);
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_statstg_get_element_type
//
// Purpose:
//    Obtain the 'type' member of the STATSTG structure.
//
// Parameters:
//    _this           EIF_POINTER pointer to the STATSTG structure.
//
// Return Value:
//    Element type.
//

extern "C" EIF_INTEGER eole2_statstg_get_element_type (EIF_POINTER _this) {
   return (EIF_INTEGER)(((STATSTG FAR *)_this)->type);
}
/////////////////////////////////////////////////////////////////////////////
//
// eole2_statstg_get_element_size
//
// Purpose:
//    Obtain the 'cbSize' member of the STATSTG structure.
//
// Parameters:
//    _this           EIF_POINTER pointer to the STATSTG structure.
//
// Return Value:
//    Element size.
//

extern "C" EIF_INTEGER eole2_statstg_get_element_size (EIF_POINTER _this) {
#ifdef EIF_BORLAND
   return (EIF_INTEGER)(((STATSTG FAR *)_this)->cbSize.u.LowPart);
#else
   return (EIF_INTEGER)(((STATSTG FAR *)_this)->cbSize.LowPart);
#endif /* EIF_BORLAND */
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_statstg_get_modification_time
//
// Purpose:
//    Obtain the pointer to the 'mtime' member of the STATSTG structure.
//
// Parameters:
//    _this           EIF_POINTER pointer to the STATSTG structure.
//
// Return Value:
//    Pointer to the 'mtime' member.
//

extern "C" EIF_POINTER eole2_statstg_get_modification_time (EIF_POINTER _this) {
   return (EIF_POINTER)(&(((STATSTG FAR *)_this)->mtime));
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_statstg_get_creation_time
//
// Purpose:
//    Obtain the pointer to the 'ctime' member of the STATSTG structure.
//
// Parameters:
//    _this           EIF_POINTER pointer to the STATSTG structure.
//
// Return Value:
//    Pointer to the 'ctime' member.
//

extern "C" EIF_POINTER eole2_statstg_get_creation_time (EIF_POINTER _this) {
   return (EIF_POINTER)(&(((STATSTG FAR *)_this)->mtime));
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_statstg_get_access_time
//
// Purpose:
//    Obtain the pointer to the 'atime' member of the STATSTG structure.
//
// Parameters:
//    _this           EIF_POINTER pointer to the STATSTG structure.
//
// Return Value:
//    Pointer to the 'atime' member.
//

extern "C" EIF_POINTER eole2_statstg_get_access_time (EIF_POINTER _this) {
   return (EIF_POINTER)(&(((STATSTG FAR *)_this)->mtime));
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_statstg_get_open_mode
//
// Purpose:
//    Obtain the 'grfMode' member of the STATSTG structure.
//
// Parameters:
//    _this           EIF_POINTER pointer to the STATSTG structure.
//
// Return Value:
//    Mode element opened in.
//

extern "C" EIF_INTEGER eole2_statstg_get_open_mode (EIF_POINTER _this) {
   return (EIF_INTEGER)(((STATSTG FAR *)_this)->grfMode);
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_statstg_get_locks_supported
//
// Purpose:
//    Obtain the 'grfLocksSupported' member of STATSTG structure.
//
// Parameters:
//    _this           EIF_POINTER pointer to the STATSTG structure.
//
// Return Value:
//    Locking region flags.
//

extern "C" EIF_INTEGER eole2_statstg_get_locks_supported (EIF_POINTER _this) {
   return (EIF_INTEGER)(((STATSTG FAR *)_this)->grfLocksSupported);
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_statstg_get_clsid
//
// Purpose:
//    Obtain the 'clsid' member of STATSTG structure.
//
// Parameters:
//    _this         EIF_POINTER pointer to the STATSTG structure.
//
// Return Value:
//    Eiffel sting, corresponding to element's CLSID.
//

extern "C" EIF_REFERENCE eole2_statstg_get_clsid (EIF_POINTER _this) {
   return GuidToEiffelString (((STATSTG FAR *)_this)->clsid);
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_statstg_get_state_bits
//
// Purpose:
//    Obtain the 'grfSateBits' member of STATSTG structure
//
// Parameters:
//    _this           EIF_POINTER pointer to the STATSTG structure.
//
// Return Value:
//    Element's current state.
//

extern "C" EIF_INTEGER eole2_statstg_get_state_bits (EIF_POINTER _this) {
   return (EIF_INTEGER)(((STATSTG FAR *)_this)->grfStateBits);
}


/////////////////////////////////////////////////////////////////////////////
//
// eole2_filetime_allocate
//
// Purpose:
//    Allocate a real FILETIME structure.
//
// Parameters:
//    None.
//
// Return Value:
//    Pointer to allocated FILETIME data structure.
//

extern "C" EIF_POINTER eole2_filetime_allocate (void) {
   return (EIF_POINTER)  calloc (1, sizeof (FILETIME));
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_filetime_set_high_date_time
//
// Purpose:
//    Set the 'dwHighDateTime' member of FILETIME structure
//    to the specified value.
//
// Parameters:
//    _this           EIF_POINTER pointer to the FILETIME structure.
//    high_date_time  EIF_INTEGER upper 32 bits of Win32 Date/Time value
//
// Return Value:
//    None.
//

extern "C" void eole2_filetime_set_high_date_time (EIF_POINTER _this,
                                                   EIF_INTEGER high_date_time) {
   ((FILETIME FAR *)_this)->dwHighDateTime = (DWORD)high_date_time;
   return;
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_filetime_set_low_date_time
//
// Purpose:
//    Set the 'dwLowDateTime' member of FILETIME structure
//    to the specified value.
//
// Parameters:
//    _this           EIF_POINTER pointer to the FILETIME structure.
//    low_date_time   EIF_INTEGER low 32 bits of Win32 Date/Time value
//
// Return Value:
//    None.
//

extern "C" void eole2_filetime_set_low_date_time (EIF_POINTER _this,
                                                  EIF_INTEGER low_date_time) {
   ((FILETIME FAR *)_this)->dwLowDateTime = (DWORD)low_date_time;
   return;
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_filetime_get_high_date_time
//
// Purpose:
//    Obtain the 'dwHighDateTime' member of FILETIME structure.
//
// Parameters:
//    _this           EIF_POINTER pointer to the FILETIME structure.
//
// Return Value:
//    Upper 32 bits of Win32 Date/Time value.
//

extern "C" EIF_INTEGER eole2_filetime_get_high_date_time (EIF_POINTER _this) {
   return (EIF_INTEGER)(((FILETIME FAR *)_this)->dwHighDateTime);
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_filetime_get_low_date_time
//
// Purpose:
//    Obtain the 'dwLowDateTime' member of FILETIME structure.
//
// Parameters:
//    _this           EIF_POINTER pointer to the FILETIME structure.
//
// Return Value:
//    Low 32 bits of Win32 Date/Time value.
//

extern "C" EIF_INTEGER eole2_filetime_get_low_date_time (EIF_POINTER _this) {
   return (EIF_INTEGER)(((FILETIME FAR *)_this)->dwLowDateTime);
}

/////// END OF FILE /////////////////////////////////////////////////////////
