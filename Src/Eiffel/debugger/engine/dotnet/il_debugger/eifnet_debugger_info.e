indexing
	description: "Objects that represents the dotnet debugger information"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	EIFNET_DEBUGGER_INFO

inherit

	IL_PREDEFINED_STRINGS

	EIFNET_DEBUGGER_BREAKPOINT_INFO
		rename
			notify_new_module as notify_new_module_for_breakpoints
--| removed so far, since we do not really need this
--| and for performance reason
--			, notify_new_class as notify_new_class_for_breakpoints
		redefine
			reset, init
		end

	SHARED_DEBUGGER_MANAGER

	SHARED_IL_DEBUG_INFO_RECORDER

	EIFNET_DEBUGGER_CONTROL_CONSTANTS

	COR_DEBUG_STEP_REASON_ENUM

create {EIFNET_DEBUGGER_INFO_ACCESSOR} -- Creation
	make

feature {NONE} -- Initialization

	make is
			-- Create Current data.
		do
			create_jit_info
			init
		end

	init is
			-- Initialize
		do
			Precursor {EIFNET_DEBUGGER_BREAKPOINT_INFO}
		end

feature -- Reset

	reset is
			-- Reset data contained in Current.
		do
				--| Breakpoint |--
			reset_last_icd_breakpoint
				--| Controller |--
			reset_last_icd_controller
				--| ICorDebugProcess |--
			reset_last_icd_process
				--| Exception |--			
			reset_last_icd_exception
				--| Evaluation Exception |--			
			reset_last_evaluation_icd_exception

				--| Last thread id
			last_icd_thread_id := Default_pointer

				--| StepComplete |--
			last_step_complete_reason   := 0
			last_exception_is_handled   := False

				--| Debugger Error
			reset_debugger_error

				--| Various |--
			if previous_stack_info /= Void then
				previous_stack_info.reset
				previous_stack_info := Void
			end
			reset_current_callstack

			last_control_mode := 0

				--| outside of any evaluation |--
			set_is_evaluating (False)

				--| Ancestors |--
			reset_jit_info
			Precursor {EIFNET_DEBUGGER_BREAKPOINT_INFO}
		end

feature -- Current CallStack

	debug_display_current_callstack_info is
			--
		local
			l_mod: ICOR_DEBUG_MODULE
			l_cn: STRING
			l_fn: STRING
		do
			debug ("debugger_trace_callstack")
				if current_stack_info.current_module_name = Void then
					print ("Callback: current stack stack info : EMPTY%N")
				else
					print ("Callback: current stack stack info :%N")
					l_mod := icor_debug_module (current_stack_info.current_module_name)
					l_cn := l_mod.md_type_name (current_stack_info.current_class_token)
					l_fn := l_mod.md_member_name (current_stack_info.current_feature_token)
					print ("   ~ Depth = " + current_stack_info.current_stack_pseudo_depth.out + "%N")
					print ("   Module  = " + current_stack_info.current_module_name + "%N")
					print ("   Class   = " + l_cn + " : " + current_stack_info.current_class_token.to_hex_string + "%N")
					print ("   Feature = " + l_fn + " : " + current_stack_info.current_feature_token.to_hex_string + "%N")
					print ("   Offset  = 0x" + current_stack_info.current_il_offset.to_hex_string + "%N")
				end
			end
		end

	current_stack_info: EIFNET_DEBUGGER_STACK_INFO
			-- Contains current debugger info about current stack

	previous_stack_info: EIFNET_DEBUGGER_STACK_INFO
			-- Contains saved debugger info about previous stack

	reset_current_callstack is
			-- Reset current callstack information
		do
			if current_stack_info /= Void then
				current_stack_info.reset
				current_stack_info := Void
			end
			current_callstack_initialized := False
		end

	init_current_callstack is
			-- Initialize current callback information
		local
			l_thread: ICOR_DEBUG_THREAD
			l_frame: ICOR_DEBUG_FRAME
			l_chain: ICOR_DEBUG_CHAIN
			l_frames: ICOR_DEBUG_FRAME_ENUM
			l_il_frame: ICOR_DEBUG_IL_FRAME
			l_func: ICOR_DEBUG_FUNCTION
			l_code : ICOR_DEBUG_CODE
			l_module : ICOR_DEBUG_MODULE
			l_class : ICOR_DEBUG_CLASS
			l_il_code : ICOR_DEBUG_CODE
			l_curr_stk_info: like current_stack_info
		do
			if not current_callstack_initialized then
				debug ("_jfiat")
					display_loaded_managed_threads
				end

				if current_stack_info = Void then
					create current_stack_info
				end
				l_curr_stk_info := current_stack_info
				l_curr_stk_info.set_synchronized (False)

				debug ("debugger_trace_eifnet")
					io.error.put_string ("[!] Initialize Current Stack in EIFNET_DEBUGGER_INFO.%N")
				end
				if
					last_p_icd_controller /= Default_pointer
					and then last_icd_thread_id /= Default_pointer
				then
					l_thread := icd_thread
					if l_thread /= Void then
						l_frame := l_thread.get_active_frame
					end
					if l_frame = Void then
						debug ("DEBUGGER_TRACE_SYNCHRO")
							io.error.put_string ("[ERROR] Debugger not synchronized%N")
						end
					else
						l_il_frame := l_frame.query_interface_icor_debug_il_frame
						if l_il_frame /= Void then
							l_curr_stk_info.set_synchronized (True)
