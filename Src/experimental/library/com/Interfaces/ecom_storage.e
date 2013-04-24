note
	description: "implementation of IStorage interface"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

create
	make_new_doc_file,
	make_new_doc_file_path,
	make_temporary_doc_file,
	make_open_file,
	make_open_file_path,
	make_from_other,
	make_from_pointer

feature {NONE} -- Initialization

	make_from_pointer (cpp_obj: POINTER)
			-- Make from pointer
		do
			initializer := ccom_create_c_storage_from_pointer (cpp_obj)
			item := ccom_item (initializer)
		end

	make_new_doc_file (filename: FILE_NAME; a_mode: INTEGER)
			-- Create new compound file with path `filename'
			-- and mode `a_mode' in file system.
			-- See class ECOM_STGM for `mode' values.
		require
			valid_filename: filename /= Void
			valid_mode: is_valid_stgm (a_mode)
		local
			l_string: WEL_STRING
		do
			initializer := ccom_create_c_storage;
			create l_string.make (filename)
			ccom_create_doc_file (initializer, l_string.item, a_mode)
			item := ccom_item (initializer)
		ensure
			compound_file_created: exists
		end

	make_new_doc_file_path (file_path: PATH; a_mode: INTEGER)
			-- Create new compound file with path `file_path'
			-- and mode `a_mode' in file system.
			-- See class ECOM_STGM for `mode' values.
		require
			valid_file_path: file_path /= Void
			valid_mode: is_valid_stgm (a_mode)
		local
			l_string: WEL_STRING
		do
			initializer := ccom_create_c_storage;
			create l_string.make (file_path.name)
			ccom_create_doc_file (initializer, l_string.item, a_mode)
			item := ccom_item (initializer)
		ensure
			compound_file_created: exists
		end

	make_temporary_doc_file (a_mode: INTEGER)
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

	make_open_file (filename: FILE_NAME; a_mode: INTEGER)
			-- Open existing root compound file with path `filename'
			-- and mode `mode' in file system.
			-- excluding block pointed by `exclude' (can be default_pointer)
			-- See class ECOM_STGM for `a_mode' values.
		require
			valid_file: filename /= Void and then is_compound_file (filename)
			valid_mode: is_valid_stgm (a_mode)
		local
			l_string: WEL_STRING
		do
			initializer := ccom_create_c_storage;
			create l_string.make (filename)
			ccom_open_root_storage (initializer, l_string.item, a_mode)
			item := ccom_item (initializer)
		ensure
			compound_file_open: exists
		end

	make_open_file_path (file_path: PATH; a_mode: INTEGER)
			-- Open existing root compound file with path `file_path'
			-- and mode `mode' in file system.
			-- excluding block pointed by `exclude' (can be default_pointer)
			-- See class ECOM_STGM for `a_mode' values.
		require
			valid_file: file_path /= Void and then is_compound_file_path (file_path)
			valid_mode: is_valid_stgm (a_mode)
		local
			l_string: WEL_STRING
		do
			initializer := ccom_create_c_storage;
			create l_string.make (file_path.name)
			ccom_open_root_storage (initializer, l_string.item, a_mode)
			item := ccom_item (initializer)
		ensure
			compound_file_open: exists
		end

