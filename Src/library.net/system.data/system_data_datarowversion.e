indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.DataRowVersion"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_DATA_DATAROWVERSION

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

	frozen default: SYSTEM_DATA_DATAROWVERSION is
		external
			"IL enum signature :System.Data.DataRowVersion use System.Data.DataRowVersion"
		alias
			"1536"
		end

	frozen Current_: SYSTEM_DATA_DATAROWVERSION is
		external
			"IL enum signature :System.Data.DataRowVersion use System.Data.DataRowVersion"
		alias
			"512"
		end

	frozen original: SYSTEM_DATA_DATAROWVERSION is
		external
			"IL enum signature :System.Data.DataRowVersion use System.Data.DataRowVersion"
		alias
			"256"
		end

	frozen proposed: SYSTEM_DATA_DATAROWVERSION is
		external
			"IL enum signature :System.Data.DataRowVersion use System.Data.DataRowVersion"
		alias
			"1024"
		end

end -- class SYSTEM_DATA_DATAROWVERSION