-- FIXME jfiat 2004-07-07: check if we should not use directly external on pointer here
-- this would reduce the burden on GC
-- NOTA jfiat 2004-07-07: maybe we should redesign this part and try to find a better way to handle stack_info ...
							l_chain := l_il_frame.get_chain
							l_frames := l_chain.enumerate_frames
							l_code := l_il_frame.get_code
							l_func 	:= l_il_frame.get_function
							l_module := l_func.get_module
							l_class := l_func.get_class
							l_il_code := l_func.get_il_code

							l_curr_stk_info.set_current_stack_pseudo_depth (l_frames.count)
							l_curr_stk_info.set_current_module_name        (l_module.get_name)
							l_curr_stk_info.set_current_class_token        (l_class.get_token)
							l_curr_stk_info.set_current_feature_token      (l_func.get_token)
							l_curr_stk_info.set_current_il_code_size       (l_il_code.get_size)
							l_curr_stk_info.set_current_il_offset          (l_il_frame.get_ip)
							l_curr_stk_info.set_current_stack_address      (create {DBG_ADDRESS}.make_from_integer_64 (l_code.get_address))

							debug("debugger_trace_callback")
								io.error.put_string (generator + ".init_current_callstack: "
									+ " chain: " + l_chain.get_reason_to_string
									+ " frame: " + l_il_frame.last_cordebugmapping_result_to_string
									+ "%N  ->"
									+ "#" + l_curr_stk_info.current_stack_pseudo_depth.out + " : "
									+ "<" + l_curr_stk_info.current_stack_address.output + "> "
									+ "{" + l_module.md_type_name (l_curr_stk_info.current_class_token) + "}."
									+ l_module.md_member_name (l_curr_stk_info.current_feature_token)
									+ " -> 0x"+ l_curr_stk_info.current_il_offset.to_hex_string
									+ "%N")
							end

							l_frames.clean_on_dispose
							l_il_code.clean_on_dispose
							l_code.clean_on_dispose
							l_chain.clean_on_dispose
							l_il_frame.clean_on_dispose
						end
						l_frame.clean_on_dispose
					end
				end
				current_callstack_initialized := True
				debug ("debugger_trace_callstack")
					debug_display_current_callstack_info
				end
			end
		ensure
			current_callstack_initialized
		end

	current_callstack_initialized: BOOLEAN
			-- Is current callstack initialized ?

feature {EIFNET_EXPORTER} -- Current Breakpoint access

	current_breakpoint_location: BREAKPOINT_LOCATION is
			-- Current eStudio Breakpoint object corresponding to the
			-- current breakpoint in dotnet world.
		local
			l_eifnet_breakpoint: EIFNET_BREAKPOINT
		do
			l_eifnet_breakpoint := eifnet_breakpoint (
										current_stack_info.current_module_name,
										current_stack_info.current_class_token,
										current_stack_info.current_feature_token,
										current_stack_info.current_il_offset
									)
			if l_eifnet_breakpoint /= Void then
				Result := l_eifnet_breakpoint.breakpoint_location
			end
		end

feature -- Evaluation

	set_is_evaluating (b: BOOLEAN) is
		do
			is_evaluating := b
		end

	is_evaluating: BOOLEAN

feature -- Progression

	save_current_stack_as_previous is
			-- Save current callstack as previous callstack.
		do
			previous_stack_info := current_stack_info.twin
		ensure
			current_stack_saved: previous_stack_info.is_equal (current_stack_info)
		end

	is_current_state_same_as_previous: BOOLEAN is
			-- Is current callstack same as previous ?
			-- Used to notice when a debugger operation had no "il offset moving" effect.
			-- this use the il offset related to stoppable point.
		require
			current_stack_info_set: current_stack_info /= Void
		do
			if previous_stack_info /= Void then
				debug ("DEBUGGER_TRACE_STEPPING")
					io.error.put_string ("PREVIOUS=" +previous_stack_info.to_string + "%N")
				end
				Result := current_stack_info.is_equal (previous_stack_info)
			end
		end

