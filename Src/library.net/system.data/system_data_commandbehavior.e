indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.CommandBehavior"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_DATA_COMMANDBEHAVIOR

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

	frozen single_result: SYSTEM_DATA_COMMANDBEHAVIOR is
		external
			"IL enum signature :System.Data.CommandBehavior use System.Data.CommandBehavior"
		alias
			"1"
		end

	frozen single_row: SYSTEM_DATA_COMMANDBEHAVIOR is
		external
			"IL enum signature :System.Data.CommandBehavior use System.Data.CommandBehavior"
		alias
			"8"
		end

	frozen close_connection: SYSTEM_DATA_COMMANDBEHAVIOR is
		external
			"IL enum signature :System.Data.CommandBehavior use System.Data.CommandBehavior"
		alias
			"32"
		end

	frozen key_info: SYSTEM_DATA_COMMANDBEHAVIOR is
		external
			"IL enum signature :System.Data.CommandBehavior use System.Data.CommandBehavior"
		alias
			"4"
		end

	frozen schema_only: SYSTEM_DATA_COMMANDBEHAVIOR is
		external
			"IL enum signature :System.Data.CommandBehavior use System.Data.CommandBehavior"
		alias
			"2"
		end

	frozen sequential_access: SYSTEM_DATA_COMMANDBEHAVIOR is
		external
			"IL enum signature :System.Data.CommandBehavior use System.Data.CommandBehavior"
		alias
			"16"
		end

feature -- Basic Operations

	infix "|" (infix_arg: like Current): like Current is
		do
			--Built-in
		end

end -- class SYSTEM_DATA_COMMANDBEHAVIOR
