indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "Implementation.ROUTINE_ANY_ANY"

deferred external class
	IMPLEMENTATION_ROUTINE_ANY_ANY

inherit
	HASHABLE
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	ROUTINE_ANY_ANY

feature -- Access

	frozen ec_illegal_36_ec_illegal_36_operands: TUPLE is
		external
			"IL field signature :TUPLE use Implementation.ROUTINE_ANY_ANY"
		alias
			"$$operands"
		end

	frozen ec_illegal_36_ec_illegal_36_operands_set_by_user: BOOLEAN is
		external
			"IL field signature :System.Boolean use Implementation.ROUTINE_ANY_ANY"
		alias
			"$$operands_set_by_user"
		end

	frozen ec_illegal_36_ec_illegal_36_rout_target: SYSTEM_OBJECT is
		external
			"IL field signature :System.Object use Implementation.ROUTINE_ANY_ANY"
		alias
			"$$rout_target"
		end

	frozen ec_illegal_36_ec_illegal_36_closed_map: NATIVE_ARRAY [INTEGER] is
		external
			"IL field signature :System.Int32[] use Implementation.ROUTINE_ANY_ANY"
		alias
			"$$closed_map"
		end

	frozen ec_illegal_36_ec_illegal_36_open_map: NATIVE_ARRAY [INTEGER] is
		external
			"IL field signature :System.Int32[] use Implementation.ROUTINE_ANY_ANY"
		alias
			"$$open_map"
		end

	frozen ec_illegal_36_ec_illegal_36_rout_disp: METHOD_BASE is
		external
			"IL field signature :System.Reflection.MethodBase use Implementation.ROUTINE_ANY_ANY"
		alias
			"$$rout_disp"
		end

	frozen ec_illegal_36_ec_illegal_36_rout_arguments: NATIVE_ARRAY [SYSTEM_OBJECT] is
		external
			"IL field signature :System.Object[] use Implementation.ROUTINE_ANY_ANY"
		alias
			"$$rout_arguments"
		end

	frozen ec_illegal_36_ec_illegal_36_closed_operands: TUPLE is
		external
			"IL field signature :TUPLE use Implementation.ROUTINE_ANY_ANY"
		alias
			"$$closed_operands"
		end

	frozen ec_illegal_36_ec_illegal_36_open_types: ARRAY_INT32 is
		external
			"IL field signature :ARRAY_INT32 use Implementation.ROUTINE_ANY_ANY"
		alias
			"$$open_types"
		end

