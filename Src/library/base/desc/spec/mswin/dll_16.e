indexing

	description:
		"16 bit DLL for Windows";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class DLL_16

inherit
	SHARED_LIBRARY

	MEMORY
		rename
			free as memory_free
		export
			{NONE} all
		redefine
			dispose
		end

creation
	make

feature {NONE} -- Initialization

	make (lib_name: STRING) is
			-- Load DLL `lib_name'
		local
			c_lib_name: ANY
		do
			library_name := lib_name
			c_lib_name := lib_name.to_c
			module_handle := desc_load_library ($c_lib_name)
			if module_handle = default_pointer then
				error_code := No_library
			else
				error_code := No_error
			end
		end

feature -- Access

	library_name: STRING
			-- Name of shared library

feature -- Status report

	error_code: INTEGER
			-- Current status of the library

feature -- Removal

	free is
			-- Release the library
		require
			meaningful: meaningful
		do
			desc_free_library (module_handle)
			module_handle := default_pointer
			error_code := Library_freed
		ensure
			not_meaningful: not meaningful
		end

feature {NONE} -- Removal

	dispose is
			-- Release the library at time of collection if not already done
		do
			if module_handle /= default_pointer then
				desc_free_library (module_handle)
			end
		end

feature {DLL_16_ROUTINE} -- Implementation

	module_handle: POINTER
			-- Pointer to the external library

feature {NONE} -- Externals

	desc_free_library (p: POINTER) is
			-- Free library
		external
			"C [dll16 %"desc.dll%"] (DWORD)"
		alias
			"12"
		end

	desc_load_library (p: POINTER): POINTER is
			-- Load library
		external
			"C [dll16 %"desc.dll%"] (PTR): EIF_POINTER"
		alias
			"15"
		end

end -- class DLL_16

--|----------------------------------------------------------------
--| EiffelBase: Library of reusable components for Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering (ISE).
--| For ISE customers the original versions are an ISE product
--| covered by the ISE Eiffel license and support agreements.
--| EiffelBase may now be used by anyone as FREE SOFTWARE to
--| develop any product, public-domain or commercial, without
--| payment to ISE, under the terms of the ISE Free Eiffel Library
--| License (IFELL) at http://eiffel.com/products/base/license.html.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://eiffel.com
--|----------------------------------------------------------------