feature -- Access

	new_stream (a_name: STRING; a_mode: INTEGER) : ECOM_STREAM
			-- Newly created stream with name `a_name'
			-- and mode `a_mode' nested within Current storage
			-- Opening the same stream more than once from the
			-- same storage is not supported.
			-- STGM_SHARE_EXCLUSIVE flag must be specified.
		require
			non_void_storage_name: a_name /= Void
			valid_storage_name: not a_name.is_empty
			valid_mode: is_valid_stgm (a_mode)
		local
			l_string: WEL_STRING
		do
			create l_string.make (a_name)
			create Result.make_from_pointer (ccom_create_stream (initializer,
					l_string.item, a_mode))
		ensure
			non_void_stream: Result /= Void
			valid_stream: Result.exists
		end

	retrieved_stream (a_name: STRING; a_mode: INTEGER): ECOM_STREAM
			-- Retrieved nested stream with name `a_name'
			-- and mode `a_mode'
			-- same storage is not supported.
			-- STGM_SHARE_EXCLUSIVE flag must be specified.
		require
			non_void_name: a_name /= Void
			valid_name: is_valid_name (a_name)
			valid_mode: is_valid_stgm (a_mode)
		local
			l_string: WEL_STRING
		do
			create l_string.make (a_name)
			create Result.make_from_pointer (ccom_open_stream (initializer,
					l_string.item, a_mode))
		ensure
			non_void_stream: Result /= Void
			valid_stream: Result.exists
		end

	new_substorage (a_name: STRING; a_mode: INTEGER): ECOM_STORAGE
			-- Newly created storage with name `a_name'
			-- and mode `a_mode'
			-- nested within Current storage
		require
			non_void_storage_name: a_name /= Void
			valid_storage_name: not a_name.is_empty
			valid_mode: is_valid_stgm (a_mode)
		local
			l_string: WEL_STRING
		do
			create l_string.make (a_name)
			create Result.make_from_pointer (ccom_create_storage (initializer,
					l_string.item, a_mode))
		ensure
			non_void_storage: Result /= Void
			valid_storage: Result.exists
		end

	retrieved_substorage (a_name: STRING; a_mode: INTEGER): ECOM_STORAGE
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
			l_string: WEL_STRING
		do
			create l_string.make (a_name)
			create Result.make_from_pointer (ccom_open_storage (initializer,
					l_string.item, a_mode))
		ensure
			non_void_storage: Result /= Void
			valid_storage: Result.exists
		end

	root_storage: ECOM_ROOT_STORAGE
			-- IRootStorage interface
		local
			ptr: POINTER
		do
			ptr := ccom_root_storage (initializer)
			if (ptr /= default_pointer) then
				create Result.make_from_pointer (ptr)
			end
		end

	elements: ECOM_ENUM_STATSTG
			-- Substorages and substreams enumerator		
		do
			create Result.make (ccom_enum_elements (initializer))
		ensure
			Result /= Void
		end

	is_valid_name (a_name: STRING): BOOLEAN
			-- is object with name `a_name'
			-- part of Current storage
		require
			valid_name: a_name /= Void
		do
			Result := elements.is_valid_name (a_name)
		end

	name: STRING
			-- Name
		do
			Result := description (Statflag_default).name
		end

	is_same_name (a_name: STRING): BOOLEAN
			-- is `a_name' equal to name of Current storage
		do
			Result := description (Statflag_default).is_same_name (a_name)
		end

	modification_time: WEL_FILE_TIME
			-- Modufication time
		do
			Result := description (Statflag_noname).modification_time
		end

	creation_time: WEL_FILE_TIME
			-- Creation time
		do
			Result := description (Statflag_noname).creation_time
		end

	access_time: WEL_FILE_TIME
			-- Access time
		do
			Result := description (Statflag_noname).access_time
		end

	mode: INTEGER
			-- Access mode
		do
			Result := description (Statflag_noname).mode
		end

	class_id: POINTER
			-- Class identifier
		do
			Result := description (Statflag_noname).clsid
		end

	element_creation_time (a_name: STRING): WEL_FILE_TIME
			-- Creation time of element `a_name'
		require
			non_void_name: a_name /= Void
			valid_name: is_valid_name (a_name)
		do
			Result := elements.creation_time (a_name)
		ensure
			non_void_creation_time: Result /= Void
		end

	element_access_time (a_name: STRING): WEL_FILE_TIME
			-- Access time of element `a_name'
		require
			non_void_name: a_name /= Void
			valid_name: is_valid_name (a_name)
		do
			Result := elements.access_time (a_name)
		ensure
			non_void_access_time: Result /= Void
		end

	element_modification_time (a_name: STRING): WEL_FILE_TIME
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

	copy_all_to (dest_storage: ECOM_STORAGE)
			-- Copy entire contents to `dest_storage'.
		require
			non_void_destination: dest_storage /= Void
			valid_destination: dest_storage.exists
		do
			ccom_copy_to (initializer, 0, default_pointer,
					dest_storage.item)
		end

	commit (a_flags: INTEGER)
			-- Commit any changes.
			-- Notify parent storage.
		require
			valid_flags: is_valid_stgc (a_flags)
		do
			ccom_commit (initializer, a_flags)
		end

	revert
			-- Discard all changes made to storage object
			-- since the last commit
		do
			ccom_revert (initializer)
		end

	destroy_element (a_name: STRING)
			-- Remove element with name `a_name' from storage.
		require
			non_void_name: a_name /= Void
			valid_name: is_valid_name (a_name)
		local
			l_string: WEL_STRING
		do
			create l_string.make (a_name)
			ccom_destroy_element (initializer, l_string.item)
		ensure
			element_removed: not is_valid_name (a_name)
		end

	rename_element (old_name: STRING; new_name:STRING)
			-- Rename element `old_name' into `new_name'
		require
			non_void_old_name: old_name /= Void
			valid_old_name: is_valid_name (old_name)
			non_void_new_name: new_name /= Void
			valid_new_name: is_valid_name (new_name)
		local
			l_string1, l_string2: WEL_STRING
		do
			create l_string1.make (old_name)
			create l_string2.make (new_name)
			ccom_rename_element (initializer, l_string1.item, l_string2.item)
		ensure
			not_valid_old_name: not is_valid_name (old_name)
			valid_new_name: is_valid_name (new_name)
		end

