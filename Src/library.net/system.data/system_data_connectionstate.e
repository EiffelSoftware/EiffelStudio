indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.ConnectionState"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_DATA_CONNECTIONSTATE

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

	frozen closed: SYSTEM_DATA_CONNECTIONSTATE is
		external
			"IL enum signature :System.Data.ConnectionState use System.Data.ConnectionState"
		alias
			"0"
		end

	frozen open: SYSTEM_DATA_CONNECTIONSTATE is
		external
			"IL enum signature :System.Data.ConnectionState use System.Data.ConnectionState"
		alias
			"1"
		end

	frozen connecting: SYSTEM_DATA_CONNECTIONSTATE is
		external
			"IL enum signature :System.Data.ConnectionState use System.Data.ConnectionState"
		alias
			"2"
		end

	frozen fetching: SYSTEM_DATA_CONNECTIONSTATE is
		external
			"IL enum signature :System.Data.ConnectionState use System.Data.ConnectionState"
		alias
			"8"
		end

	frozen executing: SYSTEM_DATA_CONNECTIONSTATE is
		external
			"IL enum signature :System.Data.ConnectionState use System.Data.ConnectionState"
		alias
			"4"
		end

	frozen broken: SYSTEM_DATA_CONNECTIONSTATE is
		external
			"IL enum signature :System.Data.ConnectionState use System.Data.ConnectionState"
		alias
			"16"
		end

feature -- Basic Operations

	infix "|" (infix_arg: like Current): like Current is
		do
			--Built-in
		end

end -- class SYSTEM_DATA_CONNECTIONSTATE
