indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.CompilerServices.CompilerGlobalScopeAttribute"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	COMPILER_GLOBAL_SCOPE_ATTRIBUTE

inherit
	ATTRIBUTE

create
	make_compiler_global_scope_attribute

feature {NONE} -- Initialization

	frozen make_compiler_global_scope_attribute is
		external
			"IL creator use System.Runtime.CompilerServices.CompilerGlobalScopeAttribute"
		end

end -- class COMPILER_GLOBAL_SCOPE_ATTRIBUTE
