indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "Implementation.EXPORT_CLAUSE"

external class
	IMPLEMENTATION_EXPORT_CLAUSE

inherit
	EXPORT_CLAUSE
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	INHERITANCE_CLAUSE

create
	make1

feature {NONE} -- Initialization

	frozen make1 is
		external
			"IL creator use Implementation.EXPORT_CLAUSE"
		end

feature -- Access

	frozen ec_illegal_36_ec_illegal_36_all_features_exported: BOOLEAN is
		external
			"IL field signature :System.Boolean use Implementation.EXPORT_CLAUSE"
		alias
			"$$all_features_exported"
		end

	frozen ec_illegal_36_ec_illegal_36_source_name: STRING is
		external
			"IL field signature :STRING use Implementation.EXPORT_CLAUSE"
		alias
			"$$source_name"
		end

	frozen ec_illegal_36_ec_illegal_36_feature_names: LINKED_LIST_ANY is
		external
			"IL field signature :LINKED_LIST_ANY use Implementation.EXPORT_CLAUSE"
		alias
			"$$feature_names"
		end

	frozen ec_illegal_36_ec_illegal_36_exportation_list: LINKED_LIST_ANY is
		external
			"IL field signature :LINKED_LIST_ANY use Implementation.EXPORT_CLAUSE"
		alias
			"$$exportation_list"
		end

