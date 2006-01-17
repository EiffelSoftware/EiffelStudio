indexing
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

	SHARED_APPLICATION_EXECUTION
		export
			{NONE} all
		end
		
	EIFNET_ICOR_ELEMENT_TYPES_CONSTANTS
		export
			{NONE} all
		end
		
	SHARED_EIFNET_DEBUG_VALUE_FORMATTER

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

	last_eval_aborted: BOOLEAN
			-- last eval had been Aborted
			
	last_call_succeed: BOOLEAN is
		do
			Result := return_code_is_call_succeed (last_call_success)
		end
		

feature {EIFNET_EXPORTER, EB_OBJECT_TOOL} -- Evaluation primitives

	function_evaluation (a_frame: ICOR_DEBUG_FRAME; a_func: ICOR_DEBUG_FUNCTION; a_args: ARRAY [ICOR_DEBUG_VALUE]): ICOR_DEBUG_VALUE is
			-- Function evaluation result for `a_func' on `a_icd'
		require
			args_not_void: a_args /= Void
			func_not_void: a_func /= Void
		do
			debug ("debugger_trace_eval")
				print ("Start : " + generator + ".function_evaluation ... %N")
				print (" -----> " + a_func.to_function_name + "%N")
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

	method_evaluation (a_frame: ICOR_DEBUG_FRAME; a_meth: ICOR_DEBUG_FUNCTION; a_args: ARRAY [ICOR_DEBUG_VALUE]) is
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
		
	new_string_evaluation (a_frame: ICOR_DEBUG_FRAME; a_string: STRING): ICOR_DEBUG_VALUE is
			-- NewString evaluation with `a_string'
		require
			a_string /= Void
		do
			prepare_evaluation (a_frame, True)
			last_icor_debug_eval.new_string (a_string)
			Result := complete_function_evaluation
		end

	new_object_no_constructor_evaluation (a_frame: ICOR_DEBUG_FRAME; a_icd_class: ICOR_DEBUG_CLASS): ICOR_DEBUG_VALUE is
			-- NewObjectNoConstructor evaluation on `a_icd_class'
		require
			a_icd_class /= Void
		do
			prepare_evaluation (a_frame, True)
			last_icor_debug_eval.new_object_no_constructor (a_icd_class)
			Result := complete_function_evaluation
		end

	new_object_evaluation (a_frame: ICOR_DEBUG_FRAME; a_icd_func: ICOR_DEBUG_FUNCTION; a_args: ARRAY [ICOR_DEBUG_VALUE]): ICOR_DEBUG_VALUE is
			-- NewObject evaluation on `a_icd_class'
		require
			a_icd_func /= Void
			a_args /= Void
		do
			prepare_evaluation (a_frame, True)
			last_icor_debug_eval.new_object (a_icd_func, a_args)
			Result := complete_function_evaluation
		end

feature {EIFNET_EXPORTER, EB_OBJECT_TOOL} -- Basic value creation

	new_i4_evaluation (a_frame: ICOR_DEBUG_FRAME; a_val: INTEGER): ICOR_DEBUG_VALUE is
			-- New Object evaluation with i4
		local
			l_gen_obj: ICOR_DEBUG_GENERIC_VALUE
		do
			prepare_evaluation (a_frame, False)
			Result := last_icor_debug_eval.create_value (Element_type_i4 , Void)
			if Result /= Void then
				l_gen_obj := Result.query_interface_icor_debug_generic_value
				check l_gen_obj /= Void end
				l_gen_obj.set_value ($a_val)
				l_gen_obj.clean_on_dispose
			end
			end_evaluation
		end
		
	new_r4_evaluation (a_frame: ICOR_DEBUG_FRAME; a_val: REAL): ICOR_DEBUG_VALUE is
			-- New Object evaluation with real
		local
			l_gen_obj: ICOR_DEBUG_GENERIC_VALUE
		do
			prepare_evaluation (a_frame, False)
			Result := last_icor_debug_eval.create_value (element_type_r4 , Void)
			if Result /= Void then
				l_gen_obj := Result.query_interface_icor_debug_generic_value
				check l_gen_obj /= Void end
				l_gen_obj.set_value ($a_val)
				l_gen_obj.clean_on_dispose
			end
			end_evaluation
		end
		
	new_r8_evaluation (a_frame: ICOR_DEBUG_FRAME; a_val: DOUBLE): ICOR_DEBUG_VALUE is
			-- New Object evaluation with real
		local
			l_gen_obj: ICOR_DEBUG_GENERIC_VALUE
		do
			prepare_evaluation (a_frame, False)
			Result := last_icor_debug_eval.create_value (element_type_r8 , Void)
			if Result /= Void then
				l_gen_obj := Result.query_interface_icor_debug_generic_value
				check l_gen_obj /= Void end
				l_gen_obj.set_value ($a_val)
				l_gen_obj.clean_on_dispose
			end
			end_evaluation
		end
		
	new_boolean_evaluation (a_frame: ICOR_DEBUG_FRAME; a_val: BOOLEAN): ICOR_DEBUG_VALUE is
			-- New Object evaluation with Boolean
		local
			l_gen_obj: ICOR_DEBUG_GENERIC_VALUE
		do
			prepare_evaluation (a_frame, False)
			Result := last_icor_debug_eval.create_value (element_type_boolean , Void)
			if Result /= Void then
				l_gen_obj := Result.query_interface_icor_debug_generic_value
				check l_gen_obj /= Void end
				l_gen_obj.set_value ($a_val)
				l_gen_obj.clean_on_dispose
			end
			end_evaluation
		end

	new_char_evaluation (a_frame: ICOR_DEBUG_FRAME; a_val: CHARACTER): ICOR_DEBUG_VALUE is
			-- New Object evaluation with Character
		local
			l_gen_obj: ICOR_DEBUG_GENERIC_VALUE
		do
			prepare_evaluation (a_frame, False)
			Result := last_icor_debug_eval.create_value (element_type_char , Void)
			if Result /= Void then
				l_gen_obj := Result.query_interface_icor_debug_generic_value
				check l_gen_obj /= Void end
				l_gen_obj.set_value ($a_val)
				l_gen_obj.clean_on_dispose
			end
			end_evaluation
		end	
		
	new_void_evaluation (a_frame: ICOR_DEBUG_FRAME): ICOR_DEBUG_VALUE is
			-- New Object evaluation with Void
		do
			prepare_evaluation (a_frame, False)
			Result := last_icor_debug_eval.create_value (element_type_class, Void)
			end_evaluation
		end	
		
feature {EIFNET_EXPORTER} -- Eiffel Instances facilities

	new_eiffel_string_evaluation (a_frame: ICOR_DEBUG_FRAME; a_val: STRING): ICOR_DEBUG_VALUE is
			-- New Object evaluation with String
		local
			l_icdv: ICOR_DEBUG_VALUE
		do
			l_icdv := new_string_evaluation (a_frame, a_val)
			Result := icdv_string_from_icdv_system_string (a_frame, l_icdv)
			l_icdv.clean_on_dispose
		end	
		
	new_reference_i4_evaluation (a_frame: ICOR_DEBUG_FRAME; a_val: INTEGER): ICOR_DEBUG_VALUE is
			-- New Object evaluation with i4 _REF
		local
			l_icdv: ICOR_DEBUG_VALUE
		do
			l_icdv := new_i4_evaluation (a_frame, a_val)
			Result := icdv_reference_integer_32_from_icdv_integer_32 (a_frame, l_icdv)
			l_icdv.clean_on_dispose
		end
		
	new_reference_real_evaluation (a_frame: ICOR_DEBUG_FRAME; a_val: REAL): ICOR_DEBUG_VALUE is
			-- New Object evaluation with real _REF
		local
			l_icdv: ICOR_DEBUG_VALUE
		do
			l_icdv := new_r4_evaluation (a_frame, a_val)
			Result := icdv_reference_real_from_icdv_real (a_frame, l_icdv)
			l_icdv.clean_on_dispose
		end	
		
	new_reference_double_evaluation (a_frame: ICOR_DEBUG_FRAME; a_val: DOUBLE): ICOR_DEBUG_VALUE is
			-- New Object evaluation with double _REF
		local
			l_icdv: ICOR_DEBUG_VALUE
		do
			l_icdv := new_r8_evaluation (a_frame, a_val)
			Result := icdv_reference_double_from_icdv_double (a_frame, l_icdv)
			l_icdv.clean_on_dispose
		end	

	new_reference_boolean_evaluation (a_frame: ICOR_DEBUG_FRAME; a_val: BOOLEAN): ICOR_DEBUG_VALUE is
			-- New Object evaluation with boolean _REF
		local
			l_icdv: ICOR_DEBUG_VALUE
		do
			l_icdv := new_boolean_evaluation (a_frame, a_val)
			Result := icdv_reference_boolean_from_icdv_boolean (a_frame, l_icdv)
			l_icdv.clean_on_dispose
		end	

	new_reference_character_evaluation (a_frame: ICOR_DEBUG_FRAME; a_val: CHARACTER): ICOR_DEBUG_VALUE is
			-- New Object evaluation with char _REF
		local
			l_icdv: ICOR_DEBUG_VALUE
		do
			l_icdv := new_char_evaluation (a_frame, a_val)
			Result := icdv_reference_character_from_icdv_character (a_frame, l_icdv)
			l_icdv.clean_on_dispose
		end
		
feature {DBG_EVALUATOR_DOTNET} -- Class construction facilities

	icdv_string_from_icdv_system_string (a_frame: ICOR_DEBUG_FRAME; a_sys_string: ICOR_DEBUG_VALUE): ICOR_DEBUG_VALUE is
			-- ICorDebugValue for STRING object created from SystemString `a_sys_string'
		do
			prepare_evaluation (a_frame, True)
			last_icor_debug_eval.new_object_no_constructor (eiffel_string_icd_class)
			Result := complete_function_evaluation
			method_evaluation (a_frame, eiffel_string_make_from_cil_constructor, <<Result, a_sys_string>>)
		end	
		
	icdv_reference_integer_32_from_icdv_integer_32 (a_frame: ICOR_DEBUG_FRAME; a_icdv_integer_32: ICOR_DEBUG_VALUE): ICOR_DEBUG_VALUE is
			-- ICorDebugValue for INTEGER_REF object created from SystemInteger `a_icdv_integer'
		do
			prepare_evaluation (a_frame, True)
			last_icor_debug_eval.new_object_no_constructor (reference_integer_32_icd_class)
			Result := complete_function_evaluation		
			method_evaluation (a_frame, reference_integer_32_set_item_method, <<Result, a_icdv_integer_32>>)
		end	
		
	icdv_reference_real_from_icdv_real (a_frame: ICOR_DEBUG_FRAME; a_icdv_real: ICOR_DEBUG_VALUE): ICOR_DEBUG_VALUE is
			-- ICorDebugValue for REAL_REF object created from SystemReal `a_icdv_real'
		do
			prepare_evaluation (a_frame, True)
			last_icor_debug_eval.new_object_no_constructor (reference_real_icd_class)
			Result := complete_function_evaluation		
			method_evaluation (a_frame, reference_real_set_item_method, <<Result, a_icdv_real>>)
		end	

	icdv_reference_double_from_icdv_double (a_frame: ICOR_DEBUG_FRAME; a_icdv_double: ICOR_DEBUG_VALUE): ICOR_DEBUG_VALUE is
			-- ICorDebugValue for DOUBLE_REF object created from SystemDouble `a_icdv_double'
		do
			prepare_evaluation (a_frame, True)
			last_icor_debug_eval.new_object_no_constructor (reference_double_icd_class)
			Result := complete_function_evaluation		
			method_evaluation (a_frame, reference_double_set_item_method, <<Result, a_icdv_double>>)
		end			
		
	icdv_reference_boolean_from_icdv_boolean (a_frame: ICOR_DEBUG_FRAME; a_icdv_boolean: ICOR_DEBUG_VALUE): ICOR_DEBUG_VALUE is
			-- ICorDebugValue for BOOLEAN_REF object created from SystemBoolean `a_icdv_boolean'
		do
			prepare_evaluation (a_frame, True)
			last_icor_debug_eval.new_object_no_constructor (reference_boolean_icd_class)
			Result := complete_function_evaluation		
			method_evaluation (a_frame, reference_boolean_set_item_method, <<Result, a_icdv_boolean>>)
		end		

	icdv_reference_character_from_icdv_character (a_frame: ICOR_DEBUG_FRAME; a_icdv_character: ICOR_DEBUG_VALUE): ICOR_DEBUG_VALUE is
			-- ICorDebugValue for CHARACTER_REF object created from SystemChar `a_icdv_character'
		do
			prepare_evaluation (a_frame, True)
			last_icor_debug_eval.new_object_no_constructor (reference_character_icd_class)
			Result := complete_function_evaluation		
			method_evaluation (a_frame, reference_character_set_item_method, <<Result, a_icdv_character>>)
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

	prepare_evaluation (a_useless_frame: ICOR_DEBUG_FRAME; stop_timer_required: BOOLEAN) is
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
			
			l_status ?= Application.status
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
		
	evaluation_termination (restart_timer_required: BOOLEAN) is
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
					if not application.is_stopped then
						eifnet_debugger.start_dbg_timer						
					end
				end
			end
			restore_state_info
			clean_temp_data
		ensure
			not Eifnet_debugger.is_inside_function_evaluation
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
		do
			l_icd_eval := last_icor_debug_eval
			if l_icd_eval /= Void then
				last_call_success := l_icd_eval.last_call_success
			end
			evaluation_termination (False)
		end

	Feature_evaluation_timeout: INTEGER is
			-- Timeout of the function evaluation.
			-- (in seconds)
		do
			Result := Application.max_evaluation_duration
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

	complete_function_evaluation: ICOR_DEBUG_VALUE is
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
					last_eval_aborted := (l_icd_eval.last_call_success & 0xFFFF) = {EIFNET_API_ERROR_CODE_FORMATTER}.cordbg_s_func_eval_aborted
				end
			end
			evaluation_termination (True)
		end

	clean_temp_data	is
			-- Clean temporary data used for evaluation
		do
			last_icor_debug_eval.clean_on_dispose
			last_icor_debug_eval := Void
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

feature {EIFNET_DEBUGGER} -- Private Implementation : ICor... once per session

	reset is
			-- Reset all data
		do
			reset_once_per_session
			last_app_status := Void
			last_icor_debug_eval := Void
		end		

	reset_once_per_session is
			-- Reset the data related to one debugging session
		do
				--| Clean kept ICorDebugClass
			if once_reference_integer_32_icd_class /= Void then
				once_reference_integer_32_icd_class          := Void
			end
			if once_reference_real_icd_class /= Void then
				once_reference_real_icd_class                := Void
			end
			if once_reference_double_icd_class /= Void then
				once_reference_double_icd_class              := Void
			end
			if once_reference_boolean_icd_class /= Void then
				once_reference_boolean_icd_class             := Void
			end
			if once_reference_character_icd_class /= Void then
				once_reference_character_icd_class           := Void
			end
			if once_eiffel_string_icd_class /= Void then
				once_eiffel_string_icd_class                 := Void
			end

				--| Clean kept ICorDebugFunction
			if once_reference_integer_32_set_item_method /= Void then
				once_reference_integer_32_set_item_method    := Void
			end
			if once_reference_real_set_item_method /= Void then
				once_reference_real_set_item_method          := Void
			end
			if once_reference_double_set_item_method /= Void then
				once_reference_double_set_item_method        := Void
			end
			if once_reference_boolean_set_item_method /= Void then
				once_reference_boolean_set_item_method       := Void
			end
			if once_reference_character_set_item_method /= Void then
				once_reference_character_set_item_method     := Void
			end

			if once_eiffel_string_make_from_cil_constructor /= Void then
				once_eiffel_string_make_from_cil_constructor := Void
			end
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

feature {NONE} -- Helper Impl

	return_code_is_call_succeed (lcs: INTEGER): BOOLEAN is
			-- Is last call `lcs' a success ?
		do
			Result := lcs = 0 or lcs = 1 -- S_OK or S_FALSE
				--| HRESULT .. < 0 if error ...
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end	
