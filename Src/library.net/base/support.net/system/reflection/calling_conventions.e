indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Reflection.CallingConventions"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"
	enum_type: "INTEGER"

frozen expanded external class
	CALLING_CONVENTIONS

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen explicit_this: CALLING_CONVENTIONS is
		external
			"IL enum signature :System.Reflection.CallingConventions use System.Reflection.CallingConventions"
		alias
			"64"
		end

	frozen standard: CALLING_CONVENTIONS is
		external
			"IL enum signature :System.Reflection.CallingConventions use System.Reflection.CallingConventions"
		alias
			"1"
		end

	frozen var_args: CALLING_CONVENTIONS is
		external
			"IL enum signature :System.Reflection.CallingConventions use System.Reflection.CallingConventions"
		alias
			"2"
		end

	frozen has_this: CALLING_CONVENTIONS is
		external
			"IL enum signature :System.Reflection.CallingConventions use System.Reflection.CallingConventions"
		alias
			"32"
		end

	frozen any: CALLING_CONVENTIONS is
		external
			"IL enum signature :System.Reflection.CallingConventions use System.Reflection.CallingConventions"
		alias
			"3"
		end

feature -- Basic Operations

	infix "|" (infix_arg: like Current): like Current is
		do
			--Built-in
		end

end -- class CALLING_CONVENTIONS
