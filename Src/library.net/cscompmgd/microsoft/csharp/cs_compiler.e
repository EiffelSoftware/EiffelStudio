indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "Microsoft.CSharp.Compiler"
	assembly: "cscompmgd", "7.0.3300.0", "neutral", "b03f5f7f11d5a3a"

external class
	CS_COMPILER

inherit
	SYSTEM_OBJECT

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use Microsoft.CSharp.Compiler"
		end

feature -- Basic Operations

	frozen compile (source_texts: NATIVE_ARRAY [SYSTEM_STRING]; source_text_names: NATIVE_ARRAY [SYSTEM_STRING]; target: SYSTEM_STRING; imports: NATIVE_ARRAY [SYSTEM_STRING]; options: IDICTIONARY): NATIVE_ARRAY [CS_COMPILER_ERROR] is
		external
			"IL static signature (System.String[], System.String[], System.String, System.String[], System.Collections.IDictionary): Microsoft.CSharp.CompilerError[] use Microsoft.CSharp.Compiler"
		alias
			"Compile"
		end

end -- class CS_COMPILER
