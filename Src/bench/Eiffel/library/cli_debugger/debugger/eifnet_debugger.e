indexing
	description: "Interface to access dotnet debugger services"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	EIFNET_DEBUGGER

inherit
	
	WEL_PROCESS_LAUNCHER

	EIFNET_DEBUGGER_INFO_ACCESSOR

	SHARED_DEBUG_VALUE_KEEPER
	
	SHARED_DBG_EVALUATOR
		export
			{NONE} all
		end	

	EIFNET_EXPORTER
		export
			{NONE} all
		end
	
	ICOR_EXPORTER
		export
			{NONE} all
		end

	COMPILER_EXPORTER
		export
			{NONE} all
		end

	EIFNET_DEBUGGER_SYNCHRO
		export
			{NONE} all
			{EIFNET_EXPORTER} dbg_timer_active, stop_dbg_timer, start_dbg_timer, lock_and_wait_for_callback
		end

	SHARED_DEBUG
		export
			{NONE} all
		end

	DEBUG_OUTPUT_SYSTEM_I
		export
			{NONE} all
		end
		
	SHARED_IL_DEBUG_INFO_RECORDER
		export
			{NONE} all
			{ICOR_DEBUG_MANAGED_CALLBACK, EIFNET_EXPORTER} Il_debug_info_recorder
		end	
		
	SHARED_EIFNET_DEBUG_VALUE_FORMATTER
		export
			{NONE} all
			{EIFNET_EXPORTER} edv_formatter
		end
		
	SHARED_TYPE_I
		export
			{NONE} all
		end

create
	make

