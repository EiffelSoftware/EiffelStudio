indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "Implementation.POINTER_REF"

external class
	IMPLEMENTATION_POINTER_REF

inherit
	HASHABLE
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	POINTER_REF

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use Implementation.POINTER_REF"
		end

feature -- Access

	frozen ec_illegal_36_ec_illegal_36_item: POINTER is
		external
			"IL field signature :System.IntPtr use Implementation.POINTER_REF"
		alias
			"$$item"
		end

feature -- Basic Operations

	item: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.POINTER_REF"
		alias
			"item"
		end

	deep_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.POINTER_REF"
		alias
			"deep_clone"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.POINTER_REF"
		alias
			"GetHashCode"
		end

	frozen ec_illegal_36_ec_illegal_36_memory_move (current_: POINTER_REF; a_source: POINTER; a_size: INTEGER) is
		external
			"IL static signature (POINTER_REF, System.IntPtr, System.Int32): System.Void use Implementation.POINTER_REF"
		alias
			"$$memory_move"
		end

	to_integer_32: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.POINTER_REF"
		alias
			"to_integer_32"
		end

	frozen ec_illegal_36_ec_illegal_36_hash_code (current_: POINTER_REF): INTEGER is
		external
			"IL static signature (POINTER_REF): System.Int32 use Implementation.POINTER_REF"
		alias
			"$$hash_code"
		end

	tagged_out: STRING is
		external
			"IL signature (): STRING use Implementation.POINTER_REF"
		alias
			"tagged_out"
		end

	c_memset (source: POINTER; val: INTEGER; count: INTEGER) is
		external
			"IL signature (System.IntPtr, System.Int32, System.Int32): System.Void use Implementation.POINTER_REF"
		alias
			"c_memset"
		end

	internal_clone: ANY is
		external
			"IL signature (): ANY use Implementation.POINTER_REF"
		alias
			"internal_clone"
		end

	operating_environment: OPERATING_ENVIRONMENT is
		external
			"IL signature (): OPERATING_ENVIRONMENT use Implementation.POINTER_REF"
		alias
			"operating_environment"
		end

	standard_is_equal (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.POINTER_REF"
		alias
			"standard_is_equal"
		end

	is_equal_ (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.POINTER_REF"
		alias
			"is_equal"
		end

	memory_copy (a_source: POINTER; a_size: INTEGER) is
		external
			"IL signature (System.IntPtr, System.Int32): System.Void use Implementation.POINTER_REF"
		alias
			"memory_copy"
		end

	frozen fcayl1c (source: POINTER; val: INTEGER; count: INTEGER) is
		external
			"IL static signature (System.IntPtr, System.Int32, System.Int32): System.Void use Implementation.POINTER_REF"
		alias
			"Fcayl1c"
		end

	standard_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.POINTER_REF"
		alias
			"standard_equal"
		end

	same_type (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.POINTER_REF"
		alias
			"same_type"
		end

	c_malloc (size: INTEGER): POINTER is
		external
			"IL signature (System.Int32): System.IntPtr use Implementation.POINTER_REF"
		alias
			"c_malloc"
		end

	generator: STRING is
		external
			"IL signature (): STRING use Implementation.POINTER_REF"
		alias
			"generator"
		end

	frozen ec_illegal_36_ec_illegal_36_to_integer_32 (current_: POINTER_REF): INTEGER is
		external
			"IL static signature (POINTER_REF): System.Int32 use Implementation.POINTER_REF"
		alias
			"$$to_integer_32"
		end

	internal_copy (o: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.POINTER_REF"
		alias
			"internal_copy"
		end

	is_hashable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.POINTER_REF"
		alias
			"is_hashable"
		end

	standard_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.POINTER_REF"
		alias
			"standard_clone"
		end

	frozen ec_illegal_36_ec_illegal_36_out (current_: POINTER_REF): STRING is
		external
			"IL static signature (POINTER_REF): STRING use Implementation.POINTER_REF"
		alias
			"$$out"
		end

	equal_ (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.POINTER_REF"
		alias
			"equal"
		end

	c_memcpy (destination: POINTER; source: POINTER; count: INTEGER) is
		external
			"IL signature (System.IntPtr, System.IntPtr, System.Int32): System.Void use Implementation.POINTER_REF"
		alias
			"c_memcpy"
		end

	frozen ec_illegal_36_ec_illegal_36_memory_alloc (current_: POINTER_REF; a_size: INTEGER): POINTER is
		external
			"IL static signature (POINTER_REF, System.Int32): System.IntPtr use Implementation.POINTER_REF"
		alias
			"$$memory_alloc"
		end

	memory_move (a_source: POINTER; a_size: INTEGER) is
		external
			"IL signature (System.IntPtr, System.Int32): System.Void use Implementation.POINTER_REF"
		alias
			"memory_move"
		end

	memory_set (val: INTEGER; n: INTEGER) is
		external
			"IL signature (System.Int32, System.Int32): System.Void use Implementation.POINTER_REF"
		alias
			"memory_set"
		end

	frozen fcay8zz (size: INTEGER): POINTER is
		external
			"IL static signature (System.Int32): System.IntPtr use Implementation.POINTER_REF"
		alias
			"Fcay8zz"
		end

	frozen a____class_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.POINTER_REF"
		alias
			"____class_name"
		end

	frozen fcawn8h (p: POINTER; o: INTEGER): POINTER is
		external
			"IL static signature (System.IntPtr, System.Int32): System.IntPtr use Implementation.POINTER_REF"
		alias
			"Fcawn8h"
		end

	do_nothing is
		external
			"IL signature (): System.Void use Implementation.POINTER_REF"
		alias
			"do_nothing"
		end

	out_: STRING is
		external
			"IL signature (): STRING use Implementation.POINTER_REF"
		alias
			"out"
		end

	default_rescue is
		external
			"IL signature (): System.Void use Implementation.POINTER_REF"
		alias
			"default_rescue"
		end

	frozen fcazwxl (p: POINTER) is
		external
			"IL static signature (System.IntPtr): System.Void use Implementation.POINTER_REF"
		alias
			"Fcazwxl"
		end

	default_pointer: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.POINTER_REF"
		alias
			"default_pointer"
		end

	frozen ec_illegal_34__in_ec_illegal_36_ec_illegal_36_infixec_illegal_32_ec_illegal_34_ (current_: POINTER_REF; offset: INTEGER): POINTER_REF is
		external
			"IL static signature (POINTER_REF, System.Int32): POINTER_REF use Implementation.POINTER_REF"
		alias
			"$$infix "+""
		end

	hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.POINTER_REF"
		alias
			"hash_code"
		end

	standard_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.POINTER_REF"
		alias
			"standard_copy"
		end

	frozen ec_illegal_36_ec_illegal_36_set_item (current_: POINTER_REF; p: POINTER) is
		external
			"IL static signature (POINTER_REF, System.IntPtr): System.Void use Implementation.POINTER_REF"
		alias
			"$$set_item"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.POINTER_REF"
		alias
			"ToString"
		end

	c_offset_pointer (p: POINTER; o: INTEGER): POINTER is
		external
			"IL signature (System.IntPtr, System.Int32): System.IntPtr use Implementation.POINTER_REF"
		alias
			"c_offset_pointer"
		end

	default_: ANY is
		external
			"IL signature (): ANY use Implementation.POINTER_REF"
		alias
			"default"
		end

	deep_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.POINTER_REF"
		alias
			"deep_equal"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use Implementation.POINTER_REF"
		alias
			"Equals"
		end

	frozen fcaxy3q (destination: POINTER; source: POINTER; count: INTEGER) is
		external
			"IL static signature (System.IntPtr, System.IntPtr, System.Int32): System.Void use Implementation.POINTER_REF"
		alias
			"Fcaxy3q"
		end

	generating_type: STRING is
		external
			"IL signature (): STRING use Implementation.POINTER_REF"
		alias
			"generating_type"
		end

	to_integer_64: INTEGER_64 is
		external
			"IL signature (): System.Int64 use Implementation.POINTER_REF"
		alias
			"to_integer_64"
		end

	memory_alloc (a_size: INTEGER): POINTER is
		external
			"IL signature (System.Int32): System.IntPtr use Implementation.POINTER_REF"
		alias
			"memory_alloc"
		end

	frozen fcaxa53 (destination: POINTER; source: POINTER; count: INTEGER) is
		external
			"IL static signature (System.IntPtr, System.IntPtr, System.Int32): System.Void use Implementation.POINTER_REF"
		alias
			"Fcaxa53"
		end

	set_item (p: POINTER) is
		external
			"IL signature (System.IntPtr): System.Void use Implementation.POINTER_REF"
		alias
			"set_item"
		end

	frozen ec_illegal_36_ec_illegal_36_to_integer_64 (current_: POINTER_REF): INTEGER_64 is
		external
			"IL static signature (POINTER_REF): System.Int64 use Implementation.POINTER_REF"
		alias
			"$$to_integer_64"
		end

	frozen ec_illegal_36_ec_illegal_36_memory_free (current_: POINTER_REF) is
		external
			"IL static signature (POINTER_REF): System.Void use Implementation.POINTER_REF"
		alias
			"$$memory_free"
		end

	c_free (p: POINTER) is
		external
			"IL signature (System.IntPtr): System.Void use Implementation.POINTER_REF"
		alias
			"c_free"
		end

	c_memmove (destination: POINTER; source: POINTER; count: INTEGER) is
		external
			"IL signature (System.IntPtr, System.IntPtr, System.Int32): System.Void use Implementation.POINTER_REF"
		alias
			"c_memmove"
		end

	a_set_item (item2: POINTER) is
		external
			"IL signature (System.IntPtr): System.Void use Implementation.POINTER_REF"
		alias
			"_set_item"
		end

	memory_free is
		external
			"IL signature (): System.Void use Implementation.POINTER_REF"
		alias
			"memory_free"
		end

	default_create_ is
		external
			"IL signature (): System.Void use Implementation.POINTER_REF"
		alias
			"default_create"
		end

	io: STD_FILES is
		external
			"IL signature (): STD_FILES use Implementation.POINTER_REF"
		alias
			"io"
		end

	clone_ (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.POINTER_REF"
		alias
			"clone"
		end

	frozen ec_illegal_36_ec_illegal_36_is_hashable (current_: POINTER_REF): BOOLEAN is
		external
			"IL static signature (POINTER_REF): System.Boolean use Implementation.POINTER_REF"
		alias
			"$$is_hashable"
		end

	frozen ec_illegal_36_ec_illegal_36_memory_copy (current_: POINTER_REF; a_source: POINTER; a_size: INTEGER) is
		external
			"IL static signature (POINTER_REF, System.IntPtr, System.Int32): System.Void use Implementation.POINTER_REF"
		alias
			"$$memory_copy"
		end

	deep_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.POINTER_REF"
		alias
			"deep_copy"
		end

	copy_ (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.POINTER_REF"
		alias
			"copy"
		end

	conforms_to (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.POINTER_REF"
		alias
			"conforms_to"
		end

	ec_illegal_34__in_infix " (offset: INTEGER): POINTER_REF is
		external
			"IL signature (System.Int32): POINTER_REF use Implementation.POINTER_REF"
		alias
			"infix "+""
		end

	frozen ec_illegal_36_ec_illegal_36_memory_set (current_: POINTER_REF; val: INTEGER; n: INTEGER) is
		external
			"IL static signature (POINTER_REF, System.Int32, System.Int32): System.Void use Implementation.POINTER_REF"
		alias
			"$$memory_set"
		end

	print (some: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.POINTER_REF"
		alias
			"print"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use Implementation.POINTER_REF"
		alias
			"Finalize"
		end

end -- class IMPLEMENTATION_POINTER_REF
