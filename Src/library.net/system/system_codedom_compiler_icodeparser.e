indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.CodeDom.Compiler.ICodeParser"

deferred external class
	SYSTEM_CODEDOM_COMPILER_ICODEPARSER

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Basic Operations

	parse (code_stream: SYSTEM_IO_TEXTREADER): SYSTEM_CODEDOM_CODECOMPILEUNIT is
		external
			"IL deferred signature (System.IO.TextReader): System.CodeDom.CodeCompileUnit use System.CodeDom.Compiler.ICodeParser"
		alias
			"Parse"
		end

end -- class SYSTEM_CODEDOM_COMPILER_ICODEPARSER
