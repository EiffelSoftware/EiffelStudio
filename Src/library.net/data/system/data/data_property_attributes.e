indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Data.PropertyAttributes"
	assembly: "System.Data", "1.0.3300.0", "neutral", "b77a5c561934e089"
	enum_type: "INTEGER"

frozen expanded external class
	DATA_PROPERTY_ATTRIBUTES

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen not_supported: DATA_PROPERTY_ATTRIBUTES is
		external
			"IL enum signature :System.Data.PropertyAttributes use System.Data.PropertyAttributes"
		alias
			"0"
		end

	frozen required: DATA_PROPERTY_ATTRIBUTES is
		external
			"IL enum signature :System.Data.PropertyAttributes use System.Data.PropertyAttributes"
		alias
			"1"
		end

	frozen optional: DATA_PROPERTY_ATTRIBUTES is
		external
			"IL enum signature :System.Data.PropertyAttributes use System.Data.PropertyAttributes"
		alias
			"2"
		end

	frozen read: DATA_PROPERTY_ATTRIBUTES is
		external
			"IL enum signature :System.Data.PropertyAttributes use System.Data.PropertyAttributes"
		alias
			"512"
		end

	frozen write: DATA_PROPERTY_ATTRIBUTES is
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

end -- class DATA_PROPERTY_ATTRIBUTES
