indexing
	description: "implementation of IStorage interface"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	ECOM_STORAGE

inherit
	ECOM_QUERIABLE

	ECOM_STORAGE_ROUTINES

	ECOM_STGC

	ECOM_STGM

	ECOM_STGMOVE
	
	ECOM_STAT_FLAGS

creation
	make_new_doc_file,
	make_temporary_doc_file,
	make_open_file,
	make_from_other,
	make_from_pointer

feature {NONE} -- Initialization

	make_from_pointer (cpp_obj: POINTER) is
			-- Make from pointer
		do
			initializer := ccom_create_c_storage_from_pointer (cpp_obj)
			item := ccom_item (initializer)
		end

	make_new_doc_file (filename: FILE_NAME; a_mode: INTEGER) is
			-- Create new compound file with path `filename' 
			-- and mode `a_mode' in file system.
			-- See class ECOM_STGM for `mode' values.
		require
			valid_filename: filename /= Void
			valid_mode: is_valid_stgm (a_mode)
		local
			wide_string: ECOM_WIDE_STRING
		do
			initializer := ccom_create_c_storage;
			create wide_string.make_from_string (filename)
			ccom_create_doc_file (initializer, wide_string.item, a_mode)
			item := ccom_item (initializer)
		ensure
			compound_file_created: exists
		end

	make_temporary_doc_file (a_mode: INTEGER) is
			-- Create temporary compound file with mode `mode'
			-- See class ECOM_STGM for `a_mode' values.
		require
			valid_mode: is_valid_stgm (a_mode)
		do
			initializer := ccom_create_c_storage;
			ccom_create_doc_file (initializer, default_pointer, a_mode)
			item := ccom_item (initializer)
		ensure
			compound_file_created: exists
		end

	make_open_file (filename: FILE_NAME; a_mode: INTEGER) is
			-- Open existing root compound file with path `filename' 
			-- and mode `mode' in file system.
			-- excluding block pointed by `exclude' (can be default_pointer)
			-- See class ECOM_STGM for `a_mode' values.
		require
			valid_file: filename /= Void and then is_compound_file (filename)
			valid_mode: is_valid_stgm (a_mode)
		local
			wide_string: ECOM_WIDE_STRING
		do
			initializer := ccom_create_c_storage;				
			create wide_string.make_from_string (filename)
			ccom_open_root_storage (initializer, wide_string.item, a_mode)	
			item := ccom_item (initializer)
		ensure
			compound_file_open: exists			
		end

feature -- Access

	new_stream (a_name: STRING; a_mode: INTEGER) : ECOM_STREAM is
			-- Newly created stream with name `a_name'
			-- and mode `a_mode' nested within Current storage
			-- Opening the same stream more than once from the 
			-- same storage is not supported. 
			-- STGM_SHARE_EXCLUSIVE flag must be specified. 
		require
			non_void_storage_name: a_name /= Void
			valid_storage_name: not a_name.empty
			valid_mode: is_valid_stgm (a_mode)
		local
			wide_string: ECOM_WIDE_STRING
		do
			create wide_string.make_from_string (a_name)
			create Result.make_from_pointer (ccom_create_stream (initializer, 
					wide_string.item, a_mode))
		ensure
			non_void_stream: Result /= Void
			valid_stream: Result.exists
		end

	retrieved_stream (a_name: STRING; a_mode: INTEGER): ECOM_STREAM is
			-- Retrieved nested stream with name `a_name' 
			-- and mode `a_mode' 
			-- same storage is not supported. 
			-- STGM_SHARE_EXCLUSIVE flag must be specified.
		require
			non_void_name: a_name /= Void
			valid_name: is_valid_name (a_name)
			valid_mode: is_valid_stgm (a_mode)
		local
			wide_string: ECOM_WIDE_STRING
		do
			create wide_string.make_from_string (a_name)
			create Result.make_from_pointer (ccom_open_stream (initializer, 
					wide_string.item, a_mode))
		ensure
			non_void_stream: Result /= Void
			valid_stream: Result.exists
		end

	new_substorage (a_name: STRING; a_mode: INTEGER): ECOM_STORAGE is
			-- Newly created storage with name `a_name'
			-- and mode `a_mode'
			-- nested within Current storage 
		require
			non_void_storage_name: a_name /= Void
			valid_storage_name: not a_name.empty
			valid_mode: is_valid_stgm (a_mode)
		local
			wide_string: ECOM_WIDE_STRING
		do
			create wide_string.make_from_string (a_name)
			create Result.make_from_pointer (ccom_create_storage (initializer, 
					wide_string.item, a_mode))
		ensure
			non_void_storage: Result /= Void
			valid_storage: Result.exists
		end

	retrieved_substorage (a_name: STRING; a_mode: INTEGER): ECOM_STORAGE is
			-- Retrieved storage with name `a_name' and mode `a_mode' 
			-- nested within Current storage
			-- Opening the same storage object more than once from the same 
			-- parent storage is not supported. 
			-- STGM_SHARE_EXCLUSIVE flag must be specified. 
		require
			non_void_name: a_name /= Void
			valid_name: is_valid_name (a_name)
			valid_mode: is_valid_stgm (a_mode)
		local
			wide_string: ECOM_WIDE_STRING
		do
			create wide_string.make_from_string (a_name)
			create Result.make_from_pointer (ccom_open_storage (initializer, 
					wide_string.item, a_mode))
		ensure
			non_void_storage: Result /= Void
			valid_storage: Result.exists
		end

	root_storage: ECOM_ROOT_STORAGE is
			-- IRootStorage interface
		local
			ptr: POINTER
		do
			ptr := ccom_root_storage (initializer)
			if (ptr /= default_pointer) then
				create Result.make_from_pointer (ptr)
			end
		end 

	elements: ECOM_ENUM_STATSTG is
			-- Substorages and substreams enumerator		
		do
			create Result.make_from_pointer (ccom_enum_elements (initializer))
		ensure
			Result /= Void
		end

	is_valid_name (a_name: STRING): BOOLEAN is
			-- is object with name `a_name'  
			-- part of Current storage
		require
			valid_name: a_name /= Void
		do
			Result := elements.is_valid_name (a_name)
		end

	name: STRING is
			-- Name
		do
			Result := description (Statflag_default).name
		end

	is_same_name (a_name: STRING): BOOLEAN is
			-- is `a_name' equal to name of Current storage
		do
			Result := description (Statflag_default).is_same_name (a_name)
		end

	modification_time: WEL_FILE_TIME is
			-- Modufication time
		do
			Result := description (Statflag_noname).modification_time
		end

	creation_time: WEL_FILE_TIME is
			-- Creation time
		do
			Result := description (Statflag_noname).creation_time
		end

	access_time: WEL_FILE_TIME is
			-- Access time
		do
			Result := description (Statflag_noname).access_time
		end

	mode: INTEGER is
			-- Access mode
		do
			Result := description (Statflag_noname).mode
		end

	class_id: POINTER is
			-- Class identifier
		do
			Result := description (Statflag_noname).clsid
		end

	element_creation_time (a_name: STRING): WEL_FILE_TIME is
			-- Creation time of element `a_name'
		require 
			non_void_name: a_name /= Void
			valid_name: is_valid_name (a_name)
		do
			Result := elements.creation_time (a_name)
		ensure
			non_void_creation_time: Result /= Void
		end

	element_access_time (a_name: STRING): WEL_FILE_TIME is
			-- Access time of element `a_name'
		require 
			non_void_name: a_name /= Void
			valid_name: is_valid_name (a_name)
		do
			Result := elements.access_time (a_name)
		ensure
			non_void_access_time: Result /= Void
		end

	element_modification_time (a_name: STRING): WEL_FILE_TIME is
			-- Modification time of element `a_name'
		require 
			non_void_name: a_name /= Void
			valid_name: is_valid_name (a_name)
		do
			Result := elements.modification_time (a_name)
		ensure
			non_void_modification_time: Result /= Void
		end

feature -- Basic Operations

	copy_all_to (dest_storage: ECOM_STORAGE) is
			-- Copy entire contents to `dest_storage'.
		require
			non_void_destination: dest_storage /= Void
			valid_destination: dest_storage.exists
		do
			ccom_copy_to (initializer, 0, default_pointer, 
					dest_storage.item)
		end

	commit (a_flags: INTEGER) is
			-- Commit any changes.
			-- Notify parent storage.
		require
			valid_flags: is_valid_stgc (a_flags)
		do
			ccom_commit (initializer, a_flags)
		end

	revert is
			-- Discard all changes made to storage object 
			-- since the last commit
		do 
			ccom_revert (initializer)
		end

	destroy_element (a_name: STRING) is
			-- Remove element with name `a_name' from storage. 
		require
			non_void_name: a_name /= Void
			valid_name: is_valid_name (a_name)
		local
			wide_string: ECOM_WIDE_STRING
		do
			create wide_string.make_from_string (a_name)	
			ccom_destroy_element (initializer, wide_string.item)
		ensure
			element_removed: not is_valid_name (a_name)
		end

	rename_element (old_name: STRING; new_name:STRING) is
			-- Rename element `old_name' into `new_name'
		require
			non_void_old_name: old_name /= Void
			valid_old_name: is_valid_name (old_name)
			non_void_new_name: new_name /= Void
			valid_new_name: is_valid_name (new_name)
		local
			wide_string1, wide_string2: ECOM_WIDE_STRING
		do
			create wide_string1.make_from_string (old_name)
			create wide_string2.make_from_string (new_name)
			ccom_rename_element (initializer, wide_string1.item, 
						wide_string2.item)
		ensure
			not_valid_old_name: not is_valid_name (old_name)
			valid_new_name: is_valid_name (new_name)
		end

