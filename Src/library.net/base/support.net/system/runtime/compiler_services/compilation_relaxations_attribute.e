indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.CompilerServices.CompilationRelaxationsAttribute"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	COMPILATION_RELAXATIONS_ATTRIBUTE

inherit
	ATTRIBUTE

create
	make_compilation_relaxations_attribute

feature {NONE} -- Initialization

	frozen make_compilation_relaxations_attribute (relaxations: INTEGER) is
		external
			"IL creator signature (System.Int32) use System.Runtime.CompilerServices.CompilationRelaxationsAttribute"
		end

feature -- Access

	frozen get_compilation_relaxations: INTEGER is
		external
			"IL signature (): System.Int32 use System.Runtime.CompilerServices.CompilationRelaxationsAttribute"
		alias
			"get_CompilationRelaxations"
		end

end -- class COMPILATION_RELAXATIONS_ATTRIBUTE
