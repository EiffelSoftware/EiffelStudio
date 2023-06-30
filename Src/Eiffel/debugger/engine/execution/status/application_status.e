note

	description:
		"Status information about the running application - current routine,%
		%current object, ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class APPLICATION_STATUS

inherit

	APPLICATION_STATUS_CONSTANTS

	SHARED_EIFFEL_PROJECT
		export
			{NONE} all
		end

	DEBUGGER_COMPILER_UTILITIES
		export
			{NONE} all
		end

feature {NONE} -- Initialization

	make (app: like application)
			-- Create Current
		do
			debug ("debugger_trace")
				print (generator + ".make %N")
			end
			application := app
			initialize
		end

feature -- Properties

	application: APPLICATION_EXECUTION
			-- Attached Application execution object.

	start_time: detachable DATE_TIME
			-- Time of the debugging session start.

	last_stopped_time: detachable DATE_TIME
			-- Time of the last stopped state.

	stopped_duration: detachable DATE_TIME_DURATION
			-- Duration of stopped state.

	execution_duration (dt: DATE_TIME): detachable DATE_TIME_DURATION
			--
		do
			if attached start_time as s then
				Result := dt.relative_duration (s)
				if attached stopped_duration as dur then
					Result := Result - dur
					Result := Result.to_canonical (s)
				end
			end
		end

feature {NONE} -- Initialization

	initialize
			-- Initialize Current
		do
			create_kept_objects
			clear_callstack_data
			record_start_time
		end

feature -- Time measurement

	record_start_time
		do
			create start_time.make_now
		end

	pause_execution
		do
			check last_stopped_time = Void end
			create last_stopped_time.make_now
		end

	quit_execution
		local
			d2: DATE_TIME
			dur: DATE_TIME_DURATION
		do
			create d2.make_now
			if attached start_time as st then
				if
					attached last_stopped_time as d1
				then
						-- It was stopped
					dur := stopped_duration
					if dur = Void then
						dur := d2.relative_duration (d1)
					else
						dur := dur + d2.relative_duration (d1)
					end
					stopped_duration := dur
				else
					-- no stopped duration.
				end
			end
		end

	resume_execution
		local
			d2: DATE_TIME
			dur: DATE_TIME_DURATION
		do
			if
				attached start_time as st and then
				attached last_stopped_time as d1
			then
				dur := stopped_duration
				create d2.make_now
				if dur = Void then
					dur := d2.relative_duration (d1)
				else
					dur := dur + d2.relative_duration (d1)
				end
				stopped_duration := dur

				last_stopped_time := Void
			end
		end

feature -- Objects kept from session to session

	create_kept_objects
		do
			create objects_keeper.make (20)
			objects_keeper.compare_objects
		end

	objects_keeper: HASH_TABLE [INTEGER, DBG_ADDRESS]

	kept_objects: LIST [DBG_ADDRESS]
			-- Objects represented by their address that should be kept during the execution.
		local
			objkr: like objects_keeper
		do
			objkr := objects_keeper
			if not objkr.is_empty then
				debug
					print (generator + ".kept_objects : " + objkr.count.out + " items%N")
				end
				create {ARRAYED_LIST [DBG_ADDRESS]} Result.make (objkr.count)
				Result.compare_objects
				from
					objkr.start
				until
					objkr.after
				loop
					debug ("debugger_trace_cache")
						print ("KeptObjects -> " + objkr.key_for_iteration.output
							+ " : " + objkr.item_for_iteration.out + "%N")
					end
					Result.extend (objkr.key_for_iteration)
					objkr.forth
				end
			end
		ensure
			Result_compare_objects: Result /= Void implies Result.object_comparison
		end

	clear_kept_objects
		do
			objects_keeper.wipe_out
		end

	keep_object (add: DBG_ADDRESS)
			-- Add object identified by `add' to `kept_objects'
		require
			address_not_void: add /= Void and then not add.is_void
		local
			nb: INTEGER
		do
			nb := objects_keeper.item (add)
			objects_keeper.force (nb + 1, add)

			debug ("debugger_trace_cache")
				print ("keep_object ("+ add.output +") " + nb.out + " -> " + objects_keeper.item (add).out + "%N")
			end
		end

	release_object (add: DBG_ADDRESS)
		require
			address_not_empty: add /= Void and then not add.is_void
