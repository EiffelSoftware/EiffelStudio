indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "Implementation.RESIZABLE_ANY"

deferred external class
	IMPLEMENTATION_RESIZABLE_ANY

inherit
	BOX_ANY
	CONTAINER_ANY
	BOUNDED_ANY
	RESIZABLE_ANY
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	FINITE_ANY

feature -- Access

	frozen ec_illegal_36_ec_illegal_36_object_comparison: BOOLEAN is
		external
			"IL field signature :System.Boolean use Implementation.RESIZABLE_ANY"
		alias
			"$$object_comparison"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.RESIZABLE_ANY"
		alias
			"GetHashCode"
		end

	deep_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.RESIZABLE_ANY"
		alias
			"deep_clone"
		end

	a_set_object_comparison (object_comparison2: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Implementation.RESIZABLE_ANY"
		alias
			"_set_object_comparison"
		end

	compare_references is
		external
			"IL signature (): System.Void use Implementation.RESIZABLE_ANY"
		alias
			"compare_references"
		end

	tagged_out: STRING is
		external
			"IL signature (): STRING use Implementation.RESIZABLE_ANY"
		alias
			"tagged_out"
		end

	internal_clone: ANY is
		external
			"IL signature (): ANY use Implementation.RESIZABLE_ANY"
		alias
			"internal_clone"
		end

	operating_environment: OPERATING_ENVIRONMENT is
		external
			"IL signature (): OPERATING_ENVIRONMENT use Implementation.RESIZABLE_ANY"
		alias
			"operating_environment"
		end

	standard_is_equal (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.RESIZABLE_ANY"
		alias
			"standard_is_equal"
		end

	is_equal_ (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.RESIZABLE_ANY"
		alias
			"is_equal"
		end

	standard_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.RESIZABLE_ANY"
		alias
			"standard_equal"
		end

	same_type (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.RESIZABLE_ANY"
		alias
			"same_type"
		end

	empty: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.RESIZABLE_ANY"
		alias
			"empty"
		end

	generator: STRING is
		external
			"IL signature (): STRING use Implementation.RESIZABLE_ANY"
		alias
			"generator"
		end

	changeable_comparison_criterion: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.RESIZABLE_ANY"
		alias
			"changeable_comparison_criterion"
		end

	internal_copy (o: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.RESIZABLE_ANY"
		alias
			"internal_copy"
		end

	compare_objects is
		external
			"IL signature (): System.Void use Implementation.RESIZABLE_ANY"
		alias
			"compare_objects"
		end

	standard_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.RESIZABLE_ANY"
		alias
			"standard_clone"
		end

	frozen ec_illegal_36_ec_illegal_36_automatic_grow (current_: RESIZABLE_ANY) is
		external
			"IL static signature (RESIZABLE_ANY): System.Void use Implementation.RESIZABLE_ANY"
		alias
			"$$automatic_grow"
		end

	equal_ (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.RESIZABLE_ANY"
		alias
			"equal"
		end

	is_empty: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.RESIZABLE_ANY"
		alias
			"is_empty"
		end

	frozen a____class_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.RESIZABLE_ANY"
		alias
			"____class_name"
		end

	do_nothing is
		external
			"IL signature (): System.Void use Implementation.RESIZABLE_ANY"
		alias
			"do_nothing"
		end

	out_: STRING is
		external
			"IL signature (): STRING use Implementation.RESIZABLE_ANY"
		alias
			"out"
		end

	default_rescue is
		external
			"IL signature (): System.Void use Implementation.RESIZABLE_ANY"
		alias
			"default_rescue"
		end

	frozen ec_illegal_36_ec_illegal_36_growth_percentage (current_: RESIZABLE_ANY): INTEGER is
		external
			"IL static signature (RESIZABLE_ANY): System.Int32 use Implementation.RESIZABLE_ANY"
		alias
			"$$growth_percentage"
		end

	default_pointer: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.RESIZABLE_ANY"
		alias
			"default_pointer"
		end

	standard_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.RESIZABLE_ANY"
		alias
			"standard_copy"
		end

	automatic_grow is
		external
			"IL signature (): System.Void use Implementation.RESIZABLE_ANY"
		alias
			"automatic_grow"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.RESIZABLE_ANY"
		alias
			"ToString"
		end

	default_: ANY is
		external
			"IL signature (): ANY use Implementation.RESIZABLE_ANY"
		alias
			"default"
		end

	resizable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.RESIZABLE_ANY"
		alias
			"resizable"
		end

	deep_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.RESIZABLE_ANY"
		alias
			"deep_equal"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use Implementation.RESIZABLE_ANY"
		alias
			"Equals"
		end

	growth_percentage: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.RESIZABLE_ANY"
		alias
			"growth_percentage"
		end

	minimal_increase: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.RESIZABLE_ANY"
		alias
			"minimal_increase"
		end

	full: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.RESIZABLE_ANY"
		alias
			"full"
		end

	frozen ec_illegal_36_ec_illegal_36_minimal_increase (current_: RESIZABLE_ANY): INTEGER is
		external
			"IL static signature (RESIZABLE_ANY): System.Int32 use Implementation.RESIZABLE_ANY"
		alias
			"$$minimal_increase"
		end

	generating_type: STRING is
		external
			"IL signature (): STRING use Implementation.RESIZABLE_ANY"
		alias
			"generating_type"
		end

	object_comparison: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.RESIZABLE_ANY"
		alias
			"object_comparison"
		end

	default_create_ is
		external
			"IL signature (): System.Void use Implementation.RESIZABLE_ANY"
		alias
			"default_create"
		end

	io: STD_FILES is
		external
			"IL signature (): STD_FILES use Implementation.RESIZABLE_ANY"
		alias
			"io"
		end

	clone_ (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.RESIZABLE_ANY"
		alias
			"clone"
		end

	frozen ec_illegal_36_ec_illegal_36_resizable (current_: RESIZABLE_ANY): BOOLEAN is
		external
			"IL static signature (RESIZABLE_ANY): System.Boolean use Implementation.RESIZABLE_ANY"
		alias
			"$$resizable"
		end

	frozen ec_illegal_36_ec_illegal_36_additional_space (current_: RESIZABLE_ANY): INTEGER is
		external
			"IL static signature (RESIZABLE_ANY): System.Int32 use Implementation.RESIZABLE_ANY"
		alias
			"$$additional_space"
		end

	deep_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.RESIZABLE_ANY"
		alias
			"deep_copy"
		end

	copy_ (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.RESIZABLE_ANY"
		alias
			"copy"
		end

	conforms_to (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.RESIZABLE_ANY"
		alias
			"conforms_to"
		end

	additional_space: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.RESIZABLE_ANY"
		alias
			"additional_space"
		end

	print (some: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.RESIZABLE_ANY"
		alias
			"print"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use Implementation.RESIZABLE_ANY"
		alias
			"Finalize"
		end

end -- class IMPLEMENTATION_RESIZABLE_ANY
