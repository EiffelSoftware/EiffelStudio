indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "ISE.Reflection.ExportClause"

external class
	ISE_REFLECTION_EXPORTCLAUSE

inherit
	ISE_REFLECTION_INHERITANCECLAUSE

create
	make_exportclause

feature {NONE} -- Initialization

	frozen make_exportclause is
		external
			"IL creator use ISE.Reflection.ExportClause"
		end

feature -- Access

	frozen a_internal_exportation_list: SYSTEM_COLLECTIONS_ARRAYLIST is
		external
			"IL field signature :System.Collections.ArrayList use ISE.Reflection.ExportClause"
		alias
			"_internal_ExportationList"
		end

	get_all_features_exported: BOOLEAN is
		external
			"IL signature (): System.Boolean use ISE.Reflection.ExportClause"
		alias
			"get_AllFeaturesExported"
		end

	get_exportation_list: SYSTEM_COLLECTIONS_ARRAYLIST is
		external
			"IL signature (): System.Collections.ArrayList use ISE.Reflection.ExportClause"
		alias
			"get_ExportationList"
		end

	frozen a_internal_feature_names: SYSTEM_COLLECTIONS_ARRAYLIST is
		external
			"IL field signature :System.Collections.ArrayList use ISE.Reflection.ExportClause"
		alias
			"_internal_FeatureNames"
		end

	frozen a_internal_all_features_exported: BOOLEAN is
		external
			"IL field signature :System.Boolean use ISE.Reflection.ExportClause"
		alias
			"_internal_AllFeaturesExported"
		end

	get_feature_names: SYSTEM_COLLECTIONS_ARRAYLIST is
		external
			"IL signature (): System.Collections.ArrayList use ISE.Reflection.ExportClause"
		alias
			"get_FeatureNames"
		end

feature -- Basic Operations

	eiffel_keyword: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.ExportClause"
		alias
			"EiffelKeyword"
		end

	opening_curl_bracket: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.ExportClause"
		alias
			"OpeningCurlBracket"
		end

	set_exportation_list (a_list: SYSTEM_COLLECTIONS_ARRAYLIST) is
		external
			"IL signature (System.Collections.ArrayList): System.Void use ISE.Reflection.ExportClause"
		alias
			"SetExportationList"
		end

	frozen a_invariant_export_clause (current_object: ISE_REFLECTION_EXPORTCLAUSE) is
		external
			"IL static signature (ISE.Reflection.ExportClause): System.Void use ISE.Reflection.ExportClause"
		alias
			"_invariant"
		end

	empty_string: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.ExportClause"
		alias
			"EmptyString"
		end

	make_void is
		external
			"IL signature (): System.Void use ISE.Reflection.ExportClause"
		alias
			"Make"
		end

	all_keyword: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.ExportClause"
		alias
			"AllKeyword"
		end

	set_all is
		external
			"IL signature (): System.Void use ISE.Reflection.ExportClause"
		alias
			"SetAll"
		end

	closing_curl_bracket: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.ExportClause"
		alias
			"ClosingCurlBracket"
		end

	add_feature_name (a_feature_name: STRING) is
		external
			"IL signature (System.String): System.Void use ISE.Reflection.ExportClause"
		alias
			"AddFeatureName"
		end

	add_exportation (a_class_name: STRING) is
		external
			"IL signature (System.String): System.Void use ISE.Reflection.ExportClause"
		alias
			"AddExportation"
		end

	string_representation: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.ExportClause"
		alias
			"StringRepresentation"
		end

	set_feature_names (a_list: SYSTEM_COLLECTIONS_ARRAYLIST) is
		external
			"IL signature (System.Collections.ArrayList): System.Void use ISE.Reflection.ExportClause"
		alias
			"SetFeatureNames"
		end

	export_keyword: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.ExportClause"
		alias
			"ExportKeyword"
		end

	intern_string_representation: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.ExportClause"
		alias
			"InternStringRepresentation"
		end

	equals_export_clause (obj: ISE_REFLECTION_EXPORTCLAUSE): BOOLEAN is
		external
			"IL signature (ISE.Reflection.ExportClause): System.Boolean use ISE.Reflection.ExportClause"
		alias
			"Equals"
		end

	space: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.ExportClause"
		alias
			"Space"
		end

	comma: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.ExportClause"
		alias
			"Comma"
		end

end -- class ISE_REFLECTION_EXPORTCLAUSE