--			kept_objects.has (add)
		local
			nb: INTEGER
		do
			nb := objects_keeper.item (add)
			if nb > 1 then
				objects_keeper.force (nb - 1, add)
			else
				objects_keeper.remove (add)
			end
			debug ("debugger_trace_cache")
				print ("release_object ("+ add.output +") " + nb.out + "-> " + objects_keeper.item (add).out + "%N")
			end
		end

feature -- Call Stack List management

	clear_callstack_data
			-- Reset `call_stack_list' or create it
		do
			if call_stack_list = Void then
				create call_stack_list.make (5)
			else
				call_stack_list.wipe_out
			end
			current_thread_id := Default_pointer
			active_thread_id := Default_pointer
			current_call_stack := Void
			dynamic_class := Void
			origin_class := Void
			e_feature := Void
			reason := 0
			body_index := 0
			break_index := 0
			exception_occurred := False
			exception := Void
			catcall_data := Void
		end

feature -- Callstack

	force_reload_current_call_stack
			-- reload the call stack from application (after having edited an
			-- object for example to make sure the modification was successful).
		do
			get_callstack (current_thread_id, stack_max_depth, True)
		end

	reload_current_call_stack
			-- reload the call stack from application (after having edited an
			-- object for example to make sure the modification was successful).
		do
			get_callstack (current_thread_id, stack_max_depth, False)
		end

feature {NONE} -- CallStack Impl

	get_callstack (a_tid: like current_thread_id; a_stack_max_depth: INTEGER; always_reload: BOOLEAN)
			-- Get Eiffel Callstack with a maximum depth of `a_stack_max_depth'
			-- for thread `a_tid'.
		local
			ecs: like current_call_stack
		do
			ecs := call_stack (a_tid)
			if ecs /= Void then
				check ecs.thread_id = current_thread_id end
				if always_reload or not ecs.is_loaded  then
					ecs.reload (a_stack_max_depth)
				end
			else
				ecs := new_callstack_with (a_tid, a_stack_max_depth)
				set_call_stack (a_tid, ecs)
			end
		end

	new_callstack_with (a_tid: like current_thread_id; a_stack_max_depth: INTEGER): like current_call_stack
		deferred
		end

feature -- Values

	is_stopped: BOOLEAN
			-- Is the debugged application stopped ?

	e_feature: E_FEATURE
			-- Feature in which we are currently stopped

	body_index: INTEGER
			-- Body index of the feature in which we are currently stopped

	dynamic_type: CLASS_TYPE
			-- Class type of object in which we are currently stopped

	dynamic_class: CLASS_C
			-- Class of object in which we are currently stopped

	origin_class: CLASS_C
			-- Origin of feature in which we are currently stopped

	break_index: INTEGER
			-- Breakpoint at which we are currently stopped
			-- (first, second...)

	break_nested_index: INTEGER
			-- Breakpoint nested index at which we are currently stopped

	reason: INTEGER
			-- Reason for the application being stopped

	object_address: DBG_ADDRESS
			-- Address of object in which we are stopped
			-- (hector address with an indirection)

	catcall_data: TUPLE [pos, expected_id, expected_annotations, actual_id, actual_annotations: INTEGER]
			-- Information related to last catcall warning

	exception_occurred: BOOLEAN
			-- Exception occurred ?

	exception: EXCEPTION_DEBUG_VALUE
			-- Associated Exception value.

	set_exception_occurred (b: BOOLEAN)
			-- Set `exception_occurred' to `b'
		do
			exception_occurred := b
		end

	exception_short_description: STRING_32
		do
			if attached exception as e then
				Result := e.short_description
			end
		ensure
			Result_not_void: Result /= Void
		end

	exception_type_name: STRING
			-- Exception class name (if any).
		require
			exception_occurred: exception_occurred
		do
			if attached exception as e then
				Result := e.type_name
			end
		end

	exception_meaning: STRING_32
			-- Exception tag (if any).
		do
			if attached exception as e then
				Result := e.meaning
			end
		end

	exception_message: STRING_32
			-- Exception message (if any).
		require
			exception_occurred: exception_occurred
		do
			if attached exception as e then
				Result := e.message
			end
		end

	exception_text: STRING_32
			-- Exception text (if any).
		require
			exception_occurred: exception_occurred
		do
			if attached exception as e then
				Result := e.text
			end
		end

