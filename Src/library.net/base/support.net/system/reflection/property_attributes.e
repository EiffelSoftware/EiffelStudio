indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Reflection.PropertyAttributes"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"
	enum_type: "INTEGER"

frozen expanded external class
	PROPERTY_ATTRIBUTES

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen reserved3: PROPERTY_ATTRIBUTES is
		external
			"IL enum signature :System.Reflection.PropertyAttributes use System.Reflection.PropertyAttributes"
		alias
			"16384"
		end

	frozen reserved_mask: PROPERTY_ATTRIBUTES is
		external
			"IL enum signature :System.Reflection.PropertyAttributes use System.Reflection.PropertyAttributes"
		alias
			"62464"
		end

	frozen rtspecial_name: PROPERTY_ATTRIBUTES is
		external
			"IL enum signature :System.Reflection.PropertyAttributes use System.Reflection.PropertyAttributes"
		alias
			"1024"
		end

	frozen special_name: PROPERTY_ATTRIBUTES is
		external
			"IL enum signature :System.Reflection.PropertyAttributes use System.Reflection.PropertyAttributes"
		alias
			"512"
		end

	frozen none: PROPERTY_ATTRIBUTES is
		external
			"IL enum signature :System.Reflection.PropertyAttributes use System.Reflection.PropertyAttributes"
		alias
			"0"
		end

	frozen reserved4: PROPERTY_ATTRIBUTES is
		external
			"IL enum signature :System.Reflection.PropertyAttributes use System.Reflection.PropertyAttributes"
		alias
			"32768"
		end

	frozen has_default: PROPERTY_ATTRIBUTES is
		external
			"IL enum signature :System.Reflection.PropertyAttributes use System.Reflection.PropertyAttributes"
		alias
			"4096"
		end

	frozen reserved2: PROPERTY_ATTRIBUTES is
		external
			"IL enum signature :System.Reflection.PropertyAttributes use System.Reflection.PropertyAttributes"
		alias
			"8192"
		end

feature -- Basic Operations

	infix "|" (infix_arg: like Current): like Current is
		do
			--Built-in
		end

end -- class PROPERTY_ATTRIBUTES
