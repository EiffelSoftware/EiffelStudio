indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.TypedDataSetGenerator"

external class
	SYSTEM_DATA_TYPEDDATASETGENERATOR

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Data.TypedDataSetGenerator"
		end

feature -- Basic Operations

	frozen generate_id_name (name: STRING; code_gen: SYSTEM_CODEDOM_COMPILER_ICODEGENERATOR): STRING is
		external
			"IL static signature (System.String, System.CodeDom.Compiler.ICodeGenerator): System.String use System.Data.TypedDataSetGenerator"
		alias
			"GenerateIdName"
		end

	frozen generate (data_set: SYSTEM_DATA_DATASET; code_namespace: SYSTEM_CODEDOM_CODENAMESPACE; code_gen: SYSTEM_CODEDOM_COMPILER_ICODEGENERATOR) is
		external
			"IL static signature (System.Data.DataSet, System.CodeDom.CodeNamespace, System.CodeDom.Compiler.ICodeGenerator): System.Void use System.Data.TypedDataSetGenerator"
		alias
			"Generate"
		end

end -- class SYSTEM_DATA_TYPEDDATASETGENERATOR