feature -- Assertion violation

	break_on_assertion_violation_pending: BOOLEAN
			-- Break action from assertion violation dialog

	set_break_on_assertion_violation_pending (b: BOOLEAN)
		require
			contract_violation_occurred: b implies assertion_violation_occurred
			not_break_on_assertion_violation_pending: b implies not break_on_assertion_violation_pending
		do
			break_on_assertion_violation_pending := b
		end

	assertion_violation_occurred: BOOLEAN
			-- Contract violation occurred?
		do
			if
				exception_occurred and then
				attached exception as e
			then
				if
					attached e.dynamic_class as e_cl and then
					attached application.debugger_manager.compiler_data as l_comp_data and then
					attached l_comp_data.assertion_violation_class_c as assert_cl
				then
					Result := e_cl.conform_to (assert_cl)
				elseif attached exception_type_name as n then
					Result := n.same_string (({CHECK_VIOLATION}).out) or else
						n.same_string (({PRECONDITION_VIOLATION}).out) or else
						n.same_string (({POSTCONDITION_VIOLATION}).out) or else
						n.same_string (({INVARIANT_VIOLATION}).out) or else
						n.same_string (({VARIANT_VIOLATION}).out) or else
						n.same_string (({LOOP_INVARIANT_VIOLATION}).out)
				end
			end
		end

feature -- Query

	reason_is_overflow: BOOLEAN
			-- Stop reason is Overflow
		do
			Result := reason = Pg_overflow
		end

	reason_is_catcall: BOOLEAN
			-- Stop reason is CatCall	
		do
			Result := reason = Pg_catcall
		end

feature -- Call Stack related

	current_call_stack: EIFFEL_CALL_STACK
			-- Current Call Stack regarding Thread Id.

	current_call_stack_depth: INTEGER
			-- Stack depth of `current_call_stack'
		do
			if current_call_stack /= Void then
				Result := current_call_stack.stack_depth
			end
		end

	has_call_stack_by_thread_id (tid: like current_thread_id): BOOLEAN
		do
			Result := call_stack_list.has (tid)
		end

	get_current_call_stack
			-- set `current_call_stack' value
		require
			current_thread_id_valid: has_call_stack_by_thread_id (current_thread_id)
		do
			current_call_stack := call_stack (current_thread_id)
		ensure
			current_call_stack /= Void
		end

	stack_max_depth: INTEGER
			-- Maximum number of stack elements that we retrieve from the application.

feature -- Call Stack element related

	current_call_stack_element: CALL_STACK_ELEMENT
			-- Current call stack element being displayed.
		local
			i: INTEGER
		do
			i := application.current_execution_stack_number
			if attached current_call_stack as ccs and then ccs.valid_index (i) then
				Result := ccs.i_th (i)
			end
		end

	current_eiffel_call_stack_element: detachable EIFFEL_CALL_STACK_ELEMENT
			-- Current call stack element being displayed
		do
			if attached {EIFFEL_CALL_STACK_ELEMENT} current_call_stack.i_th (Application.current_execution_stack_number) as e then
				Result := e
			end
		end

feature -- Process related access

	process_id: INTEGER

feature -- Process related change

	set_process_id (pid: INTEGER)
			-- Set process id
		require
			id_valid: pid > 0
		do
			debug ("DEBUGGER_TRACE")
				print (generator + ".set_process_id (" + pid.out + " ~ 0x" + pid.to_hex_string + ") %N")
			end
			process_id := pid
		end

