indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.IO.FileShare"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_IO_FILESHARE

inherit
	ENUM
	SYSTEM_ICOMPARABLE
	SYSTEM_IFORMATTABLE

feature -- Access

	frozen read_write: SYSTEM_IO_FILESHARE is
		external
			"IL enum signature :System.IO.FileShare use System.IO.FileShare"
		alias
			"3"
		end

	frozen inheritable: SYSTEM_IO_FILESHARE is
		external
			"IL enum signature :System.IO.FileShare use System.IO.FileShare"
		alias
			"16"
		end

	frozen none: SYSTEM_IO_FILESHARE is
		external
			"IL enum signature :System.IO.FileShare use System.IO.FileShare"
		alias
			"0"
		end

	frozen read: SYSTEM_IO_FILESHARE is
		external
			"IL enum signature :System.IO.FileShare use System.IO.FileShare"
		alias
			"1"
		end

	frozen write: SYSTEM_IO_FILESHARE is
		external
			"IL enum signature :System.IO.FileShare use System.IO.FileShare"
		alias
			"2"
		end

feature -- Basic Operations

	infix "|" (o: like Current): like Current is
		do
			--Built-in
		end

end -- class SYSTEM_IO_FILESHARE
