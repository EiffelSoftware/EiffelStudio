indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Data.DataRowAction"
	assembly: "System.Data", "1.0.3300.0", "neutral", "b77a5c561934e089"
	enum_type: "INTEGER"

frozen expanded external class
	DATA_DATA_ROW_ACTION

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen rollback: DATA_DATA_ROW_ACTION is
		external
			"IL enum signature :System.Data.DataRowAction use System.Data.DataRowAction"
		alias
			"4"
		end

	frozen nothing: DATA_DATA_ROW_ACTION is
		external
			"IL enum signature :System.Data.DataRowAction use System.Data.DataRowAction"
		alias
			"0"
		end

	frozen change: DATA_DATA_ROW_ACTION is
		external
			"IL enum signature :System.Data.DataRowAction use System.Data.DataRowAction"
		alias
			"2"
		end

	frozen commit: DATA_DATA_ROW_ACTION is
		external
			"IL enum signature :System.Data.DataRowAction use System.Data.DataRowAction"
		alias
			"8"
		end

	frozen add: DATA_DATA_ROW_ACTION is
		external
			"IL enum signature :System.Data.DataRowAction use System.Data.DataRowAction"
		alias
			"16"
		end

	frozen delete: DATA_DATA_ROW_ACTION is
		external
			"IL enum signature :System.Data.DataRowAction use System.Data.DataRowAction"
		alias
			"1"
		end

feature -- Basic Operations

	infix "|" (infix_arg: like Current): like Current is
		do
			--Built-in
		end

end -- class DATA_DATA_ROW_ACTION
