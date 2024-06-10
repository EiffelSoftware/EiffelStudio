note
	description: "Objects used to evaluate features in dotnet system"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	EIFNET_DEBUGGER_EVALUATOR

inherit
	EIFNET_EXPORTER

	ICOR_EXPORTER

	SHARED_DEBUGGER_MANAGER
		export
			{NONE} all
		end

	EIFNET_ICOR_ELEMENT_TYPES_CONSTANTS
		export
			{NONE} all
		end

	SHARED_EIFNET_DEBUG_VALUE_FORMATTER

	SHARED_TYPES
		export
			{NONE} all
		end

	SHARED_EIFFEL_PROJECT

create
	make

feature {NONE} -- Initialization

	make (dbg: EIFNET_DEBUGGER)
			-- Initializing Current with `dbg'
		do
			eifnet_debugger := dbg
		end

	eifnet_debugger: EIFNET_DEBUGGER
			-- Bridge to the dotnet debugger

feature -- Status

	last_call_success: INTEGER
			-- last_call_success from ICOR_DEBUG_EVAL

	last_eval_is_exception: BOOLEAN
			-- last eval raised an Eval Exception

	last_eval_aborted: BOOLEAN
			-- last eval had been Aborted

	last_call_succeed: BOOLEAN
		do
			Result := return_code_is_call_succeed (last_call_success)
		end

feature {EIFNET_EXPORTER} -- Evaluation primitives

	function_evaluation (a_frame: detachable ICOR_DEBUG_FRAME; a_func: ICOR_DEBUG_FUNCTION; a_args: ARRAY [ICOR_DEBUG_VALUE]): ICOR_DEBUG_VALUE
			-- Function evaluation result for `a_func' on `a_icd'
		require
			func_not_void: a_func /= Void
		do
			debug ("debugger_trace_eval")
				print ("Start : " + generator + ".function_evaluation ... %N")
				io.put_string_32 ({STRING_32} " -----> " + a_func.to_function_name + "%N")
			end
			prepare_evaluation (a_frame, True)

			if last_icor_debug_eval /= Void then
				last_icor_debug_eval.call_function (a_func, a_args)
			end
			Result := complete_function_evaluation
			debug ("debugger_trace_eval")
				print ("End : " + generator + ".function_evaluation ... %N")
			end
		rescue
			if eifnet_debugger.is_inside_function_evaluation then
				evaluation_termination (True)
			end
		end

	method_evaluation (a_frame: detachable ICOR_DEBUG_FRAME; a_meth: ICOR_DEBUG_FUNCTION; a_args: ARRAY [ICOR_DEBUG_VALUE])
			-- Method evaluation result for `a_meth' on `a_icd'
		require
			args_not_void: a_args /= Void
			meth_not_void: a_meth /= Void
		do
			prepare_evaluation (a_frame, True)
			if last_icor_debug_eval /= Void then
				last_icor_debug_eval.call_function (a_meth, a_args)
			end
			complete_method_evaluation
		rescue
			if eifnet_debugger.is_inside_function_evaluation then
				evaluation_termination (True)
			end
		end

	new_cil_string_evaluation (a_frame: detachable ICOR_DEBUG_FRAME; a_string: READABLE_STRING_GENERAL): ICOR_DEBUG_VALUE
			-- NewString evaluation with `a_string'
		require
			a_string /= Void
		do
			prepare_evaluation (a_frame, True)
			last_icor_debug_eval.new_string (a_string)
			Result := complete_function_evaluation
		end

	new_object_no_constructor_evaluation (a_frame: detachable ICOR_DEBUG_FRAME; a_icd_class: ICOR_DEBUG_CLASS): ICOR_DEBUG_VALUE
			-- NewObjectNoConstructor evaluation on `a_icd_class'
		require
			a_icd_class /= Void
		do
			prepare_evaluation (a_frame, True)
			last_icor_debug_eval.new_object_no_constructor (a_icd_class)
			Result := complete_function_evaluation
		end

	new_object_evaluation (a_frame: ICOR_DEBUG_FRAME; a_icd_func: ICOR_DEBUG_FUNCTION; a_args: ARRAY [ICOR_DEBUG_VALUE]): ICOR_DEBUG_VALUE
			-- NewObject evaluation on `a_icd_class'
		require
			a_icd_func /= Void
			a_args /= Void
		do
			prepare_evaluation (a_frame, True)
			last_icor_debug_eval.new_object (a_icd_func, a_args)
			Result := complete_function_evaluation
		end

feature {EIFNET_EXPORTER} -- Basic value creation

	new_elt_value_evaluation (a_frame: detachable ICOR_DEBUG_FRAME; a_pval: POINTER; a_elt_type: INTEGER): ICOR_DEBUG_VALUE
			-- New Object evaluation with `a_elt_type'.
		local
			l_gen_obj: ICOR_DEBUG_GENERIC_VALUE
		do
			prepare_evaluation (a_frame, False)
			Result := last_icor_debug_eval.create_value (a_elt_type , Void)
			if Result /= Void then
				l_gen_obj := Result.query_interface_icor_debug_generic_value
				check l_gen_obj /= Void end
				l_gen_obj.set_value (a_pval)
				l_gen_obj.clean_on_dispose
			end
			end_evaluation
		end

	new_i1_evaluation (a_frame: detachable ICOR_DEBUG_FRAME; a_val: INTEGER_8): ICOR_DEBUG_VALUE
			-- New Object evaluation with i1
		do
			Result := new_elt_value_evaluation (a_frame, $a_val, element_type_i1)
		end

	new_i2_evaluation (a_frame: detachable ICOR_DEBUG_FRAME; a_val: INTEGER_16): ICOR_DEBUG_VALUE
			-- New Object evaluation with i2
		do
			Result := new_elt_value_evaluation (a_frame, $a_val, element_type_i2)
		end

	new_i4_evaluation (a_frame: detachable ICOR_DEBUG_FRAME; a_val: INTEGER_32): ICOR_DEBUG_VALUE
			-- New Object evaluation with i4
		do
			Result := new_elt_value_evaluation (a_frame, $a_val, element_type_i4)
		end

	new_i8_evaluation (a_frame: detachable ICOR_DEBUG_FRAME; a_val: INTEGER_64): ICOR_DEBUG_VALUE
			-- New Object evaluation with i8
		do
			Result := new_elt_value_evaluation (a_frame, $a_val, element_type_i8)
		end

	new_u1_evaluation (a_frame: detachable ICOR_DEBUG_FRAME; a_val: NATURAL_8): ICOR_DEBUG_VALUE
			-- New Object evaluation with u1
		do
			Result := new_elt_value_evaluation (a_frame, $a_val, element_type_u1)
		end

	new_u2_evaluation (a_frame: detachable ICOR_DEBUG_FRAME; a_val: NATURAL_16): ICOR_DEBUG_VALUE
			-- New Object evaluation with u2
		do
			Result := new_elt_value_evaluation (a_frame, $a_val, element_type_u2)
		end

	new_u4_evaluation (a_frame: detachable ICOR_DEBUG_FRAME; a_val: NATURAL_32): ICOR_DEBUG_VALUE
			-- New Object evaluation with u4
		do
			Result := new_elt_value_evaluation (a_frame, $a_val, element_type_u4)
		end

	new_u8_evaluation (a_frame: detachable ICOR_DEBUG_FRAME; a_val: NATURAL_64): ICOR_DEBUG_VALUE
			-- New Object evaluation with u8
		do
			Result := new_elt_value_evaluation (a_frame, $a_val, element_type_u8)
		end

	new_r4_evaluation (a_frame: detachable ICOR_DEBUG_FRAME; a_val: REAL): ICOR_DEBUG_VALUE
			-- New Object evaluation with real
		do
			Result := new_elt_value_evaluation (a_frame, $a_val, element_type_r4)
		end

	new_r8_evaluation (a_frame: detachable ICOR_DEBUG_FRAME; a_val: DOUBLE): ICOR_DEBUG_VALUE
			-- New Object evaluation with real
		do
			Result := new_elt_value_evaluation (a_frame, $a_val, element_type_r8)
		end

	new_boolean_evaluation (a_frame: detachable ICOR_DEBUG_FRAME; a_val: BOOLEAN): ICOR_DEBUG_VALUE
			-- New Object evaluation with Boolean
		do
			Result := new_elt_value_evaluation (a_frame, $a_val, element_type_boolean)
		end

	new_char_evaluation (a_frame: detachable ICOR_DEBUG_FRAME; a_val: CHARACTER_8): ICOR_DEBUG_VALUE
			-- New Object evaluation with Character
		do
			Result := new_elt_value_evaluation (a_frame, $a_val, element_type_char)
		end

	new_char32_evaluation (a_frame: detachable ICOR_DEBUG_FRAME; a_val: CHARACTER_32): ICOR_DEBUG_VALUE
			-- New Object evaluation with Character
		do
			Result := new_elt_value_evaluation (a_frame, $a_val, element_type_u4)
		end

	new_ptr_evaluation (a_frame: detachable ICOR_DEBUG_FRAME; a_val: POINTER): ICOR_DEBUG_VALUE
			-- New Object evaluation with Character
		do
			Result := new_elt_value_evaluation (a_frame, $a_val, element_type_ptr)
		end

	new_void_evaluation (a_frame: detachable ICOR_DEBUG_FRAME): ICOR_DEBUG_VALUE
			-- New Object evaluation with Void
		do
			prepare_evaluation (a_frame, False)
			Result := last_icor_debug_eval.create_value (element_type_class, Void)
			end_evaluation
		end

