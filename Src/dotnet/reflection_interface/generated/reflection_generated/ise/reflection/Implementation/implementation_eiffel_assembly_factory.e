indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "Implementation.EIFFEL_ASSEMBLY_FACTORY"

external class
	IMPLEMENTATION_EIFFEL_ASSEMBLY_FACTORY

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	EIFFEL_ASSEMBLY_FACTORY

create
	make1

feature {NONE} -- Initialization

	frozen make1 is
		external
			"IL creator use Implementation.EIFFEL_ASSEMBLY_FACTORY"
		end

feature -- Access

	frozen ec_illegal_36_ec_illegal_36_assembly_culture: STRING is
		external
			"IL field signature :STRING use Implementation.EIFFEL_ASSEMBLY_FACTORY"
		alias
			"$$assembly_culture"
		end

	frozen ec_illegal_36_ec_illegal_36_assembly_version: STRING is
		external
			"IL field signature :STRING use Implementation.EIFFEL_ASSEMBLY_FACTORY"
		alias
			"$$assembly_version"
		end

	frozen ec_illegal_36_ec_illegal_36_assembly_public_key: STRING is
		external
			"IL field signature :STRING use Implementation.EIFFEL_ASSEMBLY_FACTORY"
		alias
			"$$assembly_public_key"
		end

	frozen ec_illegal_36_ec_illegal_36_eiffel_cluster_path: STRING is
		external
			"IL field signature :STRING use Implementation.EIFFEL_ASSEMBLY_FACTORY"
		alias
			"$$eiffel_cluster_path"
		end

	frozen ec_illegal_36_ec_illegal_36_emitter_version_number: STRING is
		external
			"IL field signature :STRING use Implementation.EIFFEL_ASSEMBLY_FACTORY"
		alias
			"$$emitter_version_number"
		end

	frozen ec_illegal_36_ec_illegal_36_assembly_name: STRING is
		external
			"IL field signature :STRING use Implementation.EIFFEL_ASSEMBLY_FACTORY"
		alias
			"$$assembly_name"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.EIFFEL_ASSEMBLY_FACTORY"
		alias
			"GetHashCode"
		end

	deep_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.EIFFEL_ASSEMBLY_FACTORY"
		alias
			"deep_clone"
		end

	a_set_assembly_public_key (assembly_public_key2: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.EIFFEL_ASSEMBLY_FACTORY"
		alias
			"_set_assembly_public_key"
		end

	set_assembly_culture (a_culture: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.EIFFEL_ASSEMBLY_FACTORY"
		alias
			"set_assembly_culture"
		end

	do_nothing is
		external
			"IL signature (): System.Void use Implementation.EIFFEL_ASSEMBLY_FACTORY"
		alias
			"do_nothing"
		end

	frozen ec_illegal_36_ec_illegal_36_set_eiffel_cluster_path (current_: EIFFEL_ASSEMBLY_FACTORY; a_path: STRING) is
		external
			"IL static signature (EIFFEL_ASSEMBLY_FACTORY, STRING): System.Void use Implementation.EIFFEL_ASSEMBLY_FACTORY"
		alias
			"$$set_eiffel_cluster_path"
		end

	tagged_out: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_FACTORY"
		alias
			"tagged_out"
		end

	internal_clone: ANY is
		external
			"IL signature (): ANY use Implementation.EIFFEL_ASSEMBLY_FACTORY"
		alias
			"internal_clone"
		end

	operating_environment: OPERATING_ENVIRONMENT is
		external
			"IL signature (): OPERATING_ENVIRONMENT use Implementation.EIFFEL_ASSEMBLY_FACTORY"
		alias
			"operating_environment"
		end

	frozen ec_illegal_36_ec_illegal_36_set_assembly_version (current_: EIFFEL_ASSEMBLY_FACTORY; a_version: STRING) is
		external
			"IL static signature (EIFFEL_ASSEMBLY_FACTORY, STRING): System.Void use Implementation.EIFFEL_ASSEMBLY_FACTORY"
		alias
			"$$set_assembly_version"
		end

	standard_is_equal (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.EIFFEL_ASSEMBLY_FACTORY"
		alias
			"standard_is_equal"
		end

	is_equal_ (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.EIFFEL_ASSEMBLY_FACTORY"
		alias
			"is_equal"
		end

	assembly_version: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_FACTORY"
		alias
			"assembly_version"
		end

	standard_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.EIFFEL_ASSEMBLY_FACTORY"
		alias
			"standard_equal"
		end

	same_type (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.EIFFEL_ASSEMBLY_FACTORY"
		alias
			"same_type"
		end

	frozen ec_illegal_36_ec_illegal_36_set_assembly_public_key (current_: EIFFEL_ASSEMBLY_FACTORY; a_public_key: STRING) is
		external
			"IL static signature (EIFFEL_ASSEMBLY_FACTORY, STRING): System.Void use Implementation.EIFFEL_ASSEMBLY_FACTORY"
		alias
			"$$set_assembly_public_key"
		end

	generator: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_FACTORY"
		alias
			"generator"
		end

	internal_copy (o: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.EIFFEL_ASSEMBLY_FACTORY"
		alias
			"internal_copy"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use Implementation.EIFFEL_ASSEMBLY_FACTORY"
		alias
			"Equals"
		end

	assembly_culture: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_FACTORY"
		alias
			"assembly_culture"
		end

	a_set_eiffel_cluster_path (eiffel_cluster_path2: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.EIFFEL_ASSEMBLY_FACTORY"
		alias
			"_set_eiffel_cluster_path"
		end

	standard_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.EIFFEL_ASSEMBLY_FACTORY"
		alias
			"standard_clone"
		end

	a_set_assembly_culture (assembly_culture2: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.EIFFEL_ASSEMBLY_FACTORY"
		alias
			"_set_assembly_culture"
		end

	equal_ (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.EIFFEL_ASSEMBLY_FACTORY"
		alias
			"equal"
		end

	frozen a____class_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.EIFFEL_ASSEMBLY_FACTORY"
		alias
			"____class_name"
		end

	set_assembly_public_key (a_public_key: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.EIFFEL_ASSEMBLY_FACTORY"
		alias
			"set_assembly_public_key"
		end

	out_: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_FACTORY"
		alias
			"out"
		end

	default_rescue is
		external
			"IL signature (): System.Void use Implementation.EIFFEL_ASSEMBLY_FACTORY"
		alias
			"default_rescue"
		end

	default_pointer: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.EIFFEL_ASSEMBLY_FACTORY"
		alias
			"default_pointer"
		end

	set_eiffel_cluster_path (a_path: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.EIFFEL_ASSEMBLY_FACTORY"
		alias
			"set_eiffel_cluster_path"
		end

	standard_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.EIFFEL_ASSEMBLY_FACTORY"
		alias
			"standard_copy"
		end

	frozen ec_illegal_36_ec_illegal_36_set_assembly_name (current_: EIFFEL_ASSEMBLY_FACTORY; a_name: STRING) is
		external
			"IL static signature (EIFFEL_ASSEMBLY_FACTORY, STRING): System.Void use Implementation.EIFFEL_ASSEMBLY_FACTORY"
		alias
			"$$set_assembly_name"
		end

	set_assembly_name (a_name: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.EIFFEL_ASSEMBLY_FACTORY"
		alias
			"set_assembly_name"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.EIFFEL_ASSEMBLY_FACTORY"
		alias
			"ToString"
		end

	default_: ANY is
		external
			"IL signature (): ANY use Implementation.EIFFEL_ASSEMBLY_FACTORY"
		alias
			"default"
		end

	frozen ec_illegal_36_ec_illegal_36_set_assembly_culture (current_: EIFFEL_ASSEMBLY_FACTORY; a_culture: STRING) is
		external
			"IL static signature (EIFFEL_ASSEMBLY_FACTORY, STRING): System.Void use Implementation.EIFFEL_ASSEMBLY_FACTORY"
		alias
			"$$set_assembly_culture"
		end

	deep_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.EIFFEL_ASSEMBLY_FACTORY"
		alias
			"deep_equal"
		end

	set_emitter_version_number (a_value: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.EIFFEL_ASSEMBLY_FACTORY"
		alias
			"set_emitter_version_number"
		end

	assembly_public_key: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_FACTORY"
		alias
			"assembly_public_key"
		end

	a_set_emitter_version_number (emitter_version_number2: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.EIFFEL_ASSEMBLY_FACTORY"
		alias
			"_set_emitter_version_number"
		end

	a_set_assembly_name (assembly_name2: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.EIFFEL_ASSEMBLY_FACTORY"
		alias
			"_set_assembly_name"
		end

	generating_type: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_FACTORY"
		alias
			"generating_type"
		end

	set_assembly_version (a_version: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.EIFFEL_ASSEMBLY_FACTORY"
		alias
			"set_assembly_version"
		end

	assembly_name: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_FACTORY"
		alias
			"assembly_name"
		end

	default_create_ is
		external
			"IL signature (): System.Void use Implementation.EIFFEL_ASSEMBLY_FACTORY"
		alias
			"default_create"
		end

	io: STD_FILES is
		external
			"IL signature (): STD_FILES use Implementation.EIFFEL_ASSEMBLY_FACTORY"
		alias
			"io"
		end

	a_set_assembly_version (assembly_version2: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.EIFFEL_ASSEMBLY_FACTORY"
		alias
			"_set_assembly_version"
		end

	clone_ (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.EIFFEL_ASSEMBLY_FACTORY"
		alias
			"clone"
		end

	eiffel_cluster_path: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_FACTORY"
		alias
			"eiffel_cluster_path"
		end

	deep_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.EIFFEL_ASSEMBLY_FACTORY"
		alias
			"deep_copy"
		end

	copy_ (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.EIFFEL_ASSEMBLY_FACTORY"
		alias
			"copy"
		end

	conforms_to (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.EIFFEL_ASSEMBLY_FACTORY"
		alias
			"conforms_to"
		end

	frozen ec_illegal_36_ec_illegal_36_set_emitter_version_number (current_: EIFFEL_ASSEMBLY_FACTORY; a_value: STRING) is
		external
			"IL static signature (EIFFEL_ASSEMBLY_FACTORY, STRING): System.Void use Implementation.EIFFEL_ASSEMBLY_FACTORY"
		alias
			"$$set_emitter_version_number"
		end

	frozen ec_illegal_36_ec_illegal_36_make (current_: EIFFEL_ASSEMBLY_FACTORY) is
		external
			"IL static signature (EIFFEL_ASSEMBLY_FACTORY): System.Void use Implementation.EIFFEL_ASSEMBLY_FACTORY"
		alias
			"$$make"
		end

	make is
		external
			"IL signature (): System.Void use Implementation.EIFFEL_ASSEMBLY_FACTORY"
		alias
			"make"
		end

	emitter_version_number: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_ASSEMBLY_FACTORY"
		alias
			"emitter_version_number"
		end

	print (some: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.EIFFEL_ASSEMBLY_FACTORY"
		alias
			"print"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use Implementation.EIFFEL_ASSEMBLY_FACTORY"
		alias
			"Finalize"
		end

end -- class IMPLEMENTATION_EIFFEL_ASSEMBLY_FACTORY
