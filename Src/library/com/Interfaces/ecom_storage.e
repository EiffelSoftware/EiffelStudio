indexing
	description: "implementation of IStorage interface"
	date: "$Date$"
	revision: "$Revision$"

class
	ECOM_STORAGE

inherit

	MEMORY
		redefine
			dispose
		end

	ECOM_STORAGE_ROUTINES

	ECOM_STGC

	ECOM_STGM

	ECOM_STGMOVE
	
	ECOM_STAT_FLAGS

creation
	make_new_doc_file,
	make_temporary_doc_file,
	make_open_file,
	make_from_storage

feature {NONE} -- Initialization

	make_new_doc_file (filename: FILE_NAME; a_mode: INTEGER) is
			-- Create new compound file with path `filename' 
			-- and mode `a_mode' in file system.
			-- See class ECOM_STGM for `mode' values.
		require
			valid_filename: filename /= Void
			-- valid_mode: is_valid_stgm (a_mode)
		local
			wide_string: ECOM_WIDE_STRING
		do
			initializer := ccom_create_c_storage;
			!! wide_string.make_from_string (filename);
			ccom_create_doc_file(initializer, wide_string.item, a_mode);
			item := ccom_storage(initializer)
		ensure
			compound_file_created: item /= Default_pointer
		end

	make_temporary_doc_file (a_mode: INTEGER) is
			-- Create temporary compound file with mode `mode'
			-- See class ECOM_STGM for `a_mode' values.
		require
			-- valid_mode: is_valid_stgm (a_mode)
		do
			initializer := ccom_create_c_storage;
			ccom_create_doc_file(initializer, Default_pointer, a_mode);
			item := ccom_storage(initializer)
		ensure
			compound_file_created: item /= Default_pointer
		end

	make_open_file (filename: FILE_NAME; a_mode: INTEGER) is
			-- Open existing root compound file with path `filename' 
			-- and mode `mode' in file system.
			-- excluding block pointed by `exclude' (can be Default_pointer)
			-- See class ECOM_STGM for `a_mode' values.
		require
			valid_file: filename /= Void and then is_compound_file (filename)
			-- valid_mode: is_valid_stgm (a_mode)
		local
			wide_string: ECOM_WIDE_STRING
		do
			initializer := ccom_create_c_storage;				
			!! wide_string.make_from_string (filename);
			ccom_open_root_storage(initializer, wide_string.item, a_mode);	
			item := ccom_storage(initializer)
		ensure
			compound_file_open: item /= Default_pointer			
		end

	make_from_storage (a_storage: POINTER) is
			-- Create new instance with `a_storage' as 
			-- IStorage interface pointer
		require
			valid_storage: a_storage /= Default_pointer
		do
			initializer := ccom_create_c_storage;
			ccom_initialize_storage (initializer, a_storage);
			item := ccom_storage(initializer)
		ensure
			storage_created: item /= Default_pointer
		end