feature {EIFNET_EXPORTER} -- Eiffel Instances facilities

	new_eiffel_string_8_evaluation (a_frame: detachable ICOR_DEBUG_FRAME; a_val: READABLE_STRING_GENERAL): ICOR_DEBUG_VALUE
			-- New Object evaluation with STRING_8
		local
			l_icdv: ICOR_DEBUG_VALUE
		do
			l_icdv := new_cil_string_evaluation (a_frame, a_val)
			Result := icdv_string_8_from_icdv_system_string (a_frame, l_icdv)
			l_icdv.clean_on_dispose
		end

	new_eiffel_string_32_evaluation (a_frame: detachable ICOR_DEBUG_FRAME; a_val: READABLE_STRING_32): ICOR_DEBUG_VALUE
			-- New Object evaluation with STRING_32
		local
			l_icdv: ICOR_DEBUG_VALUE
		do
			l_icdv := new_cil_string_evaluation (a_frame, a_val)
			Result := icdv_string_32_from_icdv_system_string (a_frame, l_icdv)
			l_icdv.clean_on_dispose
		end

	new_reference_i1_evaluation (a_frame: detachable ICOR_DEBUG_FRAME; a_val: INTEGER_8): ICOR_DEBUG_VALUE
			-- New Object evaluation with i1 _REF
		local
			l_icdv: ICOR_DEBUG_VALUE
		do
			l_icdv := new_i1_evaluation (a_frame, a_val)
			Result := icdv_reference_integer_8_from_icdv_integer_8 (a_frame, l_icdv)
			l_icdv.clean_on_dispose
		end
	new_reference_i2_evaluation (a_frame: detachable ICOR_DEBUG_FRAME; a_val: INTEGER_16): ICOR_DEBUG_VALUE
			-- New Object evaluation with i2 _REF
		local
			l_icdv: ICOR_DEBUG_VALUE
		do
			l_icdv := new_i2_evaluation (a_frame, a_val)
			Result := icdv_reference_integer_16_from_icdv_integer_16 (a_frame, l_icdv)
			l_icdv.clean_on_dispose
		end
	new_reference_i4_evaluation (a_frame: detachable ICOR_DEBUG_FRAME; a_val: INTEGER_32): ICOR_DEBUG_VALUE
			-- New Object evaluation with i4 _REF
		local
			l_icdv: ICOR_DEBUG_VALUE
		do
			l_icdv := new_i4_evaluation (a_frame, a_val)
			Result := icdv_reference_integer_32_from_icdv_integer_32 (a_frame, l_icdv)
			l_icdv.clean_on_dispose
		end
	new_reference_i8_evaluation (a_frame: detachable ICOR_DEBUG_FRAME; a_val: INTEGER_64): ICOR_DEBUG_VALUE
			-- New Object evaluation with i8 _REF
		local
			l_icdv: ICOR_DEBUG_VALUE
		do
			l_icdv := new_i8_evaluation (a_frame, a_val)
			Result := icdv_reference_integer_64_from_icdv_integer_64 (a_frame, l_icdv)
			l_icdv.clean_on_dispose
		end

	new_reference_u1_evaluation (a_frame: detachable ICOR_DEBUG_FRAME; a_val: NATURAL_8): ICOR_DEBUG_VALUE
			-- New Object evaluation with u1 _REF
		local
			l_icdv: ICOR_DEBUG_VALUE
		do
			l_icdv := new_u1_evaluation (a_frame, a_val)
			Result := icdv_reference_natural_8_from_icdv_natural_8 (a_frame, l_icdv)
			l_icdv.clean_on_dispose
		end
	new_reference_u2_evaluation (a_frame: detachable ICOR_DEBUG_FRAME; a_val: NATURAL_16): ICOR_DEBUG_VALUE
			-- New Object evaluation with u2 _REF
		local
			l_icdv: ICOR_DEBUG_VALUE
		do
			l_icdv := new_u2_evaluation (a_frame, a_val)
			Result := icdv_reference_natural_16_from_icdv_natural_16 (a_frame, l_icdv)
			l_icdv.clean_on_dispose
		end
	new_reference_u4_evaluation (a_frame: detachable ICOR_DEBUG_FRAME; a_val: NATURAL_32): ICOR_DEBUG_VALUE
			-- New Object evaluation with u4 _REF
		local
			l_icdv: ICOR_DEBUG_VALUE
		do
			l_icdv := new_u4_evaluation (a_frame, a_val)
			Result := icdv_reference_natural_32_from_icdv_natural_32 (a_frame, l_icdv)
			l_icdv.clean_on_dispose
		end
	new_reference_u8_evaluation (a_frame: detachable ICOR_DEBUG_FRAME; a_val: NATURAL_64): ICOR_DEBUG_VALUE
			-- New Object evaluation with u8 _REF
		local
			l_icdv: ICOR_DEBUG_VALUE
		do
			l_icdv := new_u8_evaluation (a_frame, a_val)
			Result := icdv_reference_natural_64_from_icdv_natural_64 (a_frame, l_icdv)
			l_icdv.clean_on_dispose
		end

	new_reference_real_evaluation (a_frame: detachable ICOR_DEBUG_FRAME; a_val: REAL): ICOR_DEBUG_VALUE
			-- New Object evaluation with real _REF
		local
			l_icdv: ICOR_DEBUG_VALUE
		do
			l_icdv := new_r4_evaluation (a_frame, a_val)
			Result := icdv_reference_real_from_icdv_real (a_frame, l_icdv)
			l_icdv.clean_on_dispose
		end

	new_reference_double_evaluation (a_frame: detachable ICOR_DEBUG_FRAME; a_val: DOUBLE): ICOR_DEBUG_VALUE
			-- New Object evaluation with double _REF
		local
			l_icdv: ICOR_DEBUG_VALUE
		do
			l_icdv := new_r8_evaluation (a_frame, a_val)
			Result := icdv_reference_double_from_icdv_double (a_frame, l_icdv)
			l_icdv.clean_on_dispose
		end

	new_reference_boolean_evaluation (a_frame: detachable ICOR_DEBUG_FRAME; a_val: BOOLEAN): ICOR_DEBUG_VALUE
			-- New Object evaluation with boolean _REF
		local
			l_icdv: ICOR_DEBUG_VALUE
		do
			l_icdv := new_boolean_evaluation (a_frame, a_val)
			Result := icdv_reference_boolean_from_icdv_boolean (a_frame, l_icdv)
			l_icdv.clean_on_dispose
		end

	new_reference_character_8_evaluation (a_frame: detachable ICOR_DEBUG_FRAME; a_val: CHARACTER_8): ICOR_DEBUG_VALUE
			-- New Object evaluation with char _REF
		local
			l_icdv: ICOR_DEBUG_VALUE
		do
			l_icdv := new_char_evaluation (a_frame, a_val)
			Result := icdv_reference_character_8_from_icdv_character_8 (a_frame, l_icdv)
			l_icdv.clean_on_dispose
		end

	new_reference_character_32_evaluation (a_frame: detachable ICOR_DEBUG_FRAME; a_val: CHARACTER_32): ICOR_DEBUG_VALUE
			-- New Object evaluation with char _REF
		local
			l_icdv: ICOR_DEBUG_VALUE
		do
			l_icdv := new_char32_evaluation (a_frame, a_val)
			Result := icdv_reference_character_32_from_icdv_character_32 (a_frame, l_icdv)
			l_icdv.clean_on_dispose
		end

