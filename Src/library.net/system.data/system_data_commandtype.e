indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.CommandType"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_DATA_COMMANDTYPE

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

	frozen stored_procedure: SYSTEM_DATA_COMMANDTYPE is
		external
			"IL enum signature :System.Data.CommandType use System.Data.CommandType"
		alias
			"4"
		end

	frozen table_direct: SYSTEM_DATA_COMMANDTYPE is
		external
			"IL enum signature :System.Data.CommandType use System.Data.CommandType"
		alias
			"512"
		end

	frozen text: SYSTEM_DATA_COMMANDTYPE is
		external
			"IL enum signature :System.Data.CommandType use System.Data.CommandType"
		alias
			"1"
		end

end -- class SYSTEM_DATA_COMMANDTYPE
