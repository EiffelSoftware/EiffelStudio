indexing

	description: "COM IStorage interface"
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	EOLE_STORAGE

inherit
	EOLE_UNKNOWN
		export
			{NONE}	create_ole_interface_ptr
		redefine
			interface_identifier,
			interface_identifier_list,
			is_initializable_from_eiffel
		end

	EOLE_STGC
	
	EOLE_STGM

	EOLE_STGMOVE

creation
	make

feature -- Access

	interface_identifier: STRING is
			-- Interface identifier
		once
			Result := Iid_storage
		end

	interface_identifier_list: LINKED_LIST [STRING] is
			-- List of supported interfaces
		once
			Result := precursor
			Result.extend (Iid_storage)
		end

	is_initializable_from_eiffel: BOOLEAN is
			-- Does interface support Callbacks?
		once
			Result := False
		end

feature -- Message Transmission

	create_compound_file (filename: STRING; mode: INTEGER) is
			-- Create new root compound file with path `filename' 
			-- and mode `mode' in file system.
			-- If `filename' is Void then temporary compound file
			-- is allocated with unique name.
			-- See class EOLE_STGM for `mode' values.
		require
			valid_filename: filename /= Void
			valid_mode: is_valid_stgm (mode)
		local
			wel_string: WEL_STRING
		do
			!! wel_string.make (filename)
			attach_ole_interface_ptr (ole2_create_compound_file (wel_string.item, mode))
		end

	open_compound_file (filename: STRING; mode: INTEGER) is
			-- Open existing IStorage object with path `filename' 
			-- and mode `mode' in file system.
			-- See class EOLE_STGM for `mode' values
		require
			valid_filename: filename /= Void
			valid_mode: is_valid_stgm (mode)
		local
			wel_string: WEL_STRING
		do
			!! wel_string.make (filename)
			attach_ole_interface_ptr (ole2_open_compound_file (wel_string.item, mode))
		end

	create_stream (stream_name: STRING; mode: INTEGER): EOLE_STREAM is
			-- Create and immediately open a new IStream object `stream_name' 
			-- contained in current storage object with mode `mode'.
			-- See class EOLE_STGM for `mode' values.
		require
			valid_interface: is_valid_interface
			valid_stream_name: stream_name /= Void
			valid_mode: is_valid_stgm (mode)
		local
			pistream: POINTER;
			wel_string: WEL_STRING
		do
			!! Result.make
			!! wel_string.make (stream_name)
			pistream := ole2_storage_create_stream (ole_interface_ptr, wel_string.item, mode)
			Result.attach_ole_interface_ptr (pistream)
		end

	open_stream (stream_name: STRING; mode: INTEGER): EOLE_STREAM is
			-- Open `stream_name' according to `mode'.
			-- See class EOLE_STGM for `mode' values.
			-- Child stream object should be opened in
			-- EOLE_STG_SHARE_EXCLUSIVE access mode.
		require
			valid_interface: is_valid_interface
			valid_stream_name: stream_name /= Void
			valid_mode: is_valid_stgm (mode)
		local
			pistream: POINTER;
			wel_string: WEL_STRING
		do
			!! Result.make
			!! wel_string.make (stream_name)
			pistream := ole2_storage_open_stream (ole_interface_ptr, wel_string.item, mode)
			Result.attach_ole_interface_ptr (pistream)
		end

	create_substorage (storage_name: STRING; mode: INTEGER): EOLE_STORAGE is
			-- Create and open a new IStorage object `stg_name'
			-- within current storage object according to `mode'.
			-- See class EOLE_STGM for `mode' values.
		require
			valid_interface: is_valid_interface
			valid_storage_name: storage_name /= Void
			valid_mode: is_valid_stgm (mode)
		local
			pistoragesub: POINTER;
			wel_string: WEL_STRING
		do
			!! Result.make
			!! wel_string.make (storage_name)
			pistoragesub := ole2_storage_create_substorage (ole_interface_ptr, wel_string.item, mode)
			Result.attach_ole_interface_ptr (pistoragesub)
		end

	open_substorage (stg_name: STRING; mode: INTEGER): EOLE_STORAGE is
			-- Open `stg_name' according to `mode'.
			-- `stg_name' should be in current storage object.
			-- See class EOLE_STGM for `mode' values.
		require
			valid_interface: is_valid_interface
			valid_storage_name: stg_name /= Void
			valid_mode: is_valid_stgm (mode)
		local
			pistoragesub: POINTER;
			wel_string: WEL_STRING
		do
			!! Result.make
			!! wel_string.make (stg_name)
			pistoragesub := ole2_storage_open_substorage (ole_interface_ptr, wel_string.item, mode)
			Result.attach_ole_interface_ptr (pistoragesub)
		end

	destroy_element (element_name: STRING) is
			-- Remove `element_name' from this storage, subject to the
			-- transaction mode in which the storage object was opened.
		require
			valid_interface: is_valid_interface
			valid_element_name: element_name /= Void
		local
			wel_string: WEL_STRING
		do
			!! wel_string.make (element_name)
			ole2_storage_destroy_element (ole_interface_ptr, wel_string.item)
		end

	copy_to (stg_dest: EOLE_STORAGE) is
			-- Copy entire contents of `Current' into `stg_dest'.
		require
			valid_interface: is_valid_interface
			valid_destination_storage: stg_dest /= Void and then stg_dest.is_valid_interface
		do
			ole2_storage_copy_to (ole_interface_ptr, stg_dest.ole_interface_ptr)
		end

	move_element_to (element_name: STRING; stg_dest: EOLE_STORAGE; new_element_name: STRING; movmode: INTEGER) is
			-- Move `element_name' to `stg_dest' according to
			-- name `new_element_name' and mode `movmode'.
			-- See class EOLE_STGMOVE for `movmode' values.
		require
			valid_interface: is_valid_interface
			valid_element_name: element_name /= Void
			valid_destination_storage: stg_dest /= Void and then stg_dest.is_valid_interface
			valid_new_element_name: new_element_name /= Void
			valid_move_mode: is_valid_stgmove (movmode)
		local
			wel_string1, wel_string2: WEL_STRING
		do
			!! wel_string1.make (element_name)
			!! wel_string2.make (new_element_name)
			ole2_storage_move_element_to (ole_interface_ptr, wel_string1.item, stg_dest.ole_interface_ptr, wel_string2.item, movmode)
		end

	rename_element (old_element_name, new_element_name: STRING) is
			-- Rename `old_element_name' subject to the 
			-- transaction state of the IStorage object 
			-- into `new_element_name'.
		require
			valid_interface: is_valid_interface
			valid_old_element_name: old_element_name /= Void
			valid_new_element_name: new_element_name /= Void
		local
			wel_string1, wel_string2: WEL_STRING
		do
			!! wel_string1.make (old_element_name)
			!! wel_string2.make (new_element_name)
			ole2_storage_rename_element (ole_interface_ptr, wel_string1.item, wel_string2.item)
		end

	set_class (clsid: STRING) is
			-- Associate `clsid' as `Current' CLSID.
		require
			valid_interface: is_valid_interface
			valid_clsid: clsid /= Void
		local
			wel_string: WEL_STRING
		do
			!! wel_string.make (clsid)
			ole2_storage_set_class (ole_interface_ptr, wel_string.item)
		end

	commit (mode: INTEGER) is
			-- Commit any changes made to `Current' since it was
			-- opened or last committed to persistent storage.
			-- See class EOLE_STGC for `mode' values.
		require
			valid_interface: is_valid_interface
			valid_mode: is_valid_stgc (mode)
		do
			ole2_storage_commit (ole_interface_ptr, mode)
		end

	revert is
			-- Discard all changes made in or made visible to `Current'
			-- by nested commits since `Current' was opened or last
			-- committed.
		require
			valid_interface: is_valid_interface
		do
			ole2_storage_revert (ole_interface_ptr)
		end

	is_compound_file (filename: STRING): BOOLEAN is
			-- Does `filename' contain an IStorage object?
		require
			valid_filename: filename /= Void
		local
			wel_string: WEL_STRING
		do
			!! wel_string.make (filename)
			Result := ole2_is_compound_file (wel_string.item)
		end

	enum_elements: ARRAY [EOLE_STATSTG] is
			-- Enumerate elements immediately contained
			-- within current storage object.
		require
			valid_interface: is_valid_interface
		local
			statstg: EOLE_STATSTG
			polestatstg: POINTER
			pienumstatstg: POINTER
			ref_counter: INTEGER
		do
			from
				!! Result.make (1, 0)
				pienumstatstg := ole2_storage_enum_elements (ole_interface_ptr)
			until
				status.last_hresult /= S_ok
			loop
				polestatstg := ole2_enum_statstg_next (pienumstatstg)
				if status.last_hresult = S_ok then
					!! statstg
					statstg.attach (polestatstg)
					Result.force (statstg, Result.count + 1)
				end
			end
			ref_counter := ole2_unknown_release (pienumstatstg)
		end
	
feature {NONE} -- Externals

	ole2_create_compound_file (filename: POINTER; mode: INTEGER): POINTER is
		external
			"C"
		alias
			"eole2_create_compound_file"
		end

	ole2_open_compound_file (filename: POINTER; mode: INTEGER): POINTER is
		external
			"C"
		alias
			"eole2_open_compound_file"
		end

	ole2_is_compound_file (filename: POINTER): BOOLEAN is
		external
			"C"
		alias
			"eole2_is_compound_file"
		end

	ole2_storage_create_stream (pistoragethis, stream_name: POINTER; mode: INTEGER): POINTER is
		external
			"C"
		alias
			"eole2_storage_create_stream"
		end

	ole2_storage_open_stream (pistoragethis, stream_name: POINTER; mode: INTEGER): POINTER is
		external
			"C"
		alias
			"eole2_storage_open_stream"
		end

	ole2_storage_create_substorage (pistoragethis, stg_name: POINTER; mode: INTEGER): POINTER is
		external
			"C"
		alias
			"eole2_storage_create_substorage"
		end

	ole2_storage_open_substorage (pistoragethis, stg_name: POINTER; mode: INTEGER): POINTER is
		external
			"C"
		alias
			"eole2_storage_open_substorage"
		end

	ole2_storage_destroy_element (pistoragethis, element_name: POINTER) is
		external
			"C"
		alias
			"eole2_storage_destroy_element"
		end

	ole2_storage_copy_to (pistoragethis, pistoragedest: POINTER) is
		external
			"C"
		alias
			"eole2_storage_copy_to"
		end

	ole2_storage_move_element_to (pistoragethis, element_name, pistoragedest, new_element_name: POINTER; mode: INTEGER) is
		external
			"C"
		alias
			"eole2_storage_move_element_to"
		end

	ole2_storage_rename_element (pistoragethis, old_element_name, new_element_name: POINTER) is
		external
			"C"
		alias
			"eole2_storage_rename_element"
		end

	ole2_storage_enum_elements (pistoragethis: POINTER): POINTER is
		external
			"C"
		alias
			"eole2_storage_enum_elements"
		end

	ole2_enum_statstg_next (pienumstatstg: POINTER): POINTER is
		external
			"C"
		alias
			"eole2_enum_statstg_next"
		end

	ole2_storage_set_class (pistoragethis, clsid: POINTER) is
		external
			"C"
		alias
			"eole2_storage_set_class"
		end

	ole2_storage_commit (pistoragethis: POINTER; mode: INTEGER) is
		external
			"C"
		alias
			"eole2_storage_commit"
		end

	ole2_storage_revert (pistoragethis: POINTER) is
		external
			"C"
		alias
			"eole2_storage_revert"
		end
	
end -- class EOLE_STORAGE

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--| Based on WINE library, copyright (C) Object Tools, 1996-1998.
--| Modifications and extensions: copyright (C) ISE, 1998.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

