indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "REFLECTION_INTERFACE"

deferred external class
	REFLECTION_INTERFACE

inherit
	REFLECTION_INTERFACE_SUPPORT
	XML_ELEMENTS
	DICTIONARY

feature -- Basic Operations

	search (a_descriptor: ASSEMBLY_DESCRIPTOR) is
		external
			"IL deferred signature (ASSEMBLY_DESCRIPTOR): System.Void use REFLECTION_INTERFACE"
		alias
			"search"
		end

	a_set_error_messages (error_messages2: REFLECTION_INTERFACE_ERROR_MESSAGES) is
		external
			"IL deferred signature (REFLECTION_INTERFACE_ERROR_MESSAGES): System.Void use REFLECTION_INTERFACE"
		alias
			"_set_error_messages"
		end

	has_read_lock_code: INTEGER is
		external
			"IL deferred signature (): System.Int32 use REFLECTION_INTERFACE"
		alias
			"has_read_lock_code"
		end

	set_last_error (an_error: ERROR_INFO) is
		external
			"IL deferred signature (ERROR_INFO): System.Void use REFLECTION_INTERFACE"
		alias
			"set_last_error"
		end

	a_set_last_error (last_error2: ERROR_INFO) is
		external
			"IL deferred signature (ERROR_INFO): System.Void use REFLECTION_INTERFACE"
		alias
			"_set_last_error"
		end

	eiffel_assembly (xml_filename: STRING): EIFFEL_ASSEMBLY is
		external
			"IL deferred signature (STRING): EIFFEL_ASSEMBLY use REFLECTION_INTERFACE"
		alias
			"eiffel_assembly"
		end

	type (a_type: TYPE): EIFFEL_CLASS is
		external
			"IL deferred signature (System.Type): EIFFEL_CLASS use REFLECTION_INTERFACE"
		alias
			"type"
		end

	last_read_successful: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use REFLECTION_INTERFACE"
		alias
			"last_read_successful"
		end

	found: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use REFLECTION_INTERFACE"
		alias
			"found"
		end

	a_set_search_result (search_result2: EIFFEL_ASSEMBLY) is
		external
			"IL deferred signature (EIFFEL_ASSEMBLY): System.Void use REFLECTION_INTERFACE"
		alias
			"_set_search_result"
		end

	a_set_found (found2: BOOLEAN) is
		external
			"IL deferred signature (System.Boolean): System.Void use REFLECTION_INTERFACE"
		alias
			"_set_found"
		end

	last_error: ERROR_INFO is
		external
			"IL deferred signature (): ERROR_INFO use REFLECTION_INTERFACE"
		alias
			"last_error"
		end

	read_lock_creation_failed_code: INTEGER is
		external
			"IL deferred signature (): System.Int32 use REFLECTION_INTERFACE"
		alias
			"read_lock_creation_failed_code"
		end

	remove_assembly (a_descriptor: ASSEMBLY_DESCRIPTOR) is
		external
			"IL deferred signature (ASSEMBLY_DESCRIPTOR): System.Void use REFLECTION_INTERFACE"
		alias
			"remove_assembly"
		end

	error_messages: REFLECTION_INTERFACE_ERROR_MESSAGES is
		external
			"IL deferred signature (): REFLECTION_INTERFACE_ERROR_MESSAGES use REFLECTION_INTERFACE"
		alias
			"error_messages"
		end

	support: CODE_GENERATION_SUPPORT is
		external
			"IL deferred signature (): CODE_GENERATION_SUPPORT use REFLECTION_INTERFACE"
		alias
			"support"
		end

	assembly (a_descriptor: ASSEMBLY_DESCRIPTOR): EIFFEL_ASSEMBLY is
		external
			"IL deferred signature (ASSEMBLY_DESCRIPTOR): EIFFEL_ASSEMBLY use REFLECTION_INTERFACE"
		alias
			"assembly"
		end

	make_reflection_interface is
		external
			"IL deferred signature (): System.Void use REFLECTION_INTERFACE"
		alias
			"make_reflection_interface"
		end

	has_write_lock_code: INTEGER is
		external
			"IL deferred signature (): System.Int32 use REFLECTION_INTERFACE"
		alias
			"has_write_lock_code"
		end

	assembly_descriptor_from_type (a_type: TYPE): ASSEMBLY_DESCRIPTOR is
		external
			"IL deferred signature (System.Type): ASSEMBLY_DESCRIPTOR use REFLECTION_INTERFACE"
		alias
			"assembly_descriptor_from_type"
		end

	a_set_last_read_successful (last_read_successful2: BOOLEAN) is
		external
			"IL deferred signature (System.Boolean): System.Void use REFLECTION_INTERFACE"
		alias
			"_set_last_read_successful"
		end

	assemblies: LINKED_LIST_ANY is
		external
			"IL deferred signature (): LINKED_LIST_ANY use REFLECTION_INTERFACE"
		alias
			"assemblies"
		end

	search_result: EIFFEL_ASSEMBLY is
		external
			"IL deferred signature (): EIFFEL_ASSEMBLY use REFLECTION_INTERFACE"
		alias
			"search_result"
		end

	eiffel_type (xml_filename: STRING): EIFFEL_CLASS is
		external
			"IL deferred signature (STRING): EIFFEL_CLASS use REFLECTION_INTERFACE"
		alias
			"eiffel_type"
		end

	current_history: HISTORY is
		external
			"IL deferred signature (): HISTORY use REFLECTION_INTERFACE"
		alias
			"current_history"
		end

end -- class REFLECTION_INTERFACE