feature -- Initialization

	make, init is
			-- Creation
		do
			debug ("debugger")
				print ("New EIFNET_DEBUGGER %N")
			end
		end
		
	create_icor_debug is
			-- Create icor_debug as ICorDebug
		local
			icor_debug_managed_callback_obj: ICOR_DEBUG_MANAGED_CALLBACK
			icor_debug_unmanaged_callback_obj: ICOR_DEBUG_UNMANAGED_CALLBACK
			l_icor_debug: ICOR_DEBUG
			last_icor_debug_pointer: POINTER -- Last ICorDebug created
		do
			if icor_debug = Void then
					-- And now for the dotnet world			
				initialize_clr_host
	
				eif_debug_display ("[EIFDBG] initialize debugger session")
				last_icor_debug_pointer := (create {ICOR_DEBUG_FACTORY}).new_cordebug_pointer_for (eiffel_system.system.clr_runtime_version)

				if last_icor_debug_pointer /= Default_pointer then
					create icor_debug.make_by_pointer (last_icor_debug_pointer)
					l_icor_debug := icor_debug
					l_icor_debug.add_ref

					l_icor_debug.initialize
					if l_icor_debug.last_call_succeed then
							--| We keep the callback server objects alive in the C/Cpp glue
							--| then let's add a ref, but we'll leave `dispose' the responsibility 
							--| to Release the object
						icor_debug_managed_callback_obj := (create {ICOR_DEBUG_MANAGED_CALLBACK_FACTORY}).new_cordebug_managed_callback
						icor_debug_managed_callback_obj.add_ref
						icor_debug_managed_callback_obj.initialize_callback
						l_icor_debug.set_managed_handler (icor_debug_managed_callback_obj)
						
						icor_debug_unmanaged_callback_obj := (create {ICOR_DEBUG_UNMANAGED_CALLBACK_FACTORY}).new_cordebug_unmanaged_callback
						icor_debug_unmanaged_callback_obj.add_ref
						icor_debug_unmanaged_callback_obj.initialize_callback
						l_icor_debug.set_unmanaged_handler (icor_debug_unmanaged_callback_obj)

							--| Enable callback to update data in the estudio world.
						enable_estudio_callback
					else
						l_icor_debug.release
						l_icor_debug := Void
					end
				end
			end
		end

	icor_debug: ICOR_DEBUG
			-- ICorDebug object used to control and access Dotnet debugger
		
	initialize_clr_host is
			-- Initialize dotnet runtime, to be sure to use the correct version of the
			-- runtime after while
		local
			l_host: CLR_HOST
		once
			(create {CLI_COM}).initialize_com
			l_host := (create {CLR_HOST_FACTORY}).runtime_host (Eiffel_system.System.clr_runtime_version)			
		end
		
	init_debugging_data is
		do
			debug_value_keeper.initialize
			if eifnet_dbg_evaluator = Void then
				create eifnet_dbg_evaluator.make (Current)				
			end
			Eifnet_debugger_info.set_debugger (Current)
		end
		
	reset_debugging_data is
				-- Reset objects who has session related data
		do
			reset_dbg_evaluator
			eifnet_debugger_info.reset
			exit_process_occurred := False
			
			il_debug_info_recorder.reset_debugging_live_data
			debug_value_keeper.terminate		
				-- not required
			last_dbg_call_success := 0
			last_string_value_length := 0
		end
		
	initialize_debugger_session is
			-- Initialize a debugger session
		require
			not is_debugging
		local
			l_icor_debug: ICOR_DEBUG
		do
				-- Reset objects who has session related data
			init_debugging_data

			create_icor_debug
			l_icor_debug := icor_debug
			if l_icor_debug /= Void then
					--| Initialize the dbg synchronization
				init_dbg_synchronisation
					--| start the timer which will trigger the callbacks
				start_dbg_timer
					--| Create a timer which will check for the end of the process
				create_monitoring_of_process_termination_on_exit
					--| And now we can consider inside a debugging session ...
				is_debugging := True
			else
				is_debugging := False
			end
		ensure 
			is_debugging implies icor_debug /= Void
		end

	is_debugging: BOOLEAN
			-- Is current process in debugging session ?

	exit_process_occurred: BOOLEAN
			-- Does Call back "ExitProcess" occurred ?
			--| This could be during evaluation ...
			
feature -- Termination monitoring ...

	timer_monitor_process_termination_on_exit: EV_TIMEOUT
			-- Timer used to check if debugging is finished.

	create_monitoring_of_process_termination_on_exit is
			-- Create and start the timer to check if the debugging is done
		require
			timer_void: timer_monitor_process_termination_on_exit = Void
		do
			create timer_monitor_process_termination_on_exit.make_with_interval (1000)
			timer_monitor_process_termination_on_exit.actions.extend (agent monitor_process_termination_on_exit)
		end
		
	destroy_monitoring_of_process_termination_on_exit is
			-- Destroy and clean timer
		do
			if timer_monitor_process_termination_on_exit /= Void then
				timer_monitor_process_termination_on_exit.destroy
				timer_monitor_process_termination_on_exit := Void
			end
		end

	monitor_process_termination_on_exit is
			-- Check if the debugging is done and continue the termination
		do
			if 
				timer_monitor_process_termination_on_exit /= Void 
				and then exit_process_occurred 
				and then not is_dbg_synchronizing 
			then
				destroy_monitoring_of_process_termination_on_exit
				--FIXME JFIAT:  try to reuse timer object !
				Application.process_termination

				--| else This means, Process_termination had already been called (from kill)
			end
		end

feature -- Terminate ICorDebug
		
	terminate_debugger is
			-- Terminate ICorDebug and clean what need to be cleaned
			-- Called inside Dispose, so don't pollute this with unsafe code
		do
			if icor_debug /= Void then
				icor_debug.terminate
			end
		end

feature -- Debugging session Termination ...

	terminate_debugger_session is
			-- Terminate debugging session and clean what need to be cleaned
		do
			is_debugging := False
			stop_dbg_timer
			terminate_dbg_synchronisation
			eifnet_dbg_evaluator.reset
			eifnet_debugger_info.reset
			icor_debug.clean_data
		end

	terminate_debugging is
			-- Terminate the debugging session
		require
			is_debugging: is_debugging
		local
			l_controller: ICOR_DEBUG_CONTROLLER
			l_pro_hdl: INTEGER
			l_success: BOOLEAN
		do
			eif_debug_display ("[EIFDBG] terminate debugging")
			l_controller := icor_debug_controller
			if l_controller /= Void then
				eif_debug_display ("[EIFDBG] pProcess->Terminate (..)")
				l_controller.stop (infinite_time) --| to get the hand on and to be synchronized
				l_controller.terminate (0)
				if not l_controller.last_call_succeed then
					--| the end of the killing process will be done on callback ExitProcess
					--| Maybe try with no Stop (..)
					--} but use violent .. ::TerminateProcess ...
					if icor_debug_process /= Void then
						l_pro_hdl := icor_debug_process.get_handle
					else
						l_pro_hdl := icor_debug.last_icor_debug_process_handle
					end
					l_success := cwin_terminate_process (l_pro_hdl, 0)
				end
					-- FIXME jfiat [2004/07/30] : check if this is not too violent ?
					-- maybe we could find a smarter way to terminate debugging synchronisation
				terminate_debugger_session
				notify_exit_process_occurred
			else
				eif_debug_display ("[EIFDBG] could not find ICorDebugController object ...")
				notify_exit_process_occurred
				on_exit_process
			end
		end

	on_exit_process	is
			-- On ExitProcess callback
		do
			eif_debug_display ("[EIFDBG] execution exiting")
			terminate_debugger_session
		ensure
			not is_debugging
		end

	notify_exit_process_occurred is
			-- Notify callback `ExitProcess' occurred
		do
			exit_process_occurred := True
		end
		
feature -- Status

	last_dbg_call_success: INTEGER
	
	last_dbg_call_succeed: BOOLEAN is
		do
			Result := (last_dbg_call_success = 0)
		end

feature -- Callback notification about synchro

	estudio_callback_event is
			-- Callback trigger for processing at end of dotnet callback
		do
			Application.imp_dotnet.estudio_callback_notify
		end
		