feature -- Basic Operations

	comma: STRING is
		external
			"IL signature (): STRING use Implementation.EXPORT_CLAUSE"
		alias
			"comma"
		end

	deep_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.EXPORT_CLAUSE"
		alias
			"deep_clone"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.EXPORT_CLAUSE"
		alias
			"GetHashCode"
		end

	frozen ec_illegal_36_ec_illegal_36_space (current_: EXPORT_CLAUSE): STRING is
		external
			"IL static signature (EXPORT_CLAUSE): STRING use Implementation.EXPORT_CLAUSE"
		alias
			"$$space"
		end

	tagged_out: STRING is
		external
			"IL signature (): STRING use Implementation.EXPORT_CLAUSE"
		alias
			"tagged_out"
		end

	internal_clone: ANY is
		external
			"IL signature (): ANY use Implementation.EXPORT_CLAUSE"
		alias
			"internal_clone"
		end

	operating_environment: OPERATING_ENVIRONMENT is
		external
			"IL signature (): OPERATING_ENVIRONMENT use Implementation.EXPORT_CLAUSE"
		alias
			"operating_environment"
		end

	frozen ec_illegal_36_ec_illegal_36_all_keyword (current_: EXPORT_CLAUSE): STRING is
		external
			"IL static signature (EXPORT_CLAUSE): STRING use Implementation.EXPORT_CLAUSE"
		alias
			"$$all_keyword"
		end

	standard_is_equal (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.EXPORT_CLAUSE"
		alias
			"standard_is_equal"
		end

	is_equal_ (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.EXPORT_CLAUSE"
		alias
			"is_equal"
		end

	opening_curl_bracket: STRING is
		external
			"IL signature (): STRING use Implementation.EXPORT_CLAUSE"
		alias
			"opening_curl_bracket"
		end

	frozen ec_illegal_36_ec_illegal_36_intern_string_representation (current_: EXPORT_CLAUSE): STRING is
		external
			"IL static signature (EXPORT_CLAUSE): STRING use Implementation.EXPORT_CLAUSE"
		alias
			"$$intern_string_representation"
		end

	closing_curl_bracket: STRING is
		external
			"IL signature (): STRING use Implementation.EXPORT_CLAUSE"
		alias
			"closing_curl_bracket"
		end

	standard_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.EXPORT_CLAUSE"
		alias
			"standard_equal"
		end

	same_type (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.EXPORT_CLAUSE"
		alias
			"same_type"
		end

	all_features_exported: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.EXPORT_CLAUSE"
		alias
			"all_features_exported"
		end

	generator: STRING is
		external
			"IL signature (): STRING use Implementation.EXPORT_CLAUSE"
		alias
			"generator"
		end

	a_set_all_features_exported (all_features_exported2: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Implementation.EXPORT_CLAUSE"
		alias
			"_set_all_features_exported"
		end

	internal_copy (o: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.EXPORT_CLAUSE"
		alias
			"internal_copy"
		end

	set_feature_names (a_list: LINKED_LIST_ANY) is
		external
			"IL signature (LINKED_LIST_ANY): System.Void use Implementation.EXPORT_CLAUSE"
		alias
			"set_feature_names"
		end

	space: STRING is
		external
			"IL signature (): STRING use Implementation.EXPORT_CLAUSE"
		alias
			"space"
		end

	a_set_exportation_list (exportation_list2: LINKED_LIST_ANY) is
		external
			"IL signature (LINKED_LIST_ANY): System.Void use Implementation.EXPORT_CLAUSE"
		alias
			"_set_exportation_list"
		end

	intern_string_representation: STRING is
		external
			"IL signature (): STRING use Implementation.EXPORT_CLAUSE"
		alias
			"intern_string_representation"
		end

	feature_names: LINKED_LIST_ANY is
		external
			"IL signature (): LINKED_LIST_ANY use Implementation.EXPORT_CLAUSE"
		alias
			"feature_names"
		end

	standard_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.EXPORT_CLAUSE"
		alias
			"standard_clone"
		end

	source_name: STRING is
		external
			"IL signature (): STRING use Implementation.EXPORT_CLAUSE"
		alias
			"source_name"
		end

	add_feature_name (a_feature_name: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.EXPORT_CLAUSE"
		alias
			"add_feature_name"
		end

	equal_ (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.EXPORT_CLAUSE"
		alias
			"equal"
		end

	set_source_name (a_source_name: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.EXPORT_CLAUSE"
		alias
			"set_source_name"
		end

	set_all is
		external
			"IL signature (): System.Void use Implementation.EXPORT_CLAUSE"
		alias
			"set_all"
		end

	a_set_source_name (source_name2: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.EXPORT_CLAUSE"
		alias
			"_set_source_name"
		end

	frozen ec_illegal_36_ec_illegal_36_add_feature_name (current_: EXPORT_CLAUSE; a_feature_name: STRING) is
		external
			"IL static signature (EXPORT_CLAUSE, STRING): System.Void use Implementation.EXPORT_CLAUSE"
		alias
			"$$add_feature_name"
		end

	frozen a____class_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.EXPORT_CLAUSE"
		alias
			"____class_name"
		end

	string_representation: STRING is
		external
			"IL signature (): STRING use Implementation.EXPORT_CLAUSE"
		alias
			"string_representation"
		end

	do_nothing is
		external
			"IL signature (): System.Void use Implementation.EXPORT_CLAUSE"
		alias
			"do_nothing"
		end

	out_: STRING is
		external
			"IL signature (): STRING use Implementation.EXPORT_CLAUSE"
		alias
			"out"
		end

	default_rescue is
		external
			"IL signature (): System.Void use Implementation.EXPORT_CLAUSE"
		alias
			"default_rescue"
		end

	frozen ec_illegal_36_ec_illegal_36_opening_curl_bracket (current_: EXPORT_CLAUSE): STRING is
		external
			"IL static signature (EXPORT_CLAUSE): STRING use Implementation.EXPORT_CLAUSE"
		alias
			"$$opening_curl_bracket"
		end

	default_pointer: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.EXPORT_CLAUSE"
		alias
			"default_pointer"
		end

	standard_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.EXPORT_CLAUSE"
		alias
			"standard_copy"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.EXPORT_CLAUSE"
		alias
			"ToString"
		end

	exportation_list: LINKED_LIST_ANY is
		external
			"IL signature (): LINKED_LIST_ANY use Implementation.EXPORT_CLAUSE"
		alias
			"exportation_list"
		end

	default_: ANY is
		external
			"IL signature (): ANY use Implementation.EXPORT_CLAUSE"
		alias
			"default"
		end

	frozen ec_illegal_36_ec_illegal_36_empty_string (current_: EXPORT_CLAUSE): STRING is
		external
			"IL static signature (EXPORT_CLAUSE): STRING use Implementation.EXPORT_CLAUSE"
		alias
			"$$empty_string"
		end

	deep_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.EXPORT_CLAUSE"
		alias
			"deep_equal"
		end

	frozen ec_illegal_36_ec_illegal_36_string_representation (current_: EXPORT_CLAUSE): STRING is
		external
			"IL static signature (EXPORT_CLAUSE): STRING use Implementation.EXPORT_CLAUSE"
		alias
			"$$string_representation"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use Implementation.EXPORT_CLAUSE"
		alias
			"Equals"
		end

	frozen ec_illegal_36_ec_illegal_36_closing_curl_bracket (current_: EXPORT_CLAUSE): STRING is
		external
			"IL static signature (EXPORT_CLAUSE): STRING use Implementation.EXPORT_CLAUSE"
		alias
			"$$closing_curl_bracket"
		end

	frozen ec_illegal_36_ec_illegal_36_export_keyword (current_: EXPORT_CLAUSE): STRING is
		external
			"IL static signature (EXPORT_CLAUSE): STRING use Implementation.EXPORT_CLAUSE"
		alias
			"$$export_keyword"
		end

	frozen ec_illegal_36_ec_illegal_36_is_equal (current_: EXPORT_CLAUSE; obj: EXPORT_CLAUSE): BOOLEAN is
		external
			"IL static signature (EXPORT_CLAUSE, EXPORT_CLAUSE): System.Boolean use Implementation.EXPORT_CLAUSE"
		alias
			"$$is_equal"
		end

	a_set_feature_names (feature_names2: LINKED_LIST_ANY) is
		external
			"IL signature (LINKED_LIST_ANY): System.Void use Implementation.EXPORT_CLAUSE"
		alias
			"_set_feature_names"
		end

	all_keyword: STRING is
		external
			"IL signature (): STRING use Implementation.EXPORT_CLAUSE"
		alias
			"all_keyword"
		end

	frozen ec_illegal_36_ec_illegal_36_set_exportation_list (current_: EXPORT_CLAUSE; a_list: LINKED_LIST_ANY) is
		external
			"IL static signature (EXPORT_CLAUSE, LINKED_LIST_ANY): System.Void use Implementation.EXPORT_CLAUSE"
		alias
			"$$set_exportation_list"
		end

	generating_type: STRING is
		external
			"IL signature (): STRING use Implementation.EXPORT_CLAUSE"
		alias
			"generating_type"
		end

	add_exportation (a_class_name: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.EXPORT_CLAUSE"
		alias
			"add_exportation"
		end

	frozen ec_illegal_36_ec_illegal_36_comma (current_: EXPORT_CLAUSE): STRING is
		external
			"IL static signature (EXPORT_CLAUSE): STRING use Implementation.EXPORT_CLAUSE"
		alias
			"$$comma"
		end

	set_exportation_list (a_list: LINKED_LIST_ANY) is
		external
			"IL signature (LINKED_LIST_ANY): System.Void use Implementation.EXPORT_CLAUSE"
		alias
			"set_exportation_list"
		end

	frozen ec_illegal_36_ec_illegal_36_add_exportation (current_: EXPORT_CLAUSE; a_class_name: STRING) is
		external
			"IL static signature (EXPORT_CLAUSE, STRING): System.Void use Implementation.EXPORT_CLAUSE"
		alias
			"$$add_exportation"
		end

	frozen ec_illegal_36_ec_illegal_36_set_all (current_: EXPORT_CLAUSE) is
		external
			"IL static signature (EXPORT_CLAUSE): System.Void use Implementation.EXPORT_CLAUSE"
		alias
			"$$set_all"
		end

	default_create_ is
		external
			"IL signature (): System.Void use Implementation.EXPORT_CLAUSE"
		alias
			"default_create"
		end

	io: STD_FILES is
		external
			"IL signature (): STD_FILES use Implementation.EXPORT_CLAUSE"
		alias
			"io"
		end

	clone_ (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.EXPORT_CLAUSE"
		alias
			"clone"
		end

	frozen ec_illegal_36_ec_illegal_36_set_feature_names (current_: EXPORT_CLAUSE; a_list: LINKED_LIST_ANY) is
		external
			"IL static signature (EXPORT_CLAUSE, LINKED_LIST_ANY): System.Void use Implementation.EXPORT_CLAUSE"
		alias
			"$$set_feature_names"
		end

	export_keyword: STRING is
		external
			"IL signature (): STRING use Implementation.EXPORT_CLAUSE"
		alias
			"export_keyword"
		end

	frozen ec_illegal_36_ec_illegal_36_eiffel_keyword (current_: EXPORT_CLAUSE): STRING is
		external
			"IL static signature (EXPORT_CLAUSE): STRING use Implementation.EXPORT_CLAUSE"
		alias
			"$$eiffel_keyword"
		end

	deep_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.EXPORT_CLAUSE"
		alias
			"deep_copy"
		end

	copy_ (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.EXPORT_CLAUSE"
		alias
			"copy"
		end

	conforms_to (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.EXPORT_CLAUSE"
		alias
			"conforms_to"
		end

	frozen ec_illegal_36_ec_illegal_36_make (current_: EXPORT_CLAUSE) is
		external
			"IL static signature (EXPORT_CLAUSE): System.Void use Implementation.EXPORT_CLAUSE"
		alias
			"$$make"
		end

	make is
		external
			"IL signature (): System.Void use Implementation.EXPORT_CLAUSE"
		alias
			"make"
		end

	empty_string: STRING is
		external
			"IL signature (): STRING use Implementation.EXPORT_CLAUSE"
		alias
			"empty_string"
		end

	print (some: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.EXPORT_CLAUSE"
		alias
			"print"
		end

	eiffel_keyword: STRING is
		external
			"IL signature (): STRING use Implementation.EXPORT_CLAUSE"
		alias
			"eiffel_keyword"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use Implementation.EXPORT_CLAUSE"
		alias
			"Finalize"
		end

end -- class IMPLEMENTATION_EXPORT_CLAUSE
