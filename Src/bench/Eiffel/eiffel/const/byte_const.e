indexing
	description: "[
		Constant for byte code.
		Those character values have to match C values defined in "interp.h".
		]"
	date: "$Date$"
	revision: "$Revision$"

class BYTE_CONST
	
feature -- Access

	Bc_start: 			CHARACTER is '%/000/';
	Bc_precond:			CHARACTER is '%/001/';
	Bc_postcond:		CHARACTER is '%/002/';
	Bc_deferred:		CHARACTER is '%/003/';
	Bc_reverse:			CHARACTER is '%/004/';
	Bc_check:			CHARACTER is '%/005/';
	Bc_assert:			CHARACTER is '%/006/';
	Bc_null:			CHARACTER is '%/007/';
	Bc_pre:				CHARACTER is '%/008/';
	Bc_pst:				CHARACTER is '%/009/';
	Bc_chk:				CHARACTER is '%/010/';
	Bc_linv:			CHARACTER is '%/011/';
	Bc_lvar:			CHARACTER is '%/012/';
	Bc_inv:				CHARACTER is '%/013/';
	Bc_end_assert:		CHARACTER is '%/014/';
	Bc_tag:				CHARACTER is '%/015/';
	Bc_notag:			CHARACTER is '%/016/';
	Bc_jmp_f:			CHARACTER is '%/017/';
	Bc_jmp:				CHARACTER is '%/018/';
	Bc_loop:			CHARACTER is '%/019/';
	Bc_end_variant:		CHARACTER is '%/020/';
	Bc_init_variant:	CHARACTER is '%/021/';
	Bc_debug:			CHARACTER is '%/022/';
	Bc_rassign:			CHARACTER is '%/023/';
	Bc_lassign:			CHARACTER is '%/024/';
	Bc_assign:			CHARACTER is '%/025/';
	Bc_create:			CHARACTER is '%/026/';
	Bc_ctype:			CHARACTER is '%/027/';
	Bc_carg:			CHARACTER is '%/028/';
	Bc_clike:			CHARACTER is '%/029/';
	Bc_ccur:			CHARACTER is '%/030/';
	Bc_inspect:			CHARACTER is '%/031/';
	Bc_range:			CHARACTER is '%/032/';
	Bc_inspect_excep:	CHARACTER is '%/033/';
	Bc_lreverse:		CHARACTER is '%/034/';
	Bc_rreverse:		CHARACTER is '%/035/';
	Bc_feature:			CHARACTER is '%/036/';
	Bc_metamorphose:	CHARACTER is '%/037/';
	Bc_current:			CHARACTER is '%/038/';
	Bc_rotate:			CHARACTER is '%/039/';
	Bc_feature_inv:		CHARACTER is '%/040/';
	Bc_attribute:		CHARACTER is '%/041/';
	Bc_attribute_inv:	CHARACTER is '%/042/';
	Bc_extern:			CHARACTER is '%/043/';
	Bc_extern_inv:		CHARACTER is '%/044/';
	Bc_char:			CHARACTER is '%/045/';
	Bc_bool:			CHARACTER is '%/046/';
	Bc_int:				CHARACTER is '%/047/';
	Bc_int32:			CHARACTER is '%/047/';
	Bc_double:			CHARACTER is '%/048/';
	Bc_result:			CHARACTER is '%/049/';
	Bc_local:			CHARACTER is '%/050/';
	Bc_arg:				CHARACTER is '%/051/';
	Bc_uplus:			CHARACTER is '%/052/';
	Bc_uminus:			CHARACTER is '%/053/';
	Bc_not:				CHARACTER is '%/054/';
	Bc_lt:				CHARACTER is '%/055/';
	Bc_gt:				CHARACTER is '%/056/';
	Bc_minus:			CHARACTER is '%/057/';
	Bc_xor:				CHARACTER is '%/058/';
	Bc_ge:				CHARACTER is '%/059/';
	Bc_eq:				CHARACTER is '%/060/';
	Bc_ne:				CHARACTER is '%/061/';
	Bc_star:			CHARACTER is '%/062/';
	Bc_power:			CHARACTER is '%/063/';
	Bc_le:				CHARACTER is '%/064/';
	Bc_div:				CHARACTER is '%/065/';
	Bc_nhook:			CHARACTER is '%/066/';
	Bc_and:				CHARACTER is '%/067/';
	Bc_slash:			CHARACTER is '%/068/';
	Bc_mod:				CHARACTER is '%/069/';
	Bc_plus:			CHARACTER is '%/070/';
	Bc_or:				CHARACTER is '%/071/';
	Bc_addr:			CHARACTER is '%/072/';
	Bc_string:			CHARACTER is '%/073/';
	Bc_and_then:		CHARACTER is '%/074/';
	Bc_or_else:			CHARACTER is '%/075/';
	Bc_protect:			CHARACTER is '%/076/';
	Bc_release:			CHARACTER is '%/077/';
	Bc_jmp_t:			CHARACTER is '%/078/';
	Bc_rescue: 			CHARACTER is '%/080/';
	Bc_end_rescue:		CHARACTER is '%/081/';
	Bc_retry:			CHARACTER is '%/082/';
	Bc_exp_assign:		CHARACTER is '%/083/';
	Bc_clone:			CHARACTER is '%/084/';
	Bc_exp_excep:		CHARACTER is '%/085/';
	Bc_void:			CHARACTER is '%/086/';
	Bc_none_assign:		CHARACTER is '%/087/';
	Bc_lexp_assign:		CHARACTER is '%/088/';
	Bc_rexp_assign:		CHARACTER is '%/089/';
	Bc_clone_arg:		CHARACTER is '%/090/';
	Bc_no_clone_arg:	CHARACTER is '%/091/';
	Bc_false_compar:	CHARACTER is '%/092/';
	Bc_true_compar:		CHARACTER is '%/093/';
	Bc_standard_equal:	CHARACTER is '%/094/';
	Bc_bit_standard_equal:	CHARACTER is '%/095/';
	Bc_hook:			CHARACTER is '%/096/';
	Bc_bit:				CHARACTER is '%/097/';
	Bc_array:			CHARACTER is '%/098/';
	Bc_retrieve_old:	CHARACTER is '%/099/';
	Bc_float:			CHARACTER is '%/100/';
	Bc_old:				CHARACTER is '%/101/';
	Bc_add_strip:		CHARACTER is '%/102/';
	Bc_end_strip:		CHARACTER is '%/103/';
	Bc_lbit_assign:		CHARACTER is '%/104/';
	Bc_raise_prec:		CHARACTER is '%/105/';
	Bc_goto_body:		CHARACTER is '%/106/';
	Bc_not_rec:			CHARACTER is '%/107/';
	Bc_end_pre:			CHARACTER is '%/108/';
	Bc_cast_long:		CHARACTER is '%/110/';
	Bc_cast_float:		CHARACTER is '%/111/';
	Bc_cast_double:		CHARACTER is '%/112/';
	Bc_inv_null:		CHARACTER is '%/113/';
	Bc_create_inv:		CHARACTER is '%/114/';
	Bc_end_eval_old:	CHARACTER is '%/115/';
	Bc_start_eval_old:	CHARACTER is '%/116/';
	Bc_object_addr:		CHARACTER is '%/117/';
	Bc_pfeature:		CHARACTER is '%/118/';
	Bc_pfeature_inv:	CHARACTER is '%/119/';
	Bc_pextern:			CHARACTER is '%/120/';
	Bc_pextern_inv:		CHARACTER is '%/121/';
	Bc_parray:			CHARACTER is '%/122/';
	Bc_pattribute:		CHARACTER is '%/123/';
	Bc_pattribute_inv:	CHARACTER is '%/124/';
	Bc_pexp_assign:		CHARACTER is '%/125/';
	Bc_passign:			CHARACTER is '%/126/';
	Bc_preverse:		CHARACTER is '%/127/';
	Bc_pclike:			CHARACTER is '%/128/';
	Bc_object_expr_addr:CHARACTER is '%/129/';
	Bc_reserve:			CHARACTER is '%/130/';
	Bc_pop:				CHARACTER is '%/131/';
	Bc_ref_to_ptr:		CHARACTER is '%/132/';
	Bc_rcreate:			CHARACTER is '%/133/';
	Bc_gen_param_create:CHARACTER is '%/134/';
	Bc_create_exp:		CHARACTER is '%/135/';
	Bc_null_pointer:	CHARACTER is '%/136/';

		-- Special instructions operation for basic type optimisations
	Bc_basic_operations:	CHARACTER is '%/137/'
	Bc_max:			CHARACTER is '%/001/'
	Bc_min:			CHARACTER is '%/002/'
	Bc_generator:		CHARACTER is '%/003/'
	Bc_offset:			CHARACTER is '%/004/'
	Bc_zero:			CHARACTER is '%/005/'
	Bc_one:			CHARACTER is '%/006/'

		-- Special instructions for Bit operations
	Bc_int_bit_op:		CHARACTER is '%/138/'
	bc_int_bit_and:		CHARACTER is '%/001/'
	bc_int_bit_or:		CHARACTER is '%/002/'
	bc_int_bit_xor:		CHARACTER is '%/003/'
	bc_int_bit_not:		CHARACTER is '%/004/'
	bc_int_bit_shift_left:		CHARACTER is '%/005/'
	bc_int_bit_shift_right:		CHARACTER is '%/006/'
	bc_int_bit_test:		CHARACTER is '%/007/'

		-- New basic types
	Bc_wchar:			CHARACTER is '%/139/'
	Bc_int8:			CHARACTER is '%/140/'
	Bc_int16:			CHARACTER is '%/141/'
	Bc_int64:			CHARACTER is '%/142/'

		-- Instructions for Concurrent Eiffel

	Bc_sep_set:			CHARACTER is '%/150/'; 
		-- the precondition clause contains separate feature call.
	Bc_sep_unset:		CHARACTER is '%/151/'; 
		-- clear the variable indicating if separate feature call has been met
	Bc_sep_reserve:		CHARACTER is '%/152/'; 
		-- reserve separate parameters of a feature.
	Bc_sep_free:		CHARACTER is '%/153/'; 
		-- free separate parameters of a feature.
	Bc_sep_to_sep:		CHARACTER is '%/154/'; 
		-- convert a local reference object into separate object.
	Bc_sep_raise_prec:	CHARACTER is '%/155/'; 
		-- process the failure of precondition checking with separate feature call(s)
	Bc_sep_create:			CHARACTER is '%/156/';
		-- create a separate object.
	Bc_sep_create_end: 		CHARACTER is '%/157/';
		-- end of creating a separate object.

	Bc_sep_attribute_inv:	CHARACTER is '%/158/'; 
		-- a separate attribute call which is not precompiled.
	Bc_sep_extern_inv:		CHARACTER is '%/159/';
		-- a separate external feature call which is not precompiled.
	Bc_sep_feature_inv:		CHARACTER is '%/160/'; 
		-- a separate feature call which is not precompiled.

	Bc_sep_pattribute_inv:	CHARACTER is '%/161/'; 
		-- a separate attribute call which is precompiled.
	Bc_sep_pextern_inv:		CHARACTER is '%/162/';
		-- a separate external feature call which is  precompiled.
	Bc_sep_pfeature_inv:	CHARACTER is '%/163/'; 
		-- a separate feature call which is precompiled.

		-- The following 4 instructions are only used for creating separate 
		-- object, and actually they can be got rid of if necessary.
	Bc_sep_extern:			CHARACTER is '%/164/';
		-- a separate external feature call which is not precompiled.
	Bc_sep_feature:			CHARACTER is '%/165/'; 
		-- a separate feature call which is not precompiled.
	Bc_sep_pextern:			CHARACTER is '%/166/';
		-- a separate external feature call which is precompiled.
	Bc_sep_pfeature:		CHARACTER is '%/167/'; 
		-- a separate feature call which is precompiled.

	Bc_java_rtype:			CHARACTER is '%/200/'
		-- return type of a feature call or attribute access.
		-- needed for features of formal generic type.
	Bc_java_external:		CHARACTER is '%/201/'
		-- name of external routine in an external call.

end -- class BYTE_CONST
