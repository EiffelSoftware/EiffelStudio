indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.CodeDom.Compiler.CodeGenerator"

deferred external class
	SYSTEM_CODEDOM_COMPILER_CODEGENERATOR

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_CODEDOM_COMPILER_ICODEGENERATOR
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

	to_string: STRING is
		external
			"IL signature (): System.String use System.CodeDom.Compiler.CodeGenerator"
		alias
			"ToString"
		end

	frozen is_valid_language_independent_identifier (value: STRING): BOOLEAN is
		external
			"IL static signature (System.String): System.Boolean use System.CodeDom.Compiler.CodeGenerator"
		alias
			"IsValidLanguageIndependentIdentifier"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.CodeDom.Compiler.CodeGenerator"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	generate_field_reference_expression (e: SYSTEM_CODEDOM_CODEFIELDREFERENCEEXPRESSION) is
		external
			"IL deferred signature (System.CodeDom.CodeFieldReferenceExpression): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateFieldReferenceExpression"
		end

	output_member_access_modifier (attributes: SYSTEM_CODEDOM_MEMBERATTRIBUTES) is
		external
			"IL signature (System.CodeDom.MemberAttributes): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"OutputMemberAccessModifier"
		end

	frozen system_code_dom_compiler_icode_generator_supports (support: SYSTEM_CODEDOM_COMPILER_GENERATORSUPPORT): BOOLEAN is
		external
			"IL signature (System.CodeDom.Compiler.GeneratorSupport): System.Boolean use System.CodeDom.Compiler.CodeGenerator"
		alias
			"System.CodeDom.Compiler.ICodeGenerator.Supports"
		end

	output_type_attributes (attributes: SYSTEM_REFLECTION_TYPEATTRIBUTES; is_struct: BOOLEAN; is_enum: BOOLEAN) is
		external
			"IL signature (System.Reflection.TypeAttributes, System.Boolean, System.Boolean): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"OutputTypeAttributes"
		end

	generate_comment (e: SYSTEM_CODEDOM_CODECOMMENT) is
		external
			"IL deferred signature (System.CodeDom.CodeComment): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateComment"
		end

	output_attribute_declarations (attributes: SYSTEM_CODEDOM_CODEATTRIBUTEDECLARATIONCOLLECTION) is
		external
			"IL signature (System.CodeDom.CodeAttributeDeclarationCollection): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"OutputAttributeDeclarations"
		end

	generate_attach_event_statement (e: SYSTEM_CODEDOM_CODEATTACHEVENTSTATEMENT) is
		external
			"IL deferred signature (System.CodeDom.CodeAttachEventStatement): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateAttachEventStatement"
		end

	generate_method_invoke_expression (e: SYSTEM_CODEDOM_CODEMETHODINVOKEEXPRESSION) is
		external
			"IL deferred signature (System.CodeDom.CodeMethodInvokeExpression): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateMethodInvokeExpression"
		end

	is_valid_identifier (value: STRING): BOOLEAN is
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

	output_identifier (ident: STRING) is
		external
			"IL signature (System.String): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"OutputIdentifier"
		end

	generate_property_set_value_reference_expression (e: SYSTEM_CODEDOM_CODEPROPERTYSETVALUEREFERENCEEXPRESSION) is
		external
			"IL deferred signature (System.CodeDom.CodePropertySetValueReferenceExpression): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GeneratePropertySetValueReferenceExpression"
		end

	frozen generate_namespace_imports (e: SYSTEM_CODEDOM_CODENAMESPACE) is
		external
			"IL signature (System.CodeDom.CodeNamespace): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateNamespaceImports"
		end

	generate_namespace_end (e: SYSTEM_CODEDOM_CODENAMESPACE) is
		external
			"IL deferred signature (System.CodeDom.CodeNamespace): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateNamespaceEnd"
		end

	frozen system_code_dom_compiler_icode_generator_create_escaped_identifier (value: STRING): STRING is
		external
			"IL signature (System.String): System.String use System.CodeDom.Compiler.CodeGenerator"
		alias
			"System.CodeDom.Compiler.ICodeGenerator.CreateEscapedIdentifier"
		end

	validate_identifier (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"ValidateIdentifier"
		end

	frozen system_code_dom_compiler_icode_generator_get_type_output (type: SYSTEM_CODEDOM_CODETYPEREFERENCE): STRING is
		external
			"IL signature (System.CodeDom.CodeTypeReference): System.String use System.CodeDom.Compiler.CodeGenerator"
		alias
			"System.CodeDom.Compiler.ICodeGenerator.GetTypeOutput"
		end

	generate_type_of_expression (e: SYSTEM_CODEDOM_CODETYPEOFEXPRESSION) is
		external
			"IL signature (System.CodeDom.CodeTypeOfExpression): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateTypeOfExpression"
		end

	frozen get_options: SYSTEM_CODEDOM_COMPILER_CODEGENERATOROPTIONS is
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

	frozen get_current_member_name: STRING is
		external
			"IL signature (): System.String use System.CodeDom.Compiler.CodeGenerator"
		alias
			"get_CurrentMemberName"
		end

	frozen get_current_type_name: STRING is
		external
			"IL signature (): System.String use System.CodeDom.Compiler.CodeGenerator"
		alias
			"get_CurrentTypeName"
		end

	generate_condition_statement (e: SYSTEM_CODEDOM_CODECONDITIONSTATEMENT) is
		external
			"IL deferred signature (System.CodeDom.CodeConditionStatement): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateConditionStatement"
		end

	generate_cast_expression (e: SYSTEM_CODEDOM_CODECASTEXPRESSION) is
		external
			"IL deferred signature (System.CodeDom.CodeCastExpression): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateCastExpression"
		end

	frozen system_code_dom_compiler_icode_generator_is_valid_identifier (value: STRING): BOOLEAN is
		external
			"IL signature (System.String): System.Boolean use System.CodeDom.Compiler.CodeGenerator"
		alias
			"System.CodeDom.Compiler.ICodeGenerator.IsValidIdentifier"
		end

	generate_iteration_statement (e: SYSTEM_CODEDOM_CODEITERATIONSTATEMENT) is
		external
			"IL deferred signature (System.CodeDom.CodeIterationStatement): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateIterationStatement"
		end

	generate_expression_statement (e: SYSTEM_CODEDOM_CODEEXPRESSIONSTATEMENT) is
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

	generate_variable_declaration_statement (e: SYSTEM_CODEDOM_CODEVARIABLEDECLARATIONSTATEMENT) is
		external
			"IL deferred signature (System.CodeDom.CodeVariableDeclarationStatement): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateVariableDeclarationStatement"
		end

	generate_delegate_create_expression (e: SYSTEM_CODEDOM_CODEDELEGATECREATEEXPRESSION) is
		external
			"IL deferred signature (System.CodeDom.CodeDelegateCreateExpression): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateDelegateCreateExpression"
		end

	output_attribute_argument (arg: SYSTEM_CODEDOM_CODEATTRIBUTEARGUMENT) is
		external
			"IL signature (System.CodeDom.CodeAttributeArgument): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"OutputAttributeArgument"
		end

	frozen generate_types (e: SYSTEM_CODEDOM_CODENAMESPACE) is
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

	generate_goto_statement (e: SYSTEM_CODEDOM_CODEGOTOSTATEMENT) is
		external
			"IL deferred signature (System.CodeDom.CodeGotoStatement): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateGotoStatement"
		end

	output_direction (dir: SYSTEM_CODEDOM_FIELDDIRECTION) is
		external
			"IL signature (System.CodeDom.FieldDirection): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"OutputDirection"
		end

	generate_constructor (e: SYSTEM_CODEDOM_CODECONSTRUCTOR; c: SYSTEM_CODEDOM_CODETYPEDECLARATION) is
		external
			"IL deferred signature (System.CodeDom.CodeConstructor, System.CodeDom.CodeTypeDeclaration): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateConstructor"
		end

	generate_namespace (e: SYSTEM_CODEDOM_CODENAMESPACE) is
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

	generate_compile_unit_start (e: SYSTEM_CODEDOM_CODECOMPILEUNIT) is
		external
			"IL signature (System.CodeDom.CodeCompileUnit): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateCompileUnitStart"
		end

	generate_remove_event_statement (e: SYSTEM_CODEDOM_CODEREMOVEEVENTSTATEMENT) is
		external
			"IL deferred signature (System.CodeDom.CodeRemoveEventStatement): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateRemoveEventStatement"
		end

	frozen system_code_dom_compiler_icode_generator_validate_identifier (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"System.CodeDom.Compiler.ICodeGenerator.ValidateIdentifier"
		end

	generate_method_reference_expression (e: SYSTEM_CODEDOM_CODEMETHODREFERENCEEXPRESSION) is
		external
			"IL deferred signature (System.CodeDom.CodeMethodReferenceExpression): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateMethodReferenceExpression"
		end

	generate_array_indexer_expression (e: SYSTEM_CODEDOM_CODEARRAYINDEXEREXPRESSION) is
		external
			"IL deferred signature (System.CodeDom.CodeArrayIndexerExpression): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateArrayIndexerExpression"
		end

	generate_indexer_expression (e: SYSTEM_CODEDOM_CODEINDEXEREXPRESSION) is
		external
			"IL deferred signature (System.CodeDom.CodeIndexerExpression): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateIndexerExpression"
		end

	generate_entry_point_method (e: SYSTEM_CODEDOM_CODEENTRYPOINTMETHOD; c: SYSTEM_CODEDOM_CODETYPEDECLARATION) is
		external
			"IL deferred signature (System.CodeDom.CodeEntryPointMethod, System.CodeDom.CodeTypeDeclaration): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateEntryPointMethod"
		end

	create_escaped_identifier (value: STRING): STRING is
		external
			"IL deferred signature (System.String): System.String use System.CodeDom.Compiler.CodeGenerator"
		alias
			"CreateEscapedIdentifier"
		end

	generate_compile_unit_end (e: SYSTEM_CODEDOM_CODECOMPILEUNIT) is
		external
			"IL signature (System.CodeDom.CodeCompileUnit): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateCompileUnitEnd"
		end

	generate_variable_reference_expression (e: SYSTEM_CODEDOM_CODEVARIABLEREFERENCEEXPRESSION) is
		external
			"IL deferred signature (System.CodeDom.CodeVariableReferenceExpression): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateVariableReferenceExpression"
		end

	generate_labeled_statement (e: SYSTEM_CODEDOM_CODELABELEDSTATEMENT) is
		external
			"IL deferred signature (System.CodeDom.CodeLabeledStatement): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateLabeledStatement"
		end

	generate_attribute_declarations_start (attributes: SYSTEM_CODEDOM_CODEATTRIBUTEDECLARATIONCOLLECTION) is
		external
			"IL deferred signature (System.CodeDom.CodeAttributeDeclarationCollection): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateAttributeDeclarationsStart"
		end

	generate_decimal_value (d: SYSTEM_DECIMAL) is
		external
			"IL signature (System.Decimal): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateDecimalValue"
		end

	output_member_scope_modifier (attributes: SYSTEM_CODEDOM_MEMBERATTRIBUTES) is
		external
			"IL signature (System.CodeDom.MemberAttributes): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"OutputMemberScopeModifier"
		end

	generate_namespace_start (e: SYSTEM_CODEDOM_CODENAMESPACE) is
		external
			"IL deferred signature (System.CodeDom.CodeNamespace): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateNamespaceStart"
		end

	generate_base_reference_expression (e: SYSTEM_CODEDOM_CODEBASEREFERENCEEXPRESSION) is
		external
			"IL deferred signature (System.CodeDom.CodeBaseReferenceExpression): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateBaseReferenceExpression"
		end

	generate_direction_expression (e: SYSTEM_CODEDOM_CODEDIRECTIONEXPRESSION) is
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

	frozen get_current_member: SYSTEM_CODEDOM_CODETYPEMEMBER is
		external
			"IL signature (): System.CodeDom.CodeTypeMember use System.CodeDom.Compiler.CodeGenerator"
		alias
			"get_CurrentMember"
		end

	generate_type_start (e: SYSTEM_CODEDOM_CODETYPEDECLARATION) is
		external
			"IL deferred signature (System.CodeDom.CodeTypeDeclaration): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateTypeStart"
		end

	generate_snippet_member (e: SYSTEM_CODEDOM_CODESNIPPETTYPEMEMBER) is
		external
			"IL deferred signature (System.CodeDom.CodeSnippetTypeMember): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateSnippetMember"
		end

	frozen system_code_dom_compiler_icode_generator_generate_code_from_compile_unit (e: SYSTEM_CODEDOM_CODECOMPILEUNIT; w: SYSTEM_IO_TEXTWRITER; o: SYSTEM_CODEDOM_COMPILER_CODEGENERATOROPTIONS) is
		external
			"IL signature (System.CodeDom.CodeCompileUnit, System.IO.TextWriter, System.CodeDom.Compiler.CodeGeneratorOptions): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"System.CodeDom.Compiler.ICodeGenerator.GenerateCodeFromCompileUnit"
		end

	generate_property (e: SYSTEM_CODEDOM_CODEMEMBERPROPERTY; c: SYSTEM_CODEDOM_CODETYPEDECLARATION) is
		external
			"IL deferred signature (System.CodeDom.CodeMemberProperty, System.CodeDom.CodeTypeDeclaration): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateProperty"
		end

	create_valid_identifier (value: STRING): STRING is
		external
			"IL deferred signature (System.String): System.String use System.CodeDom.Compiler.CodeGenerator"
		alias
			"CreateValidIdentifier"
		end

	output_parameters (parameters: SYSTEM_CODEDOM_CODEPARAMETERDECLARATIONEXPRESSIONCOLLECTION) is
		external
			"IL signature (System.CodeDom.CodeParameterDeclarationExpressionCollection): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"OutputParameters"
		end

	generate_argument_reference_expression (e: SYSTEM_CODEDOM_CODEARGUMENTREFERENCEEXPRESSION) is
		external
			"IL deferred signature (System.CodeDom.CodeArgumentReferenceExpression): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateArgumentReferenceExpression"
		end

	frozen system_code_dom_compiler_icode_generator_create_valid_identifier (value: STRING): STRING is
		external
			"IL signature (System.String): System.String use System.CodeDom.Compiler.CodeGenerator"
		alias
			"System.CodeDom.Compiler.ICodeGenerator.CreateValidIdentifier"
		end

	generate_property_reference_expression (e: SYSTEM_CODEDOM_CODEPROPERTYREFERENCEEXPRESSION) is
		external
			"IL deferred signature (System.CodeDom.CodePropertyReferenceExpression): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GeneratePropertyReferenceExpression"
		end

	generate_line_pragma_end (e: SYSTEM_CODEDOM_CODELINEPRAGMA) is
		external
			"IL deferred signature (System.CodeDom.CodeLinePragma): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateLinePragmaEnd"
		end

	generate_event_reference_expression (e: SYSTEM_CODEDOM_CODEEVENTREFERENCEEXPRESSION) is
		external
			"IL deferred signature (System.CodeDom.CodeEventReferenceExpression): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateEventReferenceExpression"
		end

	generate_type_constructor (e: SYSTEM_CODEDOM_CODETYPECONSTRUCTOR) is
		external
			"IL deferred signature (System.CodeDom.CodeTypeConstructor): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateTypeConstructor"
		end

	output_operator (op: SYSTEM_CODEDOM_CODEBINARYOPERATORTYPE) is
		external
			"IL signature (System.CodeDom.CodeBinaryOperatorType): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"OutputOperator"
		end

	generate_comment_statements (e: SYSTEM_CODEDOM_CODECOMMENTSTATEMENTCOLLECTION) is
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

	frozen generate_expression (e: SYSTEM_CODEDOM_CODEEXPRESSION) is
		external
			"IL signature (System.CodeDom.CodeExpression): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateExpression"
		end

	generate_parameter_declaration_expression (e: SYSTEM_CODEDOM_CODEPARAMETERDECLARATIONEXPRESSION) is
		external
			"IL signature (System.CodeDom.CodeParameterDeclarationExpression): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateParameterDeclarationExpression"
		end

	frozen system_code_dom_compiler_icode_generator_generate_code_from_statement (e: SYSTEM_CODEDOM_CODESTATEMENT; w: SYSTEM_IO_TEXTWRITER; o: SYSTEM_CODEDOM_COMPILER_CODEGENERATOROPTIONS) is
		external
			"IL signature (System.CodeDom.CodeStatement, System.IO.TextWriter, System.CodeDom.Compiler.CodeGeneratorOptions): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"System.CodeDom.Compiler.ICodeGenerator.GenerateCodeFromStatement"
		end

	frozen system_code_dom_compiler_icode_generator_generate_code_from_namespace (e: SYSTEM_CODEDOM_CODENAMESPACE; w: SYSTEM_IO_TEXTWRITER; o: SYSTEM_CODEDOM_COMPILER_CODEGENERATOROPTIONS) is
		external
			"IL signature (System.CodeDom.CodeNamespace, System.IO.TextWriter, System.CodeDom.Compiler.CodeGeneratorOptions): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"System.CodeDom.Compiler.ICodeGenerator.GenerateCodeFromNamespace"
		end

	get_null_token: STRING is
		external
			"IL deferred signature (): System.String use System.CodeDom.Compiler.CodeGenerator"
		alias
			"get_NullToken"
		end

	continue_on_new_line (st: STRING) is
		external
			"IL signature (System.String): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"ContinueOnNewLine"
		end

	supports (support: SYSTEM_CODEDOM_COMPILER_GENERATORSUPPORT): BOOLEAN is
		external
			"IL deferred signature (System.CodeDom.Compiler.GeneratorSupport): System.Boolean use System.CodeDom.Compiler.CodeGenerator"
		alias
			"Supports"
		end

	frozen generate_statements (stms: SYSTEM_CODEDOM_CODESTATEMENTCOLLECTION) is
		external
			"IL signature (System.CodeDom.CodeStatementCollection): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateStatements"
		end

	generate_compile_unit (e: SYSTEM_CODEDOM_CODECOMPILEUNIT) is
		external
			"IL signature (System.CodeDom.CodeCompileUnit): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateCompileUnit"
		end

	generate_type_end (e: SYSTEM_CODEDOM_CODETYPEDECLARATION) is
		external
			"IL deferred signature (System.CodeDom.CodeTypeDeclaration): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateTypeEnd"
		end

	generate_try_catch_finally_statement (e: SYSTEM_CODEDOM_CODETRYCATCHFINALLYSTATEMENT) is
		external
			"IL deferred signature (System.CodeDom.CodeTryCatchFinallyStatement): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateTryCatchFinallyStatement"
		end

	output_expression_list (expressions: SYSTEM_CODEDOM_CODEEXPRESSIONCOLLECTION) is
		external
			"IL signature (System.CodeDom.CodeExpressionCollection): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"OutputExpressionList"
		end

	generate_this_reference_expression (e: SYSTEM_CODEDOM_CODETHISREFERENCEEXPRESSION) is
		external
			"IL deferred signature (System.CodeDom.CodeThisReferenceExpression): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateThisReferenceExpression"
		end

	generate_assign_statement (e: SYSTEM_CODEDOM_CODEASSIGNSTATEMENT) is
		external
			"IL deferred signature (System.CodeDom.CodeAssignStatement): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateAssignStatement"
		end

	generate_field (e: SYSTEM_CODEDOM_CODEMEMBERFIELD) is
		external
			"IL deferred signature (System.CodeDom.CodeMemberField): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateField"
		end

	generate_snippet_compile_unit (e: SYSTEM_CODEDOM_CODESNIPPETCOMPILEUNIT) is
		external
			"IL signature (System.CodeDom.CodeSnippetCompileUnit): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateSnippetCompileUnit"
		end

	frozen generate_namespaces (e: SYSTEM_CODEDOM_CODECOMPILEUNIT) is
		external
			"IL signature (System.CodeDom.CodeCompileUnit): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateNamespaces"
		end

	frozen get_output: SYSTEM_IO_TEXTWRITER is
		external
			"IL signature (): System.IO.TextWriter use System.CodeDom.Compiler.CodeGenerator"
		alias
			"get_Output"
		end

	generate_delegate_invoke_expression (e: SYSTEM_CODEDOM_CODEDELEGATEINVOKEEXPRESSION) is
		external
			"IL deferred signature (System.CodeDom.CodeDelegateInvokeExpression): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateDelegateInvokeExpression"
		end

	generate_namespace_import (e: SYSTEM_CODEDOM_CODENAMESPACEIMPORT) is
		external
			"IL deferred signature (System.CodeDom.CodeNamespaceImport): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateNamespaceImport"
		end

	frozen system_code_dom_compiler_icode_generator_generate_code_from_expression (e: SYSTEM_CODEDOM_CODEEXPRESSION; w: SYSTEM_IO_TEXTWRITER; o: SYSTEM_CODEDOM_COMPILER_CODEGENERATOROPTIONS) is
		external
			"IL signature (System.CodeDom.CodeExpression, System.IO.TextWriter, System.CodeDom.Compiler.CodeGeneratorOptions): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"System.CodeDom.Compiler.ICodeGenerator.GenerateCodeFromExpression"
		end

	generate_array_create_expression (e: SYSTEM_CODEDOM_CODEARRAYCREATEEXPRESSION) is
		external
			"IL deferred signature (System.CodeDom.CodeArrayCreateExpression): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateArrayCreateExpression"
		end

	generate_snippet_statement (e: SYSTEM_CODEDOM_CODESNIPPETSTATEMENT) is
		external
			"IL signature (System.CodeDom.CodeSnippetStatement): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateSnippetStatement"
		end

	generate_method (e: SYSTEM_CODEDOM_CODEMEMBERMETHOD; c: SYSTEM_CODEDOM_CODETYPEDECLARATION) is
		external
			"IL deferred signature (System.CodeDom.CodeMemberMethod, System.CodeDom.CodeTypeDeclaration): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateMethod"
		end

	frozen system_code_dom_compiler_icode_generator_generate_code_from_type (e: SYSTEM_CODEDOM_CODETYPEDECLARATION; w: SYSTEM_IO_TEXTWRITER; o: SYSTEM_CODEDOM_COMPILER_CODEGENERATOROPTIONS) is
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

	generate_line_pragma_start (e: SYSTEM_CODEDOM_CODELINEPRAGMA) is
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

	output_type (type_ref: SYSTEM_CODEDOM_CODETYPEREFERENCE) is
		external
			"IL deferred signature (System.CodeDom.CodeTypeReference): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"OutputType"
		end

	output_field_scope_modifier (attributes: SYSTEM_CODEDOM_MEMBERATTRIBUTES) is
		external
			"IL signature (System.CodeDom.MemberAttributes): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"OutputFieldScopeModifier"
		end

	generate_primitive_expression (e: SYSTEM_CODEDOM_CODEPRIMITIVEEXPRESSION) is
		external
			"IL signature (System.CodeDom.CodePrimitiveExpression): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GeneratePrimitiveExpression"
		end

	quote_snippet_string (value: STRING): STRING is
		external
			"IL deferred signature (System.String): System.String use System.CodeDom.Compiler.CodeGenerator"
		alias
			"QuoteSnippetString"
		end

	output_type_name_pair (type_ref: SYSTEM_CODEDOM_CODETYPEREFERENCE; name: STRING) is
		external
			"IL signature (System.CodeDom.CodeTypeReference, System.String): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"OutputTypeNamePair"
		end

	output_expression_list_code_expression_collection_boolean (expressions: SYSTEM_CODEDOM_CODEEXPRESSIONCOLLECTION; newline_between_items: BOOLEAN) is
		external
			"IL signature (System.CodeDom.CodeExpressionCollection, System.Boolean): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"OutputExpressionList"
		end

	generate_event (e: SYSTEM_CODEDOM_CODEMEMBEREVENT; c: SYSTEM_CODEDOM_CODETYPEDECLARATION) is
		external
			"IL deferred signature (System.CodeDom.CodeMemberEvent, System.CodeDom.CodeTypeDeclaration): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateEvent"
		end

	generate_type_reference_expression (e: SYSTEM_CODEDOM_CODETYPEREFERENCEEXPRESSION) is
		external
			"IL signature (System.CodeDom.CodeTypeReferenceExpression): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateTypeReferenceExpression"
		end

	generate_comment_statement (e: SYSTEM_CODEDOM_CODECOMMENTSTATEMENT) is
		external
			"IL signature (System.CodeDom.CodeCommentStatement): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateCommentStatement"
		end

	generate_attribute_declarations_end (attributes: SYSTEM_CODEDOM_CODEATTRIBUTEDECLARATIONCOLLECTION) is
		external
			"IL deferred signature (System.CodeDom.CodeAttributeDeclarationCollection): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateAttributeDeclarationsEnd"
		end

	generate_throw_exception_statement (e: SYSTEM_CODEDOM_CODETHROWEXCEPTIONSTATEMENT) is
		external
			"IL deferred signature (System.CodeDom.CodeThrowExceptionStatement): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateThrowExceptionStatement"
		end

	generate_method_return_statement (e: SYSTEM_CODEDOM_CODEMETHODRETURNSTATEMENT) is
		external
			"IL deferred signature (System.CodeDom.CodeMethodReturnStatement): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateMethodReturnStatement"
		end

	generate_object_create_expression (e: SYSTEM_CODEDOM_CODEOBJECTCREATEEXPRESSION) is
		external
			"IL deferred signature (System.CodeDom.CodeObjectCreateExpression): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateObjectCreateExpression"
		end

	get_type_output (value: SYSTEM_CODEDOM_CODETYPEREFERENCE): STRING is
		external
			"IL deferred signature (System.CodeDom.CodeTypeReference): System.String use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GetTypeOutput"
		end

	generate_binary_operator_expression (e: SYSTEM_CODEDOM_CODEBINARYOPERATOREXPRESSION) is
		external
			"IL signature (System.CodeDom.CodeBinaryOperatorExpression): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateBinaryOperatorExpression"
		end

	generate_snippet_expression (e: SYSTEM_CODEDOM_CODESNIPPETEXPRESSION) is
		external
			"IL deferred signature (System.CodeDom.CodeSnippetExpression): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateSnippetExpression"
		end

	frozen generate_statement (e: SYSTEM_CODEDOM_CODESTATEMENT) is
		external
			"IL signature (System.CodeDom.CodeStatement): System.Void use System.CodeDom.Compiler.CodeGenerator"
		alias
			"GenerateStatement"
		end

end -- class SYSTEM_CODEDOM_COMPILER_CODEGENERATOR
