indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "Implementation.COLLECTION_DOUBLE"

deferred external class
	IMPLEMENTATION_COLLECTION_DOUBLE

inherit
	COLLECTION_DOUBLE
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	CONTAINER_DOUBLE

feature -- Access

	frozen ec_illegal_36_ec_illegal_36_object_comparison: BOOLEAN is
		external
			"IL field signature :System.Boolean use Implementation.COLLECTION_DOUBLE"
		alias
			"$$object_comparison"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.COLLECTION_DOUBLE"
		alias
			"GetHashCode"
		end

	deep_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.COLLECTION_DOUBLE"
		alias
			"deep_clone"
		end

	a_set_object_comparison (object_comparison2: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Implementation.COLLECTION_DOUBLE"
		alias
			"_set_object_comparison"
		end

	compare_references is
		external
			"IL signature (): System.Void use Implementation.COLLECTION_DOUBLE"
		alias
			"compare_references"
		end

	tagged_out: STRING is
		external
			"IL signature (): STRING use Implementation.COLLECTION_DOUBLE"
		alias
			"tagged_out"
		end

	internal_clone: ANY is
		external
			"IL signature (): ANY use Implementation.COLLECTION_DOUBLE"
		alias
			"internal_clone"
		end

	operating_environment: OPERATING_ENVIRONMENT is
		external
			"IL signature (): OPERATING_ENVIRONMENT use Implementation.COLLECTION_DOUBLE"
		alias
			"operating_environment"
		end

	standard_is_equal (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.COLLECTION_DOUBLE"
		alias
			"standard_is_equal"
		end

	is_equal_ (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.COLLECTION_DOUBLE"
		alias
			"is_equal"
		end

	standard_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.COLLECTION_DOUBLE"
		alias
			"standard_equal"
		end

	same_type (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.COLLECTION_DOUBLE"
		alias
			"same_type"
		end

	empty: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.COLLECTION_DOUBLE"
		alias
			"empty"
		end

	generator: STRING is
		external
			"IL signature (): STRING use Implementation.COLLECTION_DOUBLE"
		alias
			"generator"
		end

	changeable_comparison_criterion: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.COLLECTION_DOUBLE"
		alias
			"changeable_comparison_criterion"
		end

	internal_copy (o: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.COLLECTION_DOUBLE"
		alias
			"internal_copy"
		end

	compare_objects is
		external
			"IL signature (): System.Void use Implementation.COLLECTION_DOUBLE"
		alias
			"compare_objects"
		end

	standard_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.COLLECTION_DOUBLE"
		alias
			"standard_clone"
		end

	equal_ (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.COLLECTION_DOUBLE"
		alias
			"equal"
		end

	is_inserted (v: DOUBLE): BOOLEAN is
		external
			"IL signature (System.Double): System.Boolean use Implementation.COLLECTION_DOUBLE"
		alias
			"is_inserted"
		end

	frozen ec_illegal_36_ec_illegal_36_fill (current_: COLLECTION_DOUBLE; other: CONTAINER_DOUBLE) is
		external
			"IL static signature (COLLECTION_DOUBLE, CONTAINER_DOUBLE): System.Void use Implementation.COLLECTION_DOUBLE"
		alias
			"$$fill"
		end

	frozen a____class_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.COLLECTION_DOUBLE"
		alias
			"____class_name"
		end

	do_nothing is
		external
			"IL signature (): System.Void use Implementation.COLLECTION_DOUBLE"
		alias
			"do_nothing"
		end

	out_: STRING is
		external
			"IL signature (): STRING use Implementation.COLLECTION_DOUBLE"
		alias
			"out"
		end

	default_rescue is
		external
			"IL signature (): System.Void use Implementation.COLLECTION_DOUBLE"
		alias
			"default_rescue"
		end

	default_pointer: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.COLLECTION_DOUBLE"
		alias
			"default_pointer"
		end

	standard_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.COLLECTION_DOUBLE"
		alias
			"standard_copy"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.COLLECTION_DOUBLE"
		alias
			"ToString"
		end

	default_: ANY is
		external
			"IL signature (): ANY use Implementation.COLLECTION_DOUBLE"
		alias
			"default"
		end

	deep_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.COLLECTION_DOUBLE"
		alias
			"deep_equal"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use Implementation.COLLECTION_DOUBLE"
		alias
			"Equals"
		end

	fill (other: CONTAINER_DOUBLE) is
		external
			"IL signature (CONTAINER_DOUBLE): System.Void use Implementation.COLLECTION_DOUBLE"
		alias
			"fill"
		end

	frozen ec_illegal_36_ec_illegal_36_prune_all (current_: COLLECTION_DOUBLE; v: DOUBLE) is
		external
			"IL static signature (COLLECTION_DOUBLE, System.Double): System.Void use Implementation.COLLECTION_DOUBLE"
		alias
			"$$prune_all"
		end

	prune_all (v: DOUBLE) is
		external
			"IL signature (System.Double): System.Void use Implementation.COLLECTION_DOUBLE"
		alias
			"prune_all"
		end

	generating_type: STRING is
		external
			"IL signature (): STRING use Implementation.COLLECTION_DOUBLE"
		alias
			"generating_type"
		end

	object_comparison: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.COLLECTION_DOUBLE"
		alias
			"object_comparison"
		end

	default_create_ is
		external
			"IL signature (): System.Void use Implementation.COLLECTION_DOUBLE"
		alias
			"default_create"
		end

	io: STD_FILES is
		external
			"IL signature (): STD_FILES use Implementation.COLLECTION_DOUBLE"
		alias
			"io"
		end

	clone_ (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.COLLECTION_DOUBLE"
		alias
			"clone"
		end

	deep_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.COLLECTION_DOUBLE"
		alias
			"deep_copy"
		end

	copy_ (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.COLLECTION_DOUBLE"
		alias
			"copy"
		end

	conforms_to (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.COLLECTION_DOUBLE"
		alias
			"conforms_to"
		end

	frozen ec_illegal_36_ec_illegal_36_is_inserted (current_: COLLECTION_DOUBLE; v: DOUBLE): BOOLEAN is
		external
			"IL static signature (COLLECTION_DOUBLE, System.Double): System.Boolean use Implementation.COLLECTION_DOUBLE"
		alias
			"$$is_inserted"
		end

	print (some: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.COLLECTION_DOUBLE"
		alias
			"print"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use Implementation.COLLECTION_DOUBLE"
		alias
			"Finalize"
		end

end -- class IMPLEMENTATION_COLLECTION_DOUBLE