feature {EIFNET_EXPORTER} -- Access

	icd_controller: ICOR_DEBUG_CONTROLLER is
			-- Last ICOR_DEBUG_CONTROLLER object
		do
			update_icd_controller
			Result := last_icd_controller
		end

	icd_process: ICOR_DEBUG_PROCESS is
			-- Last ICOR_DEBUG_PROCESS object
		do
			update_icd_process
			Result := last_icd_process
		end

	icd_breakpoint: ICOR_DEBUG_BREAKPOINT is
			-- Last ICOR_DEBUG_BREAKPOINT object
		do
			update_icd_breakpoint
			Result := last_icd_breakpoint
		end

	last_step_complete_reason: INTEGER
			-- Last `reason' from a `step_complete' callback

	icd_exception: ICOR_DEBUG_VALUE is
			-- Last ICOR_DEBUG_VALUE's exception object
		do
			update_icd_exception
			Result := last_icd_exception
		end

	last_exception_is_handled: BOOLEAN
			-- Is last exception handled ?
			-- the value is pertinent only in the Exception callback context.
			--
			-- If last_exception_handled is True, this is a "first chance" exception that
			-- hasn't had a chance to be processed by the application.  If
			-- last_exception_handled is False, this is an unhandled exception which will
			-- terminate the process.			

	evaluation_icd_exception: ICOR_DEBUG_VALUE is
			-- Last ICOR_DEBUG_VALUE's exception object
		do
			update_evaluation_icd_exception
			Result := last_evaluation_icd_exception
		end

feature -- Debugger error

	debugger_error_occurred: BOOLEAN

	debugger_error_code: INTEGER

	debugger_error_hr: INTEGER

	notify_debugger_error (a_error_hr: INTEGER; a_error_code: INTEGER) is
		do
			debugger_error_occurred := True
			debugger_error_hr := a_error_hr
			debugger_error_code := a_error_code
		end

	reset_debugger_error is
		do
			debugger_error_occurred := False
			debugger_error_hr := 0
			debugger_error_code := 0
		end