feature -- Element Change

	move_element_to (a_element_name: STRING; dest_storage: ECOM_STORAGE; new_name: STRING;
				a_mode: INTEGER)
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
			valid_new_name: not new_name.is_empty
			valid_mode: is_valid_stgmove (a_mode)
		local
			l_string1, l_string2: WEL_STRING
		do
			create l_string1.make (a_element_name)
			create l_string2.make (new_name)
			ccom_move_element_to (initializer, l_string1.item, dest_storage.item,
							l_string2.item, a_mode)
		ensure
			element_moved: dest_storage.is_valid_name (new_name)
		end

	set_element_creation_time (a_element_name:STRING; a_creation_time: WEL_FILE_TIME)
			-- Set creation time of element `a_element_name' with `a_creation_time'.
		require
			non_void_element_name: a_element_name /= Void
			valid_element_name: is_valid_name (a_element_name)
			valid_creation_time: a_creation_time /= Void
		local
			l_string: WEL_STRING
		do
			create l_string.make (a_element_name)
			ccom_set_element_times (initializer, l_string.item, a_creation_time.item,
						default_pointer, default_pointer)
		ensure
			element_creation_time_set: element_creation_time (a_element_name).is_equal (a_creation_time)
		end

	set_element_access_time (a_element_name:STRING; an_access_time: WEL_FILE_TIME)
			-- Set access time of element `a_element_name' with `an_access_time'.
		require
			non_void_element_name: a_element_name /= Void
			valid_element_name: is_valid_name (a_element_name)
			valid_access_time: an_access_time /= Void
		local
			l_string: WEL_STRING
		do
			create l_string.make (a_element_name)
			ccom_set_element_times (initializer, l_string.item, default_pointer,
						an_access_time.item, default_pointer)
		ensure
			element_access_time_set: element_access_time (a_element_name).is_equal (an_access_time)
		end

	set_element_modification_time (a_element_name:STRING; a_modification_time: WEL_FILE_TIME)
			-- Set modification time of element `a_element_name' with `a_modification_time'.
		require
			non_void_element_name: a_element_name /= Void
			valid_element_name: is_valid_name (a_element_name)
			valid_modification_time: a_modification_time /= Void
		local
			l_string: WEL_STRING
		do
			create l_string.make (a_element_name)
			ccom_set_element_times (initializer, l_string.item, default_pointer,
						default_pointer, a_modification_time.item)
		ensure
			element_access_time_set: element_modification_time (a_element_name).is_equal (a_modification_time)
		end

	set_access_time (an_access_time: WEL_FILE_TIME)
			-- Set access time with `an_access_time'.
		require
			non_void_access_time: an_access_time /= Void
		do
			ccom_set_element_times (initializer, default_pointer, default_pointer,
						an_access_time.item, default_pointer)
		ensure
			access_time_set: access_time.is_equal (an_access_time)
		end

	set_modification_time (a_modification_time: WEL_FILE_TIME)
			-- Set modification time with `a_modification_time'.
		require
			non_void_modification_time: a_modification_time /= Void
		do
			ccom_set_element_times (initializer, default_pointer, default_pointer,
						default_pointer, a_modification_time.item)
		ensure
			modification_time_set: modification_time.is_equal (a_modification_time)
		end

	set_creation_time (a_creation_time: WEL_FILE_TIME)
			-- Set creation time with `creation_time'.
		require
			non_void_creation_time: a_creation_time /= Void
		do
			ccom_set_element_times (initializer, default_pointer, a_creation_time.item,
						default_pointer, default_pointer)
		ensure
			creation_time_set: creation_time.is_equal (a_creation_time)
		end


	set_class (a_class_id: POINTER)
			-- Associate storage with COM component with class id `a_class-id'
		require
			valid_clsid: a_class_id /= default_pointer;
		do
			ccom_set_class (initializer, a_class_id)
		end

feature {NONE} -- Implementation

	delete_wrapper
			-- Delete structure.
		do
			ccom_delete_c_storage (initializer)
		end

	description (a_flag: INTEGER): ECOM_STATSTG
			-- STATSTG structure
			-- This structure contains statistical information.
		require
			valid_flag: is_valid_stat_flag (a_flag)
		do
			create Result.make (ccom_stat (initializer, a_flag))
		ensure
			valid_description: Result /= Void
		end

