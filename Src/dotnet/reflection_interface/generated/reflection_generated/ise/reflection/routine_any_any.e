indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "ROUTINE_ANY_ANY"

deferred external class
	ROUTINE_ANY_ANY

inherit
	HASHABLE

feature -- Basic Operations

	postcondition (args: TUPLE): BOOLEAN is
		external
			"IL deferred signature (TUPLE): System.Boolean use ROUTINE_ANY_ANY"
		alias
			"postcondition"
		end

	a_set_rout_arguments (rout_arguments2: NATIVE_ARRAY [SYSTEM_OBJECT]) is
		external
			"IL deferred signature (System.Object[]): System.Void use ROUTINE_ANY_ANY"
		alias
			"_set_rout_arguments"
		end

	eif_gen_conf (type1: INTEGER; type2: INTEGER): BOOLEAN is
		external
			"IL deferred signature (System.Int32, System.Int32): System.Boolean use ROUTINE_ANY_ANY"
		alias
			"eif_gen_conf"
		end

	open_map: NATIVE_ARRAY [INTEGER] is
		external
			"IL deferred signature (): System.Int32[] use ROUTINE_ANY_ANY"
		alias
			"open_map"
		end

	rout_arguments: NATIVE_ARRAY [SYSTEM_OBJECT] is
		external
			"IL deferred signature (): System.Object[] use ROUTINE_ANY_ANY"
		alias
			"rout_arguments"
		end

	target: ANY is
		external
			"IL deferred signature (): ANY use ROUTINE_ANY_ANY"
		alias
			"target"
		end

	set_rout_disp (handle: RUNTIME_METHOD_HANDLE; closed_args: TUPLE; omap: ARRAY_INT32; cmap: ARRAY_INT32) is
		external
			"IL deferred signature (System.RuntimeMethodHandle, TUPLE, ARRAY_INT32, ARRAY_INT32): System.Void use ROUTINE_ANY_ANY"
		alias
			"set_rout_disp"
		end

	rout_set_cargs is
		external
			"IL deferred signature (): System.Void use ROUTINE_ANY_ANY"
		alias
			"rout_set_cargs"
		end

	a_set_closed_map (closed_map2: NATIVE_ARRAY [INTEGER]) is
		external
			"IL deferred signature (System.Int32[]): System.Void use ROUTINE_ANY_ANY"
		alias
			"_set_closed_map"
		end

	rout_target: SYSTEM_OBJECT is
		external
			"IL deferred signature (): System.Object use ROUTINE_ANY_ANY"
		alias
			"rout_target"
		end

	set_operands (args: TUPLE) is
		external
			"IL deferred signature (TUPLE): System.Void use ROUTINE_ANY_ANY"
		alias
			"set_operands"
		end

	closed_operands: TUPLE is
		external
			"IL deferred signature (): TUPLE use ROUTINE_ANY_ANY"
		alias
			"closed_operands"
		end

	valid_arguments (args: TUPLE): BOOLEAN is
		external
			"IL deferred signature (TUPLE): System.Boolean use ROUTINE_ANY_ANY"
		alias
			"valid_arguments"
		end

	callable: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use ROUTINE_ANY_ANY"
		alias
			"callable"
		end

	a_set_rout_target (rout_target2: SYSTEM_OBJECT) is
		external
			"IL deferred signature (System.Object): System.Void use ROUTINE_ANY_ANY"
		alias
			"_set_rout_target"
		end

	adapt_from (other: ROUTINE_ANY_ANY) is
		external
			"IL deferred signature (ROUTINE_ANY_ANY): System.Void use ROUTINE_ANY_ANY"
		alias
			"adapt_from"
		end

	arguments: TUPLE is
		external
			"IL deferred signature (): TUPLE use ROUTINE_ANY_ANY"
		alias
			"arguments"
		end

	set_arguments (args: TUPLE) is
		external
			"IL deferred signature (TUPLE): System.Void use ROUTINE_ANY_ANY"
		alias
			"set_arguments"
		end

	apply is
		external
			"IL deferred signature (): System.Void use ROUTINE_ANY_ANY"
		alias
			"apply"
		end

	open_operand_type (i: INTEGER): INTEGER is
		external
			"IL deferred signature (System.Int32): System.Int32 use ROUTINE_ANY_ANY"
		alias
			"open_operand_type"
		end

	closed_map: NATIVE_ARRAY [INTEGER] is
		external
			"IL deferred signature (): System.Int32[] use ROUTINE_ANY_ANY"
		alias
			"closed_map"
		end

	eif_gen_typecode_str (obj: POINTER): STRING is
		external
			"IL deferred signature (System.IntPtr): STRING use ROUTINE_ANY_ANY"
		alias
			"eif_gen_typecode_str"
		end

	a_set_operands_set_by_user (operands_set_by_user2: BOOLEAN) is
		external
			"IL deferred signature (System.Boolean): System.Void use ROUTINE_ANY_ANY"
		alias
			"_set_operands_set_by_user"
		end

	open_types: ARRAY_INT32 is
		external
			"IL deferred signature (): ARRAY_INT32 use ROUTINE_ANY_ANY"
		alias
			"open_types"
		end

	precondition (args: TUPLE): BOOLEAN is
		external
			"IL deferred signature (TUPLE): System.Boolean use ROUTINE_ANY_ANY"
		alias
			"precondition"
		end

	eif_gen_create (obj: POINTER; pos: INTEGER): POINTER is
		external
			"IL deferred signature (System.IntPtr, System.Int32): System.IntPtr use ROUTINE_ANY_ANY"
		alias
			"eif_gen_create"
		end

	valid_operands (args: TUPLE): BOOLEAN is
		external
			"IL deferred signature (TUPLE): System.Boolean use ROUTINE_ANY_ANY"
		alias
			"valid_operands"
		end

	eif_gen_typecode (obj: POINTER; pos: INTEGER): INTEGER_8 is
		external
			"IL deferred signature (System.IntPtr, System.Int32): System.Byte use ROUTINE_ANY_ANY"
		alias
			"eif_gen_typecode"
		end

	a_set_closed_operands (closed_operands2: TUPLE) is
		external
			"IL deferred signature (TUPLE): System.Void use ROUTINE_ANY_ANY"
		alias
			"_set_closed_operands"
		end

	a_set_open_map (open_map2: NATIVE_ARRAY [INTEGER]) is
		external
			"IL deferred signature (System.Int32[]): System.Void use ROUTINE_ANY_ANY"
		alias
			"_set_open_map"
		end

	a_set_open_types (open_types2: ARRAY_INT32) is
		external
			"IL deferred signature (ARRAY_INT32): System.Void use ROUTINE_ANY_ANY"
		alias
			"_set_open_types"
		end

	a_set_operands (operands2: TUPLE) is
		external
			"IL deferred signature (TUPLE): System.Void use ROUTINE_ANY_ANY"
		alias
			"_set_operands"
		end

	adapt (other: ROUTINE_ANY_ANY) is
		external
			"IL deferred signature (ROUTINE_ANY_ANY): System.Void use ROUTINE_ANY_ANY"
		alias
			"adapt"
		end

	operands_set_by_user: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use ROUTINE_ANY_ANY"
		alias
			"operands_set_by_user"
		end

	call (args: TUPLE) is
		external
			"IL deferred signature (TUPLE): System.Void use ROUTINE_ANY_ANY"
		alias
			"call"
		end

	open_count: INTEGER is
		external
			"IL deferred signature (): System.Int32 use ROUTINE_ANY_ANY"
		alias
			"open_count"
		end

	rout_disp: METHOD_BASE is
		external
			"IL deferred signature (): System.Reflection.MethodBase use ROUTINE_ANY_ANY"
		alias
			"rout_disp"
		end

	eif_gen_tuple_typecode_str (obj: POINTER): STRING is
		external
			"IL deferred signature (System.IntPtr): STRING use ROUTINE_ANY_ANY"
		alias
			"eif_gen_tuple_typecode_str"
		end

	operands: TUPLE is
		external
			"IL deferred signature (): TUPLE use ROUTINE_ANY_ANY"
		alias
			"operands"
		end

	a_set_rout_disp (rout_disp2: METHOD_BASE) is
		external
			"IL deferred signature (System.Reflection.MethodBase): System.Void use ROUTINE_ANY_ANY"
		alias
			"_set_rout_disp"
		end

	eif_gen_param_id (stype: INTEGER; obj: POINTER; pos: INTEGER): INTEGER is
		external
			"IL deferred signature (System.Int32, System.IntPtr, System.Int32): System.Int32 use ROUTINE_ANY_ANY"
		alias
			"eif_gen_param_id"
		end

end -- class ROUTINE_ANY_ANY
