indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.IsolationLevel"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_DATA_ISOLATIONLEVEL

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

	frozen read_uncommitted: SYSTEM_DATA_ISOLATIONLEVEL is
		external
			"IL enum signature :System.Data.IsolationLevel use System.Data.IsolationLevel"
		alias
			"256"
		end

	frozen repeatable_read: SYSTEM_DATA_ISOLATIONLEVEL is
		external
			"IL enum signature :System.Data.IsolationLevel use System.Data.IsolationLevel"
		alias
			"65536"
		end

	frozen read_committed: SYSTEM_DATA_ISOLATIONLEVEL is
		external
			"IL enum signature :System.Data.IsolationLevel use System.Data.IsolationLevel"
		alias
			"4096"
		end

	frozen unspecified: SYSTEM_DATA_ISOLATIONLEVEL is
		external
			"IL enum signature :System.Data.IsolationLevel use System.Data.IsolationLevel"
		alias
			"-1"
		end

	frozen serializable: SYSTEM_DATA_ISOLATIONLEVEL is
		external
			"IL enum signature :System.Data.IsolationLevel use System.Data.IsolationLevel"
		alias
			"1048576"
		end

	frozen chaos: SYSTEM_DATA_ISOLATIONLEVEL is
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

end -- class SYSTEM_DATA_ISOLATIONLEVEL
