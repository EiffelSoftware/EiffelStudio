indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.CodeDom.Compiler.ICodeGenerator"

deferred external class
	SYSTEM_CODEDOM_COMPILER_ICODEGENERATOR

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Basic Operations

	generate_code_from_compile_unit (e: SYSTEM_CODEDOM_CODECOMPILEUNIT; w: SYSTEM_IO_TEXTWRITER; o: SYSTEM_CODEDOM_COMPILER_CODEGENERATOROPTIONS) is
		external
			"IL deferred signature (System.CodeDom.CodeCompileUnit, System.IO.TextWriter, System.CodeDom.Compiler.CodeGeneratorOptions): System.Void use System.CodeDom.Compiler.ICodeGenerator"
		alias
			"GenerateCodeFromCompileUnit"
		end

	generate_code_from_type (e: SYSTEM_CODEDOM_CODETYPEDECLARATION; w: SYSTEM_IO_TEXTWRITER; o: SYSTEM_CODEDOM_COMPILER_CODEGENERATOROPTIONS) is
		external
			"IL deferred signature (System.CodeDom.CodeTypeDeclaration, System.IO.TextWriter, System.CodeDom.Compiler.CodeGeneratorOptions): System.Void use System.CodeDom.Compiler.ICodeGenerator"
		alias
			"GenerateCodeFromType"
		end

	generate_code_from_expression (e: SYSTEM_CODEDOM_CODEEXPRESSION; w: SYSTEM_IO_TEXTWRITER; o: SYSTEM_CODEDOM_COMPILER_CODEGENERATOROPTIONS) is
		external
			"IL deferred signature (System.CodeDom.CodeExpression, System.IO.TextWriter, System.CodeDom.Compiler.CodeGeneratorOptions): System.Void use System.CodeDom.Compiler.ICodeGenerator"
		alias
			"GenerateCodeFromExpression"
		end

	is_valid_identifier (value: STRING): BOOLEAN is
		external
			"IL deferred signature (System.String): System.Boolean use System.CodeDom.Compiler.ICodeGenerator"
		alias
			"IsValidIdentifier"
		end

	generate_code_from_namespace (e: SYSTEM_CODEDOM_CODENAMESPACE; w: SYSTEM_IO_TEXTWRITER; o: SYSTEM_CODEDOM_COMPILER_CODEGENERATOROPTIONS) is
		external
			"IL deferred signature (System.CodeDom.CodeNamespace, System.IO.TextWriter, System.CodeDom.Compiler.CodeGeneratorOptions): System.Void use System.CodeDom.Compiler.ICodeGenerator"
		alias
			"GenerateCodeFromNamespace"
		end

	create_escaped_identifier (value: STRING): STRING is
		external
			"IL deferred signature (System.String): System.String use System.CodeDom.Compiler.ICodeGenerator"
		alias
			"CreateEscapedIdentifier"
		end

	get_type_output (type: SYSTEM_CODEDOM_CODETYPEREFERENCE): STRING is
		external
			"IL deferred signature (System.CodeDom.CodeTypeReference): System.String use System.CodeDom.Compiler.ICodeGenerator"
		alias
			"GetTypeOutput"
		end

	generate_code_from_statement (e: SYSTEM_CODEDOM_CODESTATEMENT; w: SYSTEM_IO_TEXTWRITER; o: SYSTEM_CODEDOM_COMPILER_CODEGENERATOROPTIONS) is
		external
			"IL deferred signature (System.CodeDom.CodeStatement, System.IO.TextWriter, System.CodeDom.Compiler.CodeGeneratorOptions): System.Void use System.CodeDom.Compiler.ICodeGenerator"
		alias
			"GenerateCodeFromStatement"
		end

	supports (supports2: SYSTEM_CODEDOM_COMPILER_GENERATORSUPPORT): BOOLEAN is
		external
			"IL deferred signature (System.CodeDom.Compiler.GeneratorSupport): System.Boolean use System.CodeDom.Compiler.ICodeGenerator"
		alias
			"Supports"
		end

	validate_identifier (value: STRING) is
		external
			"IL deferred signature (System.String): System.Void use System.CodeDom.Compiler.ICodeGenerator"
		alias
			"ValidateIdentifier"
		end

	create_valid_identifier (value: STRING): STRING is
		external
			"IL deferred signature (System.String): System.String use System.CodeDom.Compiler.ICodeGenerator"
		alias
			"CreateValidIdentifier"
		end

end -- class SYSTEM_CODEDOM_COMPILER_ICODEGENERATOR
