indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.SchemaType"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_DATA_SCHEMATYPE

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

	frozen mapped: SYSTEM_DATA_SCHEMATYPE is
		external
			"IL enum signature :System.Data.SchemaType use System.Data.SchemaType"
		alias
			"2"
		end

	frozen source: SYSTEM_DATA_SCHEMATYPE is
		external
			"IL enum signature :System.Data.SchemaType use System.Data.SchemaType"
		alias
			"1"
		end

end -- class SYSTEM_DATA_SCHEMATYPE