feature -- Access: Thread related

	active_thread_id: like current_thread_id
			-- Thread ID when the execution was paused.

	current_thread_id: POINTER
			-- Thread ID of the Current call stack.

	all_thread_ids: LIST [like current_thread_id]
			-- All available threads' ids

	all_thread_ids_count: INTEGER

	thread_name (id: like current_thread_id): STRING_32
		do
		end

	thread_priority (id: like current_thread_id): INTEGER
		do
		end

feature -- Access: SCOOP related

	all_scoop_processor_thread_ids: detachable ARRAY [like current_thread_id]
		do
			if attached scoop_processor_ids as scp then
				Result := scp.current_keys
			end
		end

	scoop_processor_ids: HASH_TABLE [like scoop_processor_id, like current_thread_id]
			-- SCOOP Processor id indexed by thread id

	scoop_processor_id (tid: like current_thread_id): NATURAL_16
			-- Scoop processor id associated with thread id `tid'.
		do
			if attached scoop_processor_ids as scp then
				Result := scp.item (tid)
			end
		end

feature -- Thread related change

	set_call_stack (tid: like current_thread_id; ecs: like current_call_stack)
			-- Associate `ecs' with thread id `tid'
		require
			id_valid: tid /= Default_pointer
			callstack_not_void: ecs /= Void
		do
			call_stack_list.force (ecs, tid)
				--| Update in case the current call stack's object changed
			get_current_call_stack
		end

	has_thread_id (tid: like current_thread_id): BOOLEAN
		do
			Result := all_thread_ids /= Void and then all_thread_ids.has (tid)
		end

	refresh_current_thread_id
			-- Get fresh value of Thread ID from debugger
		deferred
		end

	set_active_thread_id (tid: like current_thread_id)
			-- Set active thread id
		require
			id_valid: has_thread_id (tid)
		do
			debug ("DEBUGGER_TRACE")
				print (generator + ".set_active_thread_id (" + tid.out + " ~ " + tid.to_integer_32.out + ") %N")
			end
			active_thread_id := tid
		end

	set_current_thread_id (tid: like current_thread_id)
			-- Set current thread id, and refresh `current_call_stack'
		require
			id_valid: has_thread_id (tid)
		do
			debug ("DEBUGGER_TRACE")
				print (generator + ".set_current_thread_id (" + tid.out + " ~ " + tid.to_integer_32.out + ") %N")
			end
			current_thread_id := tid
			if has_call_stack_by_thread_id (current_thread_id) then
				get_current_call_stack
			end
		end

	switch_to_current_thread_id
			-- Switch debugger context thread id to `current_thread_id'.
		do
			--| Mainly use for Classical debugger purpose
		end

	add_thread_id (tid: like current_thread_id)
		require
			thread_not_registered: all_thread_ids = Void or else not all_thread_ids.has (tid)
		do
			if all_thread_ids = Void then
				create {ARRAYED_LIST [like current_thread_id]} all_thread_ids.make (5)
			end
			all_thread_ids.force (tid)
			refresh_threads_information
		ensure
			thread_registered: all_thread_ids.has (tid)
		end

	remove_thread_id (tid: like current_thread_id)
		require
			thread_registered: all_thread_ids.has (tid)
		do
			unregister_scoop_thread_id (tid)
			all_thread_ids.prune_all (tid)
			refresh_threads_information
		ensure
			thread_unregistered: not all_thread_ids.has (tid)
			scoop_processor_unregistered: scoop_processor_id (tid) = 0
		end

	refresh_threads_information
		do
			all_thread_ids_count := all_thread_ids.count