feature -- Interaction with .Net Debugger

	do_create_process is
			-- Create Process
		local
			l_icd_process: POINTER
			n: INTEGER
		do
			l_icd_process := icor_debug.create_process (debug_param_executable + " " + debug_param_arguments, debug_param_directory)
			if icor_debug.last_call_succeed then
				n := feature {CLI_COM}.add_ref (l_icd_process)
				set_last_controller_by_pointer (l_icd_process)
				n := feature {CLI_COM}.release (l_icd_process)
			end
		end

	waiting_debugger_callback (a_title: STRING) is
		do
			debug ("debugger_trace_operation")
				print ("%N... Waiting for debugger to callback...%N%N")
			end
			
			eif_debug_display ("[EIFDBG] " + a_title)
		end

	do_run is
			-- Start the process to debug
		do
			do_create_process
			waiting_debugger_callback ("run process")
			last_dbg_call_success := icor_debug.last_call_success
		end

	do_stop is
			-- (Async) Stop the process (on a step complete or breakpoint for instance)
		require
			controller_exists: icor_debug_controller /= Void
		local
			l_controller: ICOR_DEBUG_CONTROLLER
		do
			l_controller := icor_debug_controller
			if exit_process_occurred or else l_controller = Void then
				on_exit_process
			else
				debug ("debugger_eifnet_data")
					print ("Last control mode = " + eifnet_debugger_info.last_control_mode_as_string + "%N")
				end
				l_controller.stop (infinite_time)
				last_dbg_call_success := l_controller.last_call_success
				debug ("debugger_eifnet_data")
					print ("EIFNET_DEBUGGER.do_stop : after stop ICorDebugController.last_call_success = " + l_controller.last_error_code_id + "%N")
				end
				waiting_debugger_callback ("stop")
			end
		end
		
	do_continue is
		local
			l_controller: ICOR_DEBUG_CONTROLLER		
		do	
			if exit_process_occurred or else icor_debug_controller = Void then
				on_exit_process
			else
				l_controller := icor_debug_controller
				l_controller.continue (False)
				last_dbg_call_success := l_controller.last_call_success
				debug ("debugger_trace_eifnet")
					if last_dbg_call_success /= 0 then
						io.error.put_string ("EIFNET_DEBUGGER.do_continue failed %N")
					end
				end
			end
		end
		
	do_clear_exception is
			-- Clear current exception
		local
			l_thread: ICOR_DEBUG_THREAD
		do
			l_thread := Eifnet_debugger_info.icd_thread
			if l_thread /= Void then
				l_thread.clear_current_exception
			end
		end	
	
feature {NONE} -- Stepping Implementation

	last_stepper: ICOR_DEBUG_STEPPER

	new_stepper: ICOR_DEBUG_STEPPER is
			-- Retrieve or Create Stepper
			-- Result value is the error code
		local
			edti: EIFNET_DEBUGGER_THREAD_INFO
		do
			edti := eifnet_debugger_info.managed_thread (application.status.current_thread_id)
			if edti /= Void then
				Result := edti.new_stepper
				Result.add_ref 
			else
				Result := Void
				eif_debug_display ("[DBG/WARNING] No thread available ...")
			end
		end

	do_step (a_mode: INTEGER) is
		require
--			valid_step_mode: (a_mode = cst_control_step_next) 
--								or else (a_mode = cst_control_step_in)
--								or else (a_mode = cst_control_step_out)						
			controller_exists: icor_debug_controller /= Void
		local
			l_stepper: ICOR_DEBUG_STEPPER
		do
			l_stepper := new_stepper
			if l_stepper /= Void then
				--| Manage the step
				inspect	a_mode
				when cst_control_step_next then
					l_stepper.step (False)
				when cst_control_step_into then
					l_stepper.step (True)
				when cst_control_step_out then
					l_stepper.step_out
				else
					l_stepper.step (False)
				end
				check l_stepper.check_last_call_succeed end
				
				do_continue
			else
				debug  ("DEBUGGER_TRACE_EIFNET")
					eif_debug_display ("[DBG/WARNING] No stepper made available ...")			
				end
			end
		end

feature -- Stepping Access
		
	do_step_range (a_bstep_in: BOOLEAN; a_il_ranges: ARRAY [TUPLE [INTEGER, INTEGER]]) is
			-- Step next.
		local
			l_stepper: ICOR_DEBUG_STEPPER
		do
			debug ("debugger_trace_operation")
				print ("[enter] EIFNET_DEBUGGER.do_step_range (" + a_bstep_in.out + ")%N")
			end
			l_stepper := new_stepper
			if l_stepper /= Void then
				debug  ("DEBUGGER_TRACE_EIFNET")
					print ("[>] Stepping using ICorDebugStepper [0x" + l_stepper.out + "]%N")
				end
				l_stepper.step_range (a_bstep_in, a_il_ranges)
				check l_stepper.check_last_call_succeed end				

				do_continue
			else
				eif_debug_display ("[DBG/WARNING] No stepper made available ...")			
			end

			waiting_debugger_callback ("step range")			
		end

	do_step_next is
			-- Step next.
		do
			debug ("debugger_trace_operation")
				print ("[enter] EIFNET_DEBUGGER.do_step_next%N")
			end
			
			do_step (cst_control_step_next)
			waiting_debugger_callback ("step next")
		end

	do_step_into is
			-- Step in.
		do
			debug ("debugger_trace_operation")
				print ("[enter] EIFNET_DEBUGGER.do_step_into%N")
			end
			
			do_step (cst_control_step_into)
			waiting_debugger_callback ("step into")
		end		

	do_step_out is
			-- Step out.
		do
			debug ("debugger_trace_operation")
				print ("[enter] EIFNET_DEBUGGER.do_step_out%N")
			end
			
			do_step (cst_control_step_out)
			waiting_debugger_callback ("step out")
		end		

	stepping_possible: BOOLEAN is
			-- 
		do
			Result := icor_debug_controller /= Void and then icor_debug_thread /= Void
		end

feature -- Debuggee Session Parameters

	debug_param_directory: STRING is
			-- Directory from where the debugger runs the process
		do
			Result := Eifnet_debugger_info.param_directory
		end

	debug_param_executable: STRING is
			-- Filename to the executable to debug
		do
			Result := Eifnet_debugger_info.param_executable
		end
			
	debug_param_arguments: STRING is
			-- Arguments
		do
			Result := Eifnet_debugger_info.param_arguments
		end

