indexing
	description: "Objects that ..."
	author: ""
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

feature -- Initialization

	make (dbg: EIFNET_DEBUGGER) is
		do
			eifnet_debugger := dbg
		end

	eifnet_debugger: EIFNET_DEBUGGER

feature {EIFNET_EXPORTER, EB_OBJECT_TOOL} -- Evaluation primitives

	function_evaluation (a_frame: ICOR_DEBUG_FRAME; a_func: ICOR_DEBUG_FUNCTION; a_args: ARRAY [ICOR_DEBUG_VALUE]): ICOR_DEBUG_VALUE is
			-- Function evaluation result for `a_func' on `a_icd'
		require
			args_not_void: a_args /= Void
			func_not_void: a_func /= Void
		do
			prepare_evaluation (a_frame)
			last_icor_debug_eval.call_function (a_func, a_args)
			Result := complete_evaluation
		end
		
	new_string_evaluation (a_frame: ICOR_DEBUG_FRAME; a_string: STRING): ICOR_DEBUG_VALUE is
			-- NewString evaluation with `a_string'
		require
			a_string /= Void
		do
			prepare_evaluation (a_frame)
			last_icor_debug_eval.new_string (a_string)
			Result := complete_evaluation
		end

	new_object_no_constructor_evaluation (a_frame: ICOR_DEBUG_FRAME; a_icd_class: ICOR_DEBUG_CLASS): ICOR_DEBUG_VALUE is
			-- NewObjectNoConstructor evaluation on `a_icd_class'
		require
			a_icd_class /= Void
		do
			prepare_evaluation (a_frame)
			last_icor_debug_eval.new_object_no_constructor (a_icd_class)
			Result := complete_evaluation
		end

	new_object_evaluation (a_frame: ICOR_DEBUG_FRAME; a_icd_func: ICOR_DEBUG_FUNCTION; a_args: ARRAY [ICOR_DEBUG_VALUE]): ICOR_DEBUG_VALUE is
			-- NewObject evaluation on `a_icd_class'
		require
			a_icd_func /= Void
			a_args /= Void
		do
			prepare_evaluation (a_frame)
			last_icor_debug_eval.new_object (a_icd_func, a_args)
			Result := complete_evaluation
		end

feature {EIFNET_EXPORTER, EB_OBJECT_TOOL} -- Basic value creation

	new_i4_evaluation (a_frame: ICOR_DEBUG_FRAME; a_val: INTEGER): ICOR_DEBUG_VALUE is
			-- New Object evaluation with i4
		require
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
				Result := l_gen_obj
			end
			end_evaluation
		end
		
	new_boolean_evaluation (a_frame: ICOR_DEBUG_FRAME; a_val: BOOLEAN): ICOR_DEBUG_VALUE is
			-- New Object evaluation with Boolean
		require
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
				Result := l_gen_obj
			end
			end_evaluation
		end	
		
	new_char_evaluation (a_frame: ICOR_DEBUG_FRAME; a_val: CHARACTER): ICOR_DEBUG_VALUE is
			-- New Object evaluation with Character
		require
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
				Result := l_gen_obj
			end
			end_evaluation
		end	
		
	new_void_evaluation (a_frame: ICOR_DEBUG_FRAME): ICOR_DEBUG_VALUE is
			-- New Object evaluation with Void
		require
		local
			l_gen_obj: ICOR_DEBUG_GENERIC_VALUE
			
		do
			prepare_evaluation (a_frame)
			Result := last_icor_debug_eval.create_value (element_type_class, Void)
			Result.set_associated_frame (a_frame)
			end_evaluation
		end	
		
feature {EIFNET_EXPORTER} -- String facilities

	new_eiffel_string_evaluation (a_frame: ICOR_DEBUG_FRAME; a_val: STRING): ICOR_DEBUG_VALUE is
			-- New Object evaluation with String
		require
		local
			l_str_icdv: ICOR_DEBUG_VALUE
		do
			l_str_icdv := new_string_evaluation (a_frame, a_val)
			prepare_evaluation (a_frame)
			last_icor_debug_eval.new_object (eiffel_string_make_from_cil_constructor, <<l_str_icdv>>)			
			Result := complete_evaluation
		end	

	eiffel_string_make_from_cil_constructor: ICOR_DEBUG_FUNCTION is

		once
			Result := eifnet_debugger.eiffel_string_make_from_cil_constructor
		ensure
			Result /= Void
		end		
		
feature {NONE} -- Backup state

	saved_last_managed_callback: INTEGER
	
	save_state_info is
			-- Save current debugger state information
		do
			saved_last_managed_callback := application.imp_dotnet.eifnet_debugger.last_managed_callback			
		end	

	restore_state_info is
			-- Restore saved debugger state information
		do
			application.imp_dotnet.eifnet_debugger.set_last_managed_callback (saved_last_managed_callback)
		end	
		
feature {NONE}

	last_icor_debug_eval: ICOR_DEBUG_EVAL
	last_app_status: APPLICATION_STATUS_DOTNET

	prepare_evaluation (a_frame: ICOR_DEBUG_FRAME) is
		require
		local
			l_chain: ICOR_DEBUG_CHAIN
			l_icd_thread: ICOR_DEBUG_THREAD
			l_icd_eval: ICOR_DEBUG_EVAL
			l_status: APPLICATION_STATUS_DOTNET
		do
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
		require
			last_icor_debug_eval /= Void
			last_app_status /= Void
		local
			l_icd_eval: ICOR_DEBUG_EVAL
			l_status: APPLICATION_STATUS_DOTNET
		do
			l_icd_eval := last_icor_debug_eval
			l_status := last_app_status
			l_status.set_is_evaluating (False)
			restore_state_info			
		end

	complete_evaluation: ICOR_DEBUG_VALUE is
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
			eifnet_debugger.lock_and_wait_for_callback
			eifnet_debugger.reset_data_changed
			if 
				eifnet_debugger.last_managed_callback_is_exception 
			then
				check False end
				Result := Void --"WARNING: Could not evaluate output"
				debug ("DEBUGGER_TRACE_EVAL")
					display_last_exception
					print ("EIFNET_DEBUGGER.debug_output_.. :: WARNING Exception occured %N")
				end
				eifnet_debugger.do_clear_exception
			else
				if l_icd_eval /= Void then
					Result := l_icd_eval.get_result
				end
			end
			l_status.set_is_evaluating (False)
			eifnet_debugger.start_dbg_timer
			restore_state_info			
		end

	display_last_exception is
			-- 
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

end