feature {EIFNET_DEBUGGER_INFO_ACCESSOR} -- Change

	set_last_icd_controller (p: POINTER) is
			-- Set `last_icd_controller' to `p'
		local
			n: INTEGER
		do
			if not p.is_equal (last_p_icd_controller) then
				reset_last_icd_controller
				last_p_icd_controller := p
				last_icd_controller_updated := False
				if last_p_icd_controller /= Default_pointer then
					n := {CLI_COM}.add_ref (last_p_icd_controller)
				end
				debug ("DEBUGGER_EIFNET_DATA")
					io.error.put_string ("/// EIFNET_DEBUGGER_INFO:: Controller changed%N")
				end
			end
		end

	reset_last_icd_controller is
		local
			n: INTEGER
		do
			if last_icd_controller /= Void then
				last_icd_controller.clean_on_dispose
				last_icd_controller := Void
			end
			if last_p_icd_controller /= Default_pointer then
				n := {CLI_COM}.release (last_p_icd_controller)
				last_p_icd_controller := Default_pointer
			end
			last_icd_controller_updated := True
		end

	set_last_icd_process (p: POINTER) is
			-- Set `last_icd_process' to `p'
		local
			n: INTEGER
		do
			if not p.is_equal (last_p_icd_process) then
				reset_last_icd_process
				last_p_icd_process := p
				last_icd_process_updated := False
				if last_p_icd_process /= Default_pointer then
					n := {CLI_COM}.add_ref (last_p_icd_process)
				end
				debug ("DEBUGGER_EIFNET_DATA")
					io.error.put_string ("/// EIFNET_DEBUGGER_INFO:: Process changed%N")
				end
			end
		end

	reset_last_icd_process is
		local
			n: INTEGER
		do
			if last_icd_process /= Void then
				last_icd_process.clean_on_dispose
				last_icd_process := Void
			end
			if last_p_icd_process /= Default_pointer then
				n := {CLI_COM}.release (last_p_icd_process)
				last_p_icd_process := Default_pointer
			end
			last_icd_process_updated := True
		end

	set_last_icd_breakpoint (p: POINTER) is
			-- Set `last_icd_breakpoint' to `p'
		local
			n: INTEGER
		do
			if not p.is_equal (last_p_icd_breakpoint) then
				reset_last_icd_breakpoint
				last_p_icd_breakpoint := p
				last_icd_breakpoint_updated := False
				if last_p_icd_breakpoint /= Default_pointer then
					n := {CLI_COM}.add_ref (last_p_icd_breakpoint)
				end
				debug ("DEBUGGER_EIFNET_DATA")
					io.error.put_string ("/// EIFNET_DEBUGGER_INFO:: Breakpoint changed%N")
				end
			end
		end

	reset_last_icd_breakpoint is
		local
			n: INTEGER
		do
			if last_icd_breakpoint /= Void then
				last_icd_breakpoint.clean_on_dispose
				last_icd_breakpoint := Void
			end
			if last_p_icd_breakpoint /= Default_pointer then
				n := {CLI_COM}.release (last_p_icd_breakpoint)
				last_p_icd_breakpoint := Default_pointer
			end
			last_icd_breakpoint_updated := True
		end

	set_last_step_complete_reason (val: INTEGER) is
			-- Set `last_step_complete_reason' to `val'
		do
			last_step_complete_reason := val
				--| STEP_NORMAL means that stepping completed normally, in the same
				--|		function.
				--|
				--| STEP_RETURN means that stepping continued normally, after the function
				--|		returned.
				--|
				--| STEP_CALL means that stepping continued normally, at the start of
				--|		a newly called function.
				--|
				--| STEP_EXCEPTION_FILTER means that control passed to an exception filter
				--|		after an exception was thrown.
				--|
				--| STEP_EXCEPTION_HANDLER means that control passed to an exception handler
				--|		after an exception was thrown.
				--|
				--| STEP_INTERCEPT means that control passed to an interceptor.
				--|
				--| STEP_EXIT means that the thread exited before the step completed.
				--|		No more stepping can be performed with the stepper.			
		end

	set_last_icd_exception (p: POINTER) is
			-- Set `last_icd_exception' to `p'
		local
			n: INTEGER
		do
			if not p.is_equal (last_p_icd_exception) then
				reset_last_icd_exception
				last_p_icd_exception := p
				last_icd_exception_updated := False
				if last_p_icd_exception /= Default_pointer then
					n := {CLI_COM}.add_ref (last_p_icd_exception)
				end
				debug ("DEBUGGER_EIFNET_DATA")
					io.error.put_string ("/// EIFNET_DEBUGGER_INFO:: Exception changed%N")
				end
			end
		end

	reset_last_icd_exception is
		local
			n: INTEGER
		do
			if last_icd_exception /= Void then
				last_icd_exception.clean_on_dispose
				last_icd_exception := Void
			end
			if last_p_icd_exception /= Default_pointer then
				n := {CLI_COM}.release (last_p_icd_exception)
				last_p_icd_exception := Default_pointer
			end
			last_icd_exception_updated := True
		end

	set_last_exception_handled (val: BOOLEAN) is
			-- Set `last_exception_is_handled' to `val'
		do
			last_exception_is_handled := val
		end

	set_last_evaluation_icd_exception (p: POINTER) is
			-- Set `last_evaluation_icd_exception' to `p'
		local
			n: INTEGER
		do
			if not p.is_equal (last_p_evaluation_icd_exception) then
				reset_last_evaluation_icd_exception
				last_p_evaluation_icd_exception := p
				last_evaluation_icd_exception_updated := False
				if last_p_evaluation_icd_exception /= Default_pointer then
					n := {CLI_COM}.add_ref (last_p_evaluation_icd_exception)
				end
				debug ("DEBUGGER_EIFNET_DATA")
					io.error.put_string ("/// EIFNET_DEBUGGER_INFO:: EvaluationException changed%N")
				end
			end
		end

	reset_last_evaluation_icd_exception is
		local
			n: INTEGER
		do
			if last_evaluation_icd_exception /= Void then
				last_evaluation_icd_exception.clean_on_dispose
				last_evaluation_icd_exception := Void
			end
			if last_p_evaluation_icd_exception /= Default_pointer then
				n := {CLI_COM}.release (last_p_evaluation_icd_exception)
				last_p_evaluation_icd_exception := Default_pointer
			end
			last_evaluation_icd_exception_updated := True
		end

