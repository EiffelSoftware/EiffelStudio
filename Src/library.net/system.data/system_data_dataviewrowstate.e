indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.DataViewRowState"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_DATA_DATAVIEWROWSTATE

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

	frozen current_rows: SYSTEM_DATA_DATAVIEWROWSTATE is
		external
			"IL enum signature :System.Data.DataViewRowState use System.Data.DataViewRowState"
		alias
			"22"
		end

	frozen added: SYSTEM_DATA_DATAVIEWROWSTATE is
		external
			"IL enum signature :System.Data.DataViewRowState use System.Data.DataViewRowState"
		alias
			"4"
		end

	frozen unchanged: SYSTEM_DATA_DATAVIEWROWSTATE is
		external
			"IL enum signature :System.Data.DataViewRowState use System.Data.DataViewRowState"
		alias
			"2"
		end

	frozen deleted: SYSTEM_DATA_DATAVIEWROWSTATE is
		external
			"IL enum signature :System.Data.DataViewRowState use System.Data.DataViewRowState"
		alias
			"8"
		end

	frozen none: SYSTEM_DATA_DATAVIEWROWSTATE is
		external
			"IL enum signature :System.Data.DataViewRowState use System.Data.DataViewRowState"
		alias
			"0"
		end

	frozen modified_current: SYSTEM_DATA_DATAVIEWROWSTATE is
		external
			"IL enum signature :System.Data.DataViewRowState use System.Data.DataViewRowState"
		alias
			"16"
		end

	frozen modified_original: SYSTEM_DATA_DATAVIEWROWSTATE is
		external
			"IL enum signature :System.Data.DataViewRowState use System.Data.DataViewRowState"
		alias
			"32"
		end

	frozen original_rows: SYSTEM_DATA_DATAVIEWROWSTATE is
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

end -- class SYSTEM_DATA_DATAVIEWROWSTATE
