indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "Implementation.ROOT_CLASS"

external class
	IMPLEMENTATION_ROOT_CLASS

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	ROOT_CLASS

create
	make1

feature {NONE} -- Initialization

	frozen make1 is
		external
			"IL creator use Implementation.ROOT_CLASS"
		end

feature -- Access

	frozen ec_illegal_36_ec_illegal_36_ise_reflection_eiffel_assembly_cache_notifier: NOTIFIER_HANDLE is
		external
			"IL field signature :NOTIFIER_HANDLE use Implementation.ROOT_CLASS"
		alias
			"$$ise_reflection_eiffel_assembly_cache_notifier"
		end

	frozen ec_illegal_36_ec_illegal_36_ise_reflection_code_generator: GENERATOR is
		external
			"IL field signature :GENERATOR use Implementation.ROOT_CLASS"
		alias
			"$$ise_reflection_code_generator"
		end

	frozen ec_illegal_36_ec_illegal_36_ise_reflection_eiffel_assembly_cache_handler: EIFFEL_ASSEMBLY_CACHE_HANDLER is
		external
			"IL field signature :EIFFEL_ASSEMBLY_CACHE_HANDLER use Implementation.ROOT_CLASS"
		alias
			"$$ise_reflection_eiffel_assembly_cache_handler"
		end

	frozen ec_illegal_36_ec_illegal_36_ise_reflection_reflection_interface: REFLECTION_INTERFACE is
		external
			"IL field signature :REFLECTION_INTERFACE use Implementation.ROOT_CLASS"
		alias
			"$$ise_reflection_reflection_interface"
		end

	frozen ec_illegal_36_ec_illegal_36_ise_reflection_support: SUPPORTS is
		external
			"IL field signature :SUPPORTS use Implementation.ROOT_CLASS"
		alias
			"$$ise_reflection_support"
		end

	frozen ec_illegal_36_ec_illegal_36_ise_reflection_eiffel_components: EIFFEL_COMPONENTS is
		external
			"IL field signature :EIFFEL_COMPONENTS use Implementation.ROOT_CLASS"
		alias
			"$$ise_reflection_eiffel_components"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.ROOT_CLASS"
		alias
			"GetHashCode"
		end

	deep_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.ROOT_CLASS"
		alias
			"deep_clone"
		end

	tagged_out: STRING is
		external
			"IL signature (): STRING use Implementation.ROOT_CLASS"
		alias
			"tagged_out"
		end

	internal_clone: ANY is
		external
			"IL signature (): ANY use Implementation.ROOT_CLASS"
		alias
			"internal_clone"
		end

	operating_environment: OPERATING_ENVIRONMENT is
		external
			"IL signature (): OPERATING_ENVIRONMENT use Implementation.ROOT_CLASS"
		alias
			"operating_environment"
		end

	ise_reflection_eiffel_assembly_cache_handler: EIFFEL_ASSEMBLY_CACHE_HANDLER is
		external
			"IL signature (): EIFFEL_ASSEMBLY_CACHE_HANDLER use Implementation.ROOT_CLASS"
		alias
			"ise_reflection_eiffel_assembly_cache_handler"
		end

	standard_is_equal (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.ROOT_CLASS"
		alias
			"standard_is_equal"
		end

	is_equal_ (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.ROOT_CLASS"
		alias
			"is_equal"
		end

	ise_reflection_support: SUPPORTS is
		external
			"IL signature (): SUPPORTS use Implementation.ROOT_CLASS"
		alias
			"ise_reflection_support"
		end

	standard_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.ROOT_CLASS"
		alias
			"standard_equal"
		end

	same_type (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.ROOT_CLASS"
		alias
			"same_type"
		end

	ise_reflection_reflection_interface: REFLECTION_INTERFACE is
		external
			"IL signature (): REFLECTION_INTERFACE use Implementation.ROOT_CLASS"
		alias
			"ise_reflection_reflection_interface"
		end

	generator: STRING is
		external
			"IL signature (): STRING use Implementation.ROOT_CLASS"
		alias
			"generator"
		end

	internal_copy (o: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.ROOT_CLASS"
		alias
			"internal_copy"
		end

	clone_ (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.ROOT_CLASS"
		alias
			"clone"
		end

	a_set_ise_reflection_code_generator (ise_reflection_code_generator2: GENERATOR) is
		external
			"IL signature (GENERATOR): System.Void use Implementation.ROOT_CLASS"
		alias
			"_set_ise_reflection_code_generator"
		end

	standard_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.ROOT_CLASS"
		alias
			"standard_clone"
		end

	a_set_ise_reflection_eiffel_assembly_cache_handler (ise_reflection_eiffel_assembly_cache_handler2: EIFFEL_ASSEMBLY_CACHE_HANDLER) is
		external
			"IL signature (EIFFEL_ASSEMBLY_CACHE_HANDLER): System.Void use Implementation.ROOT_CLASS"
		alias
			"_set_ise_reflection_eiffel_assembly_cache_handler"
		end

	equal_ (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.ROOT_CLASS"
		alias
			"equal"
		end

	ise_reflection_eiffel_assembly_cache_notifier: NOTIFIER_HANDLE is
		external
			"IL signature (): NOTIFIER_HANDLE use Implementation.ROOT_CLASS"
		alias
			"ise_reflection_eiffel_assembly_cache_notifier"
		end

	frozen a____class_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.ROOT_CLASS"
		alias
			"____class_name"
		end

	do_nothing is
		external
			"IL signature (): System.Void use Implementation.ROOT_CLASS"
		alias
			"do_nothing"
		end

	out_: STRING is
		external
			"IL signature (): STRING use Implementation.ROOT_CLASS"
		alias
			"out"
		end

	default_rescue is
		external
			"IL signature (): System.Void use Implementation.ROOT_CLASS"
		alias
			"default_rescue"
		end

	default_pointer: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.ROOT_CLASS"
		alias
			"default_pointer"
		end

	a_set_ise_reflection_eiffel_components (ise_reflection_eiffel_components2: EIFFEL_COMPONENTS) is
		external
			"IL signature (EIFFEL_COMPONENTS): System.Void use Implementation.ROOT_CLASS"
		alias
			"_set_ise_reflection_eiffel_components"
		end

	standard_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.ROOT_CLASS"
		alias
			"standard_copy"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.ROOT_CLASS"
		alias
			"ToString"
		end

	default_: ANY is
		external
			"IL signature (): ANY use Implementation.ROOT_CLASS"
		alias
			"default"
		end

	deep_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.ROOT_CLASS"
		alias
			"deep_equal"
		end

	ise_reflection_eiffel_components: EIFFEL_COMPONENTS is
		external
			"IL signature (): EIFFEL_COMPONENTS use Implementation.ROOT_CLASS"
		alias
			"ise_reflection_eiffel_components"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use Implementation.ROOT_CLASS"
		alias
			"Equals"
		end

	a_set_ise_reflection_support (ise_reflection_support2: SUPPORTS) is
		external
			"IL signature (SUPPORTS): System.Void use Implementation.ROOT_CLASS"
		alias
			"_set_ise_reflection_support"
		end

	a_set_ise_reflection_eiffel_assembly_cache_notifier (ise_reflection_eiffel_assembly_cache_notifier2: NOTIFIER_HANDLE) is
		external
			"IL signature (NOTIFIER_HANDLE): System.Void use Implementation.ROOT_CLASS"
		alias
			"_set_ise_reflection_eiffel_assembly_cache_notifier"
		end

	generating_type: STRING is
		external
			"IL signature (): STRING use Implementation.ROOT_CLASS"
		alias
			"generating_type"
		end

	ise_reflection_code_generator: GENERATOR is
		external
			"IL signature (): GENERATOR use Implementation.ROOT_CLASS"
		alias
			"ise_reflection_code_generator"
		end

	default_create_ is
		external
			"IL signature (): System.Void use Implementation.ROOT_CLASS"
		alias
			"default_create"
		end

	io: STD_FILES is
		external
			"IL signature (): STD_FILES use Implementation.ROOT_CLASS"
		alias
			"io"
		end

	a_set_ise_reflection_reflection_interface (ise_reflection_reflection_interface2: REFLECTION_INTERFACE) is
		external
			"IL signature (REFLECTION_INTERFACE): System.Void use Implementation.ROOT_CLASS"
		alias
			"_set_ise_reflection_reflection_interface"
		end

	deep_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.ROOT_CLASS"
		alias
			"deep_copy"
		end

	copy_ (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.ROOT_CLASS"
		alias
			"copy"
		end

	conforms_to (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.ROOT_CLASS"
		alias
			"conforms_to"
		end

	frozen ec_illegal_36_ec_illegal_36_make (current_: ROOT_CLASS) is
		external
			"IL static signature (ROOT_CLASS): System.Void use Implementation.ROOT_CLASS"
		alias
			"$$make"
		end

	make is
		external
			"IL signature (): System.Void use Implementation.ROOT_CLASS"
		alias
			"make"
		end

	print (some: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.ROOT_CLASS"
		alias
			"print"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use Implementation.ROOT_CLASS"
		alias
			"Finalize"
		end

end -- class IMPLEMENTATION_ROOT_CLASS