feature -- Element Change

	move_element_to (a_element_name: STRING; dest_storage: ECOM_STORAGE; new_name: STRING; 
				a_mode: INTEGER) is
			-- Copy or move (depending on `mode') element `a_element_name'  
			-- of root storage to `dest_storage'.
			-- Create new element in `dest_storage' with `new_name'.
			-- See class ECOM_STGM for `a_mode' values.
			-- Before calling this method, the element to be moved must 
			-- be closed, and the destination storage must be open. 
		require
			non_void_element_name: a_element_name /= Void
			valid_element_name: is_valid_name (a_element_name)
			non_void_dest_storage: dest_storage /= Void
			valid_dest_storage: dest_storage.exists
			non_void_new_name: new_name /= Void
			valid_new_name: not new_name.empty
			valid_mode: is_valid_stgmove (a_mode)
		local
			wide_string1, wide_string2: ECOM_WIDE_STRING
		do
			create wide_string1.make_from_string (a_element_name)
			create wide_string2.make_from_string (new_name)
			ccom_move_element_to (initializer, wide_string1.item, dest_storage.item, 
							wide_string2.item, a_mode)
		ensure
			element_moved: dest_storage.is_valid_name (new_name)
		end

	set_element_creation_time (a_element_name:STRING; a_creation_time: WEL_FILE_TIME) is
			-- Set creation time of element `a_element_name' with `a_creation_time'.
		require
			non_void_element_name: a_element_name /= Void
			valid_element_name: is_valid_name (a_element_name)
			valid_creation_time: a_creation_time /= Void
		local
			wide_string: ECOM_WIDE_STRING	
		do
			create wide_string.make_from_string (a_element_name)
			ccom_set_element_times (initializer, wide_string.item, a_creation_time.item,
						default_pointer, default_pointer)
		ensure
			element_creation_time_set: element_creation_time (a_element_name).is_equal (a_creation_time)
		end

	set_element_access_time (a_element_name:STRING; an_access_time: WEL_FILE_TIME) is
			-- Set access time of element `a_element_name' with `an_access_time'.
		require
			non_void_element_name: a_element_name /= Void
			valid_element_name: is_valid_name (a_element_name)
			valid_access_time: an_access_time /= Void
		local
			wide_string: ECOM_WIDE_STRING	
		do
			create wide_string.make_from_string (a_element_name)
			ccom_set_element_times (initializer, wide_string.item, default_pointer,
						an_access_time.item, default_pointer)
		ensure
			element_access_time_set: element_access_time (a_element_name).is_equal (an_access_time)
		end

	set_element_modification_time (a_element_name:STRING; a_modification_time: WEL_FILE_TIME) is
			-- Set modification time of element `a_element_name' with `a_modification_time'.
		require
			non_void_element_name: a_element_name /= Void
			valid_element_name: is_valid_name (a_element_name)
			valid_modification_time: a_modification_time /= Void
		local
			wide_string: ECOM_WIDE_STRING	
		do
			create wide_string.make_from_string (a_element_name)
			ccom_set_element_times (initializer, wide_string.item, default_pointer,
						default_pointer, a_modification_time.item)
		ensure
			element_access_time_set: element_modification_time (a_element_name).is_equal (a_modification_time)
		end

	set_access_time (an_access_time: WEL_FILE_TIME) is
			-- Set access time with `an_access_time'.
		require
			non_void_access_time: an_access_time /= Void
		do
			ccom_set_element_times (initializer, default_pointer, default_pointer,
						an_access_time.item, default_pointer)
		ensure
			access_time_set: access_time.is_equal (an_access_time)
		end

	set_modification_time (a_modification_time: WEL_FILE_TIME) is
			-- Set modification time with `a_modification_time'.
		require
			non_void_modification_time: a_modification_time /= Void
		do
			ccom_set_element_times (initializer, default_pointer, default_pointer,
						default_pointer, a_modification_time.item)
		ensure
			modification_time_set: modification_time.is_equal (a_modification_time)
		end

	set_creation_time (a_creation_time: WEL_FILE_TIME) is
			-- Set creation time with `creation_time'.
		require
			non_void_creation_time: a_creation_time /= Void
		do
			ccom_set_element_times (initializer, default_pointer, a_creation_time.item,
						default_pointer, default_pointer)
		ensure
			creation_time_set: creation_time.is_equal (a_creation_time)
		end


	set_class (a_class_id: POINTER) is
			-- Associate storage with COM component with class id `a_class-id'
		require
			valid_clsid: a_class_id /= default_pointer;
		do 
			ccom_set_class (initializer, a_class_id)
		end

feature {NONE} -- Implementation

	delete_wrapper is
			-- Delete structure.
		do
			ccom_delete_c_storage (initializer)
		end

	description (a_flag: INTEGER): ECOM_STATSTG is
			-- STATSTG structure
			-- This structure contains statistical information. 
		require
			valid_flag: is_valid_stat_flag (a_flag)
		do
			create Result.make_from_pointer (ccom_stat (initializer, a_flag))
		ensure
			valid_description: Result /= Void
		end

feature {NONE} -- Externals

	ccom_create_c_storage: POINTER is
		external
			"C++ [new E_IStorage %"E_IStorage.h%"] ()"
		end

	ccom_create_c_storage_from_pointer (a_pointer: POINTER): POINTER is
		external
			"C++ [new E_IStorage %"E_IStorage.h%"] (IStorage *)"
		end

	ccom_delete_c_storage (cpp_obj: POINTER) is
		external
			"C++ [delete E_IStorage %"E_IStorage.h%"] ()"
		end

	ccom_create_doc_file (cpp_obj: POINTER; filename: POINTER; a_mode: INTEGER) is
		external
			"C++ [E_IStorage %"E_IStorage.h%"] (WCHAR *, DWORD)"
		end

	ccom_open_root_storage (cpp_obj: POINTER; filename: POINTER; a_mode: INTEGER) is
		external
			"C++ [E_IStorage %"E_IStorage.h%"] (WCHAR *, DWORD)"
		end

	ccom_initialize_storage (cpp_obj: POINTER; p_storage: POINTER) is
		external
			"C++ [E_IStorage %"E_IStorage.h%"] (IStorage *)"
		end

	ccom_create_stream (cpp_obj: POINTER; filename: POINTER; a_mode: INTEGER): POINTER is
		external
			"C++ [E_IStorage %"E_IStorage.h%"] (WCHAR *, DWORD): EIF_POINTER"
		end

	ccom_open_stream (cpp_obj: POINTER; filename: POINTER; a_mode: INTEGER): POINTER is
		external
			"C++ [E_IStorage %"E_IStorage.h%"] (WCHAR *, DWORD): EIF_POINTER"
		end

	ccom_create_storage (cpp_obj: POINTER; filename: POINTER; a_mode: INTEGER): POINTER is
		external
			"C++ [E_IStorage %"E_IStorage.h%"] (WCHAR *, DWORD): EIF_POINTER"
		end

	ccom_open_storage (cpp_obj: POINTER; filename: POINTER; a_mode: INTEGER): POINTER is
		external
			"C++ [E_IStorage %"E_IStorage.h%"] (WCHAR *,  DWORD): EIF_POINTER"
		end

	ccom_copy_to (cpp_obj: POINTER; number_exclude: INTEGER; p_exclude: POINTER;
				dest: POINTER) is
		external
			"C++ [E_IStorage %"E_IStorage.h%"] (DWORD, IID *, IStorage *)"
		end

	ccom_move_element_to (cpp_obj: POINTER; a_name: POINTER; dest: POINTER;
				new_name: POINTER; flags: INTEGER) is
		external
			"C++ [E_IStorage %"E_IStorage.h%"] (WCHAR *, IStorage *, LPWSTR, DWORD)"
		end

	ccom_commit (cpp_obj: POINTER; flags: INTEGER) is

		external
			"C++ [E_IStorage %"E_IStorage.h%"] (DWORD)"
		end

	ccom_revert (cpp_obj: POINTER) is
		external
			"C++ [E_IStorage %"E_IStorage.h%"] ()"
		end

	ccom_enum_elements (cpp_obj: POINTER): POINTER is
		external
			"C++ [E_IStorage %"E_IStorage.h%"] (): EIF_POINTER"
		end

	ccom_destroy_element (cpp_obj: POINTER; a_name: POINTER) is
		external
			"C++ [E_IStorage %"E_IStorage.h%"] (WCHAR *)"
		end

	ccom_rename_element (cpp_obj: POINTER; old_name: POINTER; new_name:POINTER) is
		external
			"C++ [E_IStorage %"E_IStorage.h%"] (WCHAR *, WCHAR *)"
		end

	ccom_set_element_times (cpp_obj: POINTER; a_name: POINTER; ctime: POINTER;
			atime: POINTER; mtime: POINTER) is
		external
			"C++ [E_IStorage %"E_IStorage.h%"] (WCHAR *, FILETIME *, FILETIME *, FILETIME *)"
		end

	ccom_set_class (cpp_obj: POINTER; a_clsid: POINTER) is
		external
			"C++ [E_IStorage %"E_IStorage.h%"] (REFCLSID)"
		end

	ccom_stat (cpp_obj: POINTER; a_flag: INTEGER): POINTER is
		external
			"C++ [E_IStorage %"E_IStorage.h%"] (DWORD): EIF_POINTER"
		end
	
	ccom_root_storage (cpp_obj: POINTER) : POINTER is
			-- Pointer to IRootStorage interface
		external
			"C++ [E_IStorage %"E_IStorage.h%"] ():EIF_POINTER"
		end

	ccom_item (cpp_obj: POINTER): POINTER is
			-- Item
		external
			"C++ [E_IStorage %"E_IStorage.h%"]():EIF_POINTER"
		end
	
end -- class ECOM_STORAGE

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| Copyright (C) 2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support http://support.eiffel.com
--| For latest info see award-winning pages: http://eiffel.com
--|----------------------------------------------------------------

