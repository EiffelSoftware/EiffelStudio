indexing
	description: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ECOM_ROOT_STORAGE

inherit

	MEMORY
		redefine
			dispose
		end


creation
	make_from_iroot_storage

feature {NONE} -- Initialization

	make_from_iroot_storage (p_root_storage: POINTER) is
			-- Create new instance giving IRootStorage interface pointer
		require
			valid_storage: p_root_storage /= Default_pointer
		do
			initializer := ccom_create_c_iroot_storage;
			ccom_initialize_root_storage (initializer, p_root_storage);
		ensure
			storage_created: item /= Default_pointer
		end

feature -- Basic Operations

	swith_to_file (name: STRING) is
			-- Copies the current file associated with the storage object 
			-- to a new file. The new file is then used for the storage 
			-- object and any uncommitted changes
		local
			wide_string: ECOM_WIDE_STRING
		do
			!!wide_string.make_from_string (name)
			ccom_switch_to_file (initializer, wide_string.item)
		end

feature {NONE} -- Implementation

	initializer: POINTER
			-- Pointer to structure

	dispose is
			-- delete structure
		do
			ccom_delete_c_iroot_storage (initializer);
		end


feature {ECOM_ROOT_STORAGE}

	item: POINTER  is
		do
			Result := ccom_iroot_storage(initializer)
		end

feature {NONE} -- Externals

	ccom_create_c_iroot_storage: POINTER is
		external
			"C++ [new E_IRootStorage %"E_IRootStorage.h%"]()"
		end

	ccom_delete_c_iroot_storage (cpp_obj: POINTER) is
		external
			"C++ [delete E_IRootStorage %"E_IRootStorage.h%"]()"
		end

	ccom_initialize_root_storage (cpp_obj: POINTER; p_root_storage: POINTER) is
		external
			"C++ [E_IRootStorage %"E_IRootStorage.h%"](EIF_POINTER)"
		end

	ccom_iroot_storage (cpp_obj: POINTER): POINTER is
		external
			"C++ [E_IRootStorage %"E_IRootStorage.h%"](): EIF_POINTER"
		end

	ccom_switch_to_file (cpp_obj: POINTER; name: POINTER) is
		external
			"C++ [E_IRootStorage %"E_IRootStorage.h%"](EIF_POINTER)"
		end

end -- class ECOM_ROOT_STORAGE
