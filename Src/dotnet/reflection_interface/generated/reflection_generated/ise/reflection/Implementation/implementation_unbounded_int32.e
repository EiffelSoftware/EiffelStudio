indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "Implementation.UNBOUNDED_INT32"

deferred external class
	IMPLEMENTATION_UNBOUNDED_INT32

inherit
	FINITE_INT32
	BOX_INT32
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	CONTAINER_INT32
	UNBOUNDED_INT32

feature -- Access

	frozen ec_illegal_36_ec_illegal_36_object_comparison: BOOLEAN is
		external
			"IL field signature :System.Boolean use Implementation.UNBOUNDED_INT32"
		alias
			"$$object_comparison"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.UNBOUNDED_INT32"
		alias
			"GetHashCode"
		end

	deep_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.UNBOUNDED_INT32"
		alias
			"deep_clone"
		end

	a_set_object_comparison (object_comparison2: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Implementation.UNBOUNDED_INT32"
		alias
			"_set_object_comparison"
		end

	compare_references is
		external
			"IL signature (): System.Void use Implementation.UNBOUNDED_INT32"
		alias
			"compare_references"
		end

	tagged_out: STRING is
		external
			"IL signature (): STRING use Implementation.UNBOUNDED_INT32"
		alias
			"tagged_out"
		end

	internal_clone: ANY is
		external
			"IL signature (): ANY use Implementation.UNBOUNDED_INT32"
		alias
			"internal_clone"
		end

	operating_environment: OPERATING_ENVIRONMENT is
		external
			"IL signature (): OPERATING_ENVIRONMENT use Implementation.UNBOUNDED_INT32"
		alias
			"operating_environment"
		end

	standard_is_equal (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.UNBOUNDED_INT32"
		alias
			"standard_is_equal"
		end

	is_equal_ (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.UNBOUNDED_INT32"
		alias
			"is_equal"
		end

	standard_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.UNBOUNDED_INT32"
		alias
			"standard_equal"
		end

	same_type (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.UNBOUNDED_INT32"
		alias
			"same_type"
		end

	empty: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.UNBOUNDED_INT32"
		alias
			"empty"
		end

	generator: STRING is
		external
			"IL signature (): STRING use Implementation.UNBOUNDED_INT32"
		alias
			"generator"
		end

	changeable_comparison_criterion: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.UNBOUNDED_INT32"
		alias
			"changeable_comparison_criterion"
		end

	internal_copy (o: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.UNBOUNDED_INT32"
		alias
			"internal_copy"
		end

	compare_objects is
		external
			"IL signature (): System.Void use Implementation.UNBOUNDED_INT32"
		alias
			"compare_objects"
		end

	standard_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.UNBOUNDED_INT32"
		alias
			"standard_clone"
		end

	equal_ (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.UNBOUNDED_INT32"
		alias
			"equal"
		end

	is_empty: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.UNBOUNDED_INT32"
		alias
			"is_empty"
		end

	frozen a____class_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.UNBOUNDED_INT32"
		alias
			"____class_name"
		end

	do_nothing is
		external
			"IL signature (): System.Void use Implementation.UNBOUNDED_INT32"
		alias
			"do_nothing"
		end

	out_: STRING is
		external
			"IL signature (): STRING use Implementation.UNBOUNDED_INT32"
		alias
			"out"
		end

	default_rescue is
		external
			"IL signature (): System.Void use Implementation.UNBOUNDED_INT32"
		alias
			"default_rescue"
		end

	default_pointer: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.UNBOUNDED_INT32"
		alias
			"default_pointer"
		end

	standard_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.UNBOUNDED_INT32"
		alias
			"standard_copy"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.UNBOUNDED_INT32"
		alias
			"ToString"
		end

	default_: ANY is
		external
			"IL signature (): ANY use Implementation.UNBOUNDED_INT32"
		alias
			"default"
		end

	deep_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.UNBOUNDED_INT32"
		alias
			"deep_equal"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use Implementation.UNBOUNDED_INT32"
		alias
			"Equals"
		end

	generating_type: STRING is
		external
			"IL signature (): STRING use Implementation.UNBOUNDED_INT32"
		alias
			"generating_type"
		end

	object_comparison: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.UNBOUNDED_INT32"
		alias
			"object_comparison"
		end

	default_create_ is
		external
			"IL signature (): System.Void use Implementation.UNBOUNDED_INT32"
		alias
			"default_create"
		end

	io: STD_FILES is
		external
			"IL signature (): STD_FILES use Implementation.UNBOUNDED_INT32"
		alias
			"io"
		end

	clone_ (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.UNBOUNDED_INT32"
		alias
			"clone"
		end

	deep_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.UNBOUNDED_INT32"
		alias
			"deep_copy"
		end

	copy_ (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.UNBOUNDED_INT32"
		alias
			"copy"
		end

	conforms_to (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.UNBOUNDED_INT32"
		alias
			"conforms_to"
		end

	print (some: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.UNBOUNDED_INT32"
		alias
			"print"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use Implementation.UNBOUNDED_INT32"
		alias
			"Finalize"
		end

end -- class IMPLEMENTATION_UNBOUNDED_INT32