--| FIXME: This is doing nothing, check what we wanted to do with that...			
--			from
--				all_thread_ids.start
--			until
--				all_thread_ids.after
--			loop
--				all_thread_ids.forth
--			end
		end

	register_scoop_thread_id (tid: like current_thread_id; a_scp_proc_id: like scoop_processor_id)
			-- Register thread `tid' as a SCOOP Processor identified by `a_scp_proc_id'
		require
			thread_registered: all_thread_ids.has (tid)
		local
			scp: like scoop_processor_ids
		do
			scp := scoop_processor_ids
			if scp = Void then
				create scp.make (10)
				scoop_processor_ids := scp
			end
			scp.force (a_scp_proc_id, tid)
		ensure
			scoop_processor_registered: scoop_processor_id (tid) /= 0
		end

	unregister_scoop_thread_id (tid: like current_thread_id)
			-- Unregister thread `tid' as a SCOOP Processor
		require
			thread_registered: all_thread_ids.has (tid)
		do
			if attached scoop_processor_ids as scp then
				scp.remove (tid)
			end
		ensure
			scoop_processor_registered: scoop_processor_id (tid) = 0
		end

feature {NONE} -- Call stack implementation

	call_stack (tid: like current_thread_id): like current_call_stack
			-- Call stack associated with thread id `tid'.
		do
			Result := call_stack_list.item (tid)
		ensure
			Result /= Void implies call_stack_list.has (tid)
		end

	call_stack_list: HASH_TABLE [like current_call_stack, like current_thread_id]
			-- Call Stack list, associating Call Stack and their Thread Id.

feature -- Access

	valid_reason: BOOLEAN
			-- Is the reason valid for stopping of execution?
		do
			Result := reason = Pg_break or else
				reason = Pg_interrupt or else
				reason = Pg_raise or else
				reason = Pg_viol or else
				reason = Pg_update_breakpoint or else
				reason = Pg_step
		ensure
			true_implies_correct_reason:
				Result implies (reason = Pg_break) or else
						(reason = Pg_interrupt) or else
						(reason = Pg_raise) or else
						(reason = Pg_viol) or else
						(reason = Pg_update_breakpoint) or else
						(reason = Pg_step)
		end

	debugged_position_information (fe: E_FEATURE): TUPLE [bp, bp_nested: INTEGER; fid: INTEGER]
			-- Information about debugged position
		do
			if current_call_stack /= Void then
				if
					attached current_replayed_call as rep  and then
					attached rep.e_feature as r_fe and then
					r_fe.body_id_for_ast = fe.body_index
				then
					Result := [rep.replayed_break_index, 0, r_fe.feature_id]
				elseif
					attached {EIFFEL_CALL_STACK_ELEMENT} current_call_stack_element as stel and then
					attached stel.routine as ot_fe and then
					ot_fe.body_id_for_ast = fe.body_index
				then
					Result := [stel.break_index, stel.break_nested_index, ot_fe.feature_id]
				end
			end
		end

	is_at (f: E_FEATURE; index: INTEGER): BOOLEAN
			-- Is the program stopped at the given index in the given feature ?
			-- Returns False when the couple ('f','index') cannot be found on the stack.
			--         or is on the stack but not currently active.
			-- Returns True when the couple ('f','index') is active (i.e is the current
			--	       active feature on stack)
		require
			f_attached: f /= Void
		local
			n: INTEGER
			f_body_index: INTEGER
		do
			if is_stopped then
				f_body_index := f.body_index
				if attached current_replayed_call as crep then
					if crep.replayed_break_index = index then
						Result := attached crep.feature_i as fi and then fi.body_index = f_body_index
					end
				end
				if not Result then
					if attached replayed_call as rep then
						if rep.line = index then
							Result := attached rep.feat as rep_f and then rep_f.body_index = f_body_index
						end
					else
						if attached current_call_stack as l_ccs and then not l_ccs.is_empty then
							n := Application.current_execution_stack_number
							Result := attached {EIFFEL_CALL_STACK_ELEMENT} l_ccs.i_th (n) as stack_elem
									and then stack_elem.break_index = index
									and then attached stack_elem.routine as ef
									and then ef.body_index = f_body_index
						end
					end
				end
			end
		end

	is_top (f: E_FEATURE; index: INTEGER): BOOLEAN
			-- Return True if the couple ('f','index') is the top position on the stack,
			-- Return False if the couple ('f','index') is somewhere else in the stack,
			-- 		or if the couple ('f','index') is not in the stack.
		require
			f_attached: f /= Void
		local
			n: INTEGER
			f_body_index: INTEGER
		do
			if is_stopped then
				f_body_index := f.body_index
				if attached current_replayed_call as rep then
					if rep.replayed_break_index = index then
						Result := attached rep.feature_i as fi and then fi.body_index = f_body_index
					end
				else
					if attached current_call_stack as l_ccs and then not l_ccs.is_empty then
						n := 1
						Result := attached {EIFFEL_CALL_STACK_ELEMENT} l_ccs.i_th (n) as stack_elem
								and then stack_elem.break_index = index
								and then attached stack_elem.routine as ef
								and then ef.body_index = f_body_index
					end
				end
			end
		end

	has_valid_call_stack: BOOLEAN
			-- Has a valid callstack ?
		do
			if is_stopped then
				if current_call_stack /= Void and then current_call_stack.count > 0 then
					Result := True
				end
			end
		end

	has_valid_current_eiffel_call_stack_element: BOOLEAN
			-- Is current call stack element a valid Eiffel Call Stack Element ?
		do
			Result := current_eiffel_call_stack_element /= Void
		end

	has_breakpoint_enabled: BOOLEAN
			-- Has breakpoint enabled at current location ?
		do
			if e_feature /= Void then
				Result := application.debugger_manager.breakpoints_manager.is_breakpoint_enabled (e_feature, break_index)
			end
		end

