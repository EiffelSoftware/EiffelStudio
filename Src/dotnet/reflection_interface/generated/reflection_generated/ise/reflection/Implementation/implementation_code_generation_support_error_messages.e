indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "Implementation.CODE_GENERATION_SUPPORT_ERROR_MESSAGES"

external class
	IMPLEMENTATION_CODE_GENERATION_SUPPORT_ERROR_MESSAGES

inherit
	CODE_GENERATION_SUPPORT_ERROR_MESSAGES
	SUPPORT_ERROR_MESSAGES
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
			"IL creator use Implementation.CODE_GENERATION_SUPPORT_ERROR_MESSAGES"
		end

feature -- Basic Operations

	operating_environment: OPERATING_ENVIRONMENT is
		external
			"IL signature (): OPERATING_ENVIRONMENT use Implementation.CODE_GENERATION_SUPPORT_ERROR_MESSAGES"
		alias
			"operating_environment"
		end

	eiffel_class_generation_failed: STRING is
		external
			"IL signature (): STRING use Implementation.CODE_GENERATION_SUPPORT_ERROR_MESSAGES"
		alias
			"eiffel_class_generation_failed"
		end

	frozen a____class_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.CODE_GENERATION_SUPPORT_ERROR_MESSAGES"
		alias
			"____class_name"
		end

	frozen ec_illegal_36_ec_illegal_36_class_feature_comments_generation_failed_message (current_: CODE_GENERATION_SUPPORT_ERROR_MESSAGES): STRING is
		external
			"IL static signature (CODE_GENERATION_SUPPORT_ERROR_MESSAGES): STRING use Implementation.CODE_GENERATION_SUPPORT_ERROR_MESSAGES"
		alias
			"$$class_feature_comments_generation_failed_message"
		end

	default_create_ is
		external
			"IL signature (): System.Void use Implementation.CODE_GENERATION_SUPPORT_ERROR_MESSAGES"
		alias
			"default_create"
		end

	class_footer_generation_failed: STRING is
		external
			"IL signature (): STRING use Implementation.CODE_GENERATION_SUPPORT_ERROR_MESSAGES"
		alias
			"class_footer_generation_failed"
		end

	frozen ec_illegal_36_ec_illegal_36_eiffel_assembly_generation_failed (current_: CODE_GENERATION_SUPPORT_ERROR_MESSAGES): STRING is
		external
			"IL static signature (CODE_GENERATION_SUPPORT_ERROR_MESSAGES): STRING use Implementation.CODE_GENERATION_SUPPORT_ERROR_MESSAGES"
		alias
			"$$eiffel_assembly_generation_failed"
		end

	frozen ec_illegal_36_ec_illegal_36_write_lock_message (current_: CODE_GENERATION_SUPPORT_ERROR_MESSAGES): STRING is
		external
			"IL static signature (CODE_GENERATION_SUPPORT_ERROR_MESSAGES): STRING use Implementation.CODE_GENERATION_SUPPORT_ERROR_MESSAGES"
		alias
			"$$write_lock_message"
		end

	class_feature_comments_generation_failed_message: STRING is
		external
			"IL signature (): STRING use Implementation.CODE_GENERATION_SUPPORT_ERROR_MESSAGES"
		alias
			"class_feature_comments_generation_failed_message"
		end

	copy_ (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.CODE_GENERATION_SUPPORT_ERROR_MESSAGES"
		alias
			"copy"
		end

	generating_type: STRING is
		external
			"IL signature (): STRING use Implementation.CODE_GENERATION_SUPPORT_ERROR_MESSAGES"
		alias
			"generating_type"
		end

	deep_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.CODE_GENERATION_SUPPORT_ERROR_MESSAGES"
		alias
			"deep_clone"
		end

	class_feature_info_generation_failed: STRING is
		external
			"IL signature (): STRING use Implementation.CODE_GENERATION_SUPPORT_ERROR_MESSAGES"
		alias
			"class_feature_info_generation_failed"
		end

	out_: STRING is
		external
			"IL signature (): STRING use Implementation.CODE_GENERATION_SUPPORT_ERROR_MESSAGES"
		alias
			"out"
		end

	frozen ec_illegal_36_ec_illegal_36_eiffel_assembly_generation_failed_message (current_: CODE_GENERATION_SUPPORT_ERROR_MESSAGES): STRING is
		external
			"IL static signature (CODE_GENERATION_SUPPORT_ERROR_MESSAGES): STRING use Implementation.CODE_GENERATION_SUPPORT_ERROR_MESSAGES"
		alias
			"$$eiffel_assembly_generation_failed_message"
		end

	frozen ec_illegal_36_ec_illegal_36_class_features_generation_failed_message (current_: CODE_GENERATION_SUPPORT_ERROR_MESSAGES): STRING is
		external
			"IL static signature (CODE_GENERATION_SUPPORT_ERROR_MESSAGES): STRING use Implementation.CODE_GENERATION_SUPPORT_ERROR_MESSAGES"
		alias
			"$$class_features_generation_failed_message"
		end

	frozen ec_illegal_36_ec_illegal_36_generic_derivation_generation_failed (current_: CODE_GENERATION_SUPPORT_ERROR_MESSAGES): STRING is
		external
			"IL static signature (CODE_GENERATION_SUPPORT_ERROR_MESSAGES): STRING use Implementation.CODE_GENERATION_SUPPORT_ERROR_MESSAGES"
		alias
			"$$generic_derivation_generation_failed"
		end

	frozen ec_illegal_36_ec_illegal_36_class_header_generation_failed (current_: CODE_GENERATION_SUPPORT_ERROR_MESSAGES): STRING is
		external
			"IL static signature (CODE_GENERATION_SUPPORT_ERROR_MESSAGES): STRING use Implementation.CODE_GENERATION_SUPPORT_ERROR_MESSAGES"
		alias
			"$$class_header_generation_failed"
		end

	frozen ec_illegal_36_ec_illegal_36_generic_derivation_generation_failed_message (current_: CODE_GENERATION_SUPPORT_ERROR_MESSAGES): STRING is
		external
			"IL static signature (CODE_GENERATION_SUPPORT_ERROR_MESSAGES): STRING use Implementation.CODE_GENERATION_SUPPORT_ERROR_MESSAGES"
		alias
			"$$generic_derivation_generation_failed_message"
		end

	class_footer_generation_failed_message: STRING is
		external
			"IL signature (): STRING use Implementation.CODE_GENERATION_SUPPORT_ERROR_MESSAGES"
		alias
			"class_footer_generation_failed_message"
		end

	class_body_generation_failed_message: STRING is
		external
			"IL signature (): STRING use Implementation.CODE_GENERATION_SUPPORT_ERROR_MESSAGES"
		alias
			"class_body_generation_failed_message"
		end

	frozen ec_illegal_36_ec_illegal_36_class_body_generation_failed (current_: CODE_GENERATION_SUPPORT_ERROR_MESSAGES): STRING is
		external
			"IL static signature (CODE_GENERATION_SUPPORT_ERROR_MESSAGES): STRING use Implementation.CODE_GENERATION_SUPPORT_ERROR_MESSAGES"
		alias
			"$$class_body_generation_failed"
		end

	frozen ec_illegal_36_ec_illegal_36_read_lock_message (current_: CODE_GENERATION_SUPPORT_ERROR_MESSAGES): STRING is
		external
			"IL static signature (CODE_GENERATION_SUPPORT_ERROR_MESSAGES): STRING use Implementation.CODE_GENERATION_SUPPORT_ERROR_MESSAGES"
		alias
			"$$read_lock_message"
		end

	class_feature_arguments_generation_failed_message: STRING is
		external
			"IL signature (): STRING use Implementation.CODE_GENERATION_SUPPORT_ERROR_MESSAGES"
		alias
			"class_feature_arguments_generation_failed_message"
		end

	frozen ec_illegal_36_ec_illegal_36_class_feature_comments_generation_failed (current_: CODE_GENERATION_SUPPORT_ERROR_MESSAGES): STRING is
		external
			"IL static signature (CODE_GENERATION_SUPPORT_ERROR_MESSAGES): STRING use Implementation.CODE_GENERATION_SUPPORT_ERROR_MESSAGES"
		alias
			"$$class_feature_comments_generation_failed"
		end

	conforms_to (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.CODE_GENERATION_SUPPORT_ERROR_MESSAGES"
		alias
			"conforms_to"
		end

	io: STD_FILES is
		external
			"IL signature (): STD_FILES use Implementation.CODE_GENERATION_SUPPORT_ERROR_MESSAGES"
		alias
			"io"
		end

	frozen ec_illegal_36_ec_illegal_36_class_feature_arguments_generation_failed_message (current_: CODE_GENERATION_SUPPORT_ERROR_MESSAGES): STRING is
		external
			"IL static signature (CODE_GENERATION_SUPPORT_ERROR_MESSAGES): STRING use Implementation.CODE_GENERATION_SUPPORT_ERROR_MESSAGES"
		alias
			"$$class_feature_arguments_generation_failed_message"
		end

	class_header_generation_failed_message: STRING is
		external
			"IL signature (): STRING use Implementation.CODE_GENERATION_SUPPORT_ERROR_MESSAGES"
		alias
			"class_header_generation_failed_message"
		end

	read_lock_message: STRING is
		external
			"IL signature (): STRING use Implementation.CODE_GENERATION_SUPPORT_ERROR_MESSAGES"
		alias
			"read_lock_message"
		end

	tagged_out: STRING is
		external
			"IL signature (): STRING use Implementation.CODE_GENERATION_SUPPORT_ERROR_MESSAGES"
		alias
			"tagged_out"
		end

	class_parents_generation_failed_message: STRING is
		external
			"IL signature (): STRING use Implementation.CODE_GENERATION_SUPPORT_ERROR_MESSAGES"
		alias
			"class_parents_generation_failed_message"
		end

	frozen ec_illegal_36_ec_illegal_36_class_footer_generation_failed_message (current_: CODE_GENERATION_SUPPORT_ERROR_MESSAGES): STRING is
		external
			"IL static signature (CODE_GENERATION_SUPPORT_ERROR_MESSAGES): STRING use Implementation.CODE_GENERATION_SUPPORT_ERROR_MESSAGES"
		alias
			"$$class_footer_generation_failed_message"
		end

	default_: ANY is
		external
			"IL signature (): ANY use Implementation.CODE_GENERATION_SUPPORT_ERROR_MESSAGES"
		alias
			"default"
		end

	same_type (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.CODE_GENERATION_SUPPORT_ERROR_MESSAGES"
		alias
			"same_type"
		end

	do_nothing is
		external
			"IL signature (): System.Void use Implementation.CODE_GENERATION_SUPPORT_ERROR_MESSAGES"
		alias
			"do_nothing"
		end

	class_features_generation_failed: STRING is
		external
			"IL signature (): STRING use Implementation.CODE_GENERATION_SUPPORT_ERROR_MESSAGES"
		alias
			"class_features_generation_failed"
		end

	eiffel_assembly_generation_failed_message: STRING is
		external
			"IL signature (): STRING use Implementation.CODE_GENERATION_SUPPORT_ERROR_MESSAGES"
		alias
			"eiffel_assembly_generation_failed_message"
		end

	class_feature_assertions_generation_failed_message: STRING is
		external
			"IL signature (): STRING use Implementation.CODE_GENERATION_SUPPORT_ERROR_MESSAGES"
		alias
			"class_feature_assertions_generation_failed_message"
		end

	frozen ec_illegal_36_ec_illegal_36_write_lock (current_: CODE_GENERATION_SUPPORT_ERROR_MESSAGES): STRING is
		external
			"IL static signature (CODE_GENERATION_SUPPORT_ERROR_MESSAGES): STRING use Implementation.CODE_GENERATION_SUPPORT_ERROR_MESSAGES"
		alias
			"$$write_lock"
		end

	class_feature_comments_generation_failed: STRING is
		external
			"IL signature (): STRING use Implementation.CODE_GENERATION_SUPPORT_ERROR_MESSAGES"
		alias
			"class_feature_comments_generation_failed"
		end

	frozen ec_illegal_36_ec_illegal_36_class_feature_assertions_generation_failed_message (current_: CODE_GENERATION_SUPPORT_ERROR_MESSAGES): STRING is
		external
			"IL static signature (CODE_GENERATION_SUPPORT_ERROR_MESSAGES): STRING use Implementation.CODE_GENERATION_SUPPORT_ERROR_MESSAGES"
		alias
			"$$class_feature_assertions_generation_failed_message"
		end

	standard_is_equal (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.CODE_GENERATION_SUPPORT_ERROR_MESSAGES"
		alias
			"standard_is_equal"
		end

	generic_derivation_generation_failed_message: STRING is
		external
			"IL signature (): STRING use Implementation.CODE_GENERATION_SUPPORT_ERROR_MESSAGES"
		alias
			"generic_derivation_generation_failed_message"
		end

	write_lock_message: STRING is
		external
			"IL signature (): STRING use Implementation.CODE_GENERATION_SUPPORT_ERROR_MESSAGES"
		alias
			"write_lock_message"
		end

	class_feature_assertions_generation_failed: STRING is
		external
			"IL signature (): STRING use Implementation.CODE_GENERATION_SUPPORT_ERROR_MESSAGES"
		alias
			"class_feature_assertions_generation_failed"
		end

	class_features_generation_failed_message: STRING is
		external
			"IL signature (): STRING use Implementation.CODE_GENERATION_SUPPORT_ERROR_MESSAGES"
		alias
			"class_features_generation_failed_message"
		end

	frozen ec_illegal_36_ec_illegal_36_eiffel_class_generation_failed (current_: CODE_GENERATION_SUPPORT_ERROR_MESSAGES): STRING is
		external
			"IL static signature (CODE_GENERATION_SUPPORT_ERROR_MESSAGES): STRING use Implementation.CODE_GENERATION_SUPPORT_ERROR_MESSAGES"
		alias
			"$$eiffel_class_generation_failed"
		end

	eiffel_class_generation_failed_message: STRING is
		external
			"IL signature (): STRING use Implementation.CODE_GENERATION_SUPPORT_ERROR_MESSAGES"
		alias
			"eiffel_class_generation_failed_message"
		end

	class_parents_generation_failed: STRING is
		external
			"IL signature (): STRING use Implementation.CODE_GENERATION_SUPPORT_ERROR_MESSAGES"
		alias
			"class_parents_generation_failed"
		end

	default_pointer: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.CODE_GENERATION_SUPPORT_ERROR_MESSAGES"
		alias
			"default_pointer"
		end

	frozen ec_illegal_36_ec_illegal_36_class_header_generation_failed_message (current_: CODE_GENERATION_SUPPORT_ERROR_MESSAGES): STRING is
		external
			"IL static signature (CODE_GENERATION_SUPPORT_ERROR_MESSAGES): STRING use Implementation.CODE_GENERATION_SUPPORT_ERROR_MESSAGES"
		alias
			"$$class_header_generation_failed_message"
		end

	is_equal_ (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.CODE_GENERATION_SUPPORT_ERROR_MESSAGES"
		alias
			"is_equal"
		end

	class_feature_info_generation_failed_message: STRING is
		external
			"IL signature (): STRING use Implementation.CODE_GENERATION_SUPPORT_ERROR_MESSAGES"
		alias
			"class_feature_info_generation_failed_message"
		end

	frozen ec_illegal_36_ec_illegal_36_class_parents_generation_failed_message (current_: CODE_GENERATION_SUPPORT_ERROR_MESSAGES): STRING is
		external
			"IL static signature (CODE_GENERATION_SUPPORT_ERROR_MESSAGES): STRING use Implementation.CODE_GENERATION_SUPPORT_ERROR_MESSAGES"
		alias
			"$$class_parents_generation_failed_message"
		end

	print (some: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.CODE_GENERATION_SUPPORT_ERROR_MESSAGES"
		alias
			"print"
		end

	frozen ec_illegal_36_ec_illegal_36_class_feature_arguments_generation_failed (current_: CODE_GENERATION_SUPPORT_ERROR_MESSAGES): STRING is
		external
			"IL static signature (CODE_GENERATION_SUPPORT_ERROR_MESSAGES): STRING use Implementation.CODE_GENERATION_SUPPORT_ERROR_MESSAGES"
		alias
			"$$class_feature_arguments_generation_failed"
		end

	frozen ec_illegal_36_ec_illegal_36_class_features_generation_failed (current_: CODE_GENERATION_SUPPORT_ERROR_MESSAGES): STRING is
		external
			"IL static signature (CODE_GENERATION_SUPPORT_ERROR_MESSAGES): STRING use Implementation.CODE_GENERATION_SUPPORT_ERROR_MESSAGES"
		alias
			"$$class_features_generation_failed"
		end

	frozen ec_illegal_36_ec_illegal_36_read_lock (current_: CODE_GENERATION_SUPPORT_ERROR_MESSAGES): STRING is
		external
			"IL static signature (CODE_GENERATION_SUPPORT_ERROR_MESSAGES): STRING use Implementation.CODE_GENERATION_SUPPORT_ERROR_MESSAGES"
		alias
			"$$read_lock"
		end

	equal_ (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.CODE_GENERATION_SUPPORT_ERROR_MESSAGES"
		alias
			"equal"
		end

	frozen ec_illegal_36_ec_illegal_36_class_feature_assertions_generation_failed (current_: CODE_GENERATION_SUPPORT_ERROR_MESSAGES): STRING is
		external
			"IL static signature (CODE_GENERATION_SUPPORT_ERROR_MESSAGES): STRING use Implementation.CODE_GENERATION_SUPPORT_ERROR_MESSAGES"
		alias
			"$$class_feature_assertions_generation_failed"
		end

	clone_ (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.CODE_GENERATION_SUPPORT_ERROR_MESSAGES"
		alias
			"clone"
		end

	standard_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.CODE_GENERATION_SUPPORT_ERROR_MESSAGES"
		alias
			"standard_equal"
		end

	generic_derivation_generation_failed: STRING is
		external
			"IL signature (): STRING use Implementation.CODE_GENERATION_SUPPORT_ERROR_MESSAGES"
		alias
			"generic_derivation_generation_failed"
		end

	class_header_generation_failed: STRING is
		external
			"IL signature (): STRING use Implementation.CODE_GENERATION_SUPPORT_ERROR_MESSAGES"
		alias
			"class_header_generation_failed"
		end

	frozen ec_illegal_36_ec_illegal_36_class_footer_generation_failed (current_: CODE_GENERATION_SUPPORT_ERROR_MESSAGES): STRING is
		external
			"IL static signature (CODE_GENERATION_SUPPORT_ERROR_MESSAGES): STRING use Implementation.CODE_GENERATION_SUPPORT_ERROR_MESSAGES"
		alias
			"$$class_footer_generation_failed"
		end

	write_lock: STRING is
		external
			"IL signature (): STRING use Implementation.CODE_GENERATION_SUPPORT_ERROR_MESSAGES"
		alias
			"write_lock"
		end

	standard_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.CODE_GENERATION_SUPPORT_ERROR_MESSAGES"
		alias
			"standard_copy"
		end

	read_lock: STRING is
		external
			"IL signature (): STRING use Implementation.CODE_GENERATION_SUPPORT_ERROR_MESSAGES"
		alias
			"read_lock"
		end

	frozen ec_illegal_36_ec_illegal_36_class_body_generation_failed_message (current_: CODE_GENERATION_SUPPORT_ERROR_MESSAGES): STRING is
		external
			"IL static signature (CODE_GENERATION_SUPPORT_ERROR_MESSAGES): STRING use Implementation.CODE_GENERATION_SUPPORT_ERROR_MESSAGES"
		alias
			"$$class_body_generation_failed_message"
		end

	eiffel_assembly_generation_failed: STRING is
		external
			"IL signature (): STRING use Implementation.CODE_GENERATION_SUPPORT_ERROR_MESSAGES"
		alias
			"eiffel_assembly_generation_failed"
		end

	class_body_generation_failed: STRING is
		external
			"IL signature (): STRING use Implementation.CODE_GENERATION_SUPPORT_ERROR_MESSAGES"
		alias
			"class_body_generation_failed"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use Implementation.CODE_GENERATION_SUPPORT_ERROR_MESSAGES"
		alias
			"Equals"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.CODE_GENERATION_SUPPORT_ERROR_MESSAGES"
		alias
			"GetHashCode"
		end

	frozen ec_illegal_36_ec_illegal_36_class_feature_info_generation_failed_message (current_: CODE_GENERATION_SUPPORT_ERROR_MESSAGES): STRING is
		external
			"IL static signature (CODE_GENERATION_SUPPORT_ERROR_MESSAGES): STRING use Implementation.CODE_GENERATION_SUPPORT_ERROR_MESSAGES"
		alias
			"$$class_feature_info_generation_failed_message"
		end

	deep_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.CODE_GENERATION_SUPPORT_ERROR_MESSAGES"
		alias
			"deep_equal"
		end

	frozen ec_illegal_36_ec_illegal_36_class_feature_info_generation_failed (current_: CODE_GENERATION_SUPPORT_ERROR_MESSAGES): STRING is
		external
			"IL static signature (CODE_GENERATION_SUPPORT_ERROR_MESSAGES): STRING use Implementation.CODE_GENERATION_SUPPORT_ERROR_MESSAGES"
		alias
			"$$class_feature_info_generation_failed"
		end

	standard_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.CODE_GENERATION_SUPPORT_ERROR_MESSAGES"
		alias
			"standard_clone"
		end

	default_rescue is
		external
			"IL signature (): System.Void use Implementation.CODE_GENERATION_SUPPORT_ERROR_MESSAGES"
		alias
			"default_rescue"
		end

	class_feature_arguments_generation_failed: STRING is
		external
			"IL signature (): STRING use Implementation.CODE_GENERATION_SUPPORT_ERROR_MESSAGES"
		alias
			"class_feature_arguments_generation_failed"
		end

	internal_clone: ANY is
		external
			"IL signature (): ANY use Implementation.CODE_GENERATION_SUPPORT_ERROR_MESSAGES"
		alias
			"internal_clone"
		end

	generator: STRING is
		external
			"IL signature (): STRING use Implementation.CODE_GENERATION_SUPPORT_ERROR_MESSAGES"
		alias
			"generator"
		end

	frozen ec_illegal_36_ec_illegal_36_eiffel_class_generation_failed_message (current_: CODE_GENERATION_SUPPORT_ERROR_MESSAGES): STRING is
		external
			"IL static signature (CODE_GENERATION_SUPPORT_ERROR_MESSAGES): STRING use Implementation.CODE_GENERATION_SUPPORT_ERROR_MESSAGES"
		alias
			"$$eiffel_class_generation_failed_message"
		end

	internal_copy (o: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.CODE_GENERATION_SUPPORT_ERROR_MESSAGES"
		alias
			"internal_copy"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.CODE_GENERATION_SUPPORT_ERROR_MESSAGES"
		alias
			"ToString"
		end

	deep_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.CODE_GENERATION_SUPPORT_ERROR_MESSAGES"
		alias
			"deep_copy"
		end

	frozen ec_illegal_36_ec_illegal_36_class_parents_generation_failed (current_: CODE_GENERATION_SUPPORT_ERROR_MESSAGES): STRING is
		external
			"IL static signature (CODE_GENERATION_SUPPORT_ERROR_MESSAGES): STRING use Implementation.CODE_GENERATION_SUPPORT_ERROR_MESSAGES"
		alias
			"$$class_parents_generation_failed"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use Implementation.CODE_GENERATION_SUPPORT_ERROR_MESSAGES"
		alias
			"Finalize"
		end

end -- class IMPLEMENTATION_CODE_GENERATION_SUPPORT_ERROR_MESSAGES
