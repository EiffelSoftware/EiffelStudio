indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.IO.FileAttributes"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"
	enum_type: "INTEGER"

frozen expanded external class
	FILE_ATTRIBUTES

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen directory: FILE_ATTRIBUTES is
		external
			"IL enum signature :System.IO.FileAttributes use System.IO.FileAttributes"
		alias
			"16"
		end

	frozen system: FILE_ATTRIBUTES is
		external
			"IL enum signature :System.IO.FileAttributes use System.IO.FileAttributes"
		alias
			"4"
		end

	frozen sparse_file: FILE_ATTRIBUTES is
		external
			"IL enum signature :System.IO.FileAttributes use System.IO.FileAttributes"
		alias
			"512"
		end

	frozen temporary: FILE_ATTRIBUTES is
		external
			"IL enum signature :System.IO.FileAttributes use System.IO.FileAttributes"
		alias
			"256"
		end

	frozen hidden: FILE_ATTRIBUTES is
		external
			"IL enum signature :System.IO.FileAttributes use System.IO.FileAttributes"
		alias
			"2"
		end

	frozen reparse_point: FILE_ATTRIBUTES is
		external
			"IL enum signature :System.IO.FileAttributes use System.IO.FileAttributes"
		alias
			"1024"
		end

	frozen normal: FILE_ATTRIBUTES is
		external
			"IL enum signature :System.IO.FileAttributes use System.IO.FileAttributes"
		alias
			"128"
		end

	frozen compressed: FILE_ATTRIBUTES is
		external
			"IL enum signature :System.IO.FileAttributes use System.IO.FileAttributes"
		alias
			"2048"
		end

	frozen read_only: FILE_ATTRIBUTES is
		external
			"IL enum signature :System.IO.FileAttributes use System.IO.FileAttributes"
		alias
			"1"
		end

	frozen not_content_indexed: FILE_ATTRIBUTES is
		external
			"IL enum signature :System.IO.FileAttributes use System.IO.FileAttributes"
		alias
			"8192"
		end

	frozen device: FILE_ATTRIBUTES is
		external
			"IL enum signature :System.IO.FileAttributes use System.IO.FileAttributes"
		alias
			"64"
		end

	frozen archive: FILE_ATTRIBUTES is
		external
			"IL enum signature :System.IO.FileAttributes use System.IO.FileAttributes"
		alias
			"32"
		end

	frozen encrypted: FILE_ATTRIBUTES is
		external
			"IL enum signature :System.IO.FileAttributes use System.IO.FileAttributes"
		alias
			"16384"
		end

	frozen offline: FILE_ATTRIBUTES is
		external
			"IL enum signature :System.IO.FileAttributes use System.IO.FileAttributes"
		alias
			"4096"
		end

feature -- Basic Operations

	infix "|" (infix_arg: like Current): like Current is
		do
			--Built-in
		end

end -- class FILE_ATTRIBUTES
