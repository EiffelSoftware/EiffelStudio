indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Reflection.EventAttributes"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"
	enum_type: "INTEGER"

frozen expanded external class
	EVENT_ATTRIBUTES

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen special_name: EVENT_ATTRIBUTES is
		external
			"IL enum signature :System.Reflection.EventAttributes use System.Reflection.EventAttributes"
		alias
			"512"
		end

	frozen none: EVENT_ATTRIBUTES is
		external
			"IL enum signature :System.Reflection.EventAttributes use System.Reflection.EventAttributes"
		alias
			"0"
		end

	frozen reserved_mask: EVENT_ATTRIBUTES is
		external
			"IL enum signature :System.Reflection.EventAttributes use System.Reflection.EventAttributes"
		alias
			"1024"
		end

	frozen rtspecial_name: EVENT_ATTRIBUTES is
		external
			"IL enum signature :System.Reflection.EventAttributes use System.Reflection.EventAttributes"
		alias
			"1024"
		end

end -- class EVENT_ATTRIBUTES
