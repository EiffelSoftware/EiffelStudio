indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "Implementation.CONVERSION_SUPPORT"

external class
	IMPLEMENTATION_CONVERSION_SUPPORT

inherit
	SUPPORT_SUPPORT
	ASSEMBLY_NAME_DECODER
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	CONVERSION_SUPPORT

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use Implementation.CONVERSION_SUPPORT"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.CONVERSION_SUPPORT"
		alias
			"GetHashCode"
		end

	deep_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.CONVERSION_SUPPORT"
		alias
			"deep_clone"
		end

	frozen ec_illegal_36_ec_illegal_36_opening_curl_bracket (current_: CONVERSION_SUPPORT): STRING is
		external
			"IL static signature (CONVERSION_SUPPORT): STRING use Implementation.CONVERSION_SUPPORT"
		alias
			"$$opening_curl_bracket"
		end

	source_from_text (a_text: STRING): STRING is
		external
			"IL signature (STRING): STRING use Implementation.CONVERSION_SUPPORT"
		alias
			"source_from_text"
		end

	type_from_eiffel_class (a_eiffel_class: EIFFEL_CLASS): TYPE is
		external
			"IL signature (EIFFEL_CLASS): System.Type use Implementation.CONVERSION_SUPPORT"
		alias
			"type_from_eiffel_class"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.CONVERSION_SUPPORT"
		alias
			"ToString"
		end

	tagged_out: STRING is
		external
			"IL signature (): STRING use Implementation.CONVERSION_SUPPORT"
		alias
			"tagged_out"
		end

	frozen ec_illegal_36_ec_illegal_36_rename_clause_from_text (current_: CONVERSION_SUPPORT; a_text: STRING): RENAME_CLAUSE is
		external
			"IL static signature (CONVERSION_SUPPORT, STRING): RENAME_CLAUSE use Implementation.CONVERSION_SUPPORT"
		alias
			"$$rename_clause_from_text"
		end

	internal_clone: ANY is
		external
			"IL signature (): ANY use Implementation.CONVERSION_SUPPORT"
		alias
			"internal_clone"
		end

	operating_environment: OPERATING_ENVIRONMENT is
		external
			"IL signature (): OPERATING_ENVIRONMENT use Implementation.CONVERSION_SUPPORT"
		alias
			"operating_environment"
		end

	standard_is_equal (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.CONVERSION_SUPPORT"
		alias
			"standard_is_equal"
		end

	is_equal_ (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.CONVERSION_SUPPORT"
		alias
			"is_equal"
		end

	opening_curl_bracket: STRING is
		external
			"IL signature (): STRING use Implementation.CONVERSION_SUPPORT"
		alias
			"opening_curl_bracket"
		end

	frozen ec_illegal_36_ec_illegal_36_type_from_assembly_descriptor (current_: CONVERSION_SUPPORT; a_assembly_descriptor: ASSEMBLY_DESCRIPTOR; a_type_full_external_name: STRING): TYPE is
		external
			"IL static signature (CONVERSION_SUPPORT, ASSEMBLY_DESCRIPTOR, STRING): System.Type use Implementation.CONVERSION_SUPPORT"
		alias
			"$$type_from_assembly_descriptor"
		end

	closing_curl_bracket: STRING is
		external
			"IL signature (): STRING use Implementation.CONVERSION_SUPPORT"
		alias
			"closing_curl_bracket"
		end

	standard_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.CONVERSION_SUPPORT"
		alias
			"standard_equal"
		end

	same_type (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.CONVERSION_SUPPORT"
		alias
			"same_type"
		end

	assembly_descriptor_from_name (an_assembly_name: ASSEMBLY_NAME): ASSEMBLY_DESCRIPTOR is
		external
			"IL signature (System.Reflection.AssemblyName): ASSEMBLY_DESCRIPTOR use Implementation.CONVERSION_SUPPORT"
		alias
			"assembly_descriptor_from_name"
		end

	generator: STRING is
		external
			"IL signature (): STRING use Implementation.CONVERSION_SUPPORT"
		alias
			"generator"
		end

	internal_copy (o: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.CONVERSION_SUPPORT"
		alias
			"internal_copy"
		end

	from_component_string (string: STRING): STRING is
		external
			"IL signature (STRING): STRING use Implementation.CONVERSION_SUPPORT"
		alias
			"from_component_string"
		end

	space: STRING is
		external
			"IL signature (): STRING use Implementation.CONVERSION_SUPPORT"
		alias
			"space"
		end

	target_from_text (a_text: STRING): STRING is
		external
			"IL signature (STRING): STRING use Implementation.CONVERSION_SUPPORT"
		alias
			"target_from_text"
		end

	standard_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.CONVERSION_SUPPORT"
		alias
			"standard_clone"
		end

	default_create_ is
		external
			"IL signature (): System.Void use Implementation.CONVERSION_SUPPORT"
		alias
			"default_create"
		end

	equal_ (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.CONVERSION_SUPPORT"
		alias
			"equal"
		end

	frozen ec_illegal_36_ec_illegal_36_type_from_eiffel_class (current_: CONVERSION_SUPPORT; a_eiffel_class: EIFFEL_CLASS): TYPE is
		external
			"IL static signature (CONVERSION_SUPPORT, EIFFEL_CLASS): System.Type use Implementation.CONVERSION_SUPPORT"
		alias
			"$$type_from_eiffel_class"
		end

	export_clause_from_text (a_text: STRING): EXPORT_CLAUSE is
		external
			"IL signature (STRING): EXPORT_CLAUSE use Implementation.CONVERSION_SUPPORT"
		alias
			"export_clause_from_text"
		end

	frozen a____class_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.CONVERSION_SUPPORT"
		alias
			"____class_name"
		end

	do_nothing is
		external
			"IL signature (): System.Void use Implementation.CONVERSION_SUPPORT"
		alias
			"do_nothing"
		end

	out_: STRING is
		external
			"IL signature (): STRING use Implementation.CONVERSION_SUPPORT"
		alias
			"out"
		end

	default_rescue is
		external
			"IL signature (): System.Void use Implementation.CONVERSION_SUPPORT"
		alias
			"default_rescue"
		end

	default_pointer: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.CONVERSION_SUPPORT"
		alias
			"default_pointer"
		end

	assembly_info_from_name (an_assembly_name: ASSEMBLY_NAME): ARRAY_ANY is
		external
			"IL signature (System.Reflection.AssemblyName): ARRAY_ANY use Implementation.CONVERSION_SUPPORT"
		alias
			"assembly_info_from_name"
		end

	to_component_string (string: STRING): STRING is
		external
			"IL signature (STRING): STRING use Implementation.CONVERSION_SUPPORT"
		alias
			"to_component_string"
		end

	standard_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.CONVERSION_SUPPORT"
		alias
			"standard_copy"
		end

	frozen ec_illegal_36_ec_illegal_36_target_from_text (current_: CONVERSION_SUPPORT; a_text: STRING): STRING is
		external
			"IL static signature (CONVERSION_SUPPORT, STRING): STRING use Implementation.CONVERSION_SUPPORT"
		alias
			"$$target_from_text"
		end

	from_system_string (string: SYSTEM_STRING): STRING is
		external
			"IL signature (System.String): STRING use Implementation.CONVERSION_SUPPORT"
		alias
			"from_system_string"
		end

	frozen ec_illegal_36_ec_illegal_36_source_from_text (current_: CONVERSION_SUPPORT; a_text: STRING): STRING is
		external
			"IL static signature (CONVERSION_SUPPORT, STRING): STRING use Implementation.CONVERSION_SUPPORT"
		alias
			"$$source_from_text"
		end

	default_: ANY is
		external
			"IL signature (): ANY use Implementation.CONVERSION_SUPPORT"
		alias
			"default"
		end

	deep_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.CONVERSION_SUPPORT"
		alias
			"deep_equal"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use Implementation.CONVERSION_SUPPORT"
		alias
			"Equals"
		end

	frozen ec_illegal_36_ec_illegal_36_closing_curl_bracket (current_: CONVERSION_SUPPORT): STRING is
		external
			"IL static signature (CONVERSION_SUPPORT): STRING use Implementation.CONVERSION_SUPPORT"
		alias
			"$$closing_curl_bracket"
		end

	as_keyword: STRING is
		external
			"IL signature (): STRING use Implementation.CONVERSION_SUPPORT"
		alias
			"as_keyword"
		end

	frozen ec_illegal_36_ec_illegal_36_assembly_descriptor_from_name (current_: CONVERSION_SUPPORT; an_assembly_name: ASSEMBLY_NAME): ASSEMBLY_DESCRIPTOR is
		external
			"IL static signature (CONVERSION_SUPPORT, System.Reflection.AssemblyName): ASSEMBLY_DESCRIPTOR use Implementation.CONVERSION_SUPPORT"
		alias
			"$$assembly_descriptor_from_name"
		end

	neutral_culture: STRING is
		external
			"IL signature (): STRING use Implementation.CONVERSION_SUPPORT"
		alias
			"neutral_culture"
		end

	rename_clause_from_text (a_text: STRING): RENAME_CLAUSE is
		external
			"IL signature (STRING): RENAME_CLAUSE use Implementation.CONVERSION_SUPPORT"
		alias
			"rename_clause_from_text"
		end

	generating_type: STRING is
		external
			"IL signature (): STRING use Implementation.CONVERSION_SUPPORT"
		alias
			"generating_type"
		end

	frozen ec_illegal_36_ec_illegal_36_as_keyword (current_: CONVERSION_SUPPORT): STRING is
		external
			"IL static signature (CONVERSION_SUPPORT): STRING use Implementation.CONVERSION_SUPPORT"
		alias
			"$$as_keyword"
		end

	to_notifier_string (string: STRING): STRING is
		external
			"IL signature (STRING): STRING use Implementation.CONVERSION_SUPPORT"
		alias
			"to_notifier_string"
		end

	from_notifier_string (string: STRING): STRING is
		external
			"IL signature (STRING): STRING use Implementation.CONVERSION_SUPPORT"
		alias
			"from_notifier_string"
		end

	frozen ec_illegal_36_ec_illegal_36_assembly_name_from_descriptor (current_: CONVERSION_SUPPORT; a_descriptor: ASSEMBLY_DESCRIPTOR): ASSEMBLY_NAME is
		external
			"IL static signature (CONVERSION_SUPPORT, ASSEMBLY_DESCRIPTOR): System.Reflection.AssemblyName use Implementation.CONVERSION_SUPPORT"
		alias
			"$$assembly_name_from_descriptor"
		end

	frozen ec_illegal_36_ec_illegal_36_space (current_: CONVERSION_SUPPORT): STRING is
		external
			"IL static signature (CONVERSION_SUPPORT): STRING use Implementation.CONVERSION_SUPPORT"
		alias
			"$$space"
		end

	decode_key (a_key: NATIVE_ARRAY [INTEGER_8]): STRING is
		external
			"IL signature (System.Byte[]): STRING use Implementation.CONVERSION_SUPPORT"
		alias
			"decode_key"
		end

	io: STD_FILES is
		external
			"IL signature (): STD_FILES use Implementation.CONVERSION_SUPPORT"
		alias
			"io"
		end

	clone_ (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.CONVERSION_SUPPORT"
		alias
			"clone"
		end

	type_from_assembly_descriptor (a_assembly_descriptor: ASSEMBLY_DESCRIPTOR; a_type_full_external_name: STRING): TYPE is
		external
			"IL signature (ASSEMBLY_DESCRIPTOR, STRING): System.Type use Implementation.CONVERSION_SUPPORT"
		alias
			"type_from_assembly_descriptor"
		end

	deep_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.CONVERSION_SUPPORT"
		alias
			"deep_copy"
		end

	copy_ (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.CONVERSION_SUPPORT"
		alias
			"copy"
		end

	conforms_to (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.CONVERSION_SUPPORT"
		alias
			"conforms_to"
		end

	frozen ec_illegal_36_ec_illegal_36_export_clause_from_text (current_: CONVERSION_SUPPORT; a_text: STRING): EXPORT_CLAUSE is
		external
			"IL static signature (CONVERSION_SUPPORT, STRING): EXPORT_CLAUSE use Implementation.CONVERSION_SUPPORT"
		alias
			"$$export_clause_from_text"
		end

	assembly_name_from_descriptor (a_descriptor: ASSEMBLY_DESCRIPTOR): ASSEMBLY_NAME is
		external
			"IL signature (ASSEMBLY_DESCRIPTOR): System.Reflection.AssemblyName use Implementation.CONVERSION_SUPPORT"
		alias
			"assembly_name_from_descriptor"
		end

	empty_string: STRING is
		external
			"IL signature (): STRING use Implementation.CONVERSION_SUPPORT"
		alias
			"empty_string"
		end

	print (some: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.CONVERSION_SUPPORT"
		alias
			"print"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use Implementation.CONVERSION_SUPPORT"
		alias
			"Finalize"
		end

end -- class IMPLEMENTATION_CONVERSION_SUPPORT