feature -- Change Debuggee Session Parameters
	
	set_debug_param_directory (a_dir: STRING) is
		do
			Eifnet_debugger_info.set_param_directory (a_dir)
		end

	set_debug_param_executable (a_exec: STRING) is
		do
			Eifnet_debugger_info.set_param_executable (a_exec)
		end

	set_debug_param_arguments (a_arg: STRING) is
		do
			Eifnet_debugger_info.set_param_arguments (a_arg)
		end		
		
feature -- Tracer

	eif_debug_display (msg: STRING) is
		do
		end

feature {EIFNET_EXPORTER} -- Restricted Bridge to EIFNET_DEBUGGER_INFO

	set_last_managed_callback (a_cb: like last_managed_callback) is
		do
			eifnet_debugger_info.set_last_managed_callback (a_cb)
		end
		
	last_managed_callback: INTEGER is
		do
			Result := Eifnet_debugger_info.last_managed_callback
		end	
		
feature -- Bridge to EIFNET_DEBUGGER_INFO

	last_managed_callback_is_exit_process: BOOLEAN is
		do
			Result := Eifnet_debugger_info.last_managed_callback_is_exit_process
		end	
		
	last_managed_callback_is_exception: BOOLEAN is
		do
			Result := Eifnet_debugger_info.last_managed_callback_is_exception
		end	
		
	last_exception_is_handled: BOOLEAN is
		do
			Result := Eifnet_debugger_info.last_exception_is_handled
		end			
		
	last_managed_callback_is_eval_exception: BOOLEAN is
		do
			Result := Eifnet_debugger_info.last_managed_callback_is_eval_exception
		end	

	new_active_exception_value: ICOR_DEBUG_VALUE is
			-- Active Exception value retrieved each call from .Net debugger
		local
			l_last_thread: ICOR_DEBUG_THREAD
		do
			l_last_thread := icor_debug_thread
			if l_last_thread /= Void then
				Result := l_last_thread.get_current_exception
			end
		end

	new_active_frame: ICOR_DEBUG_FRAME is
			-- Active Thread value retrieved each call from .Net debugger
		local
			l_last_thread: ICOR_DEBUG_THREAD
		do
			l_last_thread := icor_debug_thread
			if l_last_thread /= Void then
				Result := l_last_thread.get_active_frame
			end
		end
		
	current_stack_icor_debug_frame: ICOR_DEBUG_FRAME is
			-- Frame related to current call stack.
			-- This is a shared instance, so don't release it unless you know
			-- what you do.
		local
			l_cse: CALL_STACK_ELEMENT_DOTNET
		do
			l_cse ?= application.status.current_call_stack_element
			Result := l_cse.icd_frame
		end

feature -- Easy access

	icor_debug_class (a_class_type: CLASS_TYPE): ICOR_DEBUG_CLASS is
		require
			arg_class_type_void: a_class_type /= Void
		local
			l_class_module_name: STRING
			l_icd_module: ICOR_DEBUG_MODULE
			l_class_token: INTEGER
		do
			l_class_module_name := Il_debug_info_recorder.module_file_name_for_class (a_class_type)
			l_icd_module := icor_debug_module (l_class_module_name)
			if l_icd_module /= Void then
				l_class_token := Il_debug_info_recorder.class_token (l_class_module_name, a_class_type)
				Result := l_icd_module.get_class_from_token (l_class_token)
			end
		end
		
feature -- Bridge to MD_IMPORT

	class_token (a_mod_name: STRING; a_class_type: CLASS_TYPE): INTEGER is
			-- Find class token using Meta Data.
		local
			l_icd_module: ICOR_DEBUG_MODULE
		do
			l_icd_module := icor_debug_module (a_mod_name)
			if l_icd_module /= Void then
				Result := l_icd_module.md_class_token_by_type_name (a_class_type.full_il_implementation_type_name)
			end
		end

feature -- Function Evaluation

	icd_function_by_feature (icdv: ICOR_DEBUG_VALUE; ct: CLASS_TYPE; a_feat: FEATURE_I): ICOR_DEBUG_FUNCTION is
			-- ICorDebugFunction for `ct'.`a_feat' 
			-- and optionally on object `icdv'
		local
			l_prepared_icdv: ICOR_DEBUG_VALUE
			l_feat_tok: INTEGER
			l_feat_name: STRING
			l_icd_class: ICOR_DEBUG_CLASS			
			l_icd_module: ICOR_DEBUG_MODULE
			l_class_module_name: STRING
			l_icd_obj_val: ICOR_DEBUG_OBJECT_VALUE
			l_dispose_mod: BOOLEAN
		do
			if icdv /= Void and ct.is_external then
				l_prepared_icdv := edv_formatter.prepared_debug_value (icdv)
				if l_prepared_icdv /= Void then
					l_icd_obj_val := l_prepared_icdv.query_interface_icor_debug_object_value
-- FIXME jfiat [2004/08/25] : in one day we ensure we have a prepared icdv
-- we'll get rid of the previous lines
--					l_icd_obj_val := icdv.query_interface_icor_debug_object_value
					if l_icd_obj_val /= Void then
						l_icd_class := l_icd_obj_val.get_class
						l_icd_module := l_icd_class.get_module
						l_feat_name := a_feat.external_name
						l_dispose_mod := True
						l_icd_class.clean_on_dispose
						l_icd_obj_val.clean_on_dispose
					end
					l_prepared_icdv.clean_on_dispose
				end
			else
					--| This should be an true Eiffel type
				l_feat_tok := Il_debug_info_recorder.feature_token_for_feat_and_class_type (a_feat, ct)
				l_class_module_name := Il_debug_info_recorder.module_file_name_for_class (ct)				
				l_icd_module := icor_debug_module (l_class_module_name)
				if l_feat_tok = 0 then
					l_feat_name := a_feat.feature_name
				end
			end
			if l_icd_module /= Void then
					--| Now we have the ICOR_DEBUG_MODULE ...				
				if l_feat_tok = 0 then
					l_feat_tok := l_icd_module.md_member_token_by_names (
								ct.full_il_implementation_type_name,
								l_feat_name
							)
				end
				if l_feat_tok > 0 then
					Result := l_icd_module.get_function_from_token (l_feat_tok)
				end
				if l_dispose_mod then
					l_icd_module.clean_on_dispose
				end
			end
		end

feature {NONE} -- Implementation of ICorDebugFunction retriever 
		
	icd_function_by_name (ct: CLASS_TYPE; a_f_name: STRING): ICOR_DEBUG_FUNCTION is
			-- ICorDebugClass for `a_class_c'.`a_f_name'
		local
			l_feat_i : FEATURE_I
			l_class_c: CLASS_C			
		do
			l_class_c := ct.associated_class
			l_feat_i := l_class_c.feature_named (a_f_name)
			Result := icd_function_by_feature (Void, ct, l_feat_i)
		end
		