feature {EIFNET_DEBUGGER_INFO_ACCESSOR} -- Pointers to COM Objects

	last_p_icd_controller: POINTER --|ICOR_DEBUG_CONTROLLER
			-- Last ICOR_DEBUG_CONTROLLER object

	last_p_icd_process: POINTER --|ICOR_DEBUG_PROCESS
			-- Last ICOR_DEBUG_PROCESS object

	last_p_icd_breakpoint: POINTER --|ICOR_DEBUG_BREAKPOINT
			-- Last Breakpoint object

	last_p_icd_exception: POINTER --|ICOR_DEBUG_VALUE
			-- Last Exception object

	last_p_evaluation_icd_exception: POINTER --|ICOR_DEBUG_VALUE
			-- Last Evaluation Exception object

feature {NONE} -- Pointers to COM Objects

	last_icd_controller_updated: BOOLEAN
	last_icd_controller: ICOR_DEBUG_CONTROLLER
			-- Last ICOR_DEBUG_CONTROLLER object

	last_icd_process_updated: BOOLEAN
	last_icd_process: ICOR_DEBUG_PROCESS
			-- Last ICOR_DEBUG_PROCESS object

	last_icd_breakpoint_updated: BOOLEAN
	last_icd_breakpoint: ICOR_DEBUG_BREAKPOINT
			-- Last Breakpoint object

	last_icd_exception_updated: BOOLEAN
	last_icd_exception: ICOR_DEBUG_VALUE
			-- Last Exception object

	last_evaluation_icd_exception_updated: BOOLEAN
	last_evaluation_icd_exception: ICOR_DEBUG_VALUE
			-- Last Evaluation Exception object			

feature {NONE} -- COM Object

	update_icd_controller is
			-- Last ICOR_DEBUG_CONTROLLER object
		local
			n: INTEGER
		do
			if not last_icd_controller_updated then
				if
					last_p_icd_controller = Default_pointer
				then
					if last_icd_controller /= Void then
						last_icd_controller.clean_on_dispose
						last_icd_controller := Void
					end
				else
					create last_icd_controller.make_by_pointer (last_p_icd_controller)
					n := {CLI_COM}.add_ref (last_p_icd_controller)
				end
				last_icd_controller_updated := True
			end
		end

	update_icd_process is
			-- Last ICOR_DEBUG_PROCESS object
		local
			n: INTEGER
		do
			if not last_icd_process_updated then
				if
					last_p_icd_process = Default_pointer
				then
					if last_icd_process /= Void	then
						last_icd_process.clean_on_dispose
						last_icd_process := Void
					end
				else
					create last_icd_process.make_by_pointer (last_p_icd_process)
					n := {CLI_COM}.add_ref (last_p_icd_process)
				end
				last_icd_process_updated := True
			end
		end

	update_icd_breakpoint is
			-- Last Breakpoint object
		local
			n: INTEGER
		do
			if not last_icd_breakpoint_updated then
				if
					last_p_icd_breakpoint = Default_pointer
				then
					if last_icd_breakpoint /= Void then
						last_icd_breakpoint.clean_on_dispose
						last_icd_breakpoint := Void
					end
				else
					create last_icd_breakpoint.make_by_pointer (last_p_icd_breakpoint)
					n := {CLI_COM}.add_ref (last_p_icd_breakpoint)
				end
				last_icd_breakpoint_updated := True
			end
		end

	update_icd_exception is
			-- Last Exception object
		local
			n: INTEGER
		do
			if not last_icd_exception_updated then
				if
					last_p_icd_exception = Default_pointer
				then
					if last_icd_exception /= Void then
						last_icd_exception.clean_on_dispose
						last_icd_exception := Void
					end
				else
					create last_icd_exception.make_value_by_pointer (last_p_icd_exception)
					n := {CLI_COM}.add_ref (last_p_icd_exception)
				end
				last_icd_exception_updated := True
			end
		end

	update_evaluation_icd_exception is
			-- Last Evaluation Exception object
		local
			n: INTEGER
		do
			if not last_evaluation_icd_exception_updated then
				if
					last_p_evaluation_icd_exception = Default_pointer
				then
					if last_evaluation_icd_exception /= Void then
						last_evaluation_icd_exception.clean_on_dispose
						last_evaluation_icd_exception := Void
					end
				else
					create last_evaluation_icd_exception.make_value_by_pointer (last_p_evaluation_icd_exception)
					n := {CLI_COM}.add_ref (last_p_evaluation_icd_exception)
				end
				last_evaluation_icd_exception_updated := True
			end
		end

feature -- JIT notification

	notify_new_module (a_mod_key: STRING) is
			-- Notify new module loading.
		do
			notify_new_module_for_breakpoints (a_mod_key)
		end

	refresh_breakpoints_on_module (a_module: ICOR_DEBUG_MODULE; a_mod_key: STRING) is
		do
			refresh_module_for_breakpoints (a_module, a_mod_key)
		end

