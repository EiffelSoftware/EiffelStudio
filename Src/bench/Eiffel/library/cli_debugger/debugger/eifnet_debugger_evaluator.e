indexing
	description: "Objects used to evaluate features in dotnet system"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	EIFNET_DEBUGGER_EVALUATOR

inherit

	EIFNET_EXPORTER
		export
			{NONE} all
		end
	
	ICOR_EXPORTER
		export
			{NONE} all
		end

	SHARED_APPLICATION_EXECUTION
		export
			{NONE} all
		end
		
	EIFNET_ICOR_ELEMENT_TYPES_CONSTANTS
		export
			{NONE} all
		end

create 
	make

feature {NONE} -- Initialization

	make (dbg: EIFNET_DEBUGGER) is
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

feature {EIFNET_EXPORTER, EB_OBJECT_TOOL} -- Evaluation primitives

	function_evaluation (a_frame: ICOR_DEBUG_FRAME; a_func: ICOR_DEBUG_FUNCTION; a_args: ARRAY [ICOR_DEBUG_VALUE]): ICOR_DEBUG_VALUE is
			-- Function evaluation result for `a_func' on `a_icd'
		require
			args_not_void: a_args /= Void
			func_not_void: a_func /= Void
		do
			prepare_evaluation (a_frame)
			last_icor_debug_eval.call_function (a_func, a_args)
			Result := complete_function_evaluation
		end

	method_evaluation (a_frame: ICOR_DEBUG_FRAME; a_meth: ICOR_DEBUG_FUNCTION; a_args: ARRAY [ICOR_DEBUG_VALUE]) is
			-- Method evaluation result for `a_func' on `a_icd'
		require
			args_not_void: a_args /= Void
			meth_not_void: a_meth /= Void
		do
			prepare_evaluation (a_frame)
			last_icor_debug_eval.call_function (a_meth, a_args)
			complete_method_evaluation
		end		
		
	new_string_evaluation (a_frame: ICOR_DEBUG_FRAME; a_string: STRING): ICOR_DEBUG_VALUE is
			-- NewString evaluation with `a_string'
		require
			a_string /= Void
		do
			prepare_evaluation (a_frame)
			last_icor_debug_eval.new_string (a_string)
			Result := complete_function_evaluation
		end

	new_object_no_constructor_evaluation (a_frame: ICOR_DEBUG_FRAME; a_icd_class: ICOR_DEBUG_CLASS): ICOR_DEBUG_VALUE is
			-- NewObjectNoConstructor evaluation on `a_icd_class'
		require
			a_icd_class /= Void
		do
			prepare_evaluation (a_frame)
			last_icor_debug_eval.new_object_no_constructor (a_icd_class)
			Result := complete_function_evaluation
		end

	new_object_evaluation (a_frame: ICOR_DEBUG_FRAME; a_icd_func: ICOR_DEBUG_FUNCTION; a_args: ARRAY [ICOR_DEBUG_VALUE]): ICOR_DEBUG_VALUE is
			-- NewObject evaluation on `a_icd_class'
		require
			a_icd_func /= Void
			a_args /= Void
		do
			prepare_evaluation (a_frame)
			last_icor_debug_eval.new_object (a_icd_func, a_args)
			Result := complete_function_evaluation
		end

feature {EIFNET_EXPORTER, EB_OBJECT_TOOL} -- Basic value creation

	new_i4_evaluation (a_frame: ICOR_DEBUG_FRAME; a_val: INTEGER): ICOR_DEBUG_VALUE is
			-- New Object evaluation with i4
		local
			l_gen_obj: ICOR_DEBUG_GENERIC_VALUE
		do
			prepare_evaluation (a_frame)
			Result := last_icor_debug_eval.create_value (Element_type_i4 , Void)
			if Result /= Void then
				l_gen_obj := Result.query_interface_icor_debug_generic_value
				check l_gen_obj /= Void end					

				l_gen_obj.set_value ($a_val)
				l_gen_obj.set_associated_frame (a_frame)				
			end
			end_evaluation
		end
		
	new_r4_evaluation (a_frame: ICOR_DEBUG_FRAME; a_val: REAL): ICOR_DEBUG_VALUE is
			-- New Object evaluation with real
		local
			l_gen_obj: ICOR_DEBUG_GENERIC_VALUE
		do
			prepare_evaluation (a_frame)
			Result := last_icor_debug_eval.create_value (element_type_r4 , Void)
			if Result /= Void then
				l_gen_obj := Result.query_interface_icor_debug_generic_value
				check l_gen_obj /= Void end					

				l_gen_obj.set_value ($a_val)
				l_gen_obj.set_associated_frame (a_frame)				
			end
			end_evaluation
		end
		
	new_r8_evaluation (a_frame: ICOR_DEBUG_FRAME; a_val: DOUBLE): ICOR_DEBUG_VALUE is
			-- New Object evaluation with real
		local
			l_gen_obj: ICOR_DEBUG_GENERIC_VALUE
		do
			prepare_evaluation (a_frame)
			Result := last_icor_debug_eval.create_value (element_type_r8 , Void)
			if Result /= Void then
				l_gen_obj := Result.query_interface_icor_debug_generic_value
				check l_gen_obj /= Void end					

				l_gen_obj.set_value ($a_val)
				l_gen_obj.set_associated_frame (a_frame)				
			end
			end_evaluation
		end			
		
	new_boolean_evaluation (a_frame: ICOR_DEBUG_FRAME; a_val: BOOLEAN): ICOR_DEBUG_VALUE is
			-- New Object evaluation with Boolean
		local
			l_gen_obj: ICOR_DEBUG_GENERIC_VALUE
		do
			prepare_evaluation (a_frame)
			Result := last_icor_debug_eval.create_value (element_type_boolean , Void)
			if Result /= Void then
				l_gen_obj := Result.query_interface_icor_debug_generic_value
				check l_gen_obj /= Void end					

				l_gen_obj.set_value ($a_val)
				l_gen_obj.set_associated_frame (a_frame)				
			end
			end_evaluation
		end

	new_char_evaluation (a_frame: ICOR_DEBUG_FRAME; a_val: CHARACTER): ICOR_DEBUG_VALUE is
			-- New Object evaluation with Character
		local
			l_gen_obj: ICOR_DEBUG_GENERIC_VALUE
		do
			prepare_evaluation (a_frame)
			Result := last_icor_debug_eval.create_value (element_type_char , Void)
			if Result /= Void then
				l_gen_obj := Result.query_interface_icor_debug_generic_value
				check l_gen_obj /= Void end					

				l_gen_obj.set_value ($a_val)
				l_gen_obj.set_associated_frame (a_frame)				
			end
			end_evaluation
		end	
		
	new_void_evaluation (a_frame: ICOR_DEBUG_FRAME): ICOR_DEBUG_VALUE is
			-- New Object evaluation with Void
		do
			prepare_evaluation (a_frame)
			Result := last_icor_debug_eval.create_value (element_type_class, Void)
			Result.set_associated_frame (a_frame)
			end_evaluation
		end	
		
feature {EIFNET_EXPORTER} -- Eiffel Instances facilities

	new_eiffel_string_evaluation (a_frame: ICOR_DEBUG_FRAME; a_val: STRING): ICOR_DEBUG_VALUE is
			-- New Object evaluation with String
		local
			l_str_icdv: ICOR_DEBUG_VALUE
		do
			l_str_icdv := new_string_evaluation (a_frame, a_val)
			Result := icdv_string_from_icdv_system_string (a_frame, l_str_icdv)
		end	
		
	new_reference_i4_evaluation (a_frame: ICOR_DEBUG_FRAME; a_val: INTEGER): ICOR_DEBUG_VALUE is
			-- New Object evaluation with i4 _REF
		do
			Result := new_i4_evaluation (a_frame, a_val)
			Result := icdv_reference_integer_from_icdv_integer (a_frame, Result)
		end
		
	new_reference_real_evaluation (a_frame: ICOR_DEBUG_FRAME; a_val: REAL): ICOR_DEBUG_VALUE is
			-- New Object evaluation with real _REF
		do
			Result := new_r4_evaluation (a_frame, a_val)
			Result := icdv_reference_real_from_icdv_real (a_frame, Result)
		end	
		
	new_reference_double_evaluation (a_frame: ICOR_DEBUG_FRAME; a_val: DOUBLE): ICOR_DEBUG_VALUE is
			-- New Object evaluation with double _REF
		do
			Result := new_r8_evaluation (a_frame, a_val)
			Result := icdv_reference_double_from_icdv_double (a_frame, Result)
		end	

	new_reference_boolean_evaluation (a_frame: ICOR_DEBUG_FRAME; a_val: BOOLEAN): ICOR_DEBUG_VALUE is
			-- New Object evaluation with boolean _REF
		do
			Result := new_boolean_evaluation (a_frame, a_val)
			Result := icdv_reference_boolean_from_icdv_boolean (a_frame, Result)
		end	

	new_reference_character_evaluation (a_frame: ICOR_DEBUG_FRAME; a_val: CHARACTER): ICOR_DEBUG_VALUE is
			-- New Object evaluation with char _REF
		do
			Result := new_char_evaluation (a_frame, a_val)
			Result := icdv_reference_character_from_icdv_character (a_frame, Result)
		end
		
		
feature {DBG_EVALUATOR} -- Class construction facilities

	icdv_string_from_icdv_system_string (a_frame: ICOR_DEBUG_FRAME; a_sys_string: ICOR_DEBUG_VALUE): ICOR_DEBUG_VALUE is
			-- ICorDebugValue for STRING object created from SystemString `a_sys_string'
		do
			prepare_evaluation (a_frame)
			last_icor_debug_eval.new_object_no_constructor (eiffel_string_icd_class)
			Result := complete_function_evaluation
			
			method_evaluation (a_frame, eiffel_string_make_from_cil_constructor, <<Result, a_sys_string>>)
			Result.set_associated_frame (a_frame)
		end	
		
	icdv_reference_integer_from_icdv_integer (a_frame: ICOR_DEBUG_FRAME; a_icdv_integer: ICOR_DEBUG_VALUE): ICOR_DEBUG_VALUE is
			-- ICorDebugValue for INTEGER_REF object created from SystemInteger `a_icdv_integer'
		do
			prepare_evaluation (a_frame)
			last_icor_debug_eval.new_object_no_constructor (reference_integer_32_icd_class)
			Result := complete_function_evaluation		
			method_evaluation (a_frame, reference_integer_32_set_item_method, <<Result, a_icdv_integer>>)
			Result.set_associated_frame (a_frame)
		end	
		
	icdv_reference_real_from_icdv_real (a_frame: ICOR_DEBUG_FRAME; a_icdv_real: ICOR_DEBUG_VALUE): ICOR_DEBUG_VALUE is
			-- ICorDebugValue for REAL_REF object created from SystemReal `a_icdv_real'
		do
			prepare_evaluation (a_frame)
			last_icor_debug_eval.new_object_no_constructor (reference_real_icd_class)
			Result := complete_function_evaluation		
			method_evaluation (a_frame, reference_real_set_item_method, <<Result, a_icdv_real>>)
			Result.set_associated_frame (a_frame)
		end	

	icdv_reference_double_from_icdv_double (a_frame: ICOR_DEBUG_FRAME; a_icdv_double: ICOR_DEBUG_VALUE): ICOR_DEBUG_VALUE is
			-- ICorDebugValue for DOUBLE_REF object created from SystemDouble `a_icdv_double'
		do
			prepare_evaluation (a_frame)
			last_icor_debug_eval.new_object_no_constructor (reference_double_icd_class)
			Result := complete_function_evaluation		
			method_evaluation (a_frame, reference_double_set_item_method, <<Result, a_icdv_double>>)
			Result.set_associated_frame (a_frame)
		end			
		
	icdv_reference_boolean_from_icdv_boolean (a_frame: ICOR_DEBUG_FRAME; a_icdv_boolean: ICOR_DEBUG_VALUE): ICOR_DEBUG_VALUE is
			-- ICorDebugValue for BOOLEAN_REF object created from SystemBoolean `a_icdv_boolean'
		do
			prepare_evaluation (a_frame)
			last_icor_debug_eval.new_object_no_constructor (reference_boolean_icd_class)
			Result := complete_function_evaluation		
			method_evaluation (a_frame, reference_boolean_set_item_method, <<Result, a_icdv_boolean>>)
			Result.set_associated_frame (a_frame)
		end		

	icdv_reference_character_from_icdv_character (a_frame: ICOR_DEBUG_FRAME; a_icdv_character: ICOR_DEBUG_VALUE): ICOR_DEBUG_VALUE is
			-- ICorDebugValue for CHARACTER_REF object created from SystemChar `a_icdv_character'
		do
			prepare_evaluation (a_frame)
			last_icor_debug_eval.new_object_no_constructor (reference_character_icd_class)
			Result := complete_function_evaluation		
			method_evaluation (a_frame, reference_character_set_item_method, <<Result, a_icdv_character>>)
			Result.set_associated_frame (a_frame)
		end				

feature {NONE} -- Backup state

	saved_last_managed_callback: INTEGER
			-- Last managed callback saved data 
			-- try to impact the less possible other debugger functionalities
	
	save_state_info is
			-- Save current debugger state information
		do
			saved_last_managed_callback := eifnet_debugger.last_managed_callback			
		end	

	restore_state_info is
			-- Restore saved debugger state information
		do
			eifnet_debugger.set_last_managed_callback (saved_last_managed_callback)
		end	
		
feature {NONE}

	last_icor_debug_eval: ICOR_DEBUG_EVAL
			-- Last ICorDebugEval object used for evalutation

	last_app_status: APPLICATION_STATUS_DOTNET
			-- Last APPLICATION_STATUS_DOTNET data

	prepare_evaluation (a_frame: ICOR_DEBUG_FRAME) is
			-- Prepare data for evaluation.
		local
			l_chain: ICOR_DEBUG_CHAIN
			l_icd_thread: ICOR_DEBUG_THREAD
			l_icd_eval: ICOR_DEBUG_EVAL
			l_status: APPLICATION_STATUS_DOTNET
		do
			last_eval_is_exception := False
			save_state_info
			if a_frame /= Void then
				l_chain := a_frame.get_chain
				l_icd_thread := l_chain.get_thread
			else
				l_icd_thread := eifnet_debugger.icor_debug_thread
			end
			l_icd_eval := l_icd_thread.create_eval
			l_status := application.imp_dotnet.status
			l_status.set_is_evaluating (True)
				--| Let use the evaluating mecanism instead of the normal one
				--| then let's disable the timer for ec callback
			eifnet_debugger.stop_dbg_timer

			last_icor_debug_eval := l_icd_eval
			last_app_status := l_status
				--| We then call effective evaluation
		end

	end_evaluation is
			-- In case of direct evaluation, with no callback,
			-- Complete the evaluation by cleaning temporary data
			-- and restoring state
		require
			last_icor_debug_eval /= Void
			last_app_status /= Void
		local
			l_icd_eval: ICOR_DEBUG_EVAL
			l_status: APPLICATION_STATUS_DOTNET
		do
			l_icd_eval := last_icor_debug_eval
			last_call_success := l_icd_eval.last_call_success
			l_status := last_app_status
			l_status.set_is_evaluating (False)
			restore_state_info			
		end

	complete_method_evaluation is
			-- In case of method evaluation, requiring a callback,
			-- Complete the evaluation by cleaning temporary data
			-- and restoring state
		require
			last_icor_debug_eval /= Void
			last_app_status /= Void
		local
			l_icd_eval: ICOR_DEBUG_EVAL
			l_status: APPLICATION_STATUS_DOTNET
		do
			l_icd_eval := last_icor_debug_eval
			last_call_success := l_icd_eval.last_call_success			
			l_status := last_app_status

			eifnet_debugger.do_continue
				--| And we wait for all callback to be finished
			eifnet_debugger.lock_and_wait_for_callback (eifnet_debugger.icor_debug_process)
			eifnet_debugger.reset_data_changed
			if 
				eifnet_debugger.last_managed_callback_is_exception 
			then
				check False end
				debug ("DEBUGGER_TRACE_EVAL")
					display_last_exception
					print ("EIFNET_DEBUGGER.debug_output_.. :: WARNING Exception occurred %N")
				end
				eifnet_debugger.do_clear_exception
			elseif eifnet_debugger.last_managed_callback_is_eval_exception then
				-- Exception !!			
				last_eval_is_exception := True
			end
			l_status.set_is_evaluating (False)
			eifnet_debugger.start_dbg_timer
			restore_state_info
		end

	complete_function_evaluation: ICOR_DEBUG_VALUE is
			-- In case of function evaluation, requiring a callback and a result value,
			-- Complete the evaluation by cleaning temporary data
			-- and restoring state
		require
			last_icor_debug_eval /= Void
			last_app_status /= Void
		local
			l_icd_eval: ICOR_DEBUG_EVAL
			l_status: APPLICATION_STATUS_DOTNET
		do
			l_icd_eval := last_icor_debug_eval
			l_status := last_app_status

			eifnet_debugger.do_continue
				--| And we wait for all callback to be finished
			eifnet_debugger.lock_and_wait_for_callback (eifnet_debugger.icor_debug_process)
			eifnet_debugger.reset_data_changed
			if 
				eifnet_debugger.last_managed_callback_is_exception 
			then
				check False end
				Result := Void --"WARNING: Could not evaluate output"
				debug ("DEBUGGER_TRACE_EVAL")
					display_last_exception
					print ("EIFNET_DEBUGGER.debug_output_.. :: WARNING Exception occurred %N")
				end
				eifnet_debugger.do_clear_exception
			elseif eifnet_debugger.last_managed_callback_is_eval_exception then
				Result := Void
				last_eval_is_exception := True
			elseif eifnet_debugger.last_managed_callback_is_exit_process then
				eifnet_debugger.notify_exit_process_occurred
				Result := Void
			else				
				Result := l_icd_eval.get_result
			end
			l_status.set_is_evaluating (False)
			eifnet_debugger.start_dbg_timer
			restore_state_info
			last_call_success := l_icd_eval.last_call_success			
		end

	display_last_exception is
			-- Display information related to Last Exception
			-- debug purpose only
		require
			eifnet_debugger.last_managed_callback_is_exception 
		local
			l_exception_info: EIFNET_DEBUG_VALUE_INFO
			l_exception: ICOR_DEBUG_VALUE
		do
			l_exception := eifnet_debugger.active_exception_value
			if l_exception /= Void then
				create l_exception_info.make (l_exception)

				print ("%N%NException ....%N")
				print ("%T Class   => " + l_exception_info.value_class_name + "%N")
				print ("%T Module  => " + l_exception_info.value_module_file_name + "%N")
			end
		end

feature {NONE} -- Implementation : ICor... once per session

	reference_integer_32_icd_class: ICOR_DEBUG_CLASS is
			-- IcorDebugClass for reference INTEGER
		do
			Result := once_reference_integer_32_icd_class
			if Result = Void then
				once_reference_integer_32_icd_class := eifnet_debugger.reference_integer_32_icd_class
				Result := once_reference_integer_32_icd_class
			end
		ensure
			Result /= Void
		end
		
	reference_real_icd_class: ICOR_DEBUG_CLASS is
			-- IcorDebugClass for reference REAL
		do
			Result := once_reference_real_icd_class
			if Result = Void then
				once_reference_real_icd_class := eifnet_debugger.reference_real_icd_class
				Result := once_reference_real_icd_class
			end
		ensure
			Result /= Void
		end
		
	reference_double_icd_class: ICOR_DEBUG_CLASS is
			-- IcorDebugClass for reference DOUBLE
		do
			Result := once_reference_double_icd_class
			if Result = Void then
				once_reference_double_icd_class := eifnet_debugger.reference_double_icd_class
				Result := once_reference_double_icd_class
			end
		ensure
			Result /= Void
		end		

	reference_boolean_icd_class: ICOR_DEBUG_CLASS is
			-- IcorDebugClass for reference BOOLEAN
		do
			Result := once_reference_boolean_icd_class
			if Result = Void then
				once_reference_boolean_icd_class := eifnet_debugger.reference_boolean_icd_class
				Result := once_reference_boolean_icd_class
			end
		ensure
			Result /= Void
		end

	reference_character_icd_class: ICOR_DEBUG_CLASS is
			-- IcorDebugClass for reference CHARACTER
		do
			Result := once_reference_character_icd_class
			if Result = Void then
				once_reference_character_icd_class := eifnet_debugger.reference_character_icd_class
				Result := once_reference_character_icd_class
			end
		ensure
			Result /= Void
		end
						
	eiffel_string_icd_class: ICOR_DEBUG_CLASS is
			-- IcorDebugClass for STRING
		do
			Result := once_eiffel_string_icd_class
			if Result = Void then
				once_eiffel_string_icd_class := eifnet_debugger.eiffel_string_icd_class
				Result := once_eiffel_string_icd_class
			end
		ensure
			Result /= Void
		end
		
	reference_integer_32_set_item_method: ICOR_DEBUG_FUNCTION is
			-- ICorDebugFunction for reference INTEGER.set_item (..)
		do
			Result := once_reference_integer_32_set_item_method
			if Result = Void then
				once_reference_integer_32_set_item_method := eifnet_debugger.reference_integer_32_set_item_method
				Result := once_reference_integer_32_set_item_method
			end
		ensure
			Result /= Void
		end
		
	reference_real_set_item_method: ICOR_DEBUG_FUNCTION is
			-- ICorDebugFunction for reference REAL.set_item (..)
		do
			Result := once_reference_real_set_item_method
			if Result = Void then
				once_reference_real_set_item_method := eifnet_debugger.reference_real_set_item_method
				Result := once_reference_real_set_item_method
			end
		ensure
			Result /= Void
		end
		
	reference_double_set_item_method: ICOR_DEBUG_FUNCTION is
			-- ICorDebugFunction for reference DOUBLE.set_item (..)
		do
			Result := once_reference_double_set_item_method
			if Result = Void then
				once_reference_double_set_item_method := eifnet_debugger.reference_double_set_item_method
				Result := once_reference_double_set_item_method
			end
		ensure
			Result /= Void
		end
		
	reference_boolean_set_item_method: ICOR_DEBUG_FUNCTION is
			-- ICorDebugFunction for reference BOOLEAN.set_item (..)
		do
			Result := once_reference_boolean_set_item_method
			if Result = Void then
				once_reference_boolean_set_item_method := eifnet_debugger.reference_boolean_set_item_method
				Result := once_reference_boolean_set_item_method
			end
		ensure
			Result /= Void
		end
				
	reference_character_set_item_method: ICOR_DEBUG_FUNCTION is
			-- ICorDebugFunction for reference CHARACTER.set_item (..)
		do
			Result := once_reference_character_set_item_method
			if Result = Void then
				once_reference_character_set_item_method := eifnet_debugger.reference_character_set_item_method
				Result := once_reference_character_set_item_method
			end
		ensure
			Result /= Void
		end	
		
	eiffel_string_make_from_cil_constructor: ICOR_DEBUG_FUNCTION is
			-- ICorDebugFunction for STRING.make_from_cil (..)
		do
			Result := once_eiffel_string_make_from_cil_constructor
			if Result = Void then
				once_eiffel_string_make_from_cil_constructor := eifnet_debugger.eiffel_string_make_from_cil_constructor
				Result := once_eiffel_string_make_from_cil_constructor
			end
		ensure
			Result /= Void
		end

feature {NONE} -- Private Implementation : ICor... once per session

	reset_once_per_session is
			-- Reset the data related to one debugging session
		do
			once_reference_integer_32_icd_class          := Void
			once_reference_real_icd_class                := Void
			once_reference_double_icd_class              := Void
			once_reference_boolean_icd_class             := Void
			once_reference_character_icd_class           := Void
			once_eiffel_string_icd_class                 := Void

			once_reference_integer_32_set_item_method    := Void
			once_reference_real_set_item_method          := Void
			once_reference_double_set_item_method        := Void
			once_reference_boolean_set_item_method       := Void
			once_reference_character_set_item_method     := Void

			once_eiffel_string_make_from_cil_constructor := Void
		end

	once_reference_integer_32_icd_class          : ICOR_DEBUG_CLASS
	once_reference_real_icd_class                : ICOR_DEBUG_CLASS
	once_reference_double_icd_class              : ICOR_DEBUG_CLASS
	once_reference_boolean_icd_class             : ICOR_DEBUG_CLASS
	once_reference_character_icd_class           : ICOR_DEBUG_CLASS
	once_eiffel_string_icd_class                 : ICOR_DEBUG_CLASS

	once_reference_integer_32_set_item_method    : ICOR_DEBUG_FUNCTION
	once_reference_real_set_item_method          : ICOR_DEBUG_FUNCTION
	once_reference_double_set_item_method        : ICOR_DEBUG_FUNCTION
	once_reference_boolean_set_item_method       : ICOR_DEBUG_FUNCTION
	once_reference_character_set_item_method     : ICOR_DEBUG_FUNCTION

	once_eiffel_string_make_from_cil_constructor : ICOR_DEBUG_FUNCTION

end	
