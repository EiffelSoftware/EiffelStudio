indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.CodeDom.Compiler.ICodeParser"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	SYSTEM_DLL_ICODE_PARSER

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Basic Operations

	parse (code_stream: TEXT_READER): SYSTEM_DLL_CODE_COMPILE_UNIT is
		external
			"IL deferred signature (System.IO.TextReader): System.CodeDom.CodeCompileUnit use System.CodeDom.Compiler.ICodeParser"
		alias
			"Parse"
		end

end -- class SYSTEM_DLL_ICODE_PARSER
