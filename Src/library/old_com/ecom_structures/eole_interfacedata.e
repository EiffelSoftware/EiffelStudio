indexing

	description: "INTERFACEDATA structure"
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	EOLE_INTERFACEDATA

inherit
	EOLE_OBJECT_WITH_POINTER
		redefine
			allocate,
			destroy
		end
	
feature -- Element change

	allocate: POINTER is
			-- Create associated C++ structure with
			-- EOLE_METHODDATA array of size `size'.
			-- `set_size' should be called first.
		do
			Result := ole2_interfacedata_allocate (size)
		end

	set_size (siz: INTEGER) is
			-- Set `size' with `siz'
		do
			size := siz
		end
		
	destroy is
			-- Destroy associated C++ structure.
		do
			ole2_interfacedata_destroy
		end
		
	add_method_data (mdata: EOLE_METHODDATA) is
			-- Add `mdata' at next available position.
		require
			valid_c_structure: ole_ptr /= default_pointer
			not_full: index <= size
		do
			ole2_interfacedata_add_method_data (ole_ptr, index, mdata.ole_ptr)
			index := index + 1
		end

	put_method_data (ind: INTEGER; mdata: EOLE_METHODDATA) is
			-- Put `mdata' at `ind'.
		require
			valid_c_structure: ole_ptr /= default_pointer
			valid_index: ind <= size
		do
			ole2_interfacedata_put_method_data (ole_ptr, ind, mdata.ole_ptr)
		end
		
feature -- Access

	method_data (ind: INTEGER): EOLE_METHODDATA is
			-- Method data at `ind'
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			!! Result
			Result.attach (ole2_interfacedata_get_method_data (ole_ptr, ind))
		end

	method_count: INTEGER is
			-- Number of method data
		require
			valid_c_structure: ole_ptr /= default_pointer
		do
			Result := ole2_interfacedata_get_method_count (ole_ptr)
		end

	size: INTEGER
			-- Size of EOLE_METHODDATA array
			
	index: INTEGER
			-- Index of first free cell in array
		
feature {NONE} -- Externals

	ole2_interfacedata_allocate (siz: INTEGER): POINTER is
		external
			"C"
		alias
			"eole2_interfacedata_allocate"
		end

	ole2_interfacedata_destroy is
		external
			"C"
		alias
			"eole2_interfacedata_destroy"
		end

	ole2_interfacedata_add_method_data (this:POINTER; ind: INTEGER; mdata_ptr: POINTER) is
		external
			"C"
		alias
			"eole2_interfacedata_add_method_data"
		end

	ole2_interfacedata_get_method_data (this: POINTER; ind: INTEGER): POINTER is
		external
			"C"
		alias
			"eole2_interfacedata_get_method_data"
		end

	ole2_interfacedata_put_method_data (this: POINTER; ind: INTEGER; mdata_ptr: POINTER) is
		external
			"C"
		alias
			"eole2_interfacedata_put_method_data"
		end

	ole2_interfacedata_get_method_count (this: POINTER): INTEGER is
		external
			"C"
		alias
			"eole2_interfacedata_get_method_count"
		end
	
end -- class EOLE_INTERFACEDATA

--|-------------------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license.
--| Contact ISE for any other use.
--| Based on WINE library, copyright (C) Object Tools, 1996-1997.
--| Modifications and extensions: copyright (C) ISE, 1997. 
--|
--| Interactive Software Engineering Inc.
--| 270 Storke Road, ISE Building, second floor, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------