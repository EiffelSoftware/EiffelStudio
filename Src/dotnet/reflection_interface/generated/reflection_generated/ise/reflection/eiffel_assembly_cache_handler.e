indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "EIFFEL_ASSEMBLY_CACHE_HANDLER"

deferred external class
	EIFFEL_ASSEMBLY_CACHE_HANDLER

inherit
	EIFFEL_ASSEMBLY_CACHE_HANDLER_SUPPORT
	XML_ELEMENTS
	DICTIONARY

feature -- Basic Operations

	eiffel_assembly: EIFFEL_ASSEMBLY is
		external
			"IL deferred signature (): EIFFEL_ASSEMBLY use EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"eiffel_assembly"
		end

	a_set_assembly_folder_path (assembly_folder_path2: STRING) is
		external
			"IL deferred signature (STRING): System.Void use EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"_set_assembly_folder_path"
		end

	last_write_successful: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"last_write_successful"
		end

	commit is
		external
			"IL deferred signature (): System.Void use EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"commit"
		end

	assembly_descriptor: ASSEMBLY_DESCRIPTOR is
		external
			"IL deferred signature (): ASSEMBLY_DESCRIPTOR use EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"assembly_descriptor"
		end

	a_set_last_error (last_error2: ERROR_INFO) is
		external
			"IL deferred signature (ERROR_INFO): System.Void use EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"_set_last_error"
		end

	write_lock_creation_failed_code: INTEGER is
		external
			"IL deferred signature (): System.Int32 use EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"write_lock_creation_failed_code"
		end

	has_read_lock_code: INTEGER is
		external
			"IL deferred signature (): System.Int32 use EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"has_read_lock_code"
		end

	a_set_assembly_descriptor (assembly_descriptor2: ASSEMBLY_DESCRIPTOR) is
		external
			"IL deferred signature (ASSEMBLY_DESCRIPTOR): System.Void use EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"_set_assembly_descriptor"
		end

	a_set_last_write_successful (last_write_successful2: BOOLEAN) is
		external
			"IL deferred signature (System.Boolean): System.Void use EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"_set_last_write_successful"
		end

	has_write_lock_code: INTEGER is
		external
			"IL deferred signature (): System.Int32 use EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"has_write_lock_code"
		end

	remove_assembly (a_descriptor: ASSEMBLY_DESCRIPTOR) is
		external
			"IL deferred signature (ASSEMBLY_DESCRIPTOR): System.Void use EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"remove_assembly"
		end

	make_cache_handler is
		external
			"IL deferred signature (): System.Void use EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"make_cache_handler"
		end

	type_storer_from_class (an_eiffel_class: EIFFEL_CLASS): TYPE_STORER is
		external
			"IL deferred signature (EIFFEL_CLASS): TYPE_STORER use EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"type_storer_from_class"
		end

	assembly_folder_path: STRING is
		external
			"IL deferred signature (): STRING use EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"assembly_folder_path"
		end

	access_violation_error: STRING is
		external
			"IL deferred signature (): STRING use EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"access_violation_error"
		end

	update_assembly_description (an_eiffel_assembly: EIFFEL_ASSEMBLY; new_path: STRING) is
		external
			"IL deferred signature (EIFFEL_ASSEMBLY, STRING): System.Void use EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"update_assembly_description"
		end

	a_set_error_messages (error_messages2: EIFFEL_ASSEMBLY_CACHE_HANDLER_ERROR_MESSAGES) is
		external
			"IL deferred signature (EIFFEL_ASSEMBLY_CACHE_HANDLER_ERROR_MESSAGES): System.Void use EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"_set_error_messages"
		end

	support: CODE_GENERATION_SUPPORT is
		external
			"IL deferred signature (): CODE_GENERATION_SUPPORT use EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"support"
		end

	prepare_assembly_storage is
		external
			"IL deferred signature (): System.Void use EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"prepare_assembly_storage"
		end

	error_caption: STRING is
		external
			"IL deferred signature (): STRING use EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"error_caption"
		end

	store_assembly (an_eiffel_assembly: EIFFEL_ASSEMBLY): TYPE_STORER is
		external
			"IL deferred signature (EIFFEL_ASSEMBLY): TYPE_STORER use EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"store_assembly"
		end

	update_index is
		external
			"IL deferred signature (): System.Void use EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"update_index"
		end

	is_valid_directory_path (a_folder_name: STRING): BOOLEAN is
		external
			"IL deferred signature (STRING): System.Boolean use EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"is_valid_directory_path"
		end

	last_removal_successful: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"last_removal_successful"
		end

	is_valid_filename (a_filename: STRING): BOOLEAN is
		external
			"IL deferred signature (STRING): System.Boolean use EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"is_valid_filename"
		end

	last_error: ERROR_INFO is
		external
			"IL deferred signature (): ERROR_INFO use EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"last_error"
		end

	prepare_type_storage (an_assembly_descriptor: ASSEMBLY_DESCRIPTOR) is
		external
			"IL deferred signature (ASSEMBLY_DESCRIPTOR): System.Void use EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"prepare_type_storage"
		end

	generate_assembly_xml_file is
		external
			"IL deferred signature (): System.Void use EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"generate_assembly_xml_file"
		end

	a_set_last_removal_successful (last_removal_successful2: BOOLEAN) is
		external
			"IL deferred signature (System.Boolean): System.Void use EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"_set_last_removal_successful"
		end

	error_messages: EIFFEL_ASSEMBLY_CACHE_HANDLER_ERROR_MESSAGES is
		external
			"IL deferred signature (): EIFFEL_ASSEMBLY_CACHE_HANDLER_ERROR_MESSAGES use EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"error_messages"
		end

	a_set_eiffel_assembly (eiffel_assembly2: EIFFEL_ASSEMBLY) is
		external
			"IL deferred signature (EIFFEL_ASSEMBLY): System.Void use EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"_set_eiffel_assembly"
		end

	assembly_types_from_xml (xml_filename: STRING): LINKED_LIST_ANY is
		external
			"IL deferred signature (STRING): LINKED_LIST_ANY use EIFFEL_ASSEMBLY_CACHE_HANDLER"
		alias
			"assembly_types_from_xml"
		end

end -- class EIFFEL_ASSEMBLY_CACHE_HANDLER
