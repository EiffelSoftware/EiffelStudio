indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.CodeDom.Compiler.ICodeGenerator"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	SYSTEM_DLL_ICODE_GENERATOR

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Basic Operations

	generate_code_from_compile_unit (e: SYSTEM_DLL_CODE_COMPILE_UNIT; w: TEXT_WRITER; o: SYSTEM_DLL_CODE_GENERATOR_OPTIONS) is
		external
			"IL deferred signature (System.CodeDom.CodeCompileUnit, System.IO.TextWriter, System.CodeDom.Compiler.CodeGeneratorOptions): System.Void use System.CodeDom.Compiler.ICodeGenerator"
		alias
			"GenerateCodeFromCompileUnit"
		end

	generate_code_from_type (e: SYSTEM_DLL_CODE_TYPE_DECLARATION; w: TEXT_WRITER; o: SYSTEM_DLL_CODE_GENERATOR_OPTIONS) is
		external
			"IL deferred signature (System.CodeDom.CodeTypeDeclaration, System.IO.TextWriter, System.CodeDom.Compiler.CodeGeneratorOptions): System.Void use System.CodeDom.Compiler.ICodeGenerator"
		alias
			"GenerateCodeFromType"
		end

	generate_code_from_expression (e: SYSTEM_DLL_CODE_EXPRESSION; w: TEXT_WRITER; o: SYSTEM_DLL_CODE_GENERATOR_OPTIONS) is
		external
			"IL deferred signature (System.CodeDom.CodeExpression, System.IO.TextWriter, System.CodeDom.Compiler.CodeGeneratorOptions): System.Void use System.CodeDom.Compiler.ICodeGenerator"
		alias
			"GenerateCodeFromExpression"
		end

	is_valid_identifier (value: SYSTEM_STRING): BOOLEAN is
		external
			"IL deferred signature (System.String): System.Boolean use System.CodeDom.Compiler.ICodeGenerator"
		alias
			"IsValidIdentifier"
		end

	generate_code_from_namespace (e: SYSTEM_DLL_CODE_NAMESPACE; w: TEXT_WRITER; o: SYSTEM_DLL_CODE_GENERATOR_OPTIONS) is
		external
			"IL deferred signature (System.CodeDom.CodeNamespace, System.IO.TextWriter, System.CodeDom.Compiler.CodeGeneratorOptions): System.Void use System.CodeDom.Compiler.ICodeGenerator"
		alias
			"GenerateCodeFromNamespace"
		end

	create_escaped_identifier (value: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL deferred signature (System.String): System.String use System.CodeDom.Compiler.ICodeGenerator"
		alias
			"CreateEscapedIdentifier"
		end

	get_type_output (type: SYSTEM_DLL_CODE_TYPE_REFERENCE): SYSTEM_STRING is
		external
			"IL deferred signature (System.CodeDom.CodeTypeReference): System.String use System.CodeDom.Compiler.ICodeGenerator"
		alias
			"GetTypeOutput"
		end

	generate_code_from_statement (e: SYSTEM_DLL_CODE_STATEMENT; w: TEXT_WRITER; o: SYSTEM_DLL_CODE_GENERATOR_OPTIONS) is
		external
			"IL deferred signature (System.CodeDom.CodeStatement, System.IO.TextWriter, System.CodeDom.Compiler.CodeGeneratorOptions): System.Void use System.CodeDom.Compiler.ICodeGenerator"
		alias
			"GenerateCodeFromStatement"
		end

	supports (supports2: SYSTEM_DLL_GENERATOR_SUPPORT): BOOLEAN is
		external
			"IL deferred signature (System.CodeDom.Compiler.GeneratorSupport): System.Boolean use System.CodeDom.Compiler.ICodeGenerator"
		alias
			"Supports"
		end

	validate_identifier (value: SYSTEM_STRING) is
		external
			"IL deferred signature (System.String): System.Void use System.CodeDom.Compiler.ICodeGenerator"
		alias
			"ValidateIdentifier"
		end

	create_valid_identifier (value: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL deferred signature (System.String): System.String use System.CodeDom.Compiler.ICodeGenerator"
		alias
			"CreateValidIdentifier"
		end

end -- class SYSTEM_DLL_ICODE_GENERATOR
