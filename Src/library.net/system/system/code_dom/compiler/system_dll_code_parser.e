indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.CodeDom.Compiler.CodeParser"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	SYSTEM_DLL_CODE_PARSER

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	SYSTEM_DLL_ICODE_PARSER

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.CodeDom.Compiler.CodeParser"
		alias
			"GetHashCode"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.CodeDom.Compiler.CodeParser"
		alias
			"ToString"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.CodeDom.Compiler.CodeParser"
		alias
			"Equals"
		end

	parse (code_stream: TEXT_READER): SYSTEM_DLL_CODE_COMPILE_UNIT is
		external
			"IL deferred signature (System.IO.TextReader): System.CodeDom.CodeCompileUnit use System.CodeDom.Compiler.CodeParser"
		alias
			"Parse"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.CodeDom.Compiler.CodeParser"
		alias
			"Finalize"
		end

end -- class SYSTEM_DLL_CODE_PARSER
