indexing
	description: "File name abstraction"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	FILE_NAME

inherit
	PATH_NAME

create
	make, make_from_string, make_temporary_name

feature {NONE} -- Initialization

	make_temporary_name is
			-- Create a temporary filename.
		local
			p: POINTER
		do
			p := c_tempnam (p, p)
			make_from_c (p)
			p.memory_free
		end

feature -- Status report

	is_valid: BOOLEAN is
			-- Is the file name valid for the operating system?
		local
			any: ANY
		do
			any := to_c
			Result := eif_is_file_valid ($any)
		end

	is_file_name_valid (f_name: STRING): BOOLEAN is
			-- Is `f_name' a valid file name part for the operating system?
		local
			any: ANY
		do
			any := f_name.to_c
			Result := eif_is_file_name_valid ($any)
		end

	is_extension_valid (ext: STRING): BOOLEAN is
			-- Is `ext' a valid extension for the operating system?
		local
			any: ANY
		do
			any := ext.to_c
			Result := eif_is_extension_valid ($any)
		end

feature -- Status setting

	set_file_name (file_name: STRING) is
			-- Set the value of the file name part.
		require
			string_exists: file_name /= Void
			valid_file_name: is_file_name_valid (file_name)
		local
			new_size: INTEGER
			str1, str2: ANY
		do
			new_size := count + file_name.count + 5
			if capacity < new_size then
				resize (new_size)
			end
			str1 := to_c
			str2 := file_name.to_c
			eif_append_file_name ($Current, $str1, $str2)
		ensure
			valid_file_name: is_valid
		end

	add_extension (ext: STRING) is
			-- Append the extension `ext' to the file name
		require
			string_exists: ext /= Void
			non_empty_extension: not ext.is_empty
			valid_extension: is_extension_valid (ext)
		do
			append_character ('.')
			append (ext)
		end

feature {NONE} -- Externals

	eif_append_file_name (s, p, v: POINTER) is
		external
			"C (EIF_REFERENCE, EIF_CHARACTER *, EIF_CHARACTER *) | %"eif_path_name.h%""
		end

	eif_is_file_name_valid (p: POINTER): BOOLEAN is
		external
			"C (EIF_CHARACTER *): EIF_BOOLEAN | %"eif_path_name.h%""
		end

	eif_is_extension_valid (p: POINTER): BOOLEAN is
		external
			"C (EIF_CHARACTER *): EIF_BOOLEAN | %"eif_path_name.h%""
		end

	eif_is_file_valid (p: POINTER): BOOLEAN is
		external
			"C (EIF_CHARACTER *): EIF_BOOLEAN | %"eif_path_name.h%""
		end

	c_tempnam (d, n: POINTER): POINTER is
		external
			"C (char *, char *): EIF_POINTER | <stdio.h>"
		alias
			"tempnam"
		end

indexing

	library: "[
			EiffelBase: Library of reusable components for Eiffel.
			]"

	status: "[
			Copyright 1986-2001 Interactive Software Engineering (ISE).
			For ISE customers the original versions are an ISE product
			covered by the ISE Eiffel license and support agreements.
			]"

	license: "[
			EiffelBase may now be used by anyone as FREE SOFTWARE to
			develop any product, public-domain or commercial, without
			payment to ISE, under the terms of the ISE Free Eiffel Library
			License (IFELL) at http://eiffel.com/products/base/license.html.
			]"

	source: "[
			Interactive Software Engineering Inc.
			ISE Building
			360 Storke Road, Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Electronic mail <info@eiffel.com>
			Customer support http://support.eiffel.com
			]"

	info: "[
			For latest info see award-winning pages: http://eiffel.com
			]"

end -- class FILE_NAME