feature -- Execution replay

	replay_recording: BOOLEAN
			-- Execution is being recorded for Exec replay functionality

	replay_activated: BOOLEAN
			-- Execution is being replayed (reviewed)

	replay_level_limit: INTEGER
			-- Maximum depth which can be replayed

	replayed_depth: INTEGER
			-- Current replayed depth
		do
			if attached current_replayed_call as rc then
				Result := rc.depth
			else
				--| 0 which mean ... not replayed
			end
		end

	replayed_call: TUPLE [feat: E_FEATURE; line: INTEGER]
			-- Current display replayed call info

	current_replayed_call: REPLAYED_CALL_STACK_ELEMENT
			-- Top replayed call

	set_replay_recording (b: BOOLEAN)
			-- Enable or disable execution replay recording
		require
			stop_recording_only_if_not_replaying: b implies not replay_activated
		do
			replay_recording := b
		end

	set_replay_activated (b: BOOLEAN)
			-- Enable or Disable Execution replaying
		require
			activate_replay_only_if_recording: b implies replay_recording
		do
			replay_activated := b
			if not b then
				replayed_call := Void
				current_replayed_call := Void
			end
		end

	set_replay_level_limit (d: INTEGER)
			-- Set maximum replay level
		require
			d_positive_or_zero: d >= 0
		do
			replay_level_limit := d
		end

	set_replayed_call (d: like replayed_call)
			-- set current replayed call
		do
			replayed_call := d
		end

	set_current_replayed_call (d: like current_replayed_call)
			-- Set `current_replayed_call'
		do
			current_replayed_call := d
		end

	set_catcall_data (v: like catcall_data)
			-- Set `catcall_data' to `v'
		do
			catcall_data := v
		end

feature -- Update

	update_on_pre_stopped_state
			-- Update data which need update before application is really stopped
		do
		end

	update_on_stopped_state
			-- Update data which need update after application is really stopped
		do
		end

feature -- Setting

	set_is_stopped (b: BOOLEAN)
			-- set is_stopped to `b'
		do
			if b and then not is_stopped then
					--| When we switch from running to stopped state
					--| we reset the call stack list
				clear_callstack_data
			end
			is_stopped := b
			set_break_on_assertion_violation_pending (False)
		end

	set_exception (e: EXCEPTION_DEBUG_VALUE)
			-- Set exception
		require
			exception_occurred: e /= Void implies exception_occurred
		do
			exception := e
		end

	set_max_depth (n: INTEGER)
			-- Set the maximum number of stack elements that should be retrieved to `n'.
			-- -1 retrieves all elements.
		require
			valid_n: n = -1 or n > 0
		do
			stack_max_depth := n
		end

note
	copyright:	"Copyright (c) 1984-2023, Eiffel Software"
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
