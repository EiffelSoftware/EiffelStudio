indexing
	Generator: "Eiffel Emitter beta 2"
	external_name: "ISE.Reflection.EiffelCodeGenerator"

external class
	ISE_REFLECTION_EIFFELCODEGENERATOR

inherit
	ISE_REFLECTION_EIFFELCODEGENERATORDICTIONARY
	ISE_REFLECTION_CODEGENERATOR
		rename
			generatecode as a__generatecode
		end

create
	make_eiffelcodegenerator

feature {NONE} -- Initialization

	frozen make_eiffelcodegenerator is
		external
			"IL creator use ISE.Reflection.EiffelCodeGenerator"
		end

feature -- Access

	frozen generatedcode: STRING is
		external
			"IL field signature :System.String use ISE.Reflection.EiffelCodeGenerator"
		alias
			"GeneratedCode"
		end

	frozen eiffelassembly: ISE_REFLECTION_EIFFELASSEMBLY is
		external
			"IL field signature :ISE.Reflection.EiffelAssembly use ISE.Reflection.EiffelCodeGenerator"
		alias
			"EiffelAssembly"
		end

	frozen eiffelclass: ISE_REFLECTION_EIFFELCLASS is
		external
			"IL field signature :ISE.Reflection.EiffelClass use ISE.Reflection.EiffelCodeGenerator"
		alias
			"EiffelClass"
		end

	frozen specialclasses: ARRAY [STRING] is
		external
			"IL field signature :System.String[] use ISE.Reflection.EiffelCodeGenerator"
		alias
			"SpecialClasses"
		end

	frozen parents: SYSTEM_COLLECTIONS_HASHTABLE is
		external
			"IL field signature :System.Collections.Hashtable use ISE.Reflection.EiffelCodeGenerator"
		alias
			"Parents"
		end

feature -- Basic Operations

	generateexternalclause (a_feature: ISE_REFLECTION_EIFFELFEATURE) is
		external
			"IL signature (ISE.Reflection.EiffelFeature): System.Void use ISE.Reflection.EiffelCodeGenerator"
		alias
			"GenerateExternalClause"
		end

	hasanyrename: BOOLEAN is
		external
			"IL signature (): System.Boolean use ISE.Reflection.EiffelCodeGenerator"
		alias
			"HasAnyRename"
		end

	featuresignature (a_feature: ISE_REFLECTION_EIFFELFEATURE): STRING is
		external
			"IL signature (ISE.Reflection.EiffelFeature): System.String use ISE.Reflection.EiffelCodeGenerator"
		alias
			"FeatureSignature"
		end

	isspecialclass: BOOLEAN is
		external
			"IL signature (): System.Boolean use ISE.Reflection.EiffelCodeGenerator"
		alias
			"IsSpecialClass"
		end

	make is
		external
			"IL signature (): System.Void use ISE.Reflection.EiffelCodeGenerator"
		alias
			"Make"
		end

	generateinheritanceclauses (clauses: SYSTEM_COLLECTIONS_ARRAYLIST) is
		external
			"IL signature (System.Collections.ArrayList): System.Void use ISE.Reflection.EiffelCodeGenerator"
		alias
			"GenerateInheritanceClauses"
		end

	generateclassfeatures is
		external
			"IL signature (): System.Void use ISE.Reflection.EiffelCodeGenerator"
		alias
			"GenerateClassFeatures"
		end

	generatefeatureassertions (assertions: SYSTEM_COLLECTIONS_ARRAYLIST; keyword: STRING) is
		external
			"IL signature (System.Collections.ArrayList, System.String): System.Void use ISE.Reflection.EiffelCodeGenerator"
		alias
			"GenerateFeatureAssertions"
		end

	generateeiffelfeature (a_feature: ISE_REFLECTION_EIFFELFEATURE) is
		external
			"IL signature (ISE.Reflection.EiffelFeature): System.Void use ISE.Reflection.EiffelCodeGenerator"
		alias
			"GenerateEiffelFeature"
		end

	interngenerateclassfeatures (a_list: SYSTEM_COLLECTIONS_ARRAYLIST) is
		external
			"IL signature (System.Collections.ArrayList): System.Void use ISE.Reflection.EiffelCodeGenerator"
		alias
			"InternGenerateClassFeatures"
		end

	generateinheritclause is
		external
			"IL signature (): System.Void use ISE.Reflection.EiffelCodeGenerator"
		alias
			"GenerateInheritClause"
		end

	hasanyredefine: BOOLEAN is
		external
			"IL signature (): System.Boolean use ISE.Reflection.EiffelCodeGenerator"
		alias
			"HasAnyRedefine"
		end

	hasanyundefine: BOOLEAN is
		external
			"IL signature (): System.Boolean use ISE.Reflection.EiffelCodeGenerator"
		alias
			"HasAnyUndefine"
		end

	generatecreateclause is
		external
			"IL signature (): System.Void use ISE.Reflection.EiffelCodeGenerator"
		alias
			"GenerateCreateClause"
		end

	makefrominfo (an_eiffel_class: ISE_REFLECTION_EIFFELCLASS; an_eiffel_assembly: ISE_REFLECTION_EIFFELASSEMBLY) is
		external
			"IL signature (ISE.Reflection.EiffelClass, ISE.Reflection.EiffelAssembly): System.Void use ISE.Reflection.EiffelCodeGenerator"
		alias
			"MakeFromInfo"
		end

	generateeiffelclass is
		external
			"IL signature (): System.Void use ISE.Reflection.EiffelCodeGenerator"
		alias
			"GenerateEiffelClass"
		end

feature {NONE} -- Implementation

	frozen a__generatecode is
		external
			"IL signature (): System.Void use ISE.Reflection.EiffelCodeGenerator"
		alias
			"__GenerateCode"
		end

end -- class ISE_REFLECTION_EIFFELCODEGENERATOR
