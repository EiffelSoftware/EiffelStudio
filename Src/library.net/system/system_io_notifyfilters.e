indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.IO.NotifyFilters"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_IO_NOTIFYFILTERS

inherit
	ENUM
		rename
			is_equal as equals_object
		end
	SYSTEM_IFORMATTABLE
		rename
			is_equal as equals_object
		end
	SYSTEM_ICOMPARABLE
		rename
			is_equal as equals_object
		end

feature -- Access

	frozen size: SYSTEM_IO_NOTIFYFILTERS is
		external
			"IL enum signature :System.IO.NotifyFilters use System.IO.NotifyFilters"
		alias
			"8"
		end

	frozen last_access: SYSTEM_IO_NOTIFYFILTERS is
		external
			"IL enum signature :System.IO.NotifyFilters use System.IO.NotifyFilters"
		alias
			"32"
		end

	frozen creation_time: SYSTEM_IO_NOTIFYFILTERS is
		external
			"IL enum signature :System.IO.NotifyFilters use System.IO.NotifyFilters"
		alias
			"64"
		end

	frozen attributes: SYSTEM_IO_NOTIFYFILTERS is
		external
			"IL enum signature :System.IO.NotifyFilters use System.IO.NotifyFilters"
		alias
			"4"
		end

	frozen directory_name: SYSTEM_IO_NOTIFYFILTERS is
		external
			"IL enum signature :System.IO.NotifyFilters use System.IO.NotifyFilters"
		alias
			"2"
		end

	frozen file_name: SYSTEM_IO_NOTIFYFILTERS is
		external
			"IL enum signature :System.IO.NotifyFilters use System.IO.NotifyFilters"
		alias
			"1"
		end

	frozen security: SYSTEM_IO_NOTIFYFILTERS is
		external
			"IL enum signature :System.IO.NotifyFilters use System.IO.NotifyFilters"
		alias
			"256"
		end

	frozen last_write: SYSTEM_IO_NOTIFYFILTERS is
		external
			"IL enum signature :System.IO.NotifyFilters use System.IO.NotifyFilters"
		alias
			"16"
		end

feature -- Basic Operations

	infix "|" (infix_arg: like Current): like Current is
		do
			--Built-in
		end

end -- class SYSTEM_IO_NOTIFYFILTERS