feature -- Basic Operations

	operating_environment: OPERATING_ENVIRONMENT is
		external
			"IL signature (): OPERATING_ENVIRONMENT use Implementation.ROUTINE_ANY_ANY"
		alias
			"operating_environment"
		end

	open_operand_type (i: INTEGER): INTEGER is
		external
			"IL signature (System.Int32): System.Int32 use Implementation.ROUTINE_ANY_ANY"
		alias
			"open_operand_type"
		end

	default_create_ is
		external
			"IL signature (): System.Void use Implementation.ROUTINE_ANY_ANY"
		alias
			"default_create"
		end

	eif_gen_create (obj: POINTER; pos: INTEGER): POINTER is
		external
			"IL signature (System.IntPtr, System.Int32): System.IntPtr use Implementation.ROUTINE_ANY_ANY"
		alias
			"eif_gen_create"
		end

	frozen ec_illegal_36_ec_illegal_36_copy (current_: ROUTINE_ANY_ANY; other: ROUTINE_ANY_ANY) is
		external
			"IL static signature (ROUTINE_ANY_ANY, ROUTINE_ANY_ANY): System.Void use Implementation.ROUTINE_ANY_ANY"
		alias
			"$$copy"
		end

	rout_target: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use Implementation.ROUTINE_ANY_ANY"
		alias
			"rout_target"
		end

	open_map: NATIVE_ARRAY [INTEGER] is
		external
			"IL signature (): System.Int32[] use Implementation.ROUTINE_ANY_ANY"
		alias
			"open_map"
		end

	set_arguments (args: TUPLE) is
		external
			"IL signature (TUPLE): System.Void use Implementation.ROUTINE_ANY_ANY"
		alias
			"set_arguments"
		end

	frozen ec_illegal_36_ec_illegal_36_set_rout_disp (current_: ROUTINE_ANY_ANY; handle: RUNTIME_METHOD_HANDLE; closed_args: TUPLE; omap: ARRAY_INT32; cmap: ARRAY_INT32) is
		external
			"IL static signature (ROUTINE_ANY_ANY, System.RuntimeMethodHandle, TUPLE, ARRAY_INT32, ARRAY_INT32): System.Void use Implementation.ROUTINE_ANY_ANY"
		alias
			"$$set_rout_disp"
		end

	frozen ec_illegal_36_ec_illegal_36_hash_code (current_: ROUTINE_ANY_ANY): INTEGER is
		external
			"IL static signature (ROUTINE_ANY_ANY): System.Int32 use Implementation.ROUTINE_ANY_ANY"
		alias
			"$$hash_code"
		end

	frozen ec_illegal_36_ec_illegal_36_valid_operands (current_: ROUTINE_ANY_ANY; args: TUPLE): BOOLEAN is
		external
			"IL static signature (ROUTINE_ANY_ANY, TUPLE): System.Boolean use Implementation.ROUTINE_ANY_ANY"
		alias
			"$$valid_operands"
		end

	frozen ec_illegal_36_ec_illegal_36_eif_gen_tuple_typecode_str (current_: ROUTINE_ANY_ANY; obj: POINTER): STRING is
		external
			"IL static signature (ROUTINE_ANY_ANY, System.IntPtr): STRING use Implementation.ROUTINE_ANY_ANY"
		alias
			"$$eif_gen_tuple_typecode_str"
		end

	open_types: ARRAY_INT32 is
		external
			"IL signature (): ARRAY_INT32 use Implementation.ROUTINE_ANY_ANY"
		alias
			"open_types"
		end

	eif_gen_typecode (obj: POINTER; pos: INTEGER): INTEGER_8 is
		external
			"IL signature (System.IntPtr, System.Int32): System.Byte use Implementation.ROUTINE_ANY_ANY"
		alias
			"eif_gen_typecode"
		end

	a_set_closed_operands (closed_operands2: TUPLE) is
		external
			"IL signature (TUPLE): System.Void use Implementation.ROUTINE_ANY_ANY"
		alias
			"_set_closed_operands"
		end

	a_set_open_types (open_types2: ARRAY_INT32) is
		external
			"IL signature (ARRAY_INT32): System.Void use Implementation.ROUTINE_ANY_ANY"
		alias
			"_set_open_types"
		end

	copy_ (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.ROUTINE_ANY_ANY"
		alias
			"copy"
		end

	frozen ec_illegal_36_ec_illegal_36_postcondition (current_: ROUTINE_ANY_ANY; args: TUPLE): BOOLEAN is
		external
			"IL static signature (ROUTINE_ANY_ANY, TUPLE): System.Boolean use Implementation.ROUTINE_ANY_ANY"
		alias
			"$$postcondition"
		end

	generating_type: STRING is
		external
			"IL signature (): STRING use Implementation.ROUTINE_ANY_ANY"
		alias
			"generating_type"
		end

	out_: STRING is
		external
			"IL signature (): STRING use Implementation.ROUTINE_ANY_ANY"
		alias
			"out"
		end

	valid_operands (args: TUPLE): BOOLEAN is
		external
			"IL signature (TUPLE): System.Boolean use Implementation.ROUTINE_ANY_ANY"
		alias
			"valid_operands"
		end

	eif_gen_param_id (stype: INTEGER; obj: POINTER; pos: INTEGER): INTEGER is
		external
			"IL signature (System.Int32, System.IntPtr, System.Int32): System.Int32 use Implementation.ROUTINE_ANY_ANY"
		alias
			"eif_gen_param_id"
		end

	closed_operands: TUPLE is
		external
			"IL signature (): TUPLE use Implementation.ROUTINE_ANY_ANY"
		alias
			"closed_operands"
		end

	frozen ec_illegal_36_ec_illegal_36_valid_arguments (current_: ROUTINE_ANY_ANY; args: TUPLE): BOOLEAN is
		external
			"IL static signature (ROUTINE_ANY_ANY, TUPLE): System.Boolean use Implementation.ROUTINE_ANY_ANY"
		alias
			"$$valid_arguments"
		end

	frozen ec_illegal_36_ec_illegal_36_set_arguments (current_: ROUTINE_ANY_ANY; args: TUPLE) is
		external
			"IL static signature (ROUTINE_ANY_ANY, TUPLE): System.Void use Implementation.ROUTINE_ANY_ANY"
		alias
			"$$set_arguments"
		end

	hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.ROUTINE_ANY_ANY"
		alias
			"hash_code"
		end

	postcondition (args: TUPLE): BOOLEAN is
		external
			"IL signature (TUPLE): System.Boolean use Implementation.ROUTINE_ANY_ANY"
		alias
			"postcondition"
		end

	rout_set_cargs is
		external
			"IL signature (): System.Void use Implementation.ROUTINE_ANY_ANY"
		alias
			"rout_set_cargs"
		end

	frozen ec_illegal_36_ec_illegal_36_call (current_: ROUTINE_ANY_ANY; args: TUPLE) is
		external
			"IL static signature (ROUTINE_ANY_ANY, TUPLE): System.Void use Implementation.ROUTINE_ANY_ANY"
		alias
			"$$call"
		end

	a_set_closed_map (closed_map2: NATIVE_ARRAY [INTEGER]) is
		external
			"IL signature (System.Int32[]): System.Void use Implementation.ROUTINE_ANY_ANY"
		alias
			"_set_closed_map"
		end

	conforms_to (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.ROUTINE_ANY_ANY"
		alias
			"conforms_to"
		end

	io: STD_FILES is
		external
			"IL signature (): STD_FILES use Implementation.ROUTINE_ANY_ANY"
		alias
			"io"
		end

	rout_arguments: NATIVE_ARRAY [SYSTEM_OBJECT] is
		external
			"IL signature (): System.Object[] use Implementation.ROUTINE_ANY_ANY"
		alias
			"rout_arguments"
		end

	tagged_out: STRING is
		external
			"IL signature (): STRING use Implementation.ROUTINE_ANY_ANY"
		alias
			"tagged_out"
		end

	frozen ec_illegal_36_ec_illegal_36_open_count (current_: ROUTINE_ANY_ANY): INTEGER is
		external
			"IL static signature (ROUTINE_ANY_ANY): System.Int32 use Implementation.ROUTINE_ANY_ANY"
		alias
			"$$open_count"
		end

	call (args: TUPLE) is
		external
			"IL signature (TUPLE): System.Void use Implementation.ROUTINE_ANY_ANY"
		alias
			"call"
		end

	default_: ANY is
		external
			"IL signature (): ANY use Implementation.ROUTINE_ANY_ANY"
		alias
			"default"
		end

	eif_gen_typecode_str (obj: POINTER): STRING is
		external
			"IL signature (System.IntPtr): STRING use Implementation.ROUTINE_ANY_ANY"
		alias
			"eif_gen_typecode_str"
		end

	eif_gen_tuple_typecode_str (obj: POINTER): STRING is
		external
			"IL signature (System.IntPtr): STRING use Implementation.ROUTINE_ANY_ANY"
		alias
			"eif_gen_tuple_typecode_str"
		end

	a_set_rout_target (rout_target2: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use Implementation.ROUTINE_ANY_ANY"
		alias
			"_set_rout_target"
		end

	same_type (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.ROUTINE_ANY_ANY"
		alias
			"same_type"
		end

	do_nothing is
		external
			"IL signature (): System.Void use Implementation.ROUTINE_ANY_ANY"
		alias
			"do_nothing"
		end

	operands_set_by_user: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ROUTINE_ANY_ANY"
		alias
			"operands_set_by_user"
		end

	a_set_operands (operands2: TUPLE) is
		external
			"IL signature (TUPLE): System.Void use Implementation.ROUTINE_ANY_ANY"
		alias
			"_set_operands"
		end

	frozen ec_illegal_36_ec_illegal_36_adapt (current_: ROUTINE_ANY_ANY; other: ROUTINE_ANY_ANY) is
		external
			"IL static signature (ROUTINE_ANY_ANY, ROUTINE_ANY_ANY): System.Void use Implementation.ROUTINE_ANY_ANY"
		alias
			"$$adapt"
		end

	target: ANY is
		external
			"IL signature (): ANY use Implementation.ROUTINE_ANY_ANY"
		alias
			"target"
		end

	rout_disp: METHOD_BASE is
		external
			"IL signature (): System.Reflection.MethodBase use Implementation.ROUTINE_ANY_ANY"
		alias
			"rout_disp"
		end

	set_rout_disp (handle: RUNTIME_METHOD_HANDLE; closed_args: TUPLE; omap: ARRAY_INT32; cmap: ARRAY_INT32) is
		external
			"IL signature (System.RuntimeMethodHandle, TUPLE, ARRAY_INT32, ARRAY_INT32): System.Void use Implementation.ROUTINE_ANY_ANY"
		alias
			"set_rout_disp"
		end

	frozen ec_illegal_36_ec_illegal_36_is_equal (current_: ROUTINE_ANY_ANY; other: ROUTINE_ANY_ANY): BOOLEAN is
		external
			"IL static signature (ROUTINE_ANY_ANY, ROUTINE_ANY_ANY): System.Boolean use Implementation.ROUTINE_ANY_ANY"
		alias
			"$$is_equal"
		end

	callable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ROUTINE_ANY_ANY"
		alias
			"callable"
		end

	a_set_operands_set_by_user (operands_set_by_user2: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Implementation.ROUTINE_ANY_ANY"
		alias
			"_set_operands_set_by_user"
		end

	eif_gen_conf (type1: INTEGER; type2: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32, System.Int32): System.Boolean use Implementation.ROUTINE_ANY_ANY"
		alias
			"eif_gen_conf"
		end

	internal_clone: ANY is
		external
			"IL signature (): ANY use Implementation.ROUTINE_ANY_ANY"
		alias
			"internal_clone"
		end

	closed_map: NATIVE_ARRAY [INTEGER] is
		external
			"IL signature (): System.Int32[] use Implementation.ROUTINE_ANY_ANY"
		alias
			"closed_map"
		end

	frozen ec_illegal_36_ec_illegal_36_open_operand_type (current_: ROUTINE_ANY_ANY; i: INTEGER): INTEGER is
		external
			"IL static signature (ROUTINE_ANY_ANY, System.Int32): System.Int32 use Implementation.ROUTINE_ANY_ANY"
		alias
			"$$open_operand_type"
		end

	frozen ec_illegal_36_ec_illegal_36_eif_gen_param_id (current_: ROUTINE_ANY_ANY; stype: INTEGER; obj: POINTER; pos: INTEGER): INTEGER is
		external
			"IL static signature (ROUTINE_ANY_ANY, System.Int32, System.IntPtr, System.Int32): System.Int32 use Implementation.ROUTINE_ANY_ANY"
		alias
			"$$eif_gen_param_id"
		end

	standard_is_equal (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.ROUTINE_ANY_ANY"
		alias
			"standard_is_equal"
		end

	frozen ec_illegal_36_ec_illegal_36_arguments (current_: ROUTINE_ANY_ANY): TUPLE is
		external
			"IL static signature (ROUTINE_ANY_ANY): TUPLE use Implementation.ROUTINE_ANY_ANY"
		alias
			"$$arguments"
		end

	frozen ec_illegal_36_ec_illegal_36_eif_gen_typecode_str (current_: ROUTINE_ANY_ANY; obj: POINTER): STRING is
		external
			"IL static signature (ROUTINE_ANY_ANY, System.IntPtr): STRING use Implementation.ROUTINE_ANY_ANY"
		alias
			"$$eif_gen_typecode_str"
		end

	frozen ec_illegal_36_ec_illegal_36_target (current_: ROUTINE_ANY_ANY): ANY is
		external
			"IL static signature (ROUTINE_ANY_ANY): ANY use Implementation.ROUTINE_ANY_ANY"
		alias
			"$$target"
		end

	a_set_rout_disp (rout_disp2: METHOD_BASE) is
		external
			"IL signature (System.Reflection.MethodBase): System.Void use Implementation.ROUTINE_ANY_ANY"
		alias
			"_set_rout_disp"
		end

	is_hashable: BOOLEAN is
		external
			"IL signature (): System.Boolean use Implementation.ROUTINE_ANY_ANY"
		alias
			"is_hashable"
		end

	default_pointer: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.ROUTINE_ANY_ANY"
		alias
			"default_pointer"
		end

	is_equal_ (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.ROUTINE_ANY_ANY"
		alias
			"is_equal"
		end

	frozen ec_illegal_36_ec_illegal_36_eif_gen_typecode (current_: ROUTINE_ANY_ANY; obj: POINTER; pos: INTEGER): INTEGER_8 is
		external
			"IL static signature (ROUTINE_ANY_ANY, System.IntPtr, System.Int32): System.Byte use Implementation.ROUTINE_ANY_ANY"
		alias
			"$$eif_gen_typecode"
		end

	frozen ec_illegal_36_ec_illegal_36_set_operands (current_: ROUTINE_ANY_ANY; args: TUPLE) is
		external
			"IL static signature (ROUTINE_ANY_ANY, TUPLE): System.Void use Implementation.ROUTINE_ANY_ANY"
		alias
			"$$set_operands"
		end

	frozen ec_illegal_36_ec_illegal_36_rout_set_cargs (current_: ROUTINE_ANY_ANY) is
		external
			"IL static signature (ROUTINE_ANY_ANY): System.Void use Implementation.ROUTINE_ANY_ANY"
		alias
			"$$rout_set_cargs"
		end

	frozen ec_illegal_36_ec_illegal_36_adapt_from (current_: ROUTINE_ANY_ANY; other: ROUTINE_ANY_ANY) is
		external
			"IL static signature (ROUTINE_ANY_ANY, ROUTINE_ANY_ANY): System.Void use Implementation.ROUTINE_ANY_ANY"
		alias
			"$$adapt_from"
		end

	open_count: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.ROUTINE_ANY_ANY"
		alias
			"open_count"
		end

	print (some: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.ROUTINE_ANY_ANY"
		alias
			"print"
		end

	valid_arguments (args: TUPLE): BOOLEAN is
		external
			"IL signature (TUPLE): System.Boolean use Implementation.ROUTINE_ANY_ANY"
		alias
			"valid_arguments"
		end

	frozen a____class_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.ROUTINE_ANY_ANY"
		alias
			"____class_name"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use Implementation.ROUTINE_ANY_ANY"
		alias
			"Equals"
		end

	operands: TUPLE is
		external
			"IL signature (): TUPLE use Implementation.ROUTINE_ANY_ANY"
		alias
			"operands"
		end

	equal_ (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.ROUTINE_ANY_ANY"
		alias
			"equal"
		end

	clone_ (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.ROUTINE_ANY_ANY"
		alias
			"clone"
		end

	standard_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.ROUTINE_ANY_ANY"
		alias
			"standard_equal"
		end

	precondition (args: TUPLE): BOOLEAN is
		external
			"IL signature (TUPLE): System.Boolean use Implementation.ROUTINE_ANY_ANY"
		alias
			"precondition"
		end

	standard_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.ROUTINE_ANY_ANY"
		alias
			"standard_copy"
		end

	frozen ec_illegal_36_ec_illegal_36_eif_gen_conf (current_: ROUTINE_ANY_ANY; type1: INTEGER; type2: INTEGER): BOOLEAN is
		external
			"IL static signature (ROUTINE_ANY_ANY, System.Int32, System.Int32): System.Boolean use Implementation.ROUTINE_ANY_ANY"
		alias
			"$$eif_gen_conf"
		end

	arguments: TUPLE is
		external
			"IL signature (): TUPLE use Implementation.ROUTINE_ANY_ANY"
		alias
			"arguments"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.ROUTINE_ANY_ANY"
		alias
			"GetHashCode"
		end

	deep_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.ROUTINE_ANY_ANY"
		alias
			"deep_equal"
		end

	set_operands (args: TUPLE) is
		external
			"IL signature (TUPLE): System.Void use Implementation.ROUTINE_ANY_ANY"
		alias
			"set_operands"
		end

	a_set_rout_arguments (rout_arguments2: NATIVE_ARRAY [SYSTEM_OBJECT]) is
		external
			"IL signature (System.Object[]): System.Void use Implementation.ROUTINE_ANY_ANY"
		alias
			"_set_rout_arguments"
		end

	frozen ec_illegal_36_ec_illegal_36_eif_gen_create (current_: ROUTINE_ANY_ANY; obj: POINTER; pos: INTEGER): POINTER is
		external
			"IL static signature (ROUTINE_ANY_ANY, System.IntPtr, System.Int32): System.IntPtr use Implementation.ROUTINE_ANY_ANY"
		alias
			"$$eif_gen_create"
		end

	standard_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.ROUTINE_ANY_ANY"
		alias
			"standard_clone"
		end

	adapt (other: ROUTINE_ANY_ANY) is
		external
			"IL signature (ROUTINE_ANY_ANY): System.Void use Implementation.ROUTINE_ANY_ANY"
		alias
			"adapt"
		end

	default_rescue is
		external
			"IL signature (): System.Void use Implementation.ROUTINE_ANY_ANY"
		alias
			"default_rescue"
		end

	a_set_open_map (open_map2: NATIVE_ARRAY [INTEGER]) is
		external
			"IL signature (System.Int32[]): System.Void use Implementation.ROUTINE_ANY_ANY"
		alias
			"_set_open_map"
		end

	generator: STRING is
		external
			"IL signature (): STRING use Implementation.ROUTINE_ANY_ANY"
		alias
			"generator"
		end

	deep_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.ROUTINE_ANY_ANY"
		alias
			"deep_clone"
		end

	internal_copy (o: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.ROUTINE_ANY_ANY"
		alias
			"internal_copy"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.ROUTINE_ANY_ANY"
		alias
			"ToString"
		end

	frozen ec_illegal_36_ec_illegal_36_precondition (current_: ROUTINE_ANY_ANY; args: TUPLE): BOOLEAN is
		external
			"IL static signature (ROUTINE_ANY_ANY, TUPLE): System.Boolean use Implementation.ROUTINE_ANY_ANY"
		alias
			"$$precondition"
		end

	frozen ec_illegal_36_ec_illegal_36_callable (current_: ROUTINE_ANY_ANY): BOOLEAN is
		external
			"IL static signature (ROUTINE_ANY_ANY): System.Boolean use Implementation.ROUTINE_ANY_ANY"
		alias
			"$$callable"
		end

	deep_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.ROUTINE_ANY_ANY"
		alias
			"deep_copy"
		end

	adapt_from (other: ROUTINE_ANY_ANY) is
		external
			"IL signature (ROUTINE_ANY_ANY): System.Void use Implementation.ROUTINE_ANY_ANY"
		alias
			"adapt_from"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use Implementation.ROUTINE_ANY_ANY"
		alias
			"Finalize"
		end

end -- class IMPLEMENTATION_ROUTINE_ANY_ANY
