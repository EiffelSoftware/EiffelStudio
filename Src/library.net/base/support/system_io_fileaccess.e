indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.IO.FileAccess"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_IO_FILEACCESS

inherit
	ENUM
	SYSTEM_ICOMPARABLE
	SYSTEM_IFORMATTABLE

feature -- Access

	frozen read_write: SYSTEM_IO_FILEACCESS is
		external
			"IL enum signature :System.IO.FileAccess use System.IO.FileAccess"
		alias
			"3"
		end

	frozen read: SYSTEM_IO_FILEACCESS is
		external
			"IL enum signature :System.IO.FileAccess use System.IO.FileAccess"
		alias
			"1"
		end

	frozen write: SYSTEM_IO_FILEACCESS is
		external
			"IL enum signature :System.IO.FileAccess use System.IO.FileAccess"
		alias
			"2"
		end

feature -- Basic Operations

	infix "|" (o: like Current): like Current is
		do
			--Built-in
		end

end -- class SYSTEM_IO_FILEACCESS
