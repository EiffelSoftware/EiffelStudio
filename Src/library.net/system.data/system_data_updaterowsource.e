indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.UpdateRowSource"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_DATA_UPDATEROWSOURCE

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

	frozen both: SYSTEM_DATA_UPDATEROWSOURCE is
		external
			"IL enum signature :System.Data.UpdateRowSource use System.Data.UpdateRowSource"
		alias
			"3"
		end

	frozen none: SYSTEM_DATA_UPDATEROWSOURCE is
		external
			"IL enum signature :System.Data.UpdateRowSource use System.Data.UpdateRowSource"
		alias
			"0"
		end

	frozen output_parameters: SYSTEM_DATA_UPDATEROWSOURCE is
		external
			"IL enum signature :System.Data.UpdateRowSource use System.Data.UpdateRowSource"
		alias
			"1"
		end

	frozen first_returned_record: SYSTEM_DATA_UPDATEROWSOURCE is
		external
			"IL enum signature :System.Data.UpdateRowSource use System.Data.UpdateRowSource"
		alias
			"2"
		end

end -- class SYSTEM_DATA_UPDATEROWSOURCE