feature -- Specific function evaluation
		
	eiffel_string_icd_class: ICOR_DEBUG_CLASS is
			-- ICorDebugClass for STRING
		do
			Result := icor_debug_class (Eiffel_system.String_class.compiled_class.types.first)
		end

	reference_integer_32_icd_class: ICOR_DEBUG_CLASS is
			-- ICorDebugClass for `reference INTEGER'
		do
			Result := icor_debug_class (int32_c_type.associated_reference_class_type)
		end	
		
	reference_integer_32_set_item_method: ICOR_DEBUG_FUNCTION is
			-- ICorDebugFunction for `reference INTEGER'.set_item
		do
			Result := icd_function_by_name (int32_c_type.associated_reference_class_type, "set_item")
		ensure
			Result /= Void
		end	
		
	reference_real_icd_class: ICOR_DEBUG_CLASS is
			-- ICorDebugClass for `reference REAL'
		do
			Result := icor_debug_class (float_c_type.associated_reference_class_type)
		end	

	reference_real_set_item_method: ICOR_DEBUG_FUNCTION is
			-- ICorDebugFunction for `reference REAL'.set_item
		do
			Result := icd_function_by_name (float_c_type.associated_reference_class_type, "set_item")
		ensure
			Result /= Void
		end		
		
	reference_double_icd_class: ICOR_DEBUG_CLASS is
			-- ICorDebugClass for `reference DOUBLE'
		do
			Result := icor_debug_class (double_c_type.associated_reference_class_type)
		end
		
	reference_double_set_item_method: ICOR_DEBUG_FUNCTION is
			-- ICorDebugFunction for `reference DOUBLE'.set_item
		do
			Result := icd_function_by_name (double_c_type.associated_reference_class_type, "set_item")
		ensure
			Result /= Void
		end

	reference_boolean_icd_class: ICOR_DEBUG_CLASS is
			-- ICorDebugClass for `reference BOOLEAN'
		do
			Result := icor_debug_class (boolean_c_type.associated_reference_class_type)
		end
		
	reference_boolean_set_item_method: ICOR_DEBUG_FUNCTION is
			-- ICorDebugFunction for `reference BOOLEAN'.set_item
		do
			Result := icd_function_by_name (boolean_c_type.associated_reference_class_type, "set_item")
		ensure
			Result /= Void
		end
		
	reference_character_icd_class: ICOR_DEBUG_CLASS is
			-- ICorDebugClass for `reference CHARACTER'
		do
			Result := icor_debug_class (char_c_type.associated_reference_class_type)
		end	
		
	reference_character_set_item_method: ICOR_DEBUG_FUNCTION is
			-- ICorDebugFunction for `reference CHARACTER'.set_item
		do
			Result := icd_function_by_name (char_c_type.associated_reference_class_type, "set_item")
		ensure
			Result /= Void
		end			
		
	eiffel_string_make_from_cil_constructor: ICOR_DEBUG_FUNCTION is
			-- ICorDebugFunction for STRING.make_from_cil
		local
			l_class : CLASS_C
		do
			l_class := Eiffel_system.String_class.compiled_class
			Result := icd_function_by_name (l_class.types.first, "make_from_cil")		
		ensure
			Result /= Void
		end

	icd_string_value_from_string_class_object_value (icd_string_instance: ICOR_DEBUG_OBJECT_VALUE): ICOR_DEBUG_STRING_VALUE is
			-- ICorDebugStringValue for `icd_string_instance' (STRING object)
		require
			icd_string_instance /= Void
		local
			l_icd_value: ICOR_DEBUG_VALUE
			
			l_class: ICOR_DEBUG_CLASS
			l_string_class: CLASS_C
			l_feat_internal_string_builder: FEATURE_I
			l_feat_internal_string_builder_token: INTEGER
		do
				--| Get STRING info from compilo
			l_string_class := Eiffel_system.String_class.compiled_class
				
				--| Get token to access `internal_string_builder'
			l_feat_internal_string_builder := l_string_class.feature_named ("internal_string_builder")
			l_feat_internal_string_builder_token := Il_debug_info_recorder.feature_token_for_non_generic (l_feat_internal_string_builder)
				
				--| Get `internal_string_builder' from `STRING' instance Value
			l_class := icd_string_instance.get_class
			l_icd_value := icd_string_instance.get_field_value (l_class, l_feat_internal_string_builder_token)
			l_class.clean_on_dispose
				
				--| l_icd_value represents the `internal_string_builder' value
			if l_icd_value /= Void then
				Result := Edv_external_formatter.icor_debug_string_value_from_string_builder (l_icd_value)
			end
		end	

	last_string_value_length: INTEGER
			-- Last length of the Result from `string_value_from_string_class_object_value'
			
	string_value_from_string_class_object_value (icd_string_instance: ICOR_DEBUG_OBJECT_VALUE; min, max: INTEGER): STRING is
			-- STRING value for `icd_string_instance' with limits `min, max'
		local
			l_icd_string_value: ICOR_DEBUG_STRING_VALUE
			l_size: INTEGER
			last_string_length: INTEGER
		do
			last_string_value_length := 0
			if icd_string_instance = Void then
				Result := "Void"
			else
				l_icd_string_value := icd_string_value_from_string_class_object_value (icd_string_instance)
				if l_icd_string_value /= Void then
					last_string_length := l_icd_string_value.get_length
					last_string_value_length := last_string_length
						--| Be careful, in this context min,max correspond to string starting at position '0'
					if max < 0 then
						l_size := last_string_length
					else
						l_size := (max + 1).min (last_string_length)
					end
					Result := l_icd_string_value.get_string (l_size)
					Result := Result.substring ((min + 1).max (1), l_size)
					l_icd_string_value.clean_on_dispose
				end
			end
		end

 	generating_type_value_from_object_value (a_frame: ICOR_DEBUG_FRAME; a_icd: ICOR_DEBUG_VALUE; 
 				a_icd_obj: ICOR_DEBUG_OBJECT_VALUE;
 				a_class_type: CLASS_TYPE; a_feat: FEATURE_I): STRING is
			-- ANY.generating_)type: STRING evaluation result
		local
			l_icd: ICOR_DEBUG_VALUE
			l_icdov: ICOR_DEBUG_OBJECT_VALUE
			l_icd_class: ICOR_DEBUG_CLASS
			l_icd_module: ICOR_DEBUG_MODULE
			l_module_name: STRING
			l_feature_token: INTEGER
			
			l_class_type: CLASS_TYPE
			l_func: ICOR_DEBUG_FUNCTION

			l_value_info : EIFNET_DEBUG_VALUE_INFO
		do	
