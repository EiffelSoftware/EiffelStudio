indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "CONVERSION_SUPPORT"

deferred external class
	CONVERSION_SUPPORT

inherit
	SUPPORT_SUPPORT
	ASSEMBLY_NAME_DECODER

feature -- Basic Operations

	closing_curl_bracket: STRING is
		external
			"IL deferred signature (): STRING use CONVERSION_SUPPORT"
		alias
			"closing_curl_bracket"
		end

	space: STRING is
		external
			"IL deferred signature (): STRING use CONVERSION_SUPPORT"
		alias
			"space"
		end

	target_from_text (a_text: STRING): STRING is
		external
			"IL deferred signature (STRING): STRING use CONVERSION_SUPPORT"
		alias
			"target_from_text"
		end

	opening_curl_bracket: STRING is
		external
			"IL deferred signature (): STRING use CONVERSION_SUPPORT"
		alias
			"opening_curl_bracket"
		end

	assembly_name_from_descriptor (a_descriptor: ASSEMBLY_DESCRIPTOR): ASSEMBLY_NAME is
		external
			"IL deferred signature (ASSEMBLY_DESCRIPTOR): System.Reflection.AssemblyName use CONVERSION_SUPPORT"
		alias
			"assembly_name_from_descriptor"
		end

	rename_clause_from_text (a_text: STRING): RENAME_CLAUSE is
		external
			"IL deferred signature (STRING): RENAME_CLAUSE use CONVERSION_SUPPORT"
		alias
			"rename_clause_from_text"
		end

	type_from_eiffel_class (a_eiffel_class: EIFFEL_CLASS): TYPE is
		external
			"IL deferred signature (EIFFEL_CLASS): System.Type use CONVERSION_SUPPORT"
		alias
			"type_from_eiffel_class"
		end

	assembly_descriptor_from_name (an_assembly_name: ASSEMBLY_NAME): ASSEMBLY_DESCRIPTOR is
		external
			"IL deferred signature (System.Reflection.AssemblyName): ASSEMBLY_DESCRIPTOR use CONVERSION_SUPPORT"
		alias
			"assembly_descriptor_from_name"
		end

	as_keyword: STRING is
		external
			"IL deferred signature (): STRING use CONVERSION_SUPPORT"
		alias
			"as_keyword"
		end

	source_from_text (a_text: STRING): STRING is
		external
			"IL deferred signature (STRING): STRING use CONVERSION_SUPPORT"
		alias
			"source_from_text"
		end

	export_clause_from_text (a_text: STRING): EXPORT_CLAUSE is
		external
			"IL deferred signature (STRING): EXPORT_CLAUSE use CONVERSION_SUPPORT"
		alias
			"export_clause_from_text"
		end

	type_from_assembly_descriptor (a_assembly_descriptor: ASSEMBLY_DESCRIPTOR; a_type_full_external_name: STRING): TYPE is
		external
			"IL deferred signature (ASSEMBLY_DESCRIPTOR, STRING): System.Type use CONVERSION_SUPPORT"
		alias
			"type_from_assembly_descriptor"
		end

end -- class CONVERSION_SUPPORT
