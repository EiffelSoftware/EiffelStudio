indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.DataRowAction"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_DATA_DATAROWACTION

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

	frozen rollback: SYSTEM_DATA_DATAROWACTION is
		external
			"IL enum signature :System.Data.DataRowAction use System.Data.DataRowAction"
		alias
			"4"
		end

	frozen nothing: SYSTEM_DATA_DATAROWACTION is
		external
			"IL enum signature :System.Data.DataRowAction use System.Data.DataRowAction"
		alias
			"0"
		end

	frozen change: SYSTEM_DATA_DATAROWACTION is
		external
			"IL enum signature :System.Data.DataRowAction use System.Data.DataRowAction"
		alias
			"2"
		end

	frozen commit: SYSTEM_DATA_DATAROWACTION is
		external
			"IL enum signature :System.Data.DataRowAction use System.Data.DataRowAction"
		alias
			"8"
		end

	frozen add: SYSTEM_DATA_DATAROWACTION is
		external
			"IL enum signature :System.Data.DataRowAction use System.Data.DataRowAction"
		alias
			"16"
		end

	frozen delete: SYSTEM_DATA_DATAROWACTION is
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

end -- class SYSTEM_DATA_DATAROWACTION
