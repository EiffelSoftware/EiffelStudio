indexing
	description: "Set of static routines belonging to System.Char"
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

end -- class DOTNET_POINTER