-- FIXME jfiat [2004/07/20] : why do we use a_icd as l_icd if failed ?
--			l_icd := a_icd
			l_class_type := a_class_type
			
			l_icd_class := a_icd_obj.get_class
			l_icd_module := l_icd_class.get_module		
			l_feature_token := l_icd_module.md_feature_token (l_icd_class.get_token, a_feat.feature_name) -- resolved {ANY}.generating_type
			l_func := l_icd_module.get_function_from_token (l_feature_token)

			if l_func /= Void then
				l_icd := eifnet_dbg_evaluator.function_evaluation (a_frame, l_func, <<a_icd>>)
				if l_icd /= Void then
					create l_value_info.make (l_icd)
					l_icdov := l_value_info.interface_debug_object_value
					Result := string_value_from_string_class_object_value (l_icdov, 0, -1)
					l_icdov.clean_on_dispose
					l_value_info.icd_prepared_value.clean_on_dispose					
					l_value_info.clean
					l_icd.clean_on_dispose
				else
					Result := Void -- "WARNING: Could not evaluate output"	
				end
				l_func.clean_on_dispose
			else
				debug ("DEBUGGER_TRACE_EVAL")
					l_module_name := l_icd_module.get_name
				
					print ("EIFNET_DEBUGGER.generating_type_.. :: Unable to retrieve ICorDebugFunction %N")
					print ("                                :: class name    = [" + l_class_type.full_il_type_name + "]%N")
					print ("                                :: module_name   = %"" + l_module_name + "%"%N")
					print ("                                :: feature_token = 0x" + l_feature_token.to_hex_string + " %N")
				end
			end

			l_icd_module.clean_on_dispose
			l_icd_class.clean_on_dispose

			debug ("DEBUGGER_TRACE_EVAL")
				if Result = Void then
					print (l_class_type.full_il_type_name + ".generating_type.. :: Error ! %N")
				end
			end
		end	

 	debug_output_value_from_object_value (a_frame: ICOR_DEBUG_FRAME; a_icd: ICOR_DEBUG_VALUE; 
 				a_icd_obj: ICOR_DEBUG_OBJECT_VALUE; a_class_type: CLASS_TYPE;
 				min,max: INTEGER): STRING is
			-- Debug ouput string value
		local
			l_icd_frame: ICOR_DEBUG_FRAME
			l_icd: ICOR_DEBUG_VALUE		
			l_icdov: ICOR_DEBUG_OBJECT_VALUE
			l_icd_class: ICOR_DEBUG_CLASS
			l_icd_module: ICOR_DEBUG_MODULE
			l_feature_token: INTEGER
			l_feat: FEATURE_I
			l_class_type: CLASS_TYPE
			l_func: ICOR_DEBUG_FUNCTION
			l_value_info : EIFNET_DEBUG_VALUE_INFO
		do	
