indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.IO.FileShare"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"
	enum_type: "INTEGER"

frozen expanded external class
	FILE_SHARE

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen read_write: FILE_SHARE is
		external
			"IL enum signature :System.IO.FileShare use System.IO.FileShare"
		alias
			"3"
		end

	frozen inheritable: FILE_SHARE is
		external
			"IL enum signature :System.IO.FileShare use System.IO.FileShare"
		alias
			"16"
		end

	frozen none: FILE_SHARE is
		external
			"IL enum signature :System.IO.FileShare use System.IO.FileShare"
		alias
			"0"
		end

	frozen read: FILE_SHARE is
		external
			"IL enum signature :System.IO.FileShare use System.IO.FileShare"
		alias
			"1"
		end

	frozen write: FILE_SHARE is
		external
			"IL enum signature :System.IO.FileShare use System.IO.FileShare"
		alias
			"2"
		end

feature -- Basic Operations

	infix "|" (infix_arg: like Current): like Current is
		do
			--Built-in
		end

end -- class FILE_SHARE
