/*
indexing
	description: "EiffelCOM: library of reusable components for COM."
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
*/

#ifndef __ECOM_E_ISTORAGE_H_INC__
#define __ECOM_E_ISTORAGE_H_INC__

#include <objbase.h>
#include "eif_except.h"
#include "ecom_rt_globals.h"

#ifdef __cplusplus
extern "C" {
#endif

class E_IStorage
{
public:
  // Commands
  E_IStorage(){};
  E_IStorage(IStorage * p_i);
  ~E_IStorage();
  void ccom_create_doc_file (WCHAR * pwcsName, DWORD grfMode);
  void ccom_initialize_storage (IStorage * pstgName);
  void ccom_open_root_storage (WCHAR * pwcsName, DWORD grfMode);
  IStream * ccom_create_stream (WCHAR * pwcsName, DWORD grfMode);
  IStream * ccom_open_stream (WCHAR * pwcsName, DWORD grfMode);
  IStorage * ccom_create_storage (WCHAR * pwcsName, DWORD grfMode);
  IStorage * ccom_open_storage (WCHAR * pwcsName, DWORD grfMode);
  void ccom_copy_to (DWORD ciidExclude, IID * rgiidExclude, 
      IStorage * pstgDest);
  void ccom_move_element_to (WCHAR * pwcsName, IStorage * pstgDest,
      LPWSTR pwcsNewName, DWORD grfFlags);
  void ccom_commit(DWORD grfCommitFlags);
  void ccom_revert ();
  IEnumSTATSTG * ccom_enum_elements ();
  void ccom_destroy_element (WCHAR * pwcsName);
  void ccom_rename_element (WCHAR * pwcsOldName, WCHAR * pwcsNewName);
  void ccom_set_element_times (WCHAR * pwcsName, FILETIME * pctime, 
      FILETIME * patime, FILETIME * pmtime );
  void ccom_set_class (REFCLSID clsid);
  STATSTG * ccom_stat (DWORD grfStatFlag);  
  
  // Queries
  EIF_POINTER ccom_item();
  IRootStorage * ccom_root_storage();
private:
  IStorage * pStorage;  

};

#ifdef __cplusplus
}
#endif

#endif // !__ECOM_E_ISTORAGE_H_INC__

