indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.ParameterDirection"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_DATA_PARAMETERDIRECTION

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

	frozen input: SYSTEM_DATA_PARAMETERDIRECTION is
		external
			"IL enum signature :System.Data.ParameterDirection use System.Data.ParameterDirection"
		alias
			"1"
		end

	frozen return_value: SYSTEM_DATA_PARAMETERDIRECTION is
		external
			"IL enum signature :System.Data.ParameterDirection use System.Data.ParameterDirection"
		alias
			"6"
		end

	frozen input_output: SYSTEM_DATA_PARAMETERDIRECTION is
		external
			"IL enum signature :System.Data.ParameterDirection use System.Data.ParameterDirection"
		alias
			"3"
		end

	frozen output: SYSTEM_DATA_PARAMETERDIRECTION is
		external
			"IL enum signature :System.Data.ParameterDirection use System.Data.ParameterDirection"
		alias
			"2"
		end

end -- class SYSTEM_DATA_PARAMETERDIRECTION
