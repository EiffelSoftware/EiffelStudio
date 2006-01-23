indexing
	description: "Set of static routines belonging to System.IntPtr"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

frozen external class
	DOTNET_POINTER

create {NONE}

feature -- Statics

	frozen get_size: INTEGER is
		external
			"IL static signature (): System.Int32 use System.IntPtr"
		alias
			"get_Size"
		end

	frozen from_integer (value: INTEGER): POINTER is
		external
			"IL static signature (System.Int32): System.IntPtr use System.IntPtr"
		alias
			"op_Explicit"
		end

	frozen from_integer_64 (value: INTEGER_64): POINTER is
		external
			"IL static signature (System.Int64): System.IntPtr use System.IntPtr"
		alias
			"op_Explicit"
		end

indexing
	library:	"EiffelBase: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class DOTNET_POINTER
