indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.IO.FileAccess"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"
	enum_type: "INTEGER"

frozen expanded external class
	FILE_ACCESS

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen read_write: FILE_ACCESS is
		external
			"IL enum signature :System.IO.FileAccess use System.IO.FileAccess"
		alias
			"3"
		end

	frozen read: FILE_ACCESS is
		external
			"IL enum signature :System.IO.FileAccess use System.IO.FileAccess"
		alias
			"1"
		end

	frozen write: FILE_ACCESS is
		external
			"IL enum signature :System.IO.FileAccess use System.IO.FileAccess"
		alias
			"2"
		end

feature -- Basic Operations

	infix "|" (infix_arg: like Current): like Current is
		do
			--Built-in
		end

end -- class FILE_ACCESS
