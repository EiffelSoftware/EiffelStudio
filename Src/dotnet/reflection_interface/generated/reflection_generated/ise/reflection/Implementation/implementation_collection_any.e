indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "Implementation.COLLECTION_ANY"

deferred external class
	IMPLEMENTATION_COLLECTION_ANY

inherit
	COLLECTION_ANY
	CONTAINER_ANY
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Access

	frozen ec_illegal_36_ec_illegal_36_object_comparison: BOOLEAN is
		external
			"IL field signature :System.Boolean use Implementation.COLLECTION_ANY"
		alias
			"$$object_comparison"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.COLLECTION_ANY"
		alias
			"GetHashCode"
		end

	deep_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.COLLECTION_ANY"
		alias
			"deep_clone"
		end

	a_set_object_comparison (object_comparison2: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Implementation.COLLECTION_ANY"
		alias
			"_set_object_comparison"
		end

	compare_references is
		external
			"IL signature (): System.Void use Implementation.COLLECTION_ANY"
		alias
			"compare_references"
		end

	tagged_out: STRING is
		external
			"IL signature (): STRING use Implementation.COLLECTION_ANY"
		alias
			"tagged_out"
		end

	internal_clone: ANY is
		external
			"IL signature (): ANY use Implementation.COLLECTION_ANY"
		alias
			"internal_clone"
		end

	operating_environment: OPERATING_ENVIRONMENT is
		external
			"IL signature (): OPERATING_ENVIRONMENT use Implementation.COLLECTION_ANY"
		alias
			"operating_environment"
		end

	standard_is_equal (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.COLLECTION_ANY"
		alias
			"standard_is_equal"
		end

	is_equal_ (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.COLLECTION_ANY"
		alias
			"is_equal"
		end

	standard_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.COLLECTION_ANY"
		alias
			"standard_equal"
		end

	same_type (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.COLLECTION_ANY"
		alias
			"same_type"
		end

	empty: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.COLLECTION_ANY"
		alias
			"empty"
		end

	generator: STRING is
		external
			"IL signature (): STRING use Implementation.COLLECTION_ANY"
		alias
			"generator"
		end

	changeable_comparison_criterion: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.COLLECTION_ANY"
		alias
			"changeable_comparison_criterion"
		end

	internal_copy (o: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.COLLECTION_ANY"
		alias
			"internal_copy"
		end

	compare_objects is
		external
			"IL signature (): System.Void use Implementation.COLLECTION_ANY"
		alias
			"compare_objects"
		end

	standard_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.COLLECTION_ANY"
		alias
			"standard_clone"
		end

	equal_ (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.COLLECTION_ANY"
		alias
			"equal"
		end

	is_inserted (v: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.COLLECTION_ANY"
		alias
			"is_inserted"
		end

	frozen ec_illegal_36_ec_illegal_36_fill (current_: COLLECTION_ANY; other: CONTAINER_ANY) is
		external
			"IL static signature (COLLECTION_ANY, CONTAINER_ANY): System.Void use Implementation.COLLECTION_ANY"
		alias
			"$$fill"
		end

	frozen a____class_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.COLLECTION_ANY"
		alias
			"____class_name"
		end

	do_nothing is
		external
			"IL signature (): System.Void use Implementation.COLLECTION_ANY"
		alias
			"do_nothing"
		end

	out_: STRING is
		external
			"IL signature (): STRING use Implementation.COLLECTION_ANY"
		alias
			"out"
		end

	default_rescue is
		external
			"IL signature (): System.Void use Implementation.COLLECTION_ANY"
		alias
			"default_rescue"
		end

	default_pointer: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.COLLECTION_ANY"
		alias
			"default_pointer"
		end

	standard_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.COLLECTION_ANY"
		alias
			"standard_copy"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.COLLECTION_ANY"
		alias
			"ToString"
		end

	default_: ANY is
		external
			"IL signature (): ANY use Implementation.COLLECTION_ANY"
		alias
			"default"
		end

	deep_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.COLLECTION_ANY"
		alias
			"deep_equal"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use Implementation.COLLECTION_ANY"
		alias
			"Equals"
		end

	fill (other: CONTAINER_ANY) is
		external
			"IL signature (CONTAINER_ANY): System.Void use Implementation.COLLECTION_ANY"
		alias
			"fill"
		end

	frozen ec_illegal_36_ec_illegal_36_prune_all (current_: COLLECTION_ANY; v: ANY) is
		external
			"IL static signature (COLLECTION_ANY, ANY): System.Void use Implementation.COLLECTION_ANY"
		alias
			"$$prune_all"
		end

	prune_all (v: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.COLLECTION_ANY"
		alias
			"prune_all"
		end

	generating_type: STRING is
		external
			"IL signature (): STRING use Implementation.COLLECTION_ANY"
		alias
			"generating_type"
		end

	object_comparison: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.COLLECTION_ANY"
		alias
			"object_comparison"
		end

	default_create_ is
		external
			"IL signature (): System.Void use Implementation.COLLECTION_ANY"
		alias
			"default_create"
		end

	io: STD_FILES is
		external
			"IL signature (): STD_FILES use Implementation.COLLECTION_ANY"
		alias
			"io"
		end

	clone_ (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.COLLECTION_ANY"
		alias
			"clone"
		end

	deep_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.COLLECTION_ANY"
		alias
			"deep_copy"
		end

	copy_ (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.COLLECTION_ANY"
		alias
			"copy"
		end

	conforms_to (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.COLLECTION_ANY"
		alias
			"conforms_to"
		end

	frozen ec_illegal_36_ec_illegal_36_is_inserted (current_: COLLECTION_ANY; v: ANY): BOOLEAN is
		external
			"IL static signature (COLLECTION_ANY, ANY): System.Boolean use Implementation.COLLECTION_ANY"
		alias
			"$$is_inserted"
		end

	print (some: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.COLLECTION_ANY"
		alias
			"print"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use Implementation.COLLECTION_ANY"
		alias
			"Finalize"
		end

end -- class IMPLEMENTATION_COLLECTION_ANY
