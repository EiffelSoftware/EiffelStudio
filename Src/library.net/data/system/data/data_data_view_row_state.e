indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Data.DataViewRowState"
	assembly: "System.Data", "1.0.3300.0", "neutral", "b77a5c561934e089"
	enum_type: "INTEGER"

frozen expanded external class
	DATA_DATA_VIEW_ROW_STATE

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen current_rows: DATA_DATA_VIEW_ROW_STATE is
		external
			"IL enum signature :System.Data.DataViewRowState use System.Data.DataViewRowState"
		alias
			"22"
		end

	frozen added: DATA_DATA_VIEW_ROW_STATE is
		external
			"IL enum signature :System.Data.DataViewRowState use System.Data.DataViewRowState"
		alias
			"4"
		end

	frozen unchanged: DATA_DATA_VIEW_ROW_STATE is
		external
			"IL enum signature :System.Data.DataViewRowState use System.Data.DataViewRowState"
		alias
			"2"
		end

	frozen deleted: DATA_DATA_VIEW_ROW_STATE is
		external
			"IL enum signature :System.Data.DataViewRowState use System.Data.DataViewRowState"
		alias
			"8"
		end

	frozen none: DATA_DATA_VIEW_ROW_STATE is
		external
			"IL enum signature :System.Data.DataViewRowState use System.Data.DataViewRowState"
		alias
			"0"
		end

	frozen modified_current: DATA_DATA_VIEW_ROW_STATE is
		external
			"IL enum signature :System.Data.DataViewRowState use System.Data.DataViewRowState"
		alias
			"16"
		end

	frozen modified_original: DATA_DATA_VIEW_ROW_STATE is
		external
			"IL enum signature :System.Data.DataViewRowState use System.Data.DataViewRowState"
		alias
			"32"
		end

	frozen original_rows: DATA_DATA_VIEW_ROW_STATE is
		external
			"IL enum signature :System.Data.DataViewRowState use System.Data.DataViewRowState"
		alias
			"42"
		end

feature -- Basic Operations

	infix "|" (infix_arg: like Current): like Current is
		do
			--Built-in
		end

end -- class DATA_DATA_VIEW_ROW_STATE