-- FIXME jfiat [2004/07/20] : Why do we set l_icd as a_icd ... this is not what we want, check it
--			l_icd := a_icd

			l_class_type := a_class_type
			l_feat := debug_output_feature_i (l_class_type.associated_class)
			if l_feat /= Void then
				l_icd_class := a_icd_obj.get_class
				l_icd_module := l_icd_class.get_module
			
				l_feature_token := Il_debug_info_recorder.feature_token_for_feat_and_class_type (l_feat, l_class_type)
				if l_feat.is_attribute then
					l_icd := a_icd_obj.get_field_value (l_icd_class, l_feature_token)
				else
					if l_feature_token = 0 then
						l_func := icd_function_by_name (l_class_type, l_feat.feature_name)
					else				
						l_func := l_icd_module.get_function_from_token (l_feature_token)
					end
					if l_func /= Void then
						l_icd_frame := a_frame
						l_icd := eifnet_dbg_evaluator.function_evaluation (l_icd_frame, l_func, <<a_icd>>)
						l_func.clean_on_dispose
					else						
						debug ("DEBUGGER_TRACE_EVAL")
							print ("EIFNET_DEBUGGER.debug_output_.. :: Unable to retrieve ICorDebugFunction %N")
							print ("                                :: class name    = [" + l_class_type.full_il_type_name + "]%N")
							print ("                                :: module_name   = %"" + l_icd_module.get_name + "%"%N")
							print ("                                :: feature_token = 0x" + l_feature_token.to_hex_string + " %N")
						end
					end
				end
				l_icd_module.clean_on_dispose
				l_icd_class.clean_on_dispose
				if l_icd /= Void then
					create l_value_info.make (l_icd)
					l_icdov := l_value_info.interface_debug_object_value
					Result := string_value_from_string_class_object_value (l_icdov, min, max)
					l_value_info.icd_prepared_value.clean_on_dispose
					l_value_info.clean
					l_icd.clean_on_dispose
				else
					Result := Void -- "WARNING: Could not evaluate output"	
				end
			else
				debug ("DEBUGGER_TRACE_EVAL")
					print ("EIFNET_DEBUGGER.debug_output_.. :: Unable to retrieve FEATURE_I [" 
						+ l_class_type.associated_class.name_in_upper
						+"] %N")
				end
			end
			debug ("DEBUGGER_TRACE_EVAL")
				if Result = Void then
					print ("EIFNET_DEBUGGER.debug_output_.. :: Error: non debuggable ! %N")
				end
			end
		end

 	to_string_value_from_exception_object_value (a_frame: ICOR_DEBUG_FRAME; a_icd: ICOR_DEBUG_VALUE; a_icd_obj: ICOR_DEBUG_OBJECT_VALUE): STRING is
			-- System.Exception.ToString value
		local
			l_icd: ICOR_DEBUG_VALUE
			l_icdov: ICOR_DEBUG_OBJECT_VALUE
			l_icd_class: ICOR_DEBUG_CLASS
			l_icd_module: ICOR_DEBUG_MODULE
			l_module_name: STRING
			l_feature_token: INTEGER
			l_func: ICOR_DEBUG_FUNCTION
			l_debug_info : EIFNET_DEBUG_VALUE_INFO
		do	
-- FIXME jfiat [2004/07/20] : why do we use a_icd as l_icd if failed ?
--			l_icd := a_icd
			l_icd_class := a_icd_obj.get_class
			l_icd_module := l_icd_class.get_module
			l_module_name := l_icd_module.get_name

			l_feature_token := Edv_external_formatter.token_Exception_ToString
			l_func := l_icd_module.get_function_from_token (l_feature_token)

			if l_func /= Void then
				l_icd := eifnet_dbg_evaluator.function_evaluation (a_frame, l_func, <<a_icd>>)
				if l_icd /= Void then
						--| We should get a System.String
					create l_debug_info.make (l_icd)
					l_icdov := l_debug_info.interface_debug_object_value
					Result := Edv_external_formatter.system_string_value_to_string (l_icdov)
					l_icdov.clean_on_dispose
					l_debug_info.icd_prepared_value.clean_on_dispose
					l_debug_info.clean
					l_icd.clean_on_dispose
				else
					Result := Void -- "WARNING: Could not evaluate output"	
				end
				l_func.clean_on_dispose
			end

			l_icd_module.clean_on_dispose
			l_icd_class.clean_on_dispose
		end

 	get_message_value_from_exception_object_value (a_frame: ICOR_DEBUG_FRAME; a_icd: ICOR_DEBUG_VALUE; a_icd_obj: ICOR_DEBUG_OBJECT_VALUE): STRING is
			-- System.Exception.ToString value
		local
			l_icd: ICOR_DEBUG_VALUE		
			l_icd_module: ICOR_DEBUG_MODULE
			l_feature_token: INTEGER
			l_func: ICOR_DEBUG_FUNCTION
			l_debug_info : EIFNET_DEBUG_VALUE_INFO
			l_icdov: ICOR_DEBUG_OBJECT_VALUE			
		do	
