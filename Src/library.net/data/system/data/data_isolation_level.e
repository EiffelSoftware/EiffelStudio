indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Data.IsolationLevel"
	assembly: "System.Data", "1.0.3300.0", "neutral", "b77a5c561934e089"
	enum_type: "INTEGER"

frozen expanded external class
	DATA_ISOLATION_LEVEL

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen read_uncommitted: DATA_ISOLATION_LEVEL is
		external
			"IL enum signature :System.Data.IsolationLevel use System.Data.IsolationLevel"
		alias
			"256"
		end

	frozen repeatable_read: DATA_ISOLATION_LEVEL is
		external
			"IL enum signature :System.Data.IsolationLevel use System.Data.IsolationLevel"
		alias
			"65536"
		end

	frozen read_committed: DATA_ISOLATION_LEVEL is
		external
			"IL enum signature :System.Data.IsolationLevel use System.Data.IsolationLevel"
		alias
			"4096"
		end

	frozen unspecified: DATA_ISOLATION_LEVEL is
		external
			"IL enum signature :System.Data.IsolationLevel use System.Data.IsolationLevel"
		alias
			"-1"
		end

	frozen serializable: DATA_ISOLATION_LEVEL is
		external
			"IL enum signature :System.Data.IsolationLevel use System.Data.IsolationLevel"
		alias
			"1048576"
		end

	frozen chaos: DATA_ISOLATION_LEVEL is
		external
			"IL enum signature :System.Data.IsolationLevel use System.Data.IsolationLevel"
		alias
			"16"
		end

feature -- Basic Operations

	infix "|" (infix_arg: like Current): like Current is
		do
			--Built-in
		end

end -- class DATA_ISOLATION_LEVEL