feature -- JIT info

	create_jit_info is
			-- Create JustInTime information.
		do
				--| Modules
			create Loaded_modules.make (10)
			loaded_modules.compare_objects

				--| Threads			
			create loaded_managed_threads.make (10)
		end

	reset_jit_info is
			-- Reset JustInTime information.
		do
				--| Threads
			if not loaded_managed_threads.is_empty then
				from
					loaded_managed_threads.start
				until
					loaded_managed_threads.after
				loop
					loaded_managed_threads.item_for_iteration.clean
					loaded_managed_threads.forth
				end
				loaded_managed_threads.wipe_out
			end

				--| Modules
			if not loaded_modules.is_empty then
					--| No need to clean or release the ICorDebugModule
					--| since they are cached and managed globally
				Loaded_modules.wipe_out
			end
				--| Mscorlib_module is already cleaned
				--| since it is also contained by `loaded_modules'
			mscorlid_module := Void
			ise_runtime_module := Void
		end

feature -- JIT Thread

	display_loaded_managed_threads is
			-- Debug purpose only
		local
			l_id: like last_icd_thread_id
		do
			debug ("eifnet_debugger")
				from
					print ("%N CallStack : Threads %N")
					loaded_managed_threads.start
				until
					loaded_managed_threads.after
				loop
					l_id := loaded_managed_threads.key_for_iteration
					if l_id = last_icd_thread_id then
						print (">- Thread :")
					else
						print (" - Thread :")
					end

					print (" " + l_id.out + "%N")
					loaded_managed_threads.forth
				end
			end
		end

	loaded_managed_threads: HASH_TABLE [EIFNET_DEBUGGER_THREAD_INFO, POINTER]
			-- Managed thread, indexed by Thread ID

	loaded_managed_threads_ids: ARRAY [POINTER] is
			-- All managed threads'ids.
		do
			Result := loaded_managed_threads.current_keys
		ensure
			Result /= Void
		end

	is_valid_managed_thread_id (thid: POINTER): BOOLEAN is
			-- Is `thid' a valid Thread id for a managed thread ?
		do
			Result := loaded_managed_threads.has (thid)
		end

	managed_thread (id: POINTER): EIFNET_DEBUGGER_THREAD_INFO is
			-- Managed Thread info related to `id'.
		do
			Result := loaded_managed_threads.item (id)
		end

	default_managed_thread: EIFNET_DEBUGGER_THREAD_INFO is
			-- Default Managed Thread info
		do
			if not loaded_managed_threads.is_empty then
				loaded_managed_threads.start
				Result := loaded_managed_threads.item_for_iteration
			end
		ensure
			Result_not_void_unless_empty_list: Result = Void implies loaded_managed_threads.is_empty
		end

	add_managed_thread_by_pointer (p: POINTER) is
			-- Add `p' as ICorDebugThread
		require
			p /= Default_pointer
		local
			edti: EIFNET_DEBUGGER_THREAD_INFO
			tid: like last_icd_thread_id
		do
			create edti.make (p)
			tid := edti.thread_id_as_pointer
			loaded_managed_threads.put (edti, tid)
			debugger_manager.application_status.add_thread_id (tid)

			if last_icd_thread_id = Default_pointer then
				set_last_icd_thread_id (tid)
			end

			debug ("eifnet_debugger")
				io.error.put_string (generator + ".add_managed_thread ("
						+ p.out + ") -> ID=" + tid.out + "%N")
			end
		end

	remove_managed_thread_by_pointer (p: POINTER) is
			-- Remove `p' as ICorDebugThread
		local
			n: INTEGER
			tid_int: INTEGER
			tid: like last_icd_thread_id
		do
			n := {ICOR_DEBUG_THREAD}.cpp_get_id (p, $tid_int)
			tid := integer_to_pointer (tid_int)
			if loaded_managed_threads.has (tid) then
				loaded_managed_threads.remove (tid)
				debugger_manager.application_status.remove_thread_id (tid)

					-- FIXME jfiat: maybe find a better way for that .. a kind of history of selected thread ?
				if last_icd_thread_id = tid and then not loaded_managed_threads.is_empty then
					loaded_managed_threads.start
					set_last_icd_thread_id (loaded_managed_threads.item_for_iteration.thread_id_as_pointer)
				end
			end
			debug ("eifnet_debugger")
				io.error.put_string (generator + ".remove_managed_thread_by_pointer ("
						+ p.out + ") -> ID=" + tid.out + "%N")
			end
		end

	refresh_last_thread_details is
			-- Refresh last thread's details
		local
			t: EIFNET_DEBUGGER_THREAD_INFO
		do
			t := managed_thread (last_icd_thread_id)
			if t /= Void then
				t.refresh_thread_details
			end
		end

	set_last_icd_thread (p: POINTER) is
			-- Set `last_icd_thread' to `p'
		local
			r: INTEGER
			tid_int: INTEGER
		do
			r := {ICOR_DEBUG_THREAD}.cpp_get_id (p, $tid_int)
			if tid_int > 0 then
				set_last_icd_thread_id (integer_to_pointer (tid_int))
			end
		end

	set_last_icd_thread_id (id: like last_icd_thread_id) is
			-- Set `last_icd_thread_id' to `id'
		require
			id_not_null: id /= Default_pointer
		do
			last_icd_thread_id := id
		end

	icd_thread: ICOR_DEBUG_THREAD is
			-- Last ICOR_DEBUG_THREAD object
		local
			edti: EIFNET_DEBUGGER_THREAD_INFO
		do
			edti := managed_thread (last_icd_thread_id)
			if edti = Void then
					--| If current selected thread is not existing any more ...
				edti := default_managed_thread
			end
			if edti /= Void then
				Result := edti.icd_thread
				check
					Result /= Void
				end
			end
		end

	icd_thread_by_id (id: like last_icd_thread_id): ICOR_DEBUG_THREAD is
			-- ICOR_DEBUG_THREAD for thread id `id'.
		local
			edti: EIFNET_DEBUGGER_THREAD_INFO
		do
			edti := managed_thread (id)
			if edti = Void then
					--| If current selected thread is not existing any more ...
				edti := default_managed_thread
			end
			if edti /= Void then
				Result := edti.icd_thread
				check
					Result /= Void
				end
			end
		end

	last_icd_thread_id: POINTER

feature -- JIT Module

	register_new_module (a_module: ICOR_DEBUG_MODULE) is
			-- Register new module after being notified laoding
		require
			a_module /= Void
		local
			l_module_key_name: STRING
			l_module_key_name_tail: STRING
			l_module_stored: ICOR_DEBUG_MODULE
		do
			debug ("debugger_trace_callback_data")
				io.error.put_string ("Registering new module : %N  [" + a_module.get_name + "]%N")
			end

			l_module_key_name := resolved_module_key (a_module.get_name)
			loaded_modules.put (a_module, l_module_key_name)

			if not loaded_modules.inserted then
				l_module_stored := loaded_modules.item (l_module_key_name)
				if l_module_stored /= Void then
					if l_module_stored.is_equal_as_icor_object (a_module) then
						debug ("debugger_trace_eifnet")
							io.error.put_string ("WARNING: Reloading same ICorDebugModule %N")
							io.error.put_string (" address -> " + a_module.item.out + "%N")
							io.error.put_string ("    name -> " + l_module_key_name + "%N")
						end
					else
						debug ("debugger_trace_eifnet")
							io.error.put_string ("WARNING: Overwriting same ICorDebugModule %N")
							io.error.put_string (" address -> " + a_module.item.out + "%N")
							io.error.put_string ("    name -> " + l_module_key_name + "%N")
						end

-- FIXME jfiat [2004/07/20] : if a new module is registered, we should keep a list of all modules
--		for now, let's keep first one only
--		we need to fix this issue for app_domain problem.
--						loaded_modules.force (a_module, l_module_key_name)
--						check inserted: loaded_modules.inserted end
						refresh_breakpoints_on_module (a_module, l_module_key_name)
					end
				else
					debug ("debugger_trace_eifnet")
						io.error.put_string ("[ERROR] while inserting new ICorDebugModule %N")
					end
				end
			end

			debug ("debugger_trace_eifnet")
				l_module_key_name_tail := l_module_key_name.twin
				l_module_key_name_tail.keep_tail (30)
				io.error.put_string ("Load module [.. " + l_module_key_name_tail + "]%N")
			end

			if not il_debug_info_recorder.has_info_about_module (l_module_key_name) then
				a_module.enable_jit_debugging (False, False)
				a_module.enable_class_load_callbacks (False)
			end

			notify_new_module (l_module_key_name)

			if mscorlid_module = Void and then l_module_key_name.has_substring ("mscorlib") then -- loaded_modules.is_empty then
					-- We have to deal with the MSCORLIB.DLL module
					--| FIXME JFIAT : 2003/12/23 : check if MSCORLIB is really always the first loaded module
				mscorlid_module := a_module
			elseif ise_runtime_module = Void and then l_module_key_name.has_substring (runtime_namespace.as_lower) then
				register_runtime_module (a_module)
			end
		end

feature {EIFNET_DEBUGGER_INFO_ACCESSOR} -- JIT info implementation

	resolved_module_key (a_module_name: STRING): STRING is
			-- module name formatted to be a key
		do
--| NOTA JFIAT: in case module comes from the GAC, we need to identify it
--| but for performance issue .. this is not very good
--| and used only for Breakpoint in class contained inside the module from GAC
			Result := il_debug_info_recorder.resolved_module_key (a_module_name)
			debug ("debugger_trace_eifnet")
				io.error.put_string ("Module name key (internal table building):%N (1) " + a_module_name + "%N (2) " + Result + "%N")
			end
		end

	loaded_modules: HASH_TABLE [ICOR_DEBUG_MODULE, STRING]
			-- Loaded modules by the execution

	mscorlid_module: ICOR_DEBUG_MODULE
			-- MSCORLIB ICorDebugModule

	ise_runtime_module: ICOR_DEBUG_MODULE
			-- EiffelSoftware.runtime ICorDebugModule

	register_runtime_module (a_module: ICOR_DEBUG_MODULE) is
		do
			ise_runtime_module := a_module
			if on_runtime_module_registration_action /= Void then
				on_runtime_module_registration_action.call ([a_module])
			end
		end

	on_runtime_module_registration_action: PROCEDURE [ANY, TUPLE [ICOR_DEBUG_MODULE]]

	set_on_runtime_module_registration_action (p: like 	on_runtime_module_registration_action) is
		do
			on_runtime_module_registration_action := p
		end

feature -- JIT Info access

	icor_debug_module (a_mod_name: STRING): ICOR_DEBUG_MODULE is
			-- ICorDebugModule interface related to `a_mod_name'.
		require
			mod_name_valid: a_mod_name /= Void and then not a_mod_name.is_empty
		do
			Result := loaded_modules.item (resolved_module_key (a_mod_name))
		end

	icor_debug_module_for_mscorlib: ICOR_DEBUG_MODULE is
			-- ICorDebugModule for MSCORLIB
		do
			Result := mscorlid_module
		end

	icor_debug_module_for_ise_runtime: ICOR_DEBUG_MODULE is
			-- ICorDebugModule for ISE_RUNTIME
		do
			Result := ise_runtime_module
		end

