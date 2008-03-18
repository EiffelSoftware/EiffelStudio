indexing

	description:
		"Platform independent abstraction of a shared library"
	legal: "See notice at end of class."

	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class SHARED_LIBRARY

obsolete
	"This class should no longer be used due to platform dependence and non-64bit compliance"

inherit
	SHARED_LIBRARY_CONSTANTS

feature {NONE} -- Initialization

	make (lib_name: STRING) is
			-- Load shared library `lib_name'
		require
			non_void: lib_name /= Void
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
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"





end -- class SHARED_LIBRARY
