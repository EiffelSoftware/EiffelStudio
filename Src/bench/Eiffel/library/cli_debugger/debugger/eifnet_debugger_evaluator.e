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

create 
	make

feature 

	make (dbg: EIFNET_DEBUGGER) is
		do
			eifnet_debugger := dbg
		end

	eifnet_debugger: EIFNET_DEBUGGER

feature {EIFNET_EXPORTER, EB_OBJECT_TOOL} -- Evaluation primitives

	function_evaluation (a_frame: ICOR_DEBUG_FRAME; a_icd: ICOR_DEBUG_VALUE; a_func: ICOR_DEBUG_FUNCTION): ICOR_DEBUG_VALUE is
			-- Function evaluation result for `a_func' on `a_icd'
		require
			object_not_void: a_icd /= Void
			func_not_void: a_func /= Void
		do
			prepare_evaluation (a_frame)
			last_icor_debug_eval.call_function (a_func, 1, << a_icd >>)
			Result := complete_evaluation
		end

	new_string_evaluation (a_frame: ICOR_DEBUG_FRAME; a_string: STRING): ICOR_DEBUG_VALUE is
			-- Function evaluation result for `a_func' on `a_icd'
		require
			a_string /= Void
		do
			prepare_evaluation (a_frame)
			last_icor_debug_eval.new_string (a_string)
			Result := complete_evaluation
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
				print ("%T Message => " + (create {EIFNET_EXCEPTION_CODE} ).exception_string_representation (l_exception_info.value_class_token ) + "%N")			
			end
		end

end
