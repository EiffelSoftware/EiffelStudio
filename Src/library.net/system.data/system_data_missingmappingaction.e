indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.MissingMappingAction"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_DATA_MISSINGMAPPINGACTION

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

	frozen passthrough: SYSTEM_DATA_MISSINGMAPPINGACTION is
		external
			"IL enum signature :System.Data.MissingMappingAction use System.Data.MissingMappingAction"
		alias
			"1"
		end

	frozen error: SYSTEM_DATA_MISSINGMAPPINGACTION is
		external
			"IL enum signature :System.Data.MissingMappingAction use System.Data.MissingMappingAction"
		alias
			"3"
		end

	frozen ignore: SYSTEM_DATA_MISSINGMAPPINGACTION is
		external
			"IL enum signature :System.Data.MissingMappingAction use System.Data.MissingMappingAction"
		alias
			"2"
		end

end -- class SYSTEM_DATA_MISSINGMAPPINGACTION