feature {NONE} -- Externals

	ccom_create_c_storage: POINTER
		external
			"C++ [new E_IStorage %"E_IStorage.h%"] ()"
		end

	ccom_create_c_storage_from_pointer (a_pointer: POINTER): POINTER
		external
			"C++ [new E_IStorage %"E_IStorage.h%"] (IStorage *)"
		end

	ccom_delete_c_storage (cpp_obj: POINTER)
		external
			"C++ [delete E_IStorage %"E_IStorage.h%"] ()"
		end

	ccom_create_doc_file (cpp_obj: POINTER; filename: POINTER; a_mode: INTEGER)
		external
			"C++ [E_IStorage %"E_IStorage.h%"] (WCHAR *, DWORD)"
		end

	ccom_open_root_storage (cpp_obj: POINTER; filename: POINTER; a_mode: INTEGER)
		external
			"C++ [E_IStorage %"E_IStorage.h%"] (WCHAR *, DWORD)"
		end

	ccom_initialize_storage (cpp_obj: POINTER; p_storage: POINTER)
		external
			"C++ [E_IStorage %"E_IStorage.h%"] (IStorage *)"
		end

	ccom_create_stream (cpp_obj: POINTER; filename: POINTER; a_mode: INTEGER): POINTER
		external
			"C++ [E_IStorage %"E_IStorage.h%"] (WCHAR *, DWORD): EIF_POINTER"
		end

	ccom_open_stream (cpp_obj: POINTER; filename: POINTER; a_mode: INTEGER): POINTER
		external
			"C++ [E_IStorage %"E_IStorage.h%"] (WCHAR *, DWORD): EIF_POINTER"
		end

	ccom_create_storage (cpp_obj: POINTER; filename: POINTER; a_mode: INTEGER): POINTER
		external
			"C++ [E_IStorage %"E_IStorage.h%"] (WCHAR *, DWORD): EIF_POINTER"
		end

	ccom_open_storage (cpp_obj: POINTER; filename: POINTER; a_mode: INTEGER): POINTER
		external
			"C++ [E_IStorage %"E_IStorage.h%"] (WCHAR *,  DWORD): EIF_POINTER"
		end

	ccom_copy_to (cpp_obj: POINTER; number_exclude: INTEGER; p_exclude: POINTER;
				dest: POINTER)
		external
			"C++ [E_IStorage %"E_IStorage.h%"] (DWORD, IID *, IStorage *)"
		end

	ccom_move_element_to (cpp_obj: POINTER; a_name: POINTER; dest: POINTER;
				new_name: POINTER; flags: INTEGER)
		external
			"C++ [E_IStorage %"E_IStorage.h%"] (WCHAR *, IStorage *, LPWSTR, DWORD)"
		end

	ccom_commit (cpp_obj: POINTER; flags: INTEGER)

		external
			"C++ [E_IStorage %"E_IStorage.h%"] (DWORD)"
		end

	ccom_revert (cpp_obj: POINTER)
		external
			"C++ [E_IStorage %"E_IStorage.h%"] ()"
		end

	ccom_enum_elements (cpp_obj: POINTER): POINTER
		external
			"C++ [E_IStorage %"E_IStorage.h%"] (): EIF_POINTER"
		end

	ccom_destroy_element (cpp_obj: POINTER; a_name: POINTER)
		external
			"C++ [E_IStorage %"E_IStorage.h%"] (WCHAR *)"
		end

	ccom_rename_element (cpp_obj: POINTER; old_name: POINTER; new_name:POINTER)
		external
			"C++ [E_IStorage %"E_IStorage.h%"] (WCHAR *, WCHAR *)"
		end

	ccom_set_element_times (cpp_obj: POINTER; a_name: POINTER; ctime: POINTER;
			atime: POINTER; mtime: POINTER)
		external
			"C++ [E_IStorage %"E_IStorage.h%"] (WCHAR *, FILETIME *, FILETIME *, FILETIME *)"
		end

	ccom_set_class (cpp_obj: POINTER; a_clsid: POINTER)
		external
			"C++ [E_IStorage %"E_IStorage.h%"] (REFCLSID)"
		end

	ccom_stat (cpp_obj: POINTER; a_flag: INTEGER): POINTER
		external
			"C++ [E_IStorage %"E_IStorage.h%"] (DWORD): EIF_POINTER"
		end

	ccom_root_storage (cpp_obj: POINTER) : POINTER
			-- Pointer to IRootStorage interface
		external
			"C++ [E_IStorage %"E_IStorage.h%"] ():EIF_POINTER"
		end

	ccom_item (cpp_obj: POINTER): POINTER
			-- Item
		external
			"C++ [E_IStorage %"E_IStorage.h%"]():EIF_POINTER"
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class ECOM_STORAGE

