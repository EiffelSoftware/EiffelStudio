indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Data.CommandBehavior"
	assembly: "System.Data", "1.0.3300.0", "neutral", "b77a5c561934e089"
	enum_type: "INTEGER"

frozen expanded external class
	DATA_COMMAND_BEHAVIOR

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen close_connection: DATA_COMMAND_BEHAVIOR is
		external
			"IL enum signature :System.Data.CommandBehavior use System.Data.CommandBehavior"
		alias
			"32"
		end

	frozen schema_only: DATA_COMMAND_BEHAVIOR is
		external
			"IL enum signature :System.Data.CommandBehavior use System.Data.CommandBehavior"
		alias
			"2"
		end

	frozen key_info: DATA_COMMAND_BEHAVIOR is
		external
			"IL enum signature :System.Data.CommandBehavior use System.Data.CommandBehavior"
		alias
			"4"
		end

	frozen sequential_access: DATA_COMMAND_BEHAVIOR is
		external
			"IL enum signature :System.Data.CommandBehavior use System.Data.CommandBehavior"
		alias
			"16"
		end

	frozen single_result: DATA_COMMAND_BEHAVIOR is
		external
			"IL enum signature :System.Data.CommandBehavior use System.Data.CommandBehavior"
		alias
			"1"
		end

	frozen default_: DATA_COMMAND_BEHAVIOR is
		external
			"IL enum signature :System.Data.CommandBehavior use System.Data.CommandBehavior"
		alias
			"0"
		end

	frozen single_row: DATA_COMMAND_BEHAVIOR is
		external
			"IL enum signature :System.Data.CommandBehavior use System.Data.CommandBehavior"
		alias
			"8"
		end

feature -- Basic Operations

	infix "|" (infix_arg: like Current): like Current is
		do
			--Built-in
		end

end -- class DATA_COMMAND_BEHAVIOR
