indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Runtime.CompilerServices.CompilationRelaxationsAttribute"

external class
	SYSTEM_RUNTIME_COMPILERSERVICES_COMPILATIONRELAXATIONSATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE

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

end -- class SYSTEM_RUNTIME_COMPILERSERVICES_COMPILATIONRELAXATIONSATTRIBUTE
