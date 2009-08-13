note
	description: "[
		Constant for byte code.
		Those character values have to match C values defined in "interp.h".
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class BYTE_CONST

feature -- Access

	Bc_start: 			CHARACTER = '%/000/';
	Bc_precond:			CHARACTER = '%/001/';
	Bc_postcond:		CHARACTER = '%/002/';
	Bc_deferred:		CHARACTER = '%/003/';
	Bc_reverse:			CHARACTER = '%/004/';
	Bc_check:			CHARACTER = '%/005/';
	Bc_assert:			CHARACTER = '%/006/';
	Bc_null:			CHARACTER = '%/007/';
	Bc_pre:				CHARACTER = '%/008/';
	Bc_pst:				CHARACTER = '%/009/';
	Bc_chk:				CHARACTER = '%/010/';
	Bc_linv:			CHARACTER = '%/011/';
	Bc_lvar:			CHARACTER = '%/012/';
	Bc_inv:				CHARACTER = '%/013/';
	Bc_end_assert:		CHARACTER = '%/014/';
	Bc_tag:				CHARACTER = '%/015/';
	Bc_notag:			CHARACTER = '%/016/';
	Bc_jmp_f:			CHARACTER = '%/017/';
	Bc_jmp:				CHARACTER = '%/018/';
	Bc_loop:			CHARACTER = '%/019/';
	Bc_end_variant:		CHARACTER = '%/020/';
	Bc_init_variant:	CHARACTER = '%/021/';
	Bc_debug:			CHARACTER = '%/022/';
	Bc_rassign:			CHARACTER = '%/023/';
	Bc_lassign:			CHARACTER = '%/024/';
	Bc_assign:			CHARACTER = '%/025/';
	Bc_create:			CHARACTER = '%/026/';
	Bc_ctype:			CHARACTER = '%/027/';
	Bc_carg:			CHARACTER = '%/028/';
	Bc_clike:			CHARACTER = '%/029/';
	Bc_ccur:			CHARACTER = '%/030/';
	Bc_create_type:		CHARACTER = '%/031/';
	Bc_range:			CHARACTER = '%/032/';
	Bc_inspect_excep:	CHARACTER = '%/033/';
	Bc_lreverse:		CHARACTER = '%/034/';
	Bc_rreverse:		CHARACTER = '%/035/';
	Bc_feature:			CHARACTER = '%/036/';
	Bc_metamorphose:	CHARACTER = '%/037/';
	Bc_current:			CHARACTER = '%/038/';
	Bc_rotate:			CHARACTER = '%/039/';
	Bc_feature_inv:		CHARACTER = '%/040/';
	Bc_attribute:		CHARACTER = '%/041/';
	Bc_attribute_inv:	CHARACTER = '%/042/';
	Bc_extern:			CHARACTER = '%/043/';
	Bc_extern_inv:		CHARACTER = '%/044/';
	Bc_char:			CHARACTER = '%/045/';
	Bc_bool:			CHARACTER = '%/046/';
	Bc_int:				CHARACTER = '%/047/';
	Bc_int32:			CHARACTER = '%/047/';
	Bc_real64:			CHARACTER = '%/048/';
	Bc_result:			CHARACTER = '%/049/';
	Bc_local:			CHARACTER = '%/050/';
	Bc_arg:				CHARACTER = '%/051/';
	Bc_uplus:			CHARACTER = '%/052/';
	Bc_uminus:			CHARACTER = '%/053/';
	Bc_not:				CHARACTER = '%/054/';
	Bc_lt:				CHARACTER = '%/055/';
	Bc_gt:				CHARACTER = '%/056/';
	Bc_minus:			CHARACTER = '%/057/';
	Bc_xor:				CHARACTER = '%/058/';
	Bc_ge:				CHARACTER = '%/059/';
	Bc_eq:				CHARACTER = '%/060/';
	Bc_ne:				CHARACTER = '%/061/';
	Bc_star:			CHARACTER = '%/062/';
	Bc_power:			CHARACTER = '%/063/';
	Bc_le:				CHARACTER = '%/064/';
	Bc_div:				CHARACTER = '%/065/';
	Bc_nhook:			CHARACTER = '%/066/';
	Bc_and:				CHARACTER = '%/067/';
	Bc_slash:			CHARACTER = '%/068/';
	Bc_mod:				CHARACTER = '%/069/';
	Bc_plus:			CHARACTER = '%/070/';
	Bc_or:				CHARACTER = '%/071/';
	Bc_addr:			CHARACTER = '%/072/';
	Bc_string:			CHARACTER = '%/073/';
	Bc_and_then:		CHARACTER = '%/074/';
	Bc_or_else:			CHARACTER = '%/075/';
	Bc_spcreate:		CHARACTER = '%/076/';
	Bc_tuple_access:	CHARACTER = '%/077/';
	Bc_jmp_t:			CHARACTER = '%/078/';
	Bc_tuple_assign:	CHARACTER = '%/079/';
	Bc_rescue: 			CHARACTER = '%/080/';
	Bc_end_rescue:		CHARACTER = '%/081/';
	Bc_retry:			CHARACTER = '%/082/';
	Bc_exp_assign:		CHARACTER = '%/083/';
	Bc_clone:			CHARACTER = '%/084/';
	Bc_exp_excep:		CHARACTER = '%/085/';
	Bc_void:			CHARACTER = '%/086/';
	Bc_none_assign:		CHARACTER = '%/087/';
	Bc_lexp_assign:		CHARACTER = '%/088/';
	Bc_rexp_assign:		CHARACTER = '%/089/';
	Bc_clone_arg:		CHARACTER = '%/090/';
	Bc_no_clone_arg:	CHARACTER = '%/091/';
	Bc_false_compar:	CHARACTER = '%/092/';
	Bc_true_compar:		CHARACTER = '%/093/';
	Bc_standard_equal:	CHARACTER = '%/094/';
	Bc_bit_standard_equal:	CHARACTER = '%/095/';
	Bc_hook:			CHARACTER = '%/096/';
	Bc_bit:				CHARACTER = '%/097/';
	Bc_array:			CHARACTER = '%/098/';
	Bc_retrieve_old:	CHARACTER = '%/099/';
	Bc_real32:			CHARACTER = '%/100/';
	Bc_old:				CHARACTER = '%/101/';
	Bc_add_strip:		CHARACTER = '%/102/';
	Bc_end_strip:		CHARACTER = '%/103/';
	Bc_lbit_assign:		CHARACTER = '%/104/';
	Bc_raise_prec:		CHARACTER = '%/105/';
	Bc_goto_body:		CHARACTER = '%/106/';
	Bc_not_rec:			CHARACTER = '%/107/';
	Bc_end_pre:			CHARACTER = '%/108/';
	bc_cast_natural:	CHARACTER = '%/109/';
	Bc_cast_integer:	CHARACTER = '%/110/';
	Bc_cast_real32:		CHARACTER = '%/111/';
	Bc_cast_real64:		CHARACTER = '%/112/';
	Bc_inv_null:		CHARACTER = '%/113/';
	Bc_create_inv:		CHARACTER = '%/114/';
	Bc_end_eval_old:	CHARACTER = '%/115/';
	Bc_start_eval_old:	CHARACTER = '%/116/';
	Bc_object_addr:		CHARACTER = '%/117/';
	Bc_pfeature:		CHARACTER = '%/118/';
	Bc_pfeature_inv:	CHARACTER = '%/119/';
	Bc_pextern:			CHARACTER = '%/120/';
	Bc_pextern_inv:		CHARACTER = '%/121/';
	Bc_parray:			CHARACTER = '%/122/';
	Bc_pattribute:		CHARACTER = '%/123/';
	Bc_pattribute_inv:	CHARACTER = '%/124/';
	Bc_pexp_assign:		CHARACTER = '%/125/';
	Bc_passign:			CHARACTER = '%/126/';
	Bc_preverse:		CHARACTER = '%/127/';
	Bc_pclike:			CHARACTER = '%/128/';
	Bc_object_expr_addr:CHARACTER = '%/129/';
	Bc_reserve:			CHARACTER = '%/130/';
	Bc_pop:				CHARACTER = '%/131/';
	Bc_ref_to_ptr:		CHARACTER = '%/132/';
	Bc_rcreate:			CHARACTER = '%/133/';

		-- Special instructions operation for builtins
	bc_builtin:			CHARACTER = '%/134/'
	bc_builtin_unknown: CHARACTER = '%/001/'
	bc_builtin_type__has_default: CHARACTER = '%/002/'
	bc_builtin_type__default: CHARACTER = '%/003/'
	bc_builtin_type__type_id: CHARACTER = '%/004/'
	bc_builtin_type__runtime_name: CHARACTER = '%/005/'
	bc_builtin_type__generic_parameter_type: CHARACTER = '%/006/'
	bc_builtin_type__generic_parameter_count: CHARACTER = '%/007/'


	Bc_cast_char32:		CHARACTER = '%/135/';
	Bc_null_pointer:	CHARACTER = '%/136/';

		-- Special instructions operation for basic type optimisations
	Bc_basic_operations:	CHARACTER = '%/137/'
	Bc_max:			CHARACTER = '%/001/'
	Bc_min:			CHARACTER = '%/002/'
	Bc_generator:		CHARACTER = '%/003/'
	Bc_offset:			CHARACTER = '%/004/'
	Bc_zero:			CHARACTER = '%/005/'
	Bc_one:			CHARACTER = '%/006/'
	Bc_three_way_comparison: CHARACTER = '%/007/'

		-- Special instructions for Bit operations
	Bc_int_bit_op:		CHARACTER = '%/138/'
	bc_int_bit_and:		CHARACTER = '%/001/'
	bc_int_bit_or:		CHARACTER = '%/002/'
	bc_int_bit_xor:		CHARACTER = '%/003/'
	bc_int_bit_not:		CHARACTER = '%/004/'
	bc_int_bit_shift_left:		CHARACTER = '%/005/'
	bc_int_bit_shift_right:		CHARACTER = '%/006/'
	bc_int_bit_test:		CHARACTER = '%/007/'
	bc_int_set_bit:		CHARACTER = '%/008/'
	bc_int_set_bit_with_mask:		CHARACTER = '%/009/'

		-- New basic types
	Bc_wchar:			CHARACTER = '%/139/'
	Bc_int8:			CHARACTER = '%/140/'
	Bc_int16:			CHARACTER = '%/141/'
	Bc_int64:			CHARACTER = '%/142/'

		-- Conversion
	bc_cast_char8:		CHARACTER = '%/143/'

		-- Once manifest strings
	Bc_once_string:		CHARACTER = '%/144/'
	Bc_allocate_once_strings:	CHARACTER = '%/145/'

		-- Conditional cloning and equality
	Bc_cclone:		CHARACTER = '%/146/';
	Bc_cequal:		CHARACTER = '%/147/';

	Bc_object_test:		CHARACTER = '%/148/'

		-- Object reattachment
	Bc_box:			CHARACTER = '%/149/';

		-- NATURAL constants
	Bc_uint8:			CHARACTER = '%/150/';
	Bc_uint16:			CHARACTER = '%/151/';
	Bc_uint32:			CHARACTER = '%/152/';
	Bc_uint64:			CHARACTER = '%/153/';

	Bc_floor:			CHARACTER = '%/154/';
	Bc_ceil:			CHARACTER = '%/155/';

	Bc_catcall:			CHARACTER = '%/156/';
	Bc_start_catcall: 	CHARACTER = '%/157/';
	Bc_end_catcall:		CHARACTER = '%/158/';

		-- Type test
	Bc_is_attached:		CHARACTER = '%/159/';

		-- Unused opcode
	Bc_notused_160:		CHARACTER = '%/160/';
	Bc_notused_161:		CHARACTER = '%/161/';
	Bc_notused_162:		CHARACTER = '%/162/';
	Bc_notused_163:		CHARACTER = '%/163/';
	Bc_notused_164:		CHARACTER = '%/164/';
	Bc_notused_165:		CHARACTER = '%/165/';
	Bc_notused_166:		CHARACTER = '%/166/';
	Bc_notused_167:		CHARACTER = '%/167/';

		-- Manifest tuple
	Bc_tuple:				CHARACTER = '%/168/'
	Bc_ptuple:				CHARACTER = '%/169/';

note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class BYTE_CONST