feature -- Access

	new_stream (a_name: STRING; a_mode: INTEGER) : ECOM_STREAM is
			-- Newly created stream with name `a_name'
			-- and mode `a_mode'
			-- nested within Current storage
			-- Opening the same stream more than once from the 
			-- same storage is not supported. 
			-- STGM_SHARE_EXCLUSIVE flag must be specified. 
		require
			valid_storagename: a_name /= Void
			-- valid_mode: is_valid_stgm (a_mode)
		local
			wide_string: ECOM_WIDE_STRING
		do
			!! wide_string.make_from_string (a_name);
			!!Result.make_from_stream (ccom_create_stream (initializer, 
					wide_string.item, a_mode));
		ensure
			stream_created: Result /= Void and then
					Result.item /= Default_pointer;			
		end

	retrieved_stream (a_name: STRING; a_mode: INTEGER): ECOM_STREAM is
			-- Retrieved nested stream with name `a_name' 
			-- and mode `a_mode' 
			-- same storage is not supported. 
			-- STGM_SHARE_EXCLUSIVE flag must be specified.
		require
			valid_name: a_name /= Void and is_valid_name (a_name)
			-- valid_mode: is_valid_stgm (a_mode)
		local
			wide_string: ECOM_WIDE_STRING
		do
			!! wide_string.make_from_string (a_name);
			!!Result.make_from_stream(ccom_open_stream (initializer, 
					wide_string.item, a_mode));
		ensure
			stream_created: Result /= Void and then
					Result.item /= Default_pointer;
		end

	new_substorage (a_name: STRING; a_mode: INTEGER): ECOM_STORAGE is
			-- Newly created storage with name `a_name'
			-- and mode `a_mode'
			-- nested within Current storage 
		require
			valid_storagename: a_name /= Void
			-- valid_mode: is_valid_stgm (a_mode)
		local
			wide_string: ECOM_WIDE_STRING
		do
			!! wide_string.make_from_string (a_name);
			!!Result.make_from_storage(ccom_create_storage (initializer, 
					wide_string.item, a_mode));
		ensure
			storage_created: Result /= Void and then
					Result.item /= Default_pointer;
		end

	retrieved_substorage (a_name: STRING; a_mode: INTEGER): ECOM_STORAGE is
			-- Retrieved storage with name `a_name' 
			-- and mode `a_mode' 
			-- nested within Current storage
			-- Opening the same storage object more than once from the same 
			-- parent storage is not supported. 
			-- STGM_SHARE_EXCLUSIVE flag must be specified. 
		require
			valid_storage: (a_name /= Void and is_valid_name (a_name))
			-- valid_mode: is_valid_stgm (a_mode)
		local
			wide_string: ECOM_WIDE_STRING
		do
			!! wide_string.make_from_string (a_name);
			!!Result.make_from_storage(ccom_open_storage (initializer, 
					wide_string.item, a_mode));
		ensure
			storage_created: Result /= Void and then
					Result.item /= Default_pointer;
		end

	root_storage: ECOM_ROOT_STORAGE is
			-- IRootStorage interface
			-- needed in low memory conditions
		local
			ptr: POINTER
		do
			ptr := ccom_root_storage(initializer)
			if (ptr /= Default_pointer) then
				!!Result.make_from_iroot_storage(ptr)
			end
		end 

	enum_elements: ECOM_ENUM_STATSTG is
			-- Substorages and substreams enumerator		
		do
			!!Result.make_from_enum_ptr (ccom_enum_elements (initializer));
		ensure
			Result /= Void
		end

	is_valid_name (a_name: STRING): BOOLEAN is
			-- is object with name `a_name'  
			-- part of Current storage
		require
			valid_name: a_name /= Void
		do
			Result := enum_elements.is_valid_name (a_name)
		end

	name: STRING is
			-- Name
		do
			Result := description(Statflag_default).name
		end

	is_same_name(a_name: STRING): BOOLEAN is
			-- is `a_name' equal to name of Current storage
		do
			Result := description(Statflag_default).is_same_name(a_name)
		end

	modification_time: POINTER is
			-- Modufication time
		do
			Result := description(Statflag_noname).modification_time
		end

	creation_time: POINTER is
			-- Creation time
		do
			Result := description(Statflag_noname).creation_time
		end

	access_time: POINTER is
			-- Access time
		do
			Result := description(Statflag_noname).access_time
		end

	mode: INTEGER is
			-- Access mode
		do
			Result := description(Statflag_noname).mode
		end

	class_id: POINTER is
			-- Class identifier for Current storage
		do
			Result := description(Statflag_noname).clsid
		end

