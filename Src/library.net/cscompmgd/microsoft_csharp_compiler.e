indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "Microsoft.CSharp.Compiler"

external class
	MICROSOFT_CSHARP_COMPILER

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use Microsoft.CSharp.Compiler"
		end

feature -- Basic Operations

	frozen compile (source_texts: ARRAY [STRING]; source_text_names: ARRAY [STRING]; target: STRING; imports: ARRAY [STRING]; options: SYSTEM_COLLECTIONS_IDICTIONARY): ARRAY [MICROSOFT_CSHARP_COMPILERERROR] is
		external
			"IL static signature (System.String[], System.String[], System.String, System.String[], System.Collections.IDictionary): Microsoft.CSharp.CompilerError[] use Microsoft.CSharp.Compiler"
		alias
			"Compile"
		end

end -- class MICROSOFT_CSHARP_COMPILER
