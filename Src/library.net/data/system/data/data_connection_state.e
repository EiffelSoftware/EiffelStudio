indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Data.ConnectionState"
	assembly: "System.Data", "1.0.3300.0", "neutral", "b77a5c561934e089"
	enum_type: "INTEGER"

frozen expanded external class
	DATA_CONNECTION_STATE

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen closed: DATA_CONNECTION_STATE is
		external
			"IL enum signature :System.Data.ConnectionState use System.Data.ConnectionState"
		alias
			"0"
		end

	frozen open: DATA_CONNECTION_STATE is
		external
			"IL enum signature :System.Data.ConnectionState use System.Data.ConnectionState"
		alias
			"1"
		end

	frozen connecting: DATA_CONNECTION_STATE is
		external
			"IL enum signature :System.Data.ConnectionState use System.Data.ConnectionState"
		alias
			"2"
		end

	frozen fetching: DATA_CONNECTION_STATE is
		external
			"IL enum signature :System.Data.ConnectionState use System.Data.ConnectionState"
		alias
			"8"
		end

	frozen executing: DATA_CONNECTION_STATE is
		external
			"IL enum signature :System.Data.ConnectionState use System.Data.ConnectionState"
		alias
			"4"
		end

	frozen broken: DATA_CONNECTION_STATE is
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

end -- class DATA_CONNECTION_STATE
