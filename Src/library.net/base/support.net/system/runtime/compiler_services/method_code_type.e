indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.CompilerServices.MethodCodeType"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"
	enum_type: "INTEGER"

frozen expanded external class
	METHOD_CODE_TYPE

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen optil: METHOD_CODE_TYPE is
		external
			"IL enum signature :System.Runtime.CompilerServices.MethodCodeType use System.Runtime.CompilerServices.MethodCodeType"
		alias
			"2"
		end

	frozen native: METHOD_CODE_TYPE is
		external
			"IL enum signature :System.Runtime.CompilerServices.MethodCodeType use System.Runtime.CompilerServices.MethodCodeType"
		alias
			"1"
		end

	frozen runtime: METHOD_CODE_TYPE is
		external
			"IL enum signature :System.Runtime.CompilerServices.MethodCodeType use System.Runtime.CompilerServices.MethodCodeType"
		alias
			"3"
		end

	frozen il: METHOD_CODE_TYPE is
		external
			"IL enum signature :System.Runtime.CompilerServices.MethodCodeType use System.Runtime.CompilerServices.MethodCodeType"
		alias
			"0"
		end

feature -- Basic Operations

	infix "|" (infix_arg: like Current): like Current is
		do
			--Built-in
		end

	from_integer (a_value: INTEGER): like Current is
		do
			--Built-in
		end

	to_integer: INTEGER is
		do
			--Built-in
		end

end -- class METHOD_CODE_TYPE
