indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.StatementType"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_DATA_STATEMENTTYPE

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

	frozen Select_: SYSTEM_DATA_STATEMENTTYPE is
		external
			"IL enum signature :System.Data.StatementType use System.Data.StatementType"
		alias
			"0"
		end

	frozen insert: SYSTEM_DATA_STATEMENTTYPE is
		external
			"IL enum signature :System.Data.StatementType use System.Data.StatementType"
		alias
			"1"
		end

	frozen delete: SYSTEM_DATA_STATEMENTTYPE is
		external
			"IL enum signature :System.Data.StatementType use System.Data.StatementType"
		alias
			"3"
		end

	frozen update: SYSTEM_DATA_STATEMENTTYPE is
		external
			"IL enum signature :System.Data.StatementType use System.Data.StatementType"
		alias
			"2"
		end

end -- class SYSTEM_DATA_STATEMENTTYPE