feature {DBG_EVALUATOR_DOTNET} -- Class construction facilities

	icdv_string_8_from_icdv_system_string (a_frame: detachable ICOR_DEBUG_FRAME; a_sys_string: ICOR_DEBUG_VALUE): detachable ICOR_DEBUG_VALUE
			-- ICorDebugValue for STRING object created from SystemString `a_sys_string'
		do
			if attached eiffel_string_8_icd_class as icd_class then
				prepare_evaluation (a_frame, True)
				last_icor_debug_eval.new_object_no_constructor (icd_class)
				Result := complete_function_evaluation
				method_evaluation (a_frame, eiffel_string_8_make_from_cil_constructor, <<Result, a_sys_string>>)
			else
				check has_eiffel_string_8_icd_class: False end
			end
		end

	icdv_string_32_from_icdv_system_string (a_frame: detachable ICOR_DEBUG_FRAME; a_sys_string: ICOR_DEBUG_VALUE): detachable ICOR_DEBUG_VALUE
			-- ICorDebugValue for STRING object created from SystemString `a_sys_string'
		do
			if attached eiffel_string_32_icd_class as icd_class then
				prepare_evaluation (a_frame, True)
				last_icor_debug_eval.new_object_no_constructor (icd_class)
				Result := complete_function_evaluation
				method_evaluation (a_frame, eiffel_string_32_make_from_cil_constructor, <<Result, a_sys_string>>)
			else
				check has_eiffel_string_32_icd_class: False end
			end
		end

	icdv_reference_integer_8_from_icdv_integer_8 (a_frame: detachable ICOR_DEBUG_FRAME; a_icdv: ICOR_DEBUG_VALUE): detachable ICOR_DEBUG_VALUE
			-- ICorDebugValue for INTEGER_8_REF object created from SystemInteger `a_icdv'
		do
			if attached reference_integer_8_icd_class as icd_class then
				prepare_evaluation (a_frame, True)
				last_icor_debug_eval.new_object_no_constructor (icd_class)
				Result := complete_function_evaluation
				method_evaluation (a_frame, reference_integer_8_set_item_method, <<Result, a_icdv>>)
			else
				check has_reference_integer_8_icd_class: False end
			end
		end
	icdv_reference_integer_16_from_icdv_integer_16 (a_frame: detachable ICOR_DEBUG_FRAME; a_icdv: ICOR_DEBUG_VALUE): detachable ICOR_DEBUG_VALUE
			-- ICorDebugValue for INTEGER_16_REF object created from SystemInteger `a_icdv'
		do
			if attached reference_integer_16_icd_class as icd_class then
				prepare_evaluation (a_frame, True)
				last_icor_debug_eval.new_object_no_constructor (icd_class)
				Result := complete_function_evaluation
				method_evaluation (a_frame, reference_integer_16_set_item_method, <<Result, a_icdv>>)
			else
				check has_reference_integer_16_icd_class: False end
			end
		end
	icdv_reference_integer_32_from_icdv_integer_32 (a_frame: detachable ICOR_DEBUG_FRAME; a_icdv: ICOR_DEBUG_VALUE): detachable ICOR_DEBUG_VALUE
			-- ICorDebugValue for INTEGER_REF object created from SystemInteger `a_icdv'
		do
			if attached reference_integer_32_icd_class as icd_class then
				prepare_evaluation (a_frame, True)
				last_icor_debug_eval.new_object_no_constructor (icd_class)
				Result := complete_function_evaluation
				method_evaluation (a_frame, reference_integer_32_set_item_method, <<Result, a_icdv>>)
			else
				check has_reference_integer_32_icd_class: False end
			end
		end
	icdv_reference_integer_64_from_icdv_integer_64 (a_frame: detachable ICOR_DEBUG_FRAME; a_icdv: ICOR_DEBUG_VALUE): detachable ICOR_DEBUG_VALUE
			-- ICorDebugValue for INTEGER_64_REF object created from SystemInteger `a_icdv'
		do
			if attached reference_integer_64_icd_class as icd_class then
				prepare_evaluation (a_frame, True)
				last_icor_debug_eval.new_object_no_constructor (icd_class)
				Result := complete_function_evaluation
				method_evaluation (a_frame, reference_integer_64_set_item_method, <<Result, a_icdv>>)
			else
				check has_reference_integer_64_icd_class: False end
			end
		end

	icdv_reference_natural_8_from_icdv_natural_8 (a_frame: detachable ICOR_DEBUG_FRAME; a_icdv: ICOR_DEBUG_VALUE): detachable ICOR_DEBUG_VALUE
			-- ICorDebugValue for NATURAL_8_REF object created from SystemInteger `a_icdv'
		do
			if attached reference_natural_8_icd_class as icd_class then
				prepare_evaluation (a_frame, True)
				last_icor_debug_eval.new_object_no_constructor (icd_class)
				Result := complete_function_evaluation
				method_evaluation (a_frame, reference_natural_8_set_item_method, <<Result, a_icdv>>)
			else
				check has_reference_natural_8_icd_class: False end
			end
		end
	icdv_reference_natural_16_from_icdv_natural_16 (a_frame: detachable ICOR_DEBUG_FRAME; a_icdv: ICOR_DEBUG_VALUE): detachable ICOR_DEBUG_VALUE
			-- ICorDebugValue for NATURAL_16_REF object created from SystemInteger `a_icdv'
		do
			if attached reference_natural_16_icd_class as icd_class then
				prepare_evaluation (a_frame, True)
				last_icor_debug_eval.new_object_no_constructor (icd_class)
				Result := complete_function_evaluation
				method_evaluation (a_frame, reference_natural_16_set_item_method, <<Result, a_icdv>>)
			else
				check has_reference_natural_16_icd_class: False end
			end
		end
	icdv_reference_natural_32_from_icdv_natural_32 (a_frame: detachable ICOR_DEBUG_FRAME; a_icdv: ICOR_DEBUG_VALUE): detachable ICOR_DEBUG_VALUE
			-- ICorDebugValue for NATURAL_REF object created from SystemInteger `a_icdv'
		do
			if attached reference_natural_32_icd_class as icd_class then
				prepare_evaluation (a_frame, True)
				last_icor_debug_eval.new_object_no_constructor (icd_class)
				Result := complete_function_evaluation
				method_evaluation (a_frame, reference_natural_32_set_item_method, <<Result, a_icdv>>)
			else
				check has_reference_natural_32_icd_class: False end
			end
		end
	icdv_reference_natural_64_from_icdv_natural_64 (a_frame: detachable ICOR_DEBUG_FRAME; a_icdv: ICOR_DEBUG_VALUE): detachable ICOR_DEBUG_VALUE
			-- ICorDebugValue for NATURAL_64_REF object created from SystemInteger `a_icdv'
		do
			if attached reference_natural_64_icd_class as icd_class then
				prepare_evaluation (a_frame, True)
				last_icor_debug_eval.new_object_no_constructor (icd_class)
				Result := complete_function_evaluation
				method_evaluation (a_frame, reference_natural_64_set_item_method, <<Result, a_icdv>>)
			else
				check has_reference_natural_64_icd_class: False end
			end
		end

	icdv_reference_real_from_icdv_real (a_frame: detachable ICOR_DEBUG_FRAME; a_icdv: ICOR_DEBUG_VALUE): detachable ICOR_DEBUG_VALUE
			-- ICorDebugValue for REAL_REF object created from SystemReal `a_icdv'
		do
			if attached reference_real_icd_class as icd_class then
				prepare_evaluation (a_frame, True)
				last_icor_debug_eval.new_object_no_constructor (icd_class)
				Result := complete_function_evaluation
				method_evaluation (a_frame, reference_real_set_item_method, <<Result, a_icdv>>)
			else
				check has_reference_real_icd_class: False end
			end
		end

	icdv_reference_double_from_icdv_double (a_frame: detachable ICOR_DEBUG_FRAME; a_icdv: ICOR_DEBUG_VALUE): detachable ICOR_DEBUG_VALUE
			-- ICorDebugValue for DOUBLE_REF object created from SystemDouble `a_icdv'
		do
			if attached reference_double_icd_class as icd_class then
				prepare_evaluation (a_frame, True)
				last_icor_debug_eval.new_object_no_constructor (icd_class)
				Result := complete_function_evaluation
				method_evaluation (a_frame, reference_double_set_item_method, <<Result, a_icdv>>)
			else
				check has_reference_double_icd_class: False end
			end
		end

	icdv_reference_boolean_from_icdv_boolean (a_frame: detachable ICOR_DEBUG_FRAME; a_icdv: ICOR_DEBUG_VALUE): detachable ICOR_DEBUG_VALUE
			-- ICorDebugValue for BOOLEAN_REF object created from SystemBoolean `a_icdv'
		do
			if attached reference_boolean_icd_class as icd_class then
				prepare_evaluation (a_frame, True)
				last_icor_debug_eval.new_object_no_constructor (icd_class)
				Result := complete_function_evaluation
				method_evaluation (a_frame, reference_boolean_set_item_method, <<Result, a_icdv>>)
			else
				check has_reference_boolean_icd_class: False end
			end
		end

	icdv_reference_character_8_from_icdv_character_8 (a_frame: detachable ICOR_DEBUG_FRAME; a_icdv: ICOR_DEBUG_VALUE): detachable ICOR_DEBUG_VALUE
			-- ICorDebugValue for CHARACTER_REF object created from SystemChar `a_icdv'
		do
			if attached reference_character_8_icd_class as icd_class then
				prepare_evaluation (a_frame, True)
				last_icor_debug_eval.new_object_no_constructor (icd_class)
				Result := complete_function_evaluation
				method_evaluation (a_frame, reference_character_8_set_item_method, <<Result, a_icdv>>)
			else
				check has_reference_character_8_icd_class: False end
			end
		end

	icdv_reference_character_32_from_icdv_character_32 (a_frame: detachable ICOR_DEBUG_FRAME; a_icdv: ICOR_DEBUG_VALUE): detachable ICOR_DEBUG_VALUE
			-- ICorDebugValue for CHARACTER_REF object created from SystemChar `a_icdv'
		do
			if attached reference_character_32_icd_class as icd_class then
				prepare_evaluation (a_frame, True)
				last_icor_debug_eval.new_object_no_constructor (icd_class)
				Result := complete_function_evaluation
				method_evaluation (a_frame, reference_character_32_set_item_method, <<Result, a_icdv>>)
			else
				check has_reference_character_32_icd_class: False end
			end
		end

	icdv_reference_pointer_from_icdv_pointer (a_frame: detachable ICOR_DEBUG_FRAME; a_icdv: ICOR_DEBUG_VALUE): detachable ICOR_DEBUG_VALUE
			-- ICorDebugValue for POINTER_REF object created from SystemPtr `a_icdv'
		do
			if attached reference_pointer_icd_class as icd_class then
				prepare_evaluation (a_frame, True)
				last_icor_debug_eval.new_object_no_constructor (icd_class)
				Result := complete_function_evaluation
				method_evaluation (a_frame, reference_pointer_set_item_method, <<Result, a_icdv>>)
			else
				check has_reference_pointer_icd_class: False end
			end
		end