-- FIXME jfiat [2004/07/20] : why do we use a_icd as l_icd if failed ?
--			l_icd := a_icd
			l_icd_module := eifnet_debugger_info.icor_debug_module_for_mscorlib
			l_feature_token := Edv_external_formatter.token_Exception_get_Message
			l_func := l_icd_module.get_function_from_token (l_feature_token)
			if l_func /= Void then
				l_icd := eifnet_dbg_evaluator.function_evaluation (a_frame, l_func, <<a_icd>>)
				if l_icd /= Void then
						--| We should get a System.String
					create l_debug_info.make (l_icd)
					l_icdov := l_debug_info.interface_debug_object_value
					Result := Edv_external_formatter.system_string_value_to_string (l_icdov)
					l_icdov.clean_on_dispose
					l_debug_info.icd_prepared_value.clean_on_dispose					
					l_debug_info.clean
					l_icd.clean_on_dispose
				else
					Result := Void -- "WARNING: Could not evaluate output"	
				end
				l_func.clean_on_dispose
			end
		end

	once_function_value (a_icd_frame: ICOR_DEBUG_FRAME; a_adapted_class_type: CLASS_TYPE;
								a_feat: E_FEATURE): ICOR_DEBUG_VALUE is
			-- ICorDebugValue object representing the once value.
		local
			l_icd_class: ICOR_DEBUG_CLASS
		do
			l_icd_class := icor_debug_class (a_adapted_class_type)			
			if l_icd_class /= Void then
				Result := once_function_value_on_icd_class (a_icd_frame,
									l_icd_class, a_adapted_class_type, a_feat)
				l_icd_class.clean_on_dispose
			end
		end

	once_function_value_on_icd_class (a_icd_frame: ICOR_DEBUG_FRAME; a_icd_class: ICOR_DEBUG_CLASS; a_adapted_class_type: CLASS_TYPE; a_feat: E_FEATURE): ICOR_DEBUG_VALUE is
			-- ICorDebugValue object representing the once value.
		require
			a_icd_class_not_void: a_icd_class /= Void
			a_feat_not_void: a_feat /= Void
			adapted_class_not_void: a_adapted_class_type /= Void
		local
			l_once_info_tokens: TUPLE [INTEGER, INTEGER]
			l_done_token, l_result_token: INTEGER
			l_icd_debug_value: ICOR_DEBUG_VALUE
			l_prepared_icd_debug_value: ICOR_DEBUG_VALUE
			l_once_already_called: BOOLEAN
			l_icd_frame: ICOR_DEBUG_FRAME
		do
				--| Set related frame
			l_icd_frame := a_icd_frame
			if l_icd_frame = Void and then icor_debug_thread /= Void then
					--| just in case icd_frame is not set
				l_icd_frame := icor_debug_thread.get_active_frame
			end

				--| Get related tokens
			l_once_info_tokens := Il_debug_info_recorder.once_feature_tokens_for_feat_and_class_type (a_feat.associated_feature_i, a_adapted_class_type)
			l_done_token := l_once_info_tokens.integer_item (1)
			l_result_token := l_once_info_tokens.integer_item (2)
			
				--| Check if already called (_done)
			if 
				l_icd_frame /= Void and then 
				l_done_token /= 0 
			then
				l_icd_debug_value := a_icd_class.get_static_field_value (l_done_token, l_icd_frame)
				if l_icd_debug_value /= Void then
					l_prepared_icd_debug_value := Edv_formatter.prepared_debug_value (l_icd_debug_value)
					l_once_already_called := Edv_formatter.prepared_icor_debug_value_as_boolean (l_prepared_icd_debug_value)
					if l_prepared_icd_debug_value /= l_icd_debug_value then
						l_prepared_icd_debug_value.clean_on_dispose						
					end
					l_icd_debug_value.clean_on_dispose
				end
			end

				--| if already called then get the value (_result)
			if l_once_already_called then
				if l_result_token /= 0 then
					Result := a_icd_class.get_static_field_value (l_result_token, l_icd_frame)
				end
			end
		end

--| NOTA jfiat [2004/03/19] : not yet ready, to be continued
--
--feature -- GC related
--
--
--	keep_alive (addr: STRING) is
--		local
--			l_icdv: ICOR_DEBUG_VALUE
--		do
--			l_icdv := dbg_evaluator.icd_value_by_address (addr)
--			keep_icdv_alive (l_icdv)
--		end
--		
--	keep_icdv_alive (icdv: ICOR_DEBUG_VALUE) is
--		require
--			icdv_not_void: icdv /= Void
--		local
--			l_icdm: ICOR_DEBUG_MODULE
--			l_md_import: MD_IMPORT
--			l_gc_class_token: INTEGER
--			l_meth_token: INTEGER
--			l_icdf: ICOR_DEBUG_FUNCTION
--		do
--			l_icdm := eifnet_debugger_info.icor_debug_module_for_mscorlib
--			l_md_import := l_icdm.interface_md_import
--			l_gc_class_token := l_md_import.find_type_def_by_name ("System.GC", 0)
--			l_meth_token := l_md_import.find_method (l_gc_class_token, "KeepAlive")
--			l_icdf := l_icdm.get_function_from_token (l_meth_token)
--			eifnet_dbg_evaluator.method_evaluation (active_frame, l_icdf, <<icdv>>)
--		end

feature -- Bridge to eifnet_dbg_evaluator

	eifnet_dbg_evaluator: EIFNET_DEBUGGER_EVALUATOR
			-- Dotnet function evaluator

feature {NONE} -- External

	Infinite_time: INTEGER is 0xFFFFFFFF
			-- Value for C externals to have an infinite wait

end -- class EIFNET_DEBUGGER
