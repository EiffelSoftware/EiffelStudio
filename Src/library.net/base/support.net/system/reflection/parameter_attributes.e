indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Reflection.ParameterAttributes"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"
	enum_type: "INTEGER"

frozen expanded external class
	PARAMETER_ATTRIBUTES

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen reserved3: PARAMETER_ATTRIBUTES is
		external
			"IL enum signature :System.Reflection.ParameterAttributes use System.Reflection.ParameterAttributes"
		alias
			"16384"
		end

	frozen reserved_mask: PARAMETER_ATTRIBUTES is
		external
			"IL enum signature :System.Reflection.ParameterAttributes use System.Reflection.ParameterAttributes"
		alias
			"61440"
		end

	frozen in: PARAMETER_ATTRIBUTES is
		external
			"IL enum signature :System.Reflection.ParameterAttributes use System.Reflection.ParameterAttributes"
		alias
			"1"
		end

	frozen out_: PARAMETER_ATTRIBUTES is
		external
			"IL enum signature :System.Reflection.ParameterAttributes use System.Reflection.ParameterAttributes"
		alias
			"2"
		end

	frozen optional: PARAMETER_ATTRIBUTES is
		external
			"IL enum signature :System.Reflection.ParameterAttributes use System.Reflection.ParameterAttributes"
		alias
			"16"
		end

	frozen retval: PARAMETER_ATTRIBUTES is
		external
			"IL enum signature :System.Reflection.ParameterAttributes use System.Reflection.ParameterAttributes"
		alias
			"8"
		end

	frozen none: PARAMETER_ATTRIBUTES is
		external
			"IL enum signature :System.Reflection.ParameterAttributes use System.Reflection.ParameterAttributes"
		alias
			"0"
		end

	frozen lcid: PARAMETER_ATTRIBUTES is
		external
			"IL enum signature :System.Reflection.ParameterAttributes use System.Reflection.ParameterAttributes"
		alias
			"4"
		end

	frozen has_field_marshal: PARAMETER_ATTRIBUTES is
		external
			"IL enum signature :System.Reflection.ParameterAttributes use System.Reflection.ParameterAttributes"
		alias
			"8192"
		end

	frozen reserved4: PARAMETER_ATTRIBUTES is
		external
			"IL enum signature :System.Reflection.ParameterAttributes use System.Reflection.ParameterAttributes"
		alias
			"32768"
		end

	frozen has_default: PARAMETER_ATTRIBUTES is
		external
			"IL enum signature :System.Reflection.ParameterAttributes use System.Reflection.ParameterAttributes"
		alias
			"4096"
		end

feature -- Basic Operations

	infix "|" (infix_arg: like Current): like Current is
		do
			--Built-in
		end

end -- class PARAMETER_ATTRIBUTES
