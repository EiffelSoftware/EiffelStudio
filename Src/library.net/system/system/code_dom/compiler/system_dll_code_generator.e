indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.CodeDom.Compiler.CodeGenerator"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	SYSTEM_DLL_CODE_GENERATOR

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	SYSTEM_DLL_ICODE_GENERATOR
		rename
			get_type_output as system_code_dom_compiler_icode_generator_get_type_output,
			create_valid_identifier as system_code_dom_compiler_icode_generator_create_valid_identifier,
			create_escaped_identifier as system_code_dom_compiler_icode_generator_create_escaped_identifier,
			validate_identifier as system_code_dom_compiler_icode_generator_validate_identifier,
			is_valid_identifier as system_code_dom_compiler_icode_generator_is_valid_identifier,
			generate_code_from_statement as system_code_dom_compiler_icode_generator_generate_code_from_statement,
			generate_code_from_namespace as system_code_dom_compiler_icode_generator_generate_code_from_namespace,
			generate_code_from_compile_unit as system_code_dom_compiler_icode_generator_generate_code_from_compile_unit,
			generate_code_from_expression as system_code_dom_compiler_icode_generator_generate_code_from_expression,
			generate_code_from_type as system_code_dom_compiler_icode_generator_generate_code_from_type,
			supports as system_code_dom_compiler_icode_generator_supports
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GetHashCode"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.CodeDom.Compiler.CodeGenerator"
		alias
			"ToString"
		end

	frozen is_valid_language_independent_identifier (value: SYSTEM_STRING): BOOLEAN is
		external
			"IL static signature (System.String): System.Boolean use System.CodeDom.Compiler.CodeGenerator"
		alias
			"IsValidLanguageIndependentIdentifier"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.CodeDom.Compiler.CodeGenerator"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	generate_field_reference_expression (e: SYSTEM_DLL_CODE_FIELD_REFERENCE_EXPRESSION) is
		external
			"IL deferred signature (System.CodeDom.CodeFieldReferenceExpression): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateFieldReferenceExpression"
		end

	output_member_access_modifier (attributes: SYSTEM_DLL_MEMBER_ATTRIBUTES) is
		external
			"IL signature (System.CodeDom.MemberAttributes): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"OutputMemberAccessModifier"
		end

	frozen system_code_dom_compiler_icode_generator_supports (support: SYSTEM_DLL_GENERATOR_SUPPORT): BOOLEAN is
		external
			"IL signature (System.CodeDom.Compiler.GeneratorSupport): System.Boolean use System.CodeDom.Compiler.CodeGenerator"
		alias
			"System.CodeDom.Compiler.ICodeGenerator.Supports"
		end

	output_type_attributes (attributes: TYPE_ATTRIBUTES; is_struct: BOOLEAN; is_enum: BOOLEAN) is
		external
			"IL signature (System.Reflection.TypeAttributes, System.Boolean, System.Boolean): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"OutputTypeAttributes"
		end

	generate_comment (e: SYSTEM_DLL_CODE_COMMENT) is
		external
			"IL deferred signature (System.CodeDom.CodeComment): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateComment"
		end

	output_attribute_declarations (attributes: SYSTEM_DLL_CODE_ATTRIBUTE_DECLARATION_COLLECTION) is
		external
			"IL signature (System.CodeDom.CodeAttributeDeclarationCollection): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"OutputAttributeDeclarations"
		end

	generate_attach_event_statement (e: SYSTEM_DLL_CODE_ATTACH_EVENT_STATEMENT) is
		external
			"IL deferred signature (System.CodeDom.CodeAttachEventStatement): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateAttachEventStatement"
		end

	generate_method_invoke_expression (e: SYSTEM_DLL_CODE_METHOD_INVOKE_EXPRESSION) is
		external
			"IL deferred signature (System.CodeDom.CodeMethodInvokeExpression): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateMethodInvokeExpression"
		end

	is_valid_identifier (value: SYSTEM_STRING): BOOLEAN is
		external
			"IL deferred signature (System.String): System.Boolean use System.CodeDom.Compiler.CodeGenerator"
		alias
			"IsValidIdentifier"
		end

	finalize is
		external
			"IL signature (): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"Finalize"
		end

	output_identifier (ident: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"OutputIdentifier"
		end

	generate_property_set_value_reference_expression (e: SYSTEM_DLL_CODE_PROPERTY_SET_VALUE_REFERENCE_EXPRESSION) is
		external
			"IL deferred signature (System.CodeDom.CodePropertySetValueReferenceExpression): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GeneratePropertySetValueReferenceExpression"
		end

	frozen generate_namespace_imports (e: SYSTEM_DLL_CODE_NAMESPACE) is
		external
			"IL signature (System.CodeDom.CodeNamespace): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateNamespaceImports"
		end

	generate_namespace_end (e: SYSTEM_DLL_CODE_NAMESPACE) is
		external
			"IL deferred signature (System.CodeDom.CodeNamespace): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateNamespaceEnd"
		end

	frozen system_code_dom_compiler_icode_generator_create_escaped_identifier (value: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL signature (System.String): System.String use System.CodeDom.Compiler.CodeGenerator"
		alias
			"System.CodeDom.Compiler.ICodeGenerator.CreateEscapedIdentifier"
		end

	validate_identifier (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"ValidateIdentifier"
		end

	frozen system_code_dom_compiler_icode_generator_get_type_output (type: SYSTEM_DLL_CODE_TYPE_REFERENCE): SYSTEM_STRING is
		external
			"IL signature (System.CodeDom.CodeTypeReference): System.String use System.CodeDom.Compiler.CodeGenerator"
		alias
			"System.CodeDom.Compiler.ICodeGenerator.GetTypeOutput"
		end

	generate_type_of_expression (e: SYSTEM_DLL_CODE_TYPE_OF_EXPRESSION) is
		external
			"IL signature (System.CodeDom.CodeTypeOfExpression): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateTypeOfExpression"
		end

	frozen get_options: SYSTEM_DLL_CODE_GENERATOR_OPTIONS is
		external
			"IL signature (): System.CodeDom.Compiler.CodeGeneratorOptions use System.CodeDom.Compiler.CodeGenerator"
		alias
			"get_Options"
		end

	frozen get_is_current_delegate: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.CodeDom.Compiler.CodeGenerator"
		alias
			"get_IsCurrentDelegate"
		end

	frozen get_current_member_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.CodeDom.Compiler.CodeGenerator"
		alias
			"get_CurrentMemberName"
		end

	frozen get_current_type_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.CodeDom.Compiler.CodeGenerator"
		alias
			"get_CurrentTypeName"
		end

	generate_condition_statement (e: SYSTEM_DLL_CODE_CONDITION_STATEMENT) is
		external
			"IL deferred signature (System.CodeDom.CodeConditionStatement): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateConditionStatement"
		end

	generate_cast_expression (e: SYSTEM_DLL_CODE_CAST_EXPRESSION) is
		external
			"IL deferred signature (System.CodeDom.CodeCastExpression): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateCastExpression"
		end

	frozen system_code_dom_compiler_icode_generator_is_valid_identifier (value: SYSTEM_STRING): BOOLEAN is
		external
			"IL signature (System.String): System.Boolean use System.CodeDom.Compiler.CodeGenerator"
		alias
			"System.CodeDom.Compiler.ICodeGenerator.IsValidIdentifier"
		end

	generate_iteration_statement (e: SYSTEM_DLL_CODE_ITERATION_STATEMENT) is
		external
			"IL deferred signature (System.CodeDom.CodeIterationStatement): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateIterationStatement"
		end

	generate_expression_statement (e: SYSTEM_DLL_CODE_EXPRESSION_STATEMENT) is
		external
			"IL deferred signature (System.CodeDom.CodeExpressionStatement): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateExpressionStatement"
		end

	frozen set_indent (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"set_Indent"
		end

	generate_variable_declaration_statement (e: SYSTEM_DLL_CODE_VARIABLE_DECLARATION_STATEMENT) is
		external
			"IL deferred signature (System.CodeDom.CodeVariableDeclarationStatement): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateVariableDeclarationStatement"
		end

	generate_delegate_create_expression (e: SYSTEM_DLL_CODE_DELEGATE_CREATE_EXPRESSION) is
		external
			"IL deferred signature (System.CodeDom.CodeDelegateCreateExpression): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateDelegateCreateExpression"
		end

	output_attribute_argument (arg: SYSTEM_DLL_CODE_ATTRIBUTE_ARGUMENT) is
		external
			"IL signature (System.CodeDom.CodeAttributeArgument): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"OutputAttributeArgument"
		end

	frozen generate_types (e: SYSTEM_DLL_CODE_NAMESPACE) is
		external
			"IL signature (System.CodeDom.CodeNamespace): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateTypes"
		end

	frozen get_is_current_class: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.CodeDom.Compiler.CodeGenerator"
		alias
			"get_IsCurrentClass"
		end

	generate_goto_statement (e: SYSTEM_DLL_CODE_GOTO_STATEMENT) is
		external
			"IL deferred signature (System.CodeDom.CodeGotoStatement): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateGotoStatement"
		end

	output_direction (dir: SYSTEM_DLL_FIELD_DIRECTION) is
		external
			"IL signature (System.CodeDom.FieldDirection): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"OutputDirection"
		end

	generate_constructor (e: SYSTEM_DLL_CODE_CONSTRUCTOR; c: SYSTEM_DLL_CODE_TYPE_DECLARATION) is
		external
			"IL deferred signature (System.CodeDom.CodeConstructor, System.CodeDom.CodeTypeDeclaration): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateConstructor"
		end

	generate_namespace (e: SYSTEM_DLL_CODE_NAMESPACE) is
		external
			"IL signature (System.CodeDom.CodeNamespace): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateNamespace"
		end

	frozen get_indent: INTEGER is
		external
			"IL signature (): System.Int32 use System.CodeDom.Compiler.CodeGenerator"
		alias
			"get_Indent"
		end

	generate_compile_unit_start (e: SYSTEM_DLL_CODE_COMPILE_UNIT) is
		external
			"IL signature (System.CodeDom.CodeCompileUnit): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateCompileUnitStart"
		end

	generate_remove_event_statement (e: SYSTEM_DLL_CODE_REMOVE_EVENT_STATEMENT) is
		external
			"IL deferred signature (System.CodeDom.CodeRemoveEventStatement): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateRemoveEventStatement"
		end

	frozen system_code_dom_compiler_icode_generator_validate_identifier (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"System.CodeDom.Compiler.ICodeGenerator.ValidateIdentifier"
		end

	generate_method_reference_expression (e: SYSTEM_DLL_CODE_METHOD_REFERENCE_EXPRESSION) is
		external
			"IL deferred signature (System.CodeDom.CodeMethodReferenceExpression): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateMethodReferenceExpression"
		end

	generate_array_indexer_expression (e: SYSTEM_DLL_CODE_ARRAY_INDEXER_EXPRESSION) is
		external
			"IL deferred signature (System.CodeDom.CodeArrayIndexerExpression): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateArrayIndexerExpression"
		end

	generate_indexer_expression (e: SYSTEM_DLL_CODE_INDEXER_EXPRESSION) is
		external
			"IL deferred signature (System.CodeDom.CodeIndexerExpression): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateIndexerExpression"
		end

	generate_entry_point_method (e: SYSTEM_DLL_CODE_ENTRY_POINT_METHOD; c: SYSTEM_DLL_CODE_TYPE_DECLARATION) is
		external
			"IL deferred signature (System.CodeDom.CodeEntryPointMethod, System.CodeDom.CodeTypeDeclaration): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateEntryPointMethod"
		end

	create_escaped_identifier (value: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL deferred signature (System.String): System.String use System.CodeDom.Compiler.CodeGenerator"
		alias
			"CreateEscapedIdentifier"
		end

	generate_compile_unit_end (e: SYSTEM_DLL_CODE_COMPILE_UNIT) is
		external
			"IL signature (System.CodeDom.CodeCompileUnit): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateCompileUnitEnd"
		end

	generate_variable_reference_expression (e: SYSTEM_DLL_CODE_VARIABLE_REFERENCE_EXPRESSION) is
		external
			"IL deferred signature (System.CodeDom.CodeVariableReferenceExpression): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateVariableReferenceExpression"
		end

	generate_labeled_statement (e: SYSTEM_DLL_CODE_LABELED_STATEMENT) is
		external
			"IL deferred signature (System.CodeDom.CodeLabeledStatement): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateLabeledStatement"
		end

	generate_attribute_declarations_start (attributes: SYSTEM_DLL_CODE_ATTRIBUTE_DECLARATION_COLLECTION) is
		external
			"IL deferred signature (System.CodeDom.CodeAttributeDeclarationCollection): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateAttributeDeclarationsStart"
		end

	generate_decimal_value (d: DECIMAL) is
		external
			"IL signature (System.Decimal): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateDecimalValue"
		end

	output_member_scope_modifier (attributes: SYSTEM_DLL_MEMBER_ATTRIBUTES) is
		external
			"IL signature (System.CodeDom.MemberAttributes): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"OutputMemberScopeModifier"
		end

	generate_namespace_start (e: SYSTEM_DLL_CODE_NAMESPACE) is
		external
			"IL deferred signature (System.CodeDom.CodeNamespace): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateNamespaceStart"
		end

	generate_base_reference_expression (e: SYSTEM_DLL_CODE_BASE_REFERENCE_EXPRESSION) is
		external
			"IL deferred signature (System.CodeDom.CodeBaseReferenceExpression): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateBaseReferenceExpression"
		end

	generate_direction_expression (e: SYSTEM_DLL_CODE_DIRECTION_EXPRESSION) is
		external
			"IL signature (System.CodeDom.CodeDirectionExpression): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateDirectionExpression"
		end

	generate_double_value (d: DOUBLE) is
		external
			"IL signature (System.Double): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateDoubleValue"
		end

	frozen get_current_member: SYSTEM_DLL_CODE_TYPE_MEMBER is
		external
			"IL signature (): System.CodeDom.CodeTypeMember use System.CodeDom.Compiler.CodeGenerator"
		alias
			"get_CurrentMember"
		end

	generate_type_start (e: SYSTEM_DLL_CODE_TYPE_DECLARATION) is
		external
			"IL deferred signature (System.CodeDom.CodeTypeDeclaration): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateTypeStart"
		end

	generate_snippet_member (e: SYSTEM_DLL_CODE_SNIPPET_TYPE_MEMBER) is
		external
			"IL deferred signature (System.CodeDom.CodeSnippetTypeMember): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateSnippetMember"
		end

	frozen system_code_dom_compiler_icode_generator_generate_code_from_compile_unit (e: SYSTEM_DLL_CODE_COMPILE_UNIT; w: TEXT_WRITER; o: SYSTEM_DLL_CODE_GENERATOR_OPTIONS) is
		external
			"IL signature (System.CodeDom.CodeCompileUnit, System.IO.TextWriter, System.CodeDom.Compiler.CodeGeneratorOptions): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"System.CodeDom.Compiler.ICodeGenerator.GenerateCodeFromCompileUnit"
		end

	generate_property (e: SYSTEM_DLL_CODE_MEMBER_PROPERTY; c: SYSTEM_DLL_CODE_TYPE_DECLARATION) is
		external
			"IL deferred signature (System.CodeDom.CodeMemberProperty, System.CodeDom.CodeTypeDeclaration): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateProperty"
		end

	create_valid_identifier (value: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL deferred signature (System.String): System.String use System.CodeDom.Compiler.CodeGenerator"
		alias
			"CreateValidIdentifier"
		end

	output_parameters (parameters: SYSTEM_DLL_CODE_PARAMETER_DECLARATION_EXPRESSION_COLLECTION) is
		external
			"IL signature (System.CodeDom.CodeParameterDeclarationExpressionCollection): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"OutputParameters"
		end

	generate_argument_reference_expression (e: SYSTEM_DLL_CODE_ARGUMENT_REFERENCE_EXPRESSION) is
		external
			"IL deferred signature (System.CodeDom.CodeArgumentReferenceExpression): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateArgumentReferenceExpression"
		end

	frozen system_code_dom_compiler_icode_generator_create_valid_identifier (value: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL signature (System.String): System.String use System.CodeDom.Compiler.CodeGenerator"
		alias
			"System.CodeDom.Compiler.ICodeGenerator.CreateValidIdentifier"
		end

	generate_property_reference_expression (e: SYSTEM_DLL_CODE_PROPERTY_REFERENCE_EXPRESSION) is
		external
			"IL deferred signature (System.CodeDom.CodePropertyReferenceExpression): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GeneratePropertyReferenceExpression"
		end

	generate_line_pragma_end (e: SYSTEM_DLL_CODE_LINE_PRAGMA) is
		external
			"IL deferred signature (System.CodeDom.CodeLinePragma): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateLinePragmaEnd"
		end

	generate_event_reference_expression (e: SYSTEM_DLL_CODE_EVENT_REFERENCE_EXPRESSION) is
		external
			"IL deferred signature (System.CodeDom.CodeEventReferenceExpression): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateEventReferenceExpression"
		end

	generate_type_constructor (e: SYSTEM_DLL_CODE_TYPE_CONSTRUCTOR) is
		external
			"IL deferred signature (System.CodeDom.CodeTypeConstructor): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateTypeConstructor"
		end

	output_operator (op: SYSTEM_DLL_CODE_BINARY_OPERATOR_TYPE) is
		external
			"IL signature (System.CodeDom.CodeBinaryOperatorType): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"OutputOperator"
		end

	generate_comment_statements (e: SYSTEM_DLL_CODE_COMMENT_STATEMENT_COLLECTION) is
		external
			"IL signature (System.CodeDom.CodeCommentStatementCollection): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateCommentStatements"
		end

	generate_single_float_value (s: REAL) is
		external
			"IL signature (System.Single): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateSingleFloatValue"
		end

	frozen get_is_current_enum: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.CodeDom.Compiler.CodeGenerator"
		alias
			"get_IsCurrentEnum"
		end

	frozen generate_expression (e: SYSTEM_DLL_CODE_EXPRESSION) is
		external
			"IL signature (System.CodeDom.CodeExpression): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateExpression"
		end

	generate_parameter_declaration_expression (e: SYSTEM_DLL_CODE_PARAMETER_DECLARATION_EXPRESSION) is
		external
			"IL signature (System.CodeDom.CodeParameterDeclarationExpression): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateParameterDeclarationExpression"
		end

	frozen system_code_dom_compiler_icode_generator_generate_code_from_statement (e: SYSTEM_DLL_CODE_STATEMENT; w: TEXT_WRITER; o: SYSTEM_DLL_CODE_GENERATOR_OPTIONS) is
		external
			"IL signature (System.CodeDom.CodeStatement, System.IO.TextWriter, System.CodeDom.Compiler.CodeGeneratorOptions): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"System.CodeDom.Compiler.ICodeGenerator.GenerateCodeFromStatement"
		end

	frozen system_code_dom_compiler_icode_generator_generate_code_from_namespace (e: SYSTEM_DLL_CODE_NAMESPACE; w: TEXT_WRITER; o: SYSTEM_DLL_CODE_GENERATOR_OPTIONS) is
		external
			"IL signature (System.CodeDom.CodeNamespace, System.IO.TextWriter, System.CodeDom.Compiler.CodeGeneratorOptions): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"System.CodeDom.Compiler.ICodeGenerator.GenerateCodeFromNamespace"
		end

	get_null_token: SYSTEM_STRING is
		external
			"IL deferred signature (): System.String use System.CodeDom.Compiler.CodeGenerator"
		alias
			"get_NullToken"
		end

	continue_on_new_line (st: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"ContinueOnNewLine"
		end

	supports (support: SYSTEM_DLL_GENERATOR_SUPPORT): BOOLEAN is
		external
			"IL deferred signature (System.CodeDom.Compiler.GeneratorSupport): System.Boolean use System.CodeDom.Compiler.CodeGenerator"
		alias
			"Supports"
		end

	frozen generate_statements (stms: SYSTEM_DLL_CODE_STATEMENT_COLLECTION) is
		external
			"IL signature (System.CodeDom.CodeStatementCollection): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateStatements"
		end

	generate_compile_unit (e: SYSTEM_DLL_CODE_COMPILE_UNIT) is
		external
			"IL signature (System.CodeDom.CodeCompileUnit): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateCompileUnit"
		end

	generate_type_end (e: SYSTEM_DLL_CODE_TYPE_DECLARATION) is
		external
			"IL deferred signature (System.CodeDom.CodeTypeDeclaration): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateTypeEnd"
		end

	generate_try_catch_finally_statement (e: SYSTEM_DLL_CODE_TRY_CATCH_FINALLY_STATEMENT) is
		external
			"IL deferred signature (System.CodeDom.CodeTryCatchFinallyStatement): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateTryCatchFinallyStatement"
		end

	output_expression_list (expressions: SYSTEM_DLL_CODE_EXPRESSION_COLLECTION) is
		external
			"IL signature (System.CodeDom.CodeExpressionCollection): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"OutputExpressionList"
		end

	generate_this_reference_expression (e: SYSTEM_DLL_CODE_THIS_REFERENCE_EXPRESSION) is
		external
			"IL deferred signature (System.CodeDom.CodeThisReferenceExpression): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateThisReferenceExpression"
		end

	generate_assign_statement (e: SYSTEM_DLL_CODE_ASSIGN_STATEMENT) is
		external
			"IL deferred signature (System.CodeDom.CodeAssignStatement): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateAssignStatement"
		end

	generate_field (e: SYSTEM_DLL_CODE_MEMBER_FIELD) is
		external
			"IL deferred signature (System.CodeDom.CodeMemberField): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateField"
		end

	generate_snippet_compile_unit (e: SYSTEM_DLL_CODE_SNIPPET_COMPILE_UNIT) is
		external
			"IL signature (System.CodeDom.CodeSnippetCompileUnit): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateSnippetCompileUnit"
		end

	frozen generate_namespaces (e: SYSTEM_DLL_CODE_COMPILE_UNIT) is
		external
			"IL signature (System.CodeDom.CodeCompileUnit): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateNamespaces"
		end

	frozen get_output: TEXT_WRITER is
		external
			"IL signature (): System.IO.TextWriter use System.CodeDom.Compiler.CodeGenerator"
		alias
			"get_Output"
		end

	generate_delegate_invoke_expression (e: SYSTEM_DLL_CODE_DELEGATE_INVOKE_EXPRESSION) is
		external
			"IL deferred signature (System.CodeDom.CodeDelegateInvokeExpression): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateDelegateInvokeExpression"
		end

	generate_namespace_import (e: SYSTEM_DLL_CODE_NAMESPACE_IMPORT) is
		external
			"IL deferred signature (System.CodeDom.CodeNamespaceImport): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateNamespaceImport"
		end

	frozen system_code_dom_compiler_icode_generator_generate_code_from_expression (e: SYSTEM_DLL_CODE_EXPRESSION; w: TEXT_WRITER; o: SYSTEM_DLL_CODE_GENERATOR_OPTIONS) is
		external
			"IL signature (System.CodeDom.CodeExpression, System.IO.TextWriter, System.CodeDom.Compiler.CodeGeneratorOptions): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"System.CodeDom.Compiler.ICodeGenerator.GenerateCodeFromExpression"
		end

	generate_array_create_expression (e: SYSTEM_DLL_CODE_ARRAY_CREATE_EXPRESSION) is
		external
			"IL deferred signature (System.CodeDom.CodeArrayCreateExpression): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateArrayCreateExpression"
		end

	generate_snippet_statement (e: SYSTEM_DLL_CODE_SNIPPET_STATEMENT) is
		external
			"IL signature (System.CodeDom.CodeSnippetStatement): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateSnippetStatement"
		end

	generate_method (e: SYSTEM_DLL_CODE_MEMBER_METHOD; c: SYSTEM_DLL_CODE_TYPE_DECLARATION) is
		external
			"IL deferred signature (System.CodeDom.CodeMemberMethod, System.CodeDom.CodeTypeDeclaration): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateMethod"
		end

	frozen system_code_dom_compiler_icode_generator_generate_code_from_type (e: SYSTEM_DLL_CODE_TYPE_DECLARATION; w: TEXT_WRITER; o: SYSTEM_DLL_CODE_GENERATOR_OPTIONS) is
		external
			"IL signature (System.CodeDom.CodeTypeDeclaration, System.IO.TextWriter, System.CodeDom.Compiler.CodeGeneratorOptions): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"System.CodeDom.Compiler.ICodeGenerator.GenerateCodeFromType"
		end

	frozen get_is_current_interface: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.CodeDom.Compiler.CodeGenerator"
		alias
			"get_IsCurrentInterface"
		end

	generate_line_pragma_start (e: SYSTEM_DLL_CODE_LINE_PRAGMA) is
		external
			"IL deferred signature (System.CodeDom.CodeLinePragma): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateLinePragmaStart"
		end

	frozen get_is_current_struct: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.CodeDom.Compiler.CodeGenerator"
		alias
			"get_IsCurrentStruct"
		end

	output_type (type_ref: SYSTEM_DLL_CODE_TYPE_REFERENCE) is
		external
			"IL deferred signature (System.CodeDom.CodeTypeReference): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"OutputType"
		end

	output_field_scope_modifier (attributes: SYSTEM_DLL_MEMBER_ATTRIBUTES) is
		external
			"IL signature (System.CodeDom.MemberAttributes): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"OutputFieldScopeModifier"
		end

	generate_primitive_expression (e: SYSTEM_DLL_CODE_PRIMITIVE_EXPRESSION) is
		external
			"IL signature (System.CodeDom.CodePrimitiveExpression): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GeneratePrimitiveExpression"
		end

	quote_snippet_string (value: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL deferred signature (System.String): System.String use System.CodeDom.Compiler.CodeGenerator"
		alias
			"QuoteSnippetString"
		end

	output_type_name_pair (type_ref: SYSTEM_DLL_CODE_TYPE_REFERENCE; name: SYSTEM_STRING) is
		external
			"IL signature (System.CodeDom.CodeTypeReference, System.String): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"OutputTypeNamePair"
		end

	output_expression_list_code_expression_collection_boolean (expressions: SYSTEM_DLL_CODE_EXPRESSION_COLLECTION; newline_between_items: BOOLEAN) is
		external
			"IL signature (System.CodeDom.CodeExpressionCollection, System.Boolean): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"OutputExpressionList"
		end

	generate_event (e: SYSTEM_DLL_CODE_MEMBER_EVENT; c: SYSTEM_DLL_CODE_TYPE_DECLARATION) is
		external
			"IL deferred signature (System.CodeDom.CodeMemberEvent, System.CodeDom.CodeTypeDeclaration): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateEvent"
		end

	generate_type_reference_expression (e: SYSTEM_DLL_CODE_TYPE_REFERENCE_EXPRESSION) is
		external
			"IL signature (System.CodeDom.CodeTypeReferenceExpression): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateTypeReferenceExpression"
		end

	generate_comment_statement (e: SYSTEM_DLL_CODE_COMMENT_STATEMENT) is
		external
			"IL signature (System.CodeDom.CodeCommentStatement): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateCommentStatement"
		end

	generate_attribute_declarations_end (attributes: SYSTEM_DLL_CODE_ATTRIBUTE_DECLARATION_COLLECTION) is
		external
			"IL deferred signature (System.CodeDom.CodeAttributeDeclarationCollection): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateAttributeDeclarationsEnd"
		end

	generate_throw_exception_statement (e: SYSTEM_DLL_CODE_THROW_EXCEPTION_STATEMENT) is
		external
			"IL deferred signature (System.CodeDom.CodeThrowExceptionStatement): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateThrowExceptionStatement"
		end

	generate_method_return_statement (e: SYSTEM_DLL_CODE_METHOD_RETURN_STATEMENT) is
		external
			"IL deferred signature (System.CodeDom.CodeMethodReturnStatement): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateMethodReturnStatement"
		end

	generate_object_create_expression (e: SYSTEM_DLL_CODE_OBJECT_CREATE_EXPRESSION) is
		external
			"IL deferred signature (System.CodeDom.CodeObjectCreateExpression): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateObjectCreateExpression"
		end

	get_type_output (value: SYSTEM_DLL_CODE_TYPE_REFERENCE): SYSTEM_STRING is
		external
			"IL deferred signature (System.CodeDom.CodeTypeReference): System.String use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GetTypeOutput"
		end

	generate_binary_operator_expression (e: SYSTEM_DLL_CODE_BINARY_OPERATOR_EXPRESSION) is
		external
			"IL signature (System.CodeDom.CodeBinaryOperatorExpression): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateBinaryOperatorExpression"
		end

	generate_snippet_expression (e: SYSTEM_DLL_CODE_SNIPPET_EXPRESSION) is
		external
			"IL deferred signature (System.CodeDom.CodeSnippetExpression): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateSnippetExpression"
		end

	frozen generate_statement (e: SYSTEM_DLL_CODE_STATEMENT) is
		external
			"IL signature (System.CodeDom.CodeStatement): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateStatement"
		end

end -- class SYSTEM_DLL_CODE_GENERATOR
