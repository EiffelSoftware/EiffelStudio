
indexing

	description:
		"Directory name abstraction"

	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class DIRECTORY_NAME

inherit
	PATH_NAME

create
	make, make_from_string

feature

	is_valid: BOOLEAN is
			-- Is the directory name valid?
		local
			any: ANY
		do
			any := to_c
			Result := eif_is_directory_valid ($any)
		end

feature {NONE} -- Externals

	eif_is_directory_valid (p: POINTER): BOOLEAN is
		external
			"C (EIF_CHARACTER *): EIF_BOOLEAN | %"eif_path_name.h%""
		end

indexing

	library: "[
			EiffelBase: Library of reusable components for Eiffel.
			]"

	status: "[
--| Copyright (c) 1993-2006 University of Southern California and contributors.
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

end -- class DIRECTORY_NAME