feature -- Basic Operations

	copy_all_to (dest_storage: ECOM_STORAGE) is
			-- Copy entire contents to `dest_storage'
		require
			dest_exist: dest_storage /= Void and then
						dest_storage.item /= Default_pointer;
		do
			ccom_copy_to (initializer, 0, Default_pointer, 
					dest_storage.item);
		end

	commit (a_flags: INTEGER) is
			-- Commit any changes made to Current 
			-- notify parent storage
		require
			valid_flags: is_valid_stgc (a_flags);
			open_in_transacted_mode: ;
		do
			ccom_commit (initializer, a_flags);
		ensure
			-- 
		end

	revert is
			-- Discard all changes made to the storage object 
			-- since the last commit
		do 
			ccom_revert (initializer);
		end

	destroy_element (a_name: STRING) is
			-- Remove element with name `a_name' from storage. 
		require
			valid_element_name: a_name /= Void and then is_valid_name (a_name)
		local
			wide_string: ECOM_WIDE_STRING
		do
			!! wide_string.make_from_string (a_name);	
			ccom_destroy_element (initializer, wide_string.item);
		ensure
			element_removed: not is_valid_name (a_name)
		end

	rename_element (old_name: STRING; new_name:STRING) is
			-- Rename element `old_name' into `new_name'
		require
			valid_old_name: old_name /= Void and then is_valid_name (old_name)
			valid_new_name: new_name /= Void and then not is_valid_name (new_name)
		local
			wide_string1, wide_string2: ECOM_WIDE_STRING
		do
			!! wide_string1.make_from_string (old_name);
			!! wide_string2.make_from_string (new_name);
			ccom_rename_element (initializer, wide_string1.item, 
						wide_string2.item);
		ensure
			not is_valid_name (old_name)
			is_valid_name (new_name)
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
			valid_element_name: a_element_name /= Void and then is_valid_name (a_element_name);
			valid_dest_storage: dest_storage /= Void and then
					dest_storage.item /= Default_pointer;
			valid_new_name: new_name /= Void;
			valid_mode: is_valid_stgmove (a_mode)
		local
			wide_string1, wide_string2: ECOM_WIDE_STRING
		do
			!! wide_string1.make_from_string (a_element_name);
			!! wide_string2.make_from_string (new_name);
			ccom_move_element_to (initializer, wide_string1.item, dest_storage.item, 
							wide_string2.item, a_mode);
		ensure
			dest_storage.is_valid_name(new_name)
		end

	set_element_creation_time (a_element_name:STRING; a_creation_time: POINTER) is
			-- set creation time 
			-- of element `a_element_name' with `a_creation_time'
		require
			valid_element_name: a_element_name /= Void and then is_valid_name (a_element_name)
			valid_creation_time: a_creation_time /= Default_pointer
		local
			wide_string: ECOM_WIDE_STRING	
		do
			!!wide_string.make_from_string (a_element_name);
			ccom_set_element_times (initializer, wide_string.item, a_creation_time,
						Default_pointer, Default_pointer);
		end

	set_element_access_time (a_element_name:STRING; an_access_time: POINTER) is
			-- set access time
			-- of element `a_element_name' with `an_access_time'
		require
			valid_element_name: a_element_name /= Void and then is_valid_name (a_element_name)
			valid_access_time: an_access_time /= Default_pointer
		local
			wide_string: ECOM_WIDE_STRING	
		do
			!!wide_string.make_from_string (a_element_name);
			ccom_set_element_times (initializer, wide_string.item, Default_pointer,
						an_access_time, Default_pointer);
		end

	set_element_modification_time (a_element_name:STRING; a_modification_time: POINTER) is
			-- set modification time
			-- of element `a_element_name' with `a_modification_time'
		require
			valid_element_name: a_element_name /= Void and then is_valid_name (a_element_name)
			valid_modification_time: a_modification_time /= Default_pointer
		local
			wide_string: ECOM_WIDE_STRING	
		do
			!!wide_string.make_from_string (a_element_name);
			ccom_set_element_times (initializer, wide_string.item, Default_pointer,
						Default_pointer, a_modification_time);
		end

	set_access_time ( an_access_time: POINTER) is
			-- set access time with `an_access_time'
		require
			an_access_time /= Default_pointer
		do
			ccom_set_element_times (initializer, Default_pointer, Default_pointer,
						an_access_time, Default_pointer);
		ensure
			access_time = an_access_time
		end

	set_modification_time (a_modification_time: POINTER) is
			-- set modification time with `a_modification_time'
		require
			a_modification_time /= Default_pointer
		do
			ccom_set_element_times (initializer, Default_pointer, Default_pointer,
						Default_pointer, a_modification_time);
		ensure
			modification_time = a_modification_time
		end

	set_creation_time (a_creation_time: POINTER) is
			-- set creation time with `creation_time'
		require
			a_creation_time /= Default_pointer
		do
			ccom_set_element_times (initializer, Default_pointer, a_creation_time,
						Default_pointer, Default_pointer);
		ensure
			creation_time = a_creation_time
		end


	set_class (a_class_id: POINTER) is
			-- Associate storage with COM component with class id `a_class-id'
		require
			valid_clsid: a_class_id /= Default_pointer;
		do 
			ccom_set_class (initializer, a_class_id);
		end

feature {ECOM_STORAGE}

	item: POINTER 
			-- Pointer to IStorage interface

feature {NONE} -- Implementation

	initializer: POINTER
			-- Pointer to structure

	dispose is
			-- Delete structure
		do
			ccom_delete_c_storage (initializer);
		end

	description (a_flag: INTEGER): ECOM_STATSTG is
			-- STATSTG structure
			-- This structure contains statistical information. 
		require
			valid_flag: is_valid_stat_flag (a_flag);
		do
			!!Result.make_from_statstg(ccom_stat(initializer, a_flag));
		ensure
			Result /= Void
		end

feature {NONE} -- Externals

	ccom_create_c_storage: POINTER is
		external
			"C++ [new E_IStorage %"E_IStorage.h%"]()"
		end

	ccom_delete_C_storage (cpp_obj: POINTER) is
		external
			"C++ [delete E_IStorage %"E_IStorage.h%"]()"
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

	ccom_storage (cpp_obj: POINTER) : POINTER is
			-- Pointer to IStorage interface
		external
			"C++ [E_IStorage %"E_IStorage.h%"] ():EIF_POINTER"
		end
	
	ccom_root_storage (cpp_obj: POINTER) : POINTER is
			-- Pointer to IRootStorage interface
		external
			"C++ [E_IStorage %"E_IStorage.h%"] ():EIF_POINTER"
		end


invariant 
	valid_cpp_object: initializer /= Default_pointer;
	valid_root_storage: item /= Default_pointer;
		
end -- class ECOM_STORAGE
