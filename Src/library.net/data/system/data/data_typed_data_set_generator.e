indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Data.TypedDataSetGenerator"
	assembly: "System.Data", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	DATA_TYPED_DATA_SET_GENERATOR

inherit
	SYSTEM_OBJECT

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Data.TypedDataSetGenerator"
		end

feature -- Basic Operations

	frozen generate_id_name (name: SYSTEM_STRING; code_gen: SYSTEM_DLL_ICODE_GENERATOR): SYSTEM_STRING is
		external
			"IL static signature (System.String, System.CodeDom.Compiler.ICodeGenerator): System.String use System.Data.TypedDataSetGenerator"
		alias
			"GenerateIdName"
		end

	frozen generate (data_set: DATA_DATA_SET; code_namespace: SYSTEM_DLL_CODE_NAMESPACE; code_gen: SYSTEM_DLL_ICODE_GENERATOR) is
		external
			"IL static signature (System.Data.DataSet, System.CodeDom.CodeNamespace, System.CodeDom.Compiler.ICodeGenerator): System.Void use System.Data.TypedDataSetGenerator"
		alias
			"Generate"
		end

end -- class DATA_TYPED_DATA_SET_GENERATOR
