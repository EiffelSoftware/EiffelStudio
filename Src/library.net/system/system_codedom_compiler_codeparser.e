indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.CodeDom.Compiler.CodeParser"

deferred external class
	SYSTEM_CODEDOM_COMPILER_CODEPARSER

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_CODEDOM_COMPILER_ICODEPARSER

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.CodeDom.Compiler.CodeParser"
		alias
			"GetHashCode"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.CodeDom.Compiler.CodeParser"
		alias
			"ToString"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.CodeDom.Compiler.CodeParser"
		alias
			"Equals"
		end

	parse (code_stream: SYSTEM_IO_TEXTREADER): SYSTEM_CODEDOM_CODECOMPILEUNIT is
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

end -- class SYSTEM_CODEDOM_COMPILER_CODEPARSER