feature -- Stepping

	last_control_mode: INTEGER
			-- Last control mode
			-- stepping into,next,out, continue...

	last_control_mode_as_string: STRING is
			-- String representation for `last_control_mode'
		do
			Result := control_mode_to_string (last_control_mode)
		end

	valid_control_mode (a_mode: INTEGER): BOOLEAN is
			-- Is the control mode `a_mode' valid ?
		do
			Result :=  a_mode = cst_control_continue
					or a_mode = cst_control_stop
					or a_mode = cst_control_kill
					or a_mode = cst_control_step_out
					or a_mode = cst_control_step_next
					or a_mode = cst_control_step_into
					or a_mode = cst_control_nothing
		end

	set_last_control_mode (a_mode: INTEGER) is
			-- Set `last_control_mode' to `a_mode'
		require
			control_value_valid: valid_control_mode (a_mode)
		do
			last_control_mode := a_mode
		end

	last_control_mode_is_stop: BOOLEAN is
			-- Last control was `stop'
		do
			Result := last_control_mode = cst_control_stop
		end

	last_control_mode_is_step_out: BOOLEAN is
			-- Last control was `step_out'
		do
			Result := last_control_mode = Cst_control_step_out
		end

	last_control_mode_is_step_into: BOOLEAN is
			-- Last control was `step_into'
		do
			Result := last_control_mode = Cst_control_step_into
		end

	last_control_mode_is_step_next: BOOLEAN is
			-- Last control was `step_next'
		do
			Result := last_control_mode = Cst_control_step_next
		end

	last_control_mode_is_stepping: BOOLEAN is
			-- Last control was `stepping'
		do
			Result := last_control_mode_is_step_into
			or else last_control_mode_is_step_out
			or else last_control_mode_is_step_next
		end

feature {NONE} -- Implementation

	integer_to_pointer (i: INTEGER): POINTER
			-- Integer value `'i converted to POINTER value
		do
			Result := Result + i
		end

invariant
	loaded_managed_threads_not_void: loaded_managed_threads /= Void

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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

end -- class EIFNET_DEBUGGER_INFO

