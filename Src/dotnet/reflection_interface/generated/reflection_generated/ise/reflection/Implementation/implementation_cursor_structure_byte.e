indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "Implementation.CURSOR_STRUCTURE_BYTE"

deferred external class
	IMPLEMENTATION_CURSOR_STRUCTURE_BYTE

inherit
	ACTIVE_BYTE
	COLLECTION_BYTE
	CONTAINER_BYTE
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	BAG_BYTE
	CURSOR_STRUCTURE_BYTE

feature -- Access

	frozen ec_illegal_36_ec_illegal_36_object_comparison: BOOLEAN is
		external
			"IL field signature :System.Boolean use Implementation.CURSOR_STRUCTURE_BYTE"
		alias
			"$$object_comparison"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.CURSOR_STRUCTURE_BYTE"
		alias
			"GetHashCode"
		end

	deep_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.CURSOR_STRUCTURE_BYTE"
		alias
			"deep_clone"
		end

	a_set_object_comparison (object_comparison2: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Implementation.CURSOR_STRUCTURE_BYTE"
		alias
			"_set_object_comparison"
		end

	compare_references is
		external
			"IL signature (): System.Void use Implementation.CURSOR_STRUCTURE_BYTE"
		alias
			"compare_references"
		end

	tagged_out: STRING is
		external
			"IL signature (): STRING use Implementation.CURSOR_STRUCTURE_BYTE"
		alias
			"tagged_out"
		end

	internal_clone: ANY is
		external
			"IL signature (): ANY use Implementation.CURSOR_STRUCTURE_BYTE"
		alias
			"internal_clone"
		end

	operating_environment: OPERATING_ENVIRONMENT is
		external
			"IL signature (): OPERATING_ENVIRONMENT use Implementation.CURSOR_STRUCTURE_BYTE"
		alias
			"operating_environment"
		end

	standard_is_equal (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.CURSOR_STRUCTURE_BYTE"
		alias
			"standard_is_equal"
		end

	is_equal_ (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.CURSOR_STRUCTURE_BYTE"
		alias
			"is_equal"
		end

	standard_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.CURSOR_STRUCTURE_BYTE"
		alias
			"standard_equal"
		end

	same_type (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.CURSOR_STRUCTURE_BYTE"
		alias
			"same_type"
		end

	empty: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CURSOR_STRUCTURE_BYTE"
		alias
			"empty"
		end

	generator: STRING is
		external
			"IL signature (): STRING use Implementation.CURSOR_STRUCTURE_BYTE"
		alias
			"generator"
		end

	changeable_comparison_criterion: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CURSOR_STRUCTURE_BYTE"
		alias
			"changeable_comparison_criterion"
		end

	internal_copy (o: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.CURSOR_STRUCTURE_BYTE"
		alias
			"internal_copy"
		end

	compare_objects is
		external
			"IL signature (): System.Void use Implementation.CURSOR_STRUCTURE_BYTE"
		alias
			"compare_objects"
		end

	standard_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.CURSOR_STRUCTURE_BYTE"
		alias
			"standard_clone"
		end

	equal_ (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.CURSOR_STRUCTURE_BYTE"
		alias
			"equal"
		end

	is_inserted (v: INTEGER_8): BOOLEAN is
		external
			"IL signature (System.Byte): System.Boolean use Implementation.CURSOR_STRUCTURE_BYTE"
		alias
			"is_inserted"
		end

	frozen a____class_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.CURSOR_STRUCTURE_BYTE"
		alias
			"____class_name"
		end

	do_nothing is
		external
			"IL signature (): System.Void use Implementation.CURSOR_STRUCTURE_BYTE"
		alias
			"do_nothing"
		end

	out_: STRING is
		external
			"IL signature (): STRING use Implementation.CURSOR_STRUCTURE_BYTE"
		alias
			"out"
		end

	default_rescue is
		external
			"IL signature (): System.Void use Implementation.CURSOR_STRUCTURE_BYTE"
		alias
			"default_rescue"
		end

	default_pointer: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.CURSOR_STRUCTURE_BYTE"
		alias
			"default_pointer"
		end

	standard_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.CURSOR_STRUCTURE_BYTE"
		alias
			"standard_copy"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.CURSOR_STRUCTURE_BYTE"
		alias
			"ToString"
		end

	default_: ANY is
		external
			"IL signature (): ANY use Implementation.CURSOR_STRUCTURE_BYTE"
		alias
			"default"
		end

	deep_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.CURSOR_STRUCTURE_BYTE"
		alias
			"deep_equal"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use Implementation.CURSOR_STRUCTURE_BYTE"
		alias
			"Equals"
		end

	fill (other: CONTAINER_BYTE) is
		external
			"IL signature (CONTAINER_BYTE): System.Void use Implementation.CURSOR_STRUCTURE_BYTE"
		alias
			"fill"
		end

	prune_all (v: INTEGER_8) is
		external
			"IL signature (System.Byte): System.Void use Implementation.CURSOR_STRUCTURE_BYTE"
		alias
			"prune_all"
		end

	generating_type: STRING is
		external
			"IL signature (): STRING use Implementation.CURSOR_STRUCTURE_BYTE"
		alias
			"generating_type"
		end

	object_comparison: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.CURSOR_STRUCTURE_BYTE"
		alias
			"object_comparison"
		end

	default_create_ is
		external
			"IL signature (): System.Void use Implementation.CURSOR_STRUCTURE_BYTE"
		alias
			"default_create"
		end

	io: STD_FILES is
		external
			"IL signature (): STD_FILES use Implementation.CURSOR_STRUCTURE_BYTE"
		alias
			"io"
		end

	clone_ (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.CURSOR_STRUCTURE_BYTE"
		alias
			"clone"
		end

	deep_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.CURSOR_STRUCTURE_BYTE"
		alias
			"deep_copy"
		end

	copy_ (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.CURSOR_STRUCTURE_BYTE"
		alias
			"copy"
		end

	conforms_to (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.CURSOR_STRUCTURE_BYTE"
		alias
			"conforms_to"
		end

	print (some: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.CURSOR_STRUCTURE_BYTE"
		alias
			"print"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use Implementation.CURSOR_STRUCTURE_BYTE"
		alias
			"Finalize"
		end

end -- class IMPLEMENTATION_CURSOR_STRUCTURE_BYTE
