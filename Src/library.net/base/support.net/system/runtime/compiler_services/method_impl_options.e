indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.CompilerServices.MethodImplOptions"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"
	enum_type: "INTEGER"

frozen expanded external class
	METHOD_IMPL_OPTIONS

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen no_inlining: METHOD_IMPL_OPTIONS is
		external
			"IL enum signature :System.Runtime.CompilerServices.MethodImplOptions use System.Runtime.CompilerServices.MethodImplOptions"
		alias
			"8"
		end

	frozen preserve_sig: METHOD_IMPL_OPTIONS is
		external
			"IL enum signature :System.Runtime.CompilerServices.MethodImplOptions use System.Runtime.CompilerServices.MethodImplOptions"
		alias
			"128"
		end

	frozen internal_call: METHOD_IMPL_OPTIONS is
		external
			"IL enum signature :System.Runtime.CompilerServices.MethodImplOptions use System.Runtime.CompilerServices.MethodImplOptions"
		alias
			"4096"
		end

	frozen unmanaged: METHOD_IMPL_OPTIONS is
		external
			"IL enum signature :System.Runtime.CompilerServices.MethodImplOptions use System.Runtime.CompilerServices.MethodImplOptions"
		alias
			"4"
		end

	frozen synchronized: METHOD_IMPL_OPTIONS is
		external
			"IL enum signature :System.Runtime.CompilerServices.MethodImplOptions use System.Runtime.CompilerServices.MethodImplOptions"
		alias
			"32"
		end

	frozen forward_ref: METHOD_IMPL_OPTIONS is
		external
			"IL enum signature :System.Runtime.CompilerServices.MethodImplOptions use System.Runtime.CompilerServices.MethodImplOptions"
		alias
			"16"
		end

end -- class METHOD_IMPL_OPTIONS