feature {NONE} -- Backup state

	saved_last_managed_callback: INTEGER
			-- Last managed callback saved data
			-- try to impact the less possible other debugger functionalities

	save_state_info
			-- Save current debugger state information
		do
			saved_last_managed_callback := eifnet_debugger.last_managed_callback
		end

	restore_state_info
			-- Restore saved debugger state information
		do
			eifnet_debugger.set_last_managed_callback (saved_last_managed_callback)
		end

feature {NONE}

	last_icor_debug_eval: ICOR_DEBUG_EVAL
			-- Last ICorDebugEval object used for evalutation

	last_app_status: APPLICATION_STATUS_DOTNET
			-- Last APPLICATION_STATUS_DOTNET data

	prepare_evaluation (a_useless_frame: detachable ICOR_DEBUG_FRAME; stop_timer_required: BOOLEAN)
			-- Prepare data for evaluation.
			--| FIXME jfiat [2005/06/07] : get rid of `a_useless_frame' if really useless
		require
			not Eifnet_debugger.is_inside_function_evaluation
		local
			l_icd_thread: ICOR_DEBUG_THREAD
			l_icd_eval: ICOR_DEBUG_EVAL
			l_status: APPLICATION_STATUS_DOTNET
		do
			debug ("debugger_trace_eval")
				print ("<start> " + generator + ".prepare_evaluation %N")
				eifnet_debugger.notify_debugger ("preparing evaluation")
			end

			last_call_success := 0
			last_eval_is_exception := False
			last_eval_aborted := False
			save_state_info

			if l_icd_eval = Void then
				l_icd_thread := eifnet_debugger.icor_debug_thread
				l_icd_eval := l_icd_thread.create_eval
			end

			l_status ?= debugger_manager.application_status
			Eifnet_debugger.reset_evaluation_exception
			l_status.set_is_evaluating (True)
				--| Let use the evaluating mecanism instead of the normal one
				--| then let's disable the timer for ec callback

			if stop_timer_required then
				eifnet_debugger.stop_dbg_timer
			end

			last_icor_debug_eval := l_icd_eval
			last_app_status := l_status
				--| We then call effective evaluation
			debug ("debugger_trace_eval")
				print ("<stop> " + generator + ".prepare_evaluation %N")
			end
		end

	evaluation_termination (restart_timer_required: BOOLEAN)
		local
			l_status: APPLICATION_STATUS_DOTNET
		do
			l_status := last_app_status
			Eifnet_debugger.reset_evaluation_exception
			l_status.set_is_evaluating (False)
			if restart_timer_required then
				if eifnet_debugger.callback_notification_processing then
					eifnet_debugger.restore_callback_notification_state
				else
					if not debugger_manager.application_is_stopped then
						eifnet_debugger.start_dbg_timer
					end
				end
			end
			restore_state_info
			clean_temp_data
		ensure
			not Eifnet_debugger.is_inside_function_evaluation
		end

	end_evaluation
			-- In case of direct evaluation, with no callback,
			-- Complete the evaluation by cleaning temporary data
			-- and restoring state
		require
			last_icor_debug_eval /= Void
			last_app_status /= Void
		local
			l_icd_eval: ICOR_DEBUG_EVAL
		do
			l_icd_eval := last_icor_debug_eval
			if l_icd_eval /= Void then
				last_call_success := l_icd_eval.last_call_success
			end
			evaluation_termination (False)
		end

	Feature_evaluation_timeout: INTEGER
			-- Timeout of the function evaluation.
			-- (in seconds)
		do
			Result := debugger_manager.max_evaluation_duration
		end

	complete_method_evaluation
			-- In case of method evaluation, requiring a callback,
			-- Complete the evaluation by cleaning temporary data
			-- and restoring state
		require
			last_icor_debug_eval /= Void
			last_app_status /= Void
		local
			l_icd_eval: ICOR_DEBUG_EVAL
		do
			l_icd_eval := last_icor_debug_eval
			if l_icd_eval /= Void then
				last_call_success := l_icd_eval.last_call_success
			end
			if not return_code_is_call_succeed (last_call_success) then
				debug ("DEBUGGER_TRACE_EVAL")
					print (generator + ".complete_method_evaluation %N")
					print ("  => last call success of Eval = " + last_call_success.to_hex_string + "%N")
				end
			else
					--| And we wait for all callback to be finished
				eifnet_debugger.process_debugger_evaluation (l_icd_eval,
							eifnet_debugger.icor_debug_controller,
							Feature_evaluation_timeout
						)
				if
					eifnet_debugger.last_managed_callback_is_exception
				then
					-- FIXME jfiat [2004/12/17] : for now we consider an exception durign evaluation
					--			as an Eval exception, maybe we should manage this differently
					last_eval_is_exception := True
					debug ("DEBUGGER_TRACE_EVAL")
						io.error.put_string ("EIFNET_DEBUGGER.debug_output_.. :: WARNING Exception occurred %N")
					end
				elseif eifnet_debugger.last_managed_callback_is_eval_exception then
					-- Exception !!			
					last_eval_is_exception := True
				end
			end
			evaluation_termination (True)
		end

	complete_function_evaluation: ICOR_DEBUG_VALUE
			-- In case of function evaluation, requiring a callback and a result value,
			-- Complete the evaluation by cleaning temporary data
			-- and restoring state
		require
			last_icor_debug_eval /= Void
			last_app_status /= Void
		local
			l_icd_eval: ICOR_DEBUG_EVAL
			lmcb: INTEGER
		do
			l_icd_eval := last_icor_debug_eval
			if l_icd_eval /= Void then
				last_call_success := l_icd_eval.last_call_success
			end
			if l_icd_eval = Void or else not return_code_is_call_succeed (last_call_success) then
				debug ("DEBUGGER_TRACE_EVAL")
					print (generator + "complete_function_evaluation %N")
					print ("  => last call success of Eval = " + last_call_success.to_hex_string + "%N")
				end
			else
					--| And we wait for all callback to be finished
				eifnet_debugger.process_debugger_evaluation (l_icd_eval,
							eifnet_debugger.icor_debug_controller,
							Feature_evaluation_timeout
						)
				lmcb := eifnet_debugger.last_managed_callback
				if
					eifnet_debugger.managed_callback_is_exception (lmcb)
				then
					-- FIXME jfiat [2004/12/17] : for now we consider an exception durign evaluation
					--			as an Eval exception, maybe we should manage this differently
					last_eval_is_exception := True
					Result := Void --"WARNING: Could not evaluate output"
					debug ("DEBUGGER_TRACE_EVAL")
						io.error.put_string ("EIFNET_DEBUGGER.debug_output_.. :: WARNING Exception occurred %N")
					end
				elseif eifnet_debugger.managed_callback_is_eval_exception (lmcb) then
					Result := Void
					last_eval_is_exception := True
					Result := l_icd_eval.get_result
				elseif eifnet_debugger.managed_callback_is_exit_process (lmcb) then
					eifnet_debugger.notify_exit_process_occurred
					Result := Void
				else
					Result := l_icd_eval.get_result
					last_eval_aborted := (l_icd_eval.last_call_success & 0xFFFF) = {ICOR_DEBUG_API_ERROR_CODE_FORMATTER}.cordbg_s_func_eval_aborted
				end
			end
			evaluation_termination (True)
		end

	clean_temp_data
			-- Clean temporary data used for evaluation
		do
			last_icor_debug_eval.clean_on_dispose
			last_icor_debug_eval := Void
		end

feature {NONE} -- Implementation : ICorDebugClass... once per session

	icor_debug_class_from (ct: CLASS_TYPE): ICOR_DEBUG_CLASS
		do
			Result := Eifnet_debugger.icor_debug_class (ct)
		end

	reference_integer_8_icd_class: ICOR_DEBUG_CLASS
			-- IcorDebugClass for reference INTEGER
		do
			Result := once_reference_integer_8_icd_class
			if Result = Void then
				Result := icor_debug_class_from (integer_8_type.associated_reference_class_type)
				once_reference_integer_8_icd_class := Result
			end
		ensure
			Result /= Void
		end
	reference_integer_16_icd_class: ICOR_DEBUG_CLASS
			-- IcorDebugClass for reference INTEGER
		do
			Result := once_reference_integer_16_icd_class
			if Result = Void then
				Result := icor_debug_class_from (integer_16_type.associated_reference_class_type)
				once_reference_integer_16_icd_class := Result
			end
		ensure
			Result /= Void
		end
	reference_integer_32_icd_class: ICOR_DEBUG_CLASS
			-- IcorDebugClass for reference INTEGER
		do
			Result := once_reference_integer_32_icd_class
			if Result = Void then
				Result := icor_debug_class_from (integer_32_type.associated_reference_class_type)
				once_reference_integer_32_icd_class := Result
			end
		ensure
			Result /= Void
		end
	reference_integer_64_icd_class: ICOR_DEBUG_CLASS
			-- IcorDebugClass for reference INTEGER
		do
			Result := once_reference_integer_64_icd_class
			if Result = Void then
				Result := icor_debug_class_from (integer_64_type.associated_reference_class_type)
				once_reference_integer_64_icd_class := Result
			end
		ensure
			Result /= Void
		end

	reference_natural_8_icd_class: ICOR_DEBUG_CLASS
			-- IcorDebugClass for reference INTEGER
		do
			Result := once_reference_natural_8_icd_class
			if Result = Void then
				Result := icor_debug_class_from (natural_8_type.associated_reference_class_type)
				once_reference_natural_8_icd_class := Result
			end
		ensure
			Result /= Void
		end
	reference_natural_16_icd_class: ICOR_DEBUG_CLASS
			-- IcorDebugClass for reference INTEGER
		do
			Result := once_reference_natural_16_icd_class
			if Result = Void then
				Result := icor_debug_class_from (natural_16_type.associated_reference_class_type)
				once_reference_natural_16_icd_class := Result
			end
		ensure
			Result /= Void
		end
	reference_natural_32_icd_class: ICOR_DEBUG_CLASS
			-- IcorDebugClass for reference INTEGER
		do
			Result := once_reference_natural_32_icd_class
			if Result = Void then
				Result := icor_debug_class_from (natural_32_type.associated_reference_class_type)
				once_reference_natural_32_icd_class := Result
			end
		ensure
			Result /= Void
		end
	reference_natural_64_icd_class: ICOR_DEBUG_CLASS
			-- IcorDebugClass for reference INTEGER
		do
			Result := once_reference_natural_64_icd_class
			if Result = Void then
				Result := icor_debug_class_from (natural_64_type.associated_reference_class_type)
				once_reference_natural_64_icd_class := Result
			end
		ensure
			Result /= Void
		end

	reference_real_icd_class: ICOR_DEBUG_CLASS
			-- IcorDebugClass for reference REAL
		do
			Result := once_reference_real_icd_class
			if Result = Void then
				Result := icor_debug_class_from (real_32_type.associated_reference_class_type)
				once_reference_real_icd_class := Result
			end
		ensure
			Result /= Void
		end

	reference_double_icd_class: ICOR_DEBUG_CLASS
			-- IcorDebugClass for reference DOUBLE
		do
			Result := once_reference_double_icd_class
			if Result = Void then
				Result := icor_debug_class_from (real_64_type.associated_reference_class_type)
				once_reference_double_icd_class := Result
			end
		ensure
			Result /= Void
		end

	reference_boolean_icd_class: ICOR_DEBUG_CLASS
			-- IcorDebugClass for reference BOOLEAN
		do
			Result := once_reference_boolean_icd_class
			if Result = Void then
				Result := icor_debug_class_from (boolean_type.associated_reference_class_type)
				once_reference_boolean_icd_class := Result
			end
		ensure
			Result /= Void
		end

	reference_character_8_icd_class: ICOR_DEBUG_CLASS
			-- IcorDebugClass for reference CHARACTER
		do
			Result := once_reference_character_8_icd_class
			if Result = Void then
				Result := icor_debug_class_from (character_type.associated_reference_class_type)
				once_reference_character_8_icd_class := Result
			end
		ensure
			Result /= Void
		end

	reference_character_32_icd_class: ICOR_DEBUG_CLASS
			-- IcorDebugClass for reference CHARACTER_32
		do
			Result := once_reference_character_32_icd_class
			if Result = Void then
				Result := icor_debug_class_from (wide_char_type.associated_reference_class_type)
				once_reference_character_32_icd_class := Result
			end
		ensure
			Result /= Void
		end

	reference_pointer_icd_class: ICOR_DEBUG_CLASS
			-- IcorDebugClass for reference POINTER
		do
			Result := once_reference_pointer_icd_class
			if Result = Void then
				Result := icor_debug_class_from (pointer_type.associated_reference_class_type)
				once_reference_pointer_icd_class := Result
			end
		ensure
			Result /= Void
		end

	eiffel_string_8_icd_class: ICOR_DEBUG_CLASS
			-- IcorDebugClass for STRING
		do
			Result := once_eiffel_string_8_icd_class
			if Result = Void then
				Result := Eifnet_debugger.icor_debug_class (Eiffel_system.String_class.compiled_class.types.first)
				once_eiffel_string_8_icd_class := Result
			end
		ensure
			Result /= Void
		end

	eiffel_string_32_icd_class: ICOR_DEBUG_CLASS
			-- IcorDebugClass for STRING_32
		do
			Result := once_eiffel_string_32_icd_class
			if Result = Void then
				Result := Eifnet_debugger.icor_debug_class (Eiffel_system.system.string_32_class.compiled_class.types.first)
				once_eiffel_string_32_icd_class := Result
			end
		ensure
			Result /= Void
		end

feature {NONE} -- Implementation : ICorDebugFunction... once per session

	icor_set_item_method_from (ct: CLASS_TYPE): ICOR_DEBUG_FUNCTION
		do
			Result := Eifnet_debugger.eiffel_icd_function_by_name (ct, once "set_item")
		end

	reference_integer_8_set_item_method: ICOR_DEBUG_FUNCTION
			-- ICorDebugFunction for reference INTEGER.set_item (..)
		do
			Result := once_reference_integer_8_set_item_method
			if Result = Void then
				Result := icor_set_item_method_from (integer_8_type.associated_reference_class_type)
				once_reference_integer_8_set_item_method := Result
			end
		ensure
			Result /= Void
		end
	reference_integer_16_set_item_method: ICOR_DEBUG_FUNCTION
			-- ICorDebugFunction for reference INTEGER.set_item (..)
		do
			Result := once_reference_integer_16_set_item_method
			if Result = Void then
				Result := icor_set_item_method_from (integer_16_type.associated_reference_class_type)
				once_reference_integer_16_set_item_method := Result
			end
		ensure
			Result /= Void
		end
	reference_integer_32_set_item_method: ICOR_DEBUG_FUNCTION
			-- ICorDebugFunction for reference INTEGER.set_item (..)
		do
			Result := once_reference_integer_32_set_item_method
			if Result = Void then
				Result := icor_set_item_method_from (integer_32_type.associated_reference_class_type)
				once_reference_integer_32_set_item_method := Result
			end
		ensure
			Result /= Void
		end
	reference_integer_64_set_item_method: ICOR_DEBUG_FUNCTION
			-- ICorDebugFunction for reference INTEGER.set_item (..)
		do
			Result := once_reference_integer_64_set_item_method
			if Result = Void then
				Result := icor_set_item_method_from (integer_64_type.associated_reference_class_type)
				once_reference_integer_64_set_item_method := Result
			end
		ensure
			Result /= Void
		end

	reference_natural_8_set_item_method: ICOR_DEBUG_FUNCTION
			-- ICorDebugFunction for reference NATURAL.set_item (..)
		do
			Result := once_reference_natural_8_set_item_method
			if Result = Void then
				Result := icor_set_item_method_from (natural_8_type.associated_reference_class_type)
				once_reference_natural_8_set_item_method := Result
			end
		ensure
			Result /= Void
		end
	reference_natural_16_set_item_method: ICOR_DEBUG_FUNCTION
			-- ICorDebugFunction for reference NATURAL.set_item (..)
		do
			Result := once_reference_natural_16_set_item_method
			if Result = Void then
				Result := icor_set_item_method_from (natural_16_type.associated_reference_class_type)
				once_reference_natural_16_set_item_method := Result
			end
		ensure
			Result /= Void
		end
	reference_natural_32_set_item_method: ICOR_DEBUG_FUNCTION
			-- ICorDebugFunction for reference NATURAL.set_item (..)
		do
			Result := once_reference_natural_32_set_item_method
			if Result = Void then
				Result := icor_set_item_method_from (natural_32_type.associated_reference_class_type)
				once_reference_natural_32_set_item_method := Result
			end
		ensure
			Result /= Void
		end
	reference_natural_64_set_item_method: ICOR_DEBUG_FUNCTION
			-- ICorDebugFunction for reference NATURAL.set_item (..)
		do
			Result := once_reference_natural_64_set_item_method
			if Result = Void then
				Result := icor_set_item_method_from (natural_64_type.associated_reference_class_type)
				once_reference_natural_64_set_item_method := Result
			end
		ensure
			Result /= Void
		end

	reference_real_set_item_method: ICOR_DEBUG_FUNCTION
			-- ICorDebugFunction for reference REAL.set_item (..)
		do
			Result := once_reference_real_set_item_method
			if Result = Void then
				Result := icor_set_item_method_from (Real_32_type.associated_reference_class_type)
				once_reference_real_set_item_method := Result
			end
		ensure
			Result /= Void
		end

	reference_double_set_item_method: ICOR_DEBUG_FUNCTION
			-- ICorDebugFunction for reference DOUBLE.set_item (..)
		do
			Result := once_reference_double_set_item_method
			if Result = Void then
				Result := icor_set_item_method_from (Real_64_type.associated_reference_class_type)
				once_reference_double_set_item_method := Result
			end
		ensure
			Result /= Void
		end

	reference_boolean_set_item_method: ICOR_DEBUG_FUNCTION
			-- ICorDebugFunction for reference BOOLEAN.set_item (..)
		do
			Result := once_reference_boolean_set_item_method
			if Result = Void then
				Result := icor_set_item_method_from (boolean_type.associated_reference_class_type)
				once_reference_boolean_set_item_method := Result
			end
		ensure
			Result /= Void
		end

	reference_character_8_set_item_method: ICOR_DEBUG_FUNCTION
			-- ICorDebugFunction for reference CHARACTER.set_item (..)
		do
			Result := once_reference_character_8_set_item_method
			if Result = Void then
				Result := icor_set_item_method_from (character_type.associated_reference_class_type)
				once_reference_character_8_set_item_method := Result
			end
		ensure
			Result /= Void
		end

	reference_character_32_set_item_method: ICOR_DEBUG_FUNCTION
			-- ICorDebugFunction for reference CHARACTER.set_item (..)
		do
			Result := once_reference_character_32_set_item_method
			if Result = Void then
				Result := icor_set_item_method_from (Wide_char_type.associated_reference_class_type)
				once_reference_character_32_set_item_method := Result
			end
		ensure
			Result /= Void
		end

	reference_pointer_set_item_method: ICOR_DEBUG_FUNCTION
			-- ICorDebugFunction for reference POINTER.set_item (..)
		do
			Result := once_reference_pointer_set_item_method
			if Result = Void then
				Result := icor_set_item_method_from (pointer_type.associated_reference_class_type)
				once_reference_pointer_set_item_method := Result
			end
		ensure
			Result /= Void
		end

	eiffel_string_8_make_from_cil_constructor: ICOR_DEBUG_FUNCTION
			-- ICorDebugFunction for STRING.make_from_cil (..)
		local
			l_class: CLASS_C
		do
			Result := once_eiffel_string_make_from_cil_constructor
			if Result = Void then
				l_class := Eiffel_system.String_class.compiled_class
				check l_class /= Void end
				Result := Eifnet_debugger.eiffel_icd_function_by_name (l_class.types.first, "make_from_cil")
				once_eiffel_string_make_from_cil_constructor := Result
			end
		ensure
			Result /= Void
		end

	eiffel_string_32_make_from_cil_constructor: ICOR_DEBUG_FUNCTION
			-- ICorDebugFunction for STRING_32.make_from_cil (..)
		local
			l_class: CLASS_C
		do
			Result := once_eiffel_string_32_make_from_cil_constructor
			if Result = Void then
				l_class := Eiffel_system.system.String_32_class.compiled_class
				check l_class /= Void end
				Result := Eifnet_debugger.eiffel_icd_function_by_name (l_class.types.first, "make_from_cil")
				once_eiffel_string_32_make_from_cil_constructor := Result
			end
		ensure
			Result /= Void
		end

feature {EIFNET_DEBUGGER} -- Private Implementation : ICor... once per session

	reset
			-- Reset all data
		do
			reset_once_per_session
			last_app_status := Void
			last_icor_debug_eval := Void
		end

	reset_once_per_session
			-- Reset the data related to one debugging session
		do
				--| Clean kept ICorDebugClass
			once_reference_integer_8_icd_class           := Void
			once_reference_integer_16_icd_class          := Void
			once_reference_integer_32_icd_class          := Void
			once_reference_integer_64_icd_class          := Void
			once_reference_natural_8_icd_class           := Void
			once_reference_natural_16_icd_class          := Void
			once_reference_natural_32_icd_class          := Void
			once_reference_natural_64_icd_class          := Void
			once_reference_real_icd_class                := Void
			once_reference_double_icd_class              := Void
			once_reference_boolean_icd_class             := Void
			once_reference_character_8_icd_class         := Void
			once_reference_character_32_icd_class        := Void
			once_eiffel_string_8_icd_class                 := Void
			once_eiffel_string_32_icd_class              := Void
			once_reference_pointer_icd_class 			 := Void

				--| Clean kept ICorDebugFunction
			once_reference_integer_8_set_item_method     := Void
			once_reference_integer_16_set_item_method    := Void
			once_reference_integer_32_set_item_method    := Void
			once_reference_integer_64_set_item_method    := Void
			once_reference_natural_8_set_item_method     := Void
			once_reference_natural_16_set_item_method    := Void
			once_reference_natural_32_set_item_method    := Void
			once_reference_natural_64_set_item_method    := Void
			once_reference_real_set_item_method          := Void
			once_reference_double_set_item_method        := Void
			once_reference_boolean_set_item_method       := Void
			once_reference_character_8_set_item_method   := Void
			once_reference_character_32_set_item_method  := Void
			once_reference_pointer_set_item_method  	 := Void

			once_eiffel_string_make_from_cil_constructor    := Void
			once_eiffel_string_32_make_from_cil_constructor := Void
		end

	once_reference_integer_8_icd_class           : ICOR_DEBUG_CLASS
	once_reference_integer_16_icd_class          : ICOR_DEBUG_CLASS
	once_reference_integer_32_icd_class          : ICOR_DEBUG_CLASS
	once_reference_integer_64_icd_class          : ICOR_DEBUG_CLASS
	once_reference_natural_8_icd_class           : ICOR_DEBUG_CLASS
	once_reference_natural_16_icd_class          : ICOR_DEBUG_CLASS
	once_reference_natural_32_icd_class          : ICOR_DEBUG_CLASS
	once_reference_natural_64_icd_class          : ICOR_DEBUG_CLASS
	once_reference_real_icd_class                : ICOR_DEBUG_CLASS
	once_reference_double_icd_class              : ICOR_DEBUG_CLASS
	once_reference_boolean_icd_class             : ICOR_DEBUG_CLASS
	once_reference_character_8_icd_class         : ICOR_DEBUG_CLASS
	once_reference_character_32_icd_class        : ICOR_DEBUG_CLASS
	once_reference_pointer_icd_class 			 : ICOR_DEBUG_CLASS

	once_eiffel_string_8_icd_class                 : ICOR_DEBUG_CLASS
	once_eiffel_string_32_icd_class              : ICOR_DEBUG_CLASS

	once_reference_integer_8_set_item_method     : ICOR_DEBUG_FUNCTION
	once_reference_integer_16_set_item_method    : ICOR_DEBUG_FUNCTION
	once_reference_integer_32_set_item_method    : ICOR_DEBUG_FUNCTION
	once_reference_integer_64_set_item_method    : ICOR_DEBUG_FUNCTION
	once_reference_natural_8_set_item_method     : ICOR_DEBUG_FUNCTION
	once_reference_natural_16_set_item_method    : ICOR_DEBUG_FUNCTION
	once_reference_natural_32_set_item_method    : ICOR_DEBUG_FUNCTION
	once_reference_natural_64_set_item_method    : ICOR_DEBUG_FUNCTION
	once_reference_real_set_item_method          : ICOR_DEBUG_FUNCTION
	once_reference_double_set_item_method        : ICOR_DEBUG_FUNCTION
	once_reference_boolean_set_item_method       : ICOR_DEBUG_FUNCTION
	once_reference_character_8_set_item_method   : ICOR_DEBUG_FUNCTION
	once_reference_character_32_set_item_method  : ICOR_DEBUG_FUNCTION
	once_reference_pointer_set_item_method       : ICOR_DEBUG_FUNCTION

	once_eiffel_string_make_from_cil_constructor   : ICOR_DEBUG_FUNCTION
	once_eiffel_string_32_make_from_cil_constructor: ICOR_DEBUG_FUNCTION

feature {NONE} -- Helper Impl

	return_code_is_call_succeed (lcs: INTEGER): BOOLEAN
			-- Is last call `lcs' a success ?
		do
			Result := lcs = 0 or lcs = 1 -- S_OK or S_FALSE
				--| HRESULT .. < 0 if error ...
		end

note
	copyright:	"Copyright (c) 1984-2024, Eiffel Software"
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

end
