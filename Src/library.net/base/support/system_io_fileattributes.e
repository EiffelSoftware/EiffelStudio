indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.IO.FileAttributes"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_IO_FILEATTRIBUTES

inherit
	ENUM
	SYSTEM_ICOMPARABLE
	SYSTEM_IFORMATTABLE

feature -- Access

	frozen directory: SYSTEM_IO_FILEATTRIBUTES is
		external
			"IL enum signature :System.IO.FileAttributes use System.IO.FileAttributes"
		alias
			"16"
		end

	frozen system: SYSTEM_IO_FILEATTRIBUTES is
		external
			"IL enum signature :System.IO.FileAttributes use System.IO.FileAttributes"
		alias
			"4"
		end

	frozen sparse_file: SYSTEM_IO_FILEATTRIBUTES is
		external
			"IL enum signature :System.IO.FileAttributes use System.IO.FileAttributes"
		alias
			"512"
		end

	frozen temporary: SYSTEM_IO_FILEATTRIBUTES is
		external
			"IL enum signature :System.IO.FileAttributes use System.IO.FileAttributes"
		alias
			"256"
		end

	frozen hidden: SYSTEM_IO_FILEATTRIBUTES is
		external
			"IL enum signature :System.IO.FileAttributes use System.IO.FileAttributes"
		alias
			"2"
		end

	frozen reparse_point: SYSTEM_IO_FILEATTRIBUTES is
		external
			"IL enum signature :System.IO.FileAttributes use System.IO.FileAttributes"
		alias
			"1024"
		end

	frozen normal: SYSTEM_IO_FILEATTRIBUTES is
		external
			"IL enum signature :System.IO.FileAttributes use System.IO.FileAttributes"
		alias
			"128"
		end

	frozen compressed: SYSTEM_IO_FILEATTRIBUTES is
		external
			"IL enum signature :System.IO.FileAttributes use System.IO.FileAttributes"
		alias
			"2048"
		end

	frozen read_only: SYSTEM_IO_FILEATTRIBUTES is
		external
			"IL enum signature :System.IO.FileAttributes use System.IO.FileAttributes"
		alias
			"1"
		end

	frozen not_content_indexed: SYSTEM_IO_FILEATTRIBUTES is
		external
			"IL enum signature :System.IO.FileAttributes use System.IO.FileAttributes"
		alias
			"8192"
		end

	frozen device: SYSTEM_IO_FILEATTRIBUTES is
		external
			"IL enum signature :System.IO.FileAttributes use System.IO.FileAttributes"
		alias
			"64"
		end

	frozen archive: SYSTEM_IO_FILEATTRIBUTES is
		external
			"IL enum signature :System.IO.FileAttributes use System.IO.FileAttributes"
		alias
			"32"
		end

	frozen encrypted: SYSTEM_IO_FILEATTRIBUTES is
		external
			"IL enum signature :System.IO.FileAttributes use System.IO.FileAttributes"
		alias
			"16384"
		end

	frozen offline: SYSTEM_IO_FILEATTRIBUTES is
		external
			"IL enum signature :System.IO.FileAttributes use System.IO.FileAttributes"
		alias
			"4096"
		end

feature -- Basic Operations

	infix "|" (o: like Current): like Current is
		do
			--Built-in
		end

end -- class SYSTEM_IO_FILEATTRIBUTES
