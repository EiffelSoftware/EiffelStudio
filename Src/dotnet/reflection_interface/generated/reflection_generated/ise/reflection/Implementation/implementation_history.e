indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "Implementation.HISTORY"

external class
	IMPLEMENTATION_HISTORY

inherit
	REFLECTION_INTERFACE_SUPPORT
	HISTORY
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

create
	make1

feature {NONE} -- Initialization

	frozen make1 is
		external
			"IL creator use Implementation.HISTORY"
		end

feature -- Access

	frozen ec_illegal_36_ec_illegal_36_assemblies_table: HASH_TABLE_ANY_ANY is
		external
			"IL field signature :HASH_TABLE_ANY_ANY use Implementation.HISTORY"
		alias
			"$$assemblies_table"
		end

	frozen ec_illegal_36_ec_illegal_36_search_for_type_result: EIFFEL_CLASS is
		external
			"IL field signature :EIFFEL_CLASS use Implementation.HISTORY"
		alias
			"$$search_for_type_result"
		end

	frozen ec_illegal_36_ec_illegal_36_type_found: BOOLEAN is
		external
			"IL field signature :System.Boolean use Implementation.HISTORY"
		alias
			"$$type_found"
		end

	frozen ec_illegal_36_ec_illegal_36_search_for_assembly_result: EIFFEL_ASSEMBLY is
		external
			"IL field signature :EIFFEL_ASSEMBLY use Implementation.HISTORY"
		alias
			"$$search_for_assembly_result"
		end

	frozen ec_illegal_36_ec_illegal_36_types_table: HASH_TABLE_ANY_INT32 is
		external
			"IL field signature :HASH_TABLE_ANY_INT32 use Implementation.HISTORY"
		alias
			"$$types_table"
		end

	frozen ec_illegal_36_ec_illegal_36_assembly_found: BOOLEAN is
		external
			"IL field signature :System.Boolean use Implementation.HISTORY"
		alias
			"$$assembly_found"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.HISTORY"
		alias
			"GetHashCode"
		end

	deep_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.HISTORY"
		alias
			"deep_clone"
		end

	frozen ec_illegal_36_ec_illegal_36_maximum_count (current_: HISTORY): INTEGER is
		external
			"IL static signature (HISTORY): System.Int32 use Implementation.HISTORY"
		alias
			"$$maximum_count"
		end

	a_set_types_table (types_table2: HASH_TABLE_ANY_INT32) is
		external
			"IL signature (HASH_TABLE_ANY_INT32): System.Void use Implementation.HISTORY"
		alias
			"_set_types_table"
		end

	tagged_out: STRING is
		external
			"IL signature (): STRING use Implementation.HISTORY"
		alias
			"tagged_out"
		end

	frozen ec_illegal_36_ec_illegal_36_add_assembly (current_: HISTORY; a_descriptor: ASSEMBLY_DESCRIPTOR; an_eiffel_assembly: EIFFEL_ASSEMBLY) is
		external
			"IL static signature (HISTORY, ASSEMBLY_DESCRIPTOR, EIFFEL_ASSEMBLY): System.Void use Implementation.HISTORY"
		alias
			"$$add_assembly"
		end

	internal_clone: ANY is
		external
			"IL signature (): ANY use Implementation.HISTORY"
		alias
			"internal_clone"
		end

	operating_environment: OPERATING_ENVIRONMENT is
		external
			"IL signature (): OPERATING_ENVIRONMENT use Implementation.HISTORY"
		alias
			"operating_environment"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.HISTORY"
		alias
			"ToString"
		end

	standard_is_equal (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.HISTORY"
		alias
			"standard_is_equal"
		end

	is_equal_ (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.HISTORY"
		alias
			"is_equal"
		end

	a_set_search_for_assembly_result (search_for_assembly_result2: EIFFEL_ASSEMBLY) is
		external
			"IL signature (EIFFEL_ASSEMBLY): System.Void use Implementation.HISTORY"
		alias
			"_set_search_for_assembly_result"
		end

	from_support_string (string: STRING): STRING is
		external
			"IL signature (STRING): STRING use Implementation.HISTORY"
		alias
			"from_support_string"
		end

	standard_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.HISTORY"
		alias
			"standard_equal"
		end

	same_type (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.HISTORY"
		alias
			"same_type"
		end

	has_type (a_type: TYPE): BOOLEAN is
		external
			"IL signature (System.Type): System.Boolean use Implementation.HISTORY"
		alias
			"has_type"
		end

	generator: STRING is
		external
			"IL signature (): STRING use Implementation.HISTORY"
		alias
			"generator"
		end

	to_handler_string (string: STRING): STRING is
		external
			"IL signature (STRING): STRING use Implementation.HISTORY"
		alias
			"to_handler_string"
		end

	internal_copy (o: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.HISTORY"
		alias
			"internal_copy"
		end

	from_generator_string (string: STRING): STRING is
		external
			"IL signature (STRING): STRING use Implementation.HISTORY"
		alias
			"from_generator_string"
		end

	type_found: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.HISTORY"
		alias
			"type_found"
		end

	standard_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.HISTORY"
		alias
			"standard_clone"
		end

	has_assembly (a_descriptor: ASSEMBLY_DESCRIPTOR): BOOLEAN is
		external
			"IL signature (ASSEMBLY_DESCRIPTOR): System.Boolean use Implementation.HISTORY"
		alias
			"has_assembly"
		end

	equal_ (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.HISTORY"
		alias
			"equal"
		end

	search_for_assembly_result: EIFFEL_ASSEMBLY is
		external
			"IL signature (): EIFFEL_ASSEMBLY use Implementation.HISTORY"
		alias
			"search_for_assembly_result"
		end

	frozen ec_illegal_36_ec_illegal_36_has_assembly (current_: HISTORY; a_descriptor: ASSEMBLY_DESCRIPTOR): BOOLEAN is
		external
			"IL static signature (HISTORY, ASSEMBLY_DESCRIPTOR): System.Boolean use Implementation.HISTORY"
		alias
			"$$has_assembly"
		end

	a_set_assembly_found (assembly_found2: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Implementation.HISTORY"
		alias
			"_set_assembly_found"
		end

	maximum_count: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.HISTORY"
		alias
			"maximum_count"
		end

	frozen a____class_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.HISTORY"
		alias
			"____class_name"
		end

	do_nothing is
		external
			"IL signature (): System.Void use Implementation.HISTORY"
		alias
			"do_nothing"
		end

	out_: STRING is
		external
			"IL signature (): STRING use Implementation.HISTORY"
		alias
			"out"
		end

	default_rescue is
		external
			"IL signature (): System.Void use Implementation.HISTORY"
		alias
			"default_rescue"
		end

	default_pointer: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.HISTORY"
		alias
			"default_pointer"
		end

	search_for_assembly (a_descriptor: ASSEMBLY_DESCRIPTOR) is
		external
			"IL signature (ASSEMBLY_DESCRIPTOR): System.Void use Implementation.HISTORY"
		alias
			"search_for_assembly"
		end

	to_component_string (string: STRING): STRING is
		external
			"IL signature (STRING): STRING use Implementation.HISTORY"
		alias
			"to_component_string"
		end

	standard_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.HISTORY"
		alias
			"standard_copy"
		end

	frozen ec_illegal_36_ec_illegal_36_search_for_type (current_: HISTORY; a_type: TYPE) is
		external
			"IL static signature (HISTORY, System.Type): System.Void use Implementation.HISTORY"
		alias
			"$$search_for_type"
		end

	to_generator_string (string: STRING): STRING is
		external
			"IL signature (STRING): STRING use Implementation.HISTORY"
		alias
			"to_generator_string"
		end

	from_system_string (string: SYSTEM_STRING): STRING is
		external
			"IL signature (System.String): STRING use Implementation.HISTORY"
		alias
			"from_system_string"
		end

	default_: ANY is
		external
			"IL signature (): ANY use Implementation.HISTORY"
		alias
			"default"
		end

	a_set_search_for_type_result (search_for_type_result2: EIFFEL_CLASS) is
		external
			"IL signature (EIFFEL_CLASS): System.Void use Implementation.HISTORY"
		alias
			"_set_search_for_type_result"
		end

	deep_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.HISTORY"
		alias
			"deep_equal"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use Implementation.HISTORY"
		alias
			"Equals"
		end

	add_type (a_type: TYPE; an_eiffel_class: EIFFEL_CLASS) is
		external
			"IL signature (System.Type, EIFFEL_CLASS): System.Void use Implementation.HISTORY"
		alias
			"add_type"
		end

	add_assembly (a_descriptor: ASSEMBLY_DESCRIPTOR; an_eiffel_assembly: EIFFEL_ASSEMBLY) is
		external
			"IL signature (ASSEMBLY_DESCRIPTOR, EIFFEL_ASSEMBLY): System.Void use Implementation.HISTORY"
		alias
			"add_assembly"
		end

	search_for_type (a_type: TYPE) is
		external
			"IL signature (System.Type): System.Void use Implementation.HISTORY"
		alias
			"search_for_type"
		end

	types_table: HASH_TABLE_ANY_INT32 is
		external
			"IL signature (): HASH_TABLE_ANY_INT32 use Implementation.HISTORY"
		alias
			"types_table"
		end

	search_for_type_result: EIFFEL_CLASS is
		external
			"IL signature (): EIFFEL_CLASS use Implementation.HISTORY"
		alias
			"search_for_type_result"
		end

	frozen ec_illegal_36_ec_illegal_36_add_type (current_: HISTORY; a_type: TYPE; an_eiffel_class: EIFFEL_CLASS) is
		external
			"IL static signature (HISTORY, System.Type, EIFFEL_CLASS): System.Void use Implementation.HISTORY"
		alias
			"$$add_type"
		end

	generating_type: STRING is
		external
			"IL signature (): STRING use Implementation.HISTORY"
		alias
			"generating_type"
		end

	assembly_found: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.HISTORY"
		alias
			"assembly_found"
		end

	frozen ec_illegal_36_ec_illegal_36_make (current_: HISTORY) is
		external
			"IL static signature (HISTORY): System.Void use Implementation.HISTORY"
		alias
			"$$make"
		end

	to_notifier_string (string: STRING): STRING is
		external
			"IL signature (STRING): STRING use Implementation.HISTORY"
		alias
			"to_notifier_string"
		end

	frozen ec_illegal_36_ec_illegal_36_search_for_assembly (current_: HISTORY; a_descriptor: ASSEMBLY_DESCRIPTOR) is
		external
			"IL static signature (HISTORY, ASSEMBLY_DESCRIPTOR): System.Void use Implementation.HISTORY"
		alias
			"$$search_for_assembly"
		end

	from_notifier_string (string: STRING): STRING is
		external
			"IL signature (STRING): STRING use Implementation.HISTORY"
		alias
			"from_notifier_string"
		end

	default_create_ is
		external
			"IL signature (): System.Void use Implementation.HISTORY"
		alias
			"default_create"
		end

	io: STD_FILES is
		external
			"IL signature (): STD_FILES use Implementation.HISTORY"
		alias
			"io"
		end

	from_handler_string (string: STRING): STRING is
		external
			"IL signature (STRING): STRING use Implementation.HISTORY"
		alias
			"from_handler_string"
		end

	clone_ (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.HISTORY"
		alias
			"clone"
		end

	to_support_string (string: STRING): STRING is
		external
			"IL signature (STRING): STRING use Implementation.HISTORY"
		alias
			"to_support_string"
		end

	a_set_type_found (type_found2: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Implementation.HISTORY"
		alias
			"_set_type_found"
		end

	frozen ec_illegal_36_ec_illegal_36_has_type (current_: HISTORY; a_type: TYPE): BOOLEAN is
		external
			"IL static signature (HISTORY, System.Type): System.Boolean use Implementation.HISTORY"
		alias
			"$$has_type"
		end

	deep_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.HISTORY"
		alias
			"deep_copy"
		end

	copy_ (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.HISTORY"
		alias
			"copy"
		end

	conforms_to (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.HISTORY"
		alias
			"conforms_to"
		end

	a_set_assemblies_table (assemblies_table2: HASH_TABLE_ANY_ANY) is
		external
			"IL signature (HASH_TABLE_ANY_ANY): System.Void use Implementation.HISTORY"
		alias
			"_set_assemblies_table"
		end

	make is
		external
			"IL signature (): System.Void use Implementation.HISTORY"
		alias
			"make"
		end

	from_component_string (string: STRING): STRING is
		external
			"IL signature (STRING): STRING use Implementation.HISTORY"
		alias
			"from_component_string"
		end

	print (some: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.HISTORY"
		alias
			"print"
		end

	assemblies_table: HASH_TABLE_ANY_ANY is
		external
			"IL signature (): HASH_TABLE_ANY_ANY use Implementation.HISTORY"
		alias
			"assemblies_table"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use Implementation.HISTORY"
		alias
			"Finalize"
		end

end -- class IMPLEMENTATION_HISTORY
