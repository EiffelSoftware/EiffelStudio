indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "Implementation.TYPE_STORER_ERROR_MESSAGES"

external class
	IMPLEMENTATION_TYPE_STORER_ERROR_MESSAGES

inherit
	SUPPORT_ERROR_MESSAGES
	TYPE_STORER_ERROR_MESSAGES
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use Implementation.TYPE_STORER_ERROR_MESSAGES"
		end

feature -- Basic Operations

	operating_environment: OPERATING_ENVIRONMENT is
		external
			"IL signature (): OPERATING_ENVIRONMENT use Implementation.TYPE_STORER_ERROR_MESSAGES"
		alias
			"operating_environment"
		end

	frozen a____class_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.TYPE_STORER_ERROR_MESSAGES"
		alias
			"____class_name"
		end

	default_create_ is
		external
			"IL signature (): System.Void use Implementation.TYPE_STORER_ERROR_MESSAGES"
		alias
			"default_create"
		end

	frozen ec_illegal_36_ec_illegal_36_write_lock_removal_failed (current_: TYPE_STORER_ERROR_MESSAGES): STRING is
		external
			"IL static signature (TYPE_STORER_ERROR_MESSAGES): STRING use Implementation.TYPE_STORER_ERROR_MESSAGES"
		alias
			"$$write_lock_removal_failed"
		end

	frozen ec_illegal_36_ec_illegal_36_assembly_description_update_failed_message (current_: TYPE_STORER_ERROR_MESSAGES): STRING is
		external
			"IL static signature (TYPE_STORER_ERROR_MESSAGES): STRING use Implementation.TYPE_STORER_ERROR_MESSAGES"
		alias
			"$$assembly_description_update_failed_message"
		end

	xml_feature_assertions_generation_failed: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER_ERROR_MESSAGES"
		alias
			"xml_feature_assertions_generation_failed"
		end

	frozen ec_illegal_36_ec_illegal_36_xml_class_header_generation_failed (current_: TYPE_STORER_ERROR_MESSAGES): STRING is
		external
			"IL static signature (TYPE_STORER_ERROR_MESSAGES): STRING use Implementation.TYPE_STORER_ERROR_MESSAGES"
		alias
			"$$xml_class_header_generation_failed"
		end

	xml_alias_element_generation_failed: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER_ERROR_MESSAGES"
		alias
			"xml_alias_element_generation_failed"
		end

	xml_type_generation_failed_message: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER_ERROR_MESSAGES"
		alias
			"xml_type_generation_failed_message"
		end

	file_access_failed_message: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER_ERROR_MESSAGES"
		alias
			"file_access_failed_message"
		end

	copy_ (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.TYPE_STORER_ERROR_MESSAGES"
		alias
			"copy"
		end

	generating_type: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER_ERROR_MESSAGES"
		alias
			"generating_type"
		end

	xml_alias_element_generation_failed_message: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER_ERROR_MESSAGES"
		alias
			"xml_alias_element_generation_failed_message"
		end

	xml_class_body_generation_failed: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER_ERROR_MESSAGES"
		alias
			"xml_class_body_generation_failed"
		end

	out_: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER_ERROR_MESSAGES"
		alias
			"out"
		end

	frozen ec_illegal_36_ec_illegal_36_xml_class_footer_generation_failed_message (current_: TYPE_STORER_ERROR_MESSAGES): STRING is
		external
			"IL static signature (TYPE_STORER_ERROR_MESSAGES): STRING use Implementation.TYPE_STORER_ERROR_MESSAGES"
		alias
			"$$xml_class_footer_generation_failed_message"
		end

	frozen ec_illegal_36_ec_illegal_36_xml_class_features_generation_failed (current_: TYPE_STORER_ERROR_MESSAGES): STRING is
		external
			"IL static signature (TYPE_STORER_ERROR_MESSAGES): STRING use Implementation.TYPE_STORER_ERROR_MESSAGES"
		alias
			"$$xml_class_features_generation_failed"
		end

	frozen ec_illegal_36_ec_illegal_36_xml_alias_element_generation_failed (current_: TYPE_STORER_ERROR_MESSAGES): STRING is
		external
			"IL static signature (TYPE_STORER_ERROR_MESSAGES): STRING use Implementation.TYPE_STORER_ERROR_MESSAGES"
		alias
			"$$xml_alias_element_generation_failed"
		end

	frozen ec_illegal_36_ec_illegal_36_xml_feature_assertions_generation_failed_message (current_: TYPE_STORER_ERROR_MESSAGES): STRING is
		external
			"IL static signature (TYPE_STORER_ERROR_MESSAGES): STRING use Implementation.TYPE_STORER_ERROR_MESSAGES"
		alias
			"$$xml_feature_assertions_generation_failed_message"
		end

	xml_inherit_element_generation_failed: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER_ERROR_MESSAGES"
		alias
			"xml_inherit_element_generation_failed"
		end

	frozen ec_illegal_36_ec_illegal_36_xml_type_generation_failed (current_: TYPE_STORER_ERROR_MESSAGES): STRING is
		external
			"IL static signature (TYPE_STORER_ERROR_MESSAGES): STRING use Implementation.TYPE_STORER_ERROR_MESSAGES"
		alias
			"$$xml_type_generation_failed"
		end

	conforms_to (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.TYPE_STORER_ERROR_MESSAGES"
		alias
			"conforms_to"
		end

	io: STD_FILES is
		external
			"IL signature (): STD_FILES use Implementation.TYPE_STORER_ERROR_MESSAGES"
		alias
			"io"
		end

	file_access_failed: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER_ERROR_MESSAGES"
		alias
			"file_access_failed"
		end

	xml_feature_assertions_generation_failed_message: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER_ERROR_MESSAGES"
		alias
			"xml_feature_assertions_generation_failed_message"
		end

	tagged_out: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER_ERROR_MESSAGES"
		alias
			"tagged_out"
		end

	default_: ANY is
		external
			"IL signature (): ANY use Implementation.TYPE_STORER_ERROR_MESSAGES"
		alias
			"default"
		end

	frozen ec_illegal_36_ec_illegal_36_xml_class_header_generation_failed_message (current_: TYPE_STORER_ERROR_MESSAGES): STRING is
		external
			"IL static signature (TYPE_STORER_ERROR_MESSAGES): STRING use Implementation.TYPE_STORER_ERROR_MESSAGES"
		alias
			"$$xml_class_header_generation_failed_message"
		end

	same_type (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.TYPE_STORER_ERROR_MESSAGES"
		alias
			"same_type"
		end

	do_nothing is
		external
			"IL signature (): System.Void use Implementation.TYPE_STORER_ERROR_MESSAGES"
		alias
			"do_nothing"
		end

	assembly_description_update_failed_message: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER_ERROR_MESSAGES"
		alias
			"assembly_description_update_failed_message"
		end

	xml_class_features_generation_failed_message: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER_ERROR_MESSAGES"
		alias
			"xml_class_features_generation_failed_message"
		end

	frozen ec_illegal_36_ec_illegal_36_xml_feature_arguments_generation_failed_message (current_: TYPE_STORER_ERROR_MESSAGES): STRING is
		external
			"IL static signature (TYPE_STORER_ERROR_MESSAGES): STRING use Implementation.TYPE_STORER_ERROR_MESSAGES"
		alias
			"$$xml_feature_arguments_generation_failed_message"
		end

	xml_feature_arguments_generation_failed_message: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER_ERROR_MESSAGES"
		alias
			"xml_feature_arguments_generation_failed_message"
		end

	xml_type_generation_failed: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER_ERROR_MESSAGES"
		alias
			"xml_type_generation_failed"
		end

	xml_class_header_generation_failed: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER_ERROR_MESSAGES"
		alias
			"xml_class_header_generation_failed"
		end

	standard_is_equal (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.TYPE_STORER_ERROR_MESSAGES"
		alias
			"standard_is_equal"
		end

	write_lock_removal_failed_message: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER_ERROR_MESSAGES"
		alias
			"write_lock_removal_failed_message"
		end

	frozen ec_illegal_36_ec_illegal_36_xml_inherit_element_generation_failed_message (current_: TYPE_STORER_ERROR_MESSAGES): STRING is
		external
			"IL static signature (TYPE_STORER_ERROR_MESSAGES): STRING use Implementation.TYPE_STORER_ERROR_MESSAGES"
		alias
			"$$xml_inherit_element_generation_failed_message"
		end

	standard_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.TYPE_STORER_ERROR_MESSAGES"
		alias
			"standard_equal"
		end

	frozen ec_illegal_36_ec_illegal_36_write_lock_removal_failed_message (current_: TYPE_STORER_ERROR_MESSAGES): STRING is
		external
			"IL static signature (TYPE_STORER_ERROR_MESSAGES): STRING use Implementation.TYPE_STORER_ERROR_MESSAGES"
		alias
			"$$write_lock_removal_failed_message"
		end

	xml_class_footer_generation_failed_message: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER_ERROR_MESSAGES"
		alias
			"xml_class_footer_generation_failed_message"
		end

	default_pointer: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.TYPE_STORER_ERROR_MESSAGES"
		alias
			"default_pointer"
		end

	frozen ec_illegal_36_ec_illegal_36_xml_feature_assertions_generation_failed (current_: TYPE_STORER_ERROR_MESSAGES): STRING is
		external
			"IL static signature (TYPE_STORER_ERROR_MESSAGES): STRING use Implementation.TYPE_STORER_ERROR_MESSAGES"
		alias
			"$$xml_feature_assertions_generation_failed"
		end

	frozen ec_illegal_36_ec_illegal_36_xml_alias_element_generation_failed_message (current_: TYPE_STORER_ERROR_MESSAGES): STRING is
		external
			"IL static signature (TYPE_STORER_ERROR_MESSAGES): STRING use Implementation.TYPE_STORER_ERROR_MESSAGES"
		alias
			"$$xml_alias_element_generation_failed_message"
		end

	frozen ec_illegal_36_ec_illegal_36_file_access_failed (current_: TYPE_STORER_ERROR_MESSAGES): STRING is
		external
			"IL static signature (TYPE_STORER_ERROR_MESSAGES): STRING use Implementation.TYPE_STORER_ERROR_MESSAGES"
		alias
			"$$file_access_failed"
		end

	is_equal_ (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.TYPE_STORER_ERROR_MESSAGES"
		alias
			"is_equal"
		end

	frozen ec_illegal_36_ec_illegal_36_file_access_failed_message (current_: TYPE_STORER_ERROR_MESSAGES): STRING is
		external
			"IL static signature (TYPE_STORER_ERROR_MESSAGES): STRING use Implementation.TYPE_STORER_ERROR_MESSAGES"
		alias
			"$$file_access_failed_message"
		end

	print (some: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.TYPE_STORER_ERROR_MESSAGES"
		alias
			"print"
		end

	frozen ec_illegal_36_ec_illegal_36_xml_class_body_generation_failed (current_: TYPE_STORER_ERROR_MESSAGES): STRING is
		external
			"IL static signature (TYPE_STORER_ERROR_MESSAGES): STRING use Implementation.TYPE_STORER_ERROR_MESSAGES"
		alias
			"$$xml_class_body_generation_failed"
		end

	xml_class_footer_generation_failed: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER_ERROR_MESSAGES"
		alias
			"xml_class_footer_generation_failed"
		end

	assembly_description_update_failed: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER_ERROR_MESSAGES"
		alias
			"assembly_description_update_failed"
		end

	frozen ec_illegal_36_ec_illegal_36_xml_class_body_generation_failed_message (current_: TYPE_STORER_ERROR_MESSAGES): STRING is
		external
			"IL static signature (TYPE_STORER_ERROR_MESSAGES): STRING use Implementation.TYPE_STORER_ERROR_MESSAGES"
		alias
			"$$xml_class_body_generation_failed_message"
		end

	equal_ (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.TYPE_STORER_ERROR_MESSAGES"
		alias
			"equal"
		end

	write_lock_removal_failed: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER_ERROR_MESSAGES"
		alias
			"write_lock_removal_failed"
		end

	clone_ (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.TYPE_STORER_ERROR_MESSAGES"
		alias
			"clone"
		end

	xml_class_features_generation_failed: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER_ERROR_MESSAGES"
		alias
			"xml_class_features_generation_failed"
		end

	frozen ec_illegal_36_ec_illegal_36_xml_class_footer_generation_failed (current_: TYPE_STORER_ERROR_MESSAGES): STRING is
		external
			"IL static signature (TYPE_STORER_ERROR_MESSAGES): STRING use Implementation.TYPE_STORER_ERROR_MESSAGES"
		alias
			"$$xml_class_footer_generation_failed"
		end

	xml_feature_arguments_generation_failed: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER_ERROR_MESSAGES"
		alias
			"xml_feature_arguments_generation_failed"
		end

	standard_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.TYPE_STORER_ERROR_MESSAGES"
		alias
			"standard_copy"
		end

	xml_inherit_element_generation_failed_message: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER_ERROR_MESSAGES"
		alias
			"xml_inherit_element_generation_failed_message"
		end

	xml_class_header_generation_failed_message: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER_ERROR_MESSAGES"
		alias
			"xml_class_header_generation_failed_message"
		end

	frozen ec_illegal_36_ec_illegal_36_assembly_description_update_failed (current_: TYPE_STORER_ERROR_MESSAGES): STRING is
		external
			"IL static signature (TYPE_STORER_ERROR_MESSAGES): STRING use Implementation.TYPE_STORER_ERROR_MESSAGES"
		alias
			"$$assembly_description_update_failed"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use Implementation.TYPE_STORER_ERROR_MESSAGES"
		alias
			"Equals"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.TYPE_STORER_ERROR_MESSAGES"
		alias
			"GetHashCode"
		end

	deep_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.TYPE_STORER_ERROR_MESSAGES"
		alias
			"deep_equal"
		end

	frozen ec_illegal_36_ec_illegal_36_xml_feature_arguments_generation_failed (current_: TYPE_STORER_ERROR_MESSAGES): STRING is
		external
			"IL static signature (TYPE_STORER_ERROR_MESSAGES): STRING use Implementation.TYPE_STORER_ERROR_MESSAGES"
		alias
			"$$xml_feature_arguments_generation_failed"
		end

	standard_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.TYPE_STORER_ERROR_MESSAGES"
		alias
			"standard_clone"
		end

	xml_class_body_generation_failed_message: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER_ERROR_MESSAGES"
		alias
			"xml_class_body_generation_failed_message"
		end

	default_rescue is
		external
			"IL signature (): System.Void use Implementation.TYPE_STORER_ERROR_MESSAGES"
		alias
			"default_rescue"
		end

	internal_clone: ANY is
		external
			"IL signature (): ANY use Implementation.TYPE_STORER_ERROR_MESSAGES"
		alias
			"internal_clone"
		end

	generator: STRING is
		external
			"IL signature (): STRING use Implementation.TYPE_STORER_ERROR_MESSAGES"
		alias
			"generator"
		end

	deep_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.TYPE_STORER_ERROR_MESSAGES"
		alias
			"deep_clone"
		end

	internal_copy (o: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.TYPE_STORER_ERROR_MESSAGES"
		alias
			"internal_copy"
		end

	frozen ec_illegal_36_ec_illegal_36_xml_class_features_generation_failed_message (current_: TYPE_STORER_ERROR_MESSAGES): STRING is
		external
			"IL static signature (TYPE_STORER_ERROR_MESSAGES): STRING use Implementation.TYPE_STORER_ERROR_MESSAGES"
		alias
			"$$xml_class_features_generation_failed_message"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.TYPE_STORER_ERROR_MESSAGES"
		alias
			"ToString"
		end

	deep_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.TYPE_STORER_ERROR_MESSAGES"
		alias
			"deep_copy"
		end

	frozen ec_illegal_36_ec_illegal_36_xml_inherit_element_generation_failed (current_: TYPE_STORER_ERROR_MESSAGES): STRING is
		external
			"IL static signature (TYPE_STORER_ERROR_MESSAGES): STRING use Implementation.TYPE_STORER_ERROR_MESSAGES"
		alias
			"$$xml_inherit_element_generation_failed"
		end

	frozen ec_illegal_36_ec_illegal_36_xml_type_generation_failed_message (current_: TYPE_STORER_ERROR_MESSAGES): STRING is
		external
			"IL static signature (TYPE_STORER_ERROR_MESSAGES): STRING use Implementation.TYPE_STORER_ERROR_MESSAGES"
		alias
			"$$xml_type_generation_failed_message"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use Implementation.TYPE_STORER_ERROR_MESSAGES"
		alias
			"Finalize"
		end

end -- class IMPLEMENTATION_TYPE_STORER_ERROR_MESSAGES
