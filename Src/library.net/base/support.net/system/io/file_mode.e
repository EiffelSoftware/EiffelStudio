indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.IO.FileMode"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"
	enum_type: "INTEGER"

frozen expanded external class
	FILE_MODE

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen open_or_create: FILE_MODE is
		external
			"IL enum signature :System.IO.FileMode use System.IO.FileMode"
		alias
			"4"
		end

	frozen create_: FILE_MODE is
		external
			"IL enum signature :System.IO.FileMode use System.IO.FileMode"
		alias
			"2"
		end

	frozen create_new: FILE_MODE is
		external
			"IL enum signature :System.IO.FileMode use System.IO.FileMode"
		alias
			"1"
		end

	frozen open: FILE_MODE is
		external
			"IL enum signature :System.IO.FileMode use System.IO.FileMode"
		alias
			"3"
		end

	frozen truncate: FILE_MODE is
		external
			"IL enum signature :System.IO.FileMode use System.IO.FileMode"
		alias
			"5"
		end

	frozen append: FILE_MODE is
		external
			"IL enum signature :System.IO.FileMode use System.IO.FileMode"
		alias
			"6"
		end

end -- class FILE_MODE
