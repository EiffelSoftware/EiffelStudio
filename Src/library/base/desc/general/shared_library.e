indexing

	description:
		"Platform independent abstraction of a shared library"

	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class SHARED_LIBRARY

inherit
	SHARED_LIBRARY_CONSTANTS

feature {NONE} -- Initialization

	make (lib_name: STRING) is
			-- Load shared library `lib_name'
		require
			non_Void: lib_name /= Void
			non_empty: not lib_name.is_empty
		deferred
		ensure
			consistent: lib_name.is_equal (library_name)
		end

feature -- Access

	library_name: STRING is
			-- Name of shared library
		deferred
		end

feature -- Status report

	error_code: INTEGER is
			-- Current status of the library
		deferred
		end

	meaningful: BOOLEAN is
			-- Is the library currently loaded?
		do
			Result := error_code = No_error
		end

invariant
	meaningful_definition: meaningful = (error_code = No_error)

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

end -- class SHARED_LIBRARY
