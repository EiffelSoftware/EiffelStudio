indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.PropertyAttributes"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_DATA_PROPERTYATTRIBUTES

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

	frozen not_supported: SYSTEM_DATA_PROPERTYATTRIBUTES is
		external
			"IL enum signature :System.Data.PropertyAttributes use System.Data.PropertyAttributes"
		alias
			"0"
		end

	frozen required: SYSTEM_DATA_PROPERTYATTRIBUTES is
		external
			"IL enum signature :System.Data.PropertyAttributes use System.Data.PropertyAttributes"
		alias
			"1"
		end

	frozen optional: SYSTEM_DATA_PROPERTYATTRIBUTES is
		external
			"IL enum signature :System.Data.PropertyAttributes use System.Data.PropertyAttributes"
		alias
			"2"
		end

	frozen read: SYSTEM_DATA_PROPERTYATTRIBUTES is
		external
			"IL enum signature :System.Data.PropertyAttributes use System.Data.PropertyAttributes"
		alias
			"512"
		end

	frozen write: SYSTEM_DATA_PROPERTYATTRIBUTES is
		external
			"IL enum signature :System.Data.PropertyAttributes use System.Data.PropertyAttributes"
		alias
			"1024"
		end

feature -- Basic Operations

	infix "|" (infix_arg: like Current): like Current is
		do
			--Built-in
		end

end -- class SYSTEM_DATA_PROPERTYATTRIBUTES
