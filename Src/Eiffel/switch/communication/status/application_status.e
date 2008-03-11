indexing

	description:
		"Status information about the running application - current routine,%
		%current object, ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision $"

deferred class APPLICATION_STATUS

inherit

	APPLICATION_STATUS_CONSTANTS

	SHARED_EIFFEL_PROJECT
		export
			{NONE} all
		end

	COMPILER_EXPORTER

feature {NONE} -- Initialization

	make (app: like application) is
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

feature {NONE} -- Initialization

	initialize is
			-- Initialize Current
		do
			create_kept_objects
			clear_callstack_data
		end

feature -- Objects kept from session to session

	create_kept_objects is
		do
			create objects_keeper.make (20)
			objects_keeper.compare_objects
		end

	objects_keeper: HASH_TABLE [INTEGER, STRING]

	kept_objects: LIST [STRING] is
			-- Objects represented by their address that should be kept during the execution.
		do
			if not objects_keeper.is_empty then
				debug
					print (generator + ".kept_objets : " + objects_keeper.count.out + " items%N")
				end
				create {ARRAYED_LIST [STRING]} Result.make (objects_keeper.count)
				Result.compare_objects
				from
					objects_keeper.start
				until
					objects_keeper.after
				loop
					debug ("debugger_trace_cache")
						print ("KeptObjects -> " + objects_keeper.key_for_iteration
							+ " : " + objects_keeper.item_for_iteration.out + "%N")
					end
					Result.extend (objects_keeper.key_for_iteration)
					objects_keeper.forth
				end
			end
		ensure
			Result_compare_objects: Result /= Void implies Result.object_comparison
		end

	clear_kept_objects is
		do
			objects_keeper.wipe_out
		end

	keep_object (add: STRING) is
			-- Add object identified by `add' to `kept_objects'
		require
			address_not_empty: add /= Void and then not add.is_empty
		local
			nb: INTEGER
		do
			nb := objects_keeper.item (add)
			objects_keeper.force (nb + 1, add)

			debug ("debugger_trace_cache")
				print ("keep_object ("+ add +") " + nb.out + " -> " + objects_keeper.item (add).out + "%N")
			end
		end

	release_object (add: STRING) is
		require
			address_not_empty: add /= Void and then not add.is_empty
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
				print ("release_object ("+ add +") " + nb.out + "-> " + objects_keeper.item (add).out + "%N")
			end
		end

feature -- Call Stack List management

	clear_callstack_data is
			-- Reset `call_stack_list' or create it
		do
			if call_stack_list = Void then
				create call_stack_list.make (5)
			else
				call_stack_list.wipe_out
			end
			current_thread_id := 0
			active_thread_id := 0
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

	force_reload_current_call_stack is
			-- reload the call stack from application (after having edited an
			-- object for example to make sure the modification was successful).
		do
			get_callstack (current_thread_id, stack_max_depth, True)
		end

	reload_current_call_stack is
			-- reload the call stack from application (after having edited an
			-- object for example to make sure the modification was successful).
		do
			get_callstack (current_thread_id, stack_max_depth, False)
		end

feature {NONE} -- CallStack Impl

	get_callstack (a_tid: INTEGER; a_stack_max_depth: INTEGER; always_reload: BOOLEAN) is
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

	new_callstack_with (a_tid: INTEGER; a_stack_max_depth: INTEGER): like current_call_stack is
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

	reason: INTEGER
			-- Reason for the application being stopped

	object_address: STRING
			-- Address of object in which we are stopped
			-- (hector address with an indirection)

	catcall_data: TUPLE [pos: INTEGER; expected: INTEGER; actual: INTEGER] assign set_catcall_data
			-- Information related to last catcall warning

	exception_occurred: BOOLEAN
			-- Exception occurred ?

	exception: EXCEPTION_DEBUG_VALUE
			-- Associated Exception value.

	set_exception_occurred (b: BOOLEAN) is
			-- Set `exception_occurred' to `b'
		do
			exception_occurred := b
		end

	exception_short_description: STRING_32 is
		do
			Result := exception.short_description
		ensure
			Result_not_void: Result /= Void
		end

	exception_type_name: STRING is
			-- Exception class name (if any).
		require
			exception_occurred: exception_occurred
		do
			if exception /= Void then
				Result := exception.type_name
			end
		end

	exception_meaning: STRING_32 is
			-- Exception tag (if any).
		do
			if exception /= Void then
				Result := exception.meaning
			end
		end

	exception_message: STRING_32 is
			-- Exception message (if any).
		require
			exception_occurred: exception_occurred
		do
			if exception /= Void then
				Result := exception.message
			end
		end

	exception_text: STRING_32 is
			-- Exception text (if any).
		require
			exception_occurred: exception_occurred
		do
			if exception /= Void then
				Result := exception.text
			end
		end

feature -- Query

	reason_is_overflow: BOOLEAN is
			-- Stop reason is Overflow
		do
			Result := reason = Pg_overflow
		end

	reason_is_catcall: BOOLEAN is
			-- Stop reason is CatCall	
		do
			Result := reason = Pg_catcall
		end

feature -- Call Stack related

	current_call_stack: EIFFEL_CALL_STACK
			-- Current Call Stack regarding Thread Id.

	has_call_stack_by_thread_id (tid: INTEGER): BOOLEAN is
		do
			Result := call_stack_list.has (tid)
		end

	get_current_call_stack is
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

	current_call_stack_element: CALL_STACK_ELEMENT is
			-- Current call stack element being displayed.
		require
			current_call_stack /= Void
		local
			i: INTEGER
		do
			i := application.current_execution_stack_number
			if current_call_stack.valid_index (i) then
				Result := current_call_stack.i_th (i)
			end
		end

feature -- Process related access

	process_id: INTEGER

feature -- Process related change

	set_process_id (pid: INTEGER) is
			-- Set process id
		require
			id_valid: pid > 0
		do
			debug ("DEBUGGER_TRACE")
				print (generator + ".set_process_id (" + pid.out + " ~ 0x" + pid.to_hex_string + ") %N")
			end
			process_id := pid
		end

feature -- Thread related access

	active_thread_id: INTEGER
			-- Thread ID when the execution was paused.

	current_thread_id: INTEGER
			-- Thread ID of the Current call stack.

	all_thread_ids: ARRAYED_LIST [INTEGER]
			-- All available threads' ids

	all_thread_ids_count: INTEGER

	thread_name (id: like current_thread_id): STRING is
		do
		end

	thread_priority (id: like current_thread_id): INTEGER is
		do
		end

feature -- Thread related change

	set_call_stack (tid: INTEGER; ecs: like current_call_stack) is
			-- Associate `ecs' with thread id `tid'
		require
			id_valid: tid >= 0
			callstack_not_void: ecs /= Void
		do
			call_stack_list.force (ecs, tid)
				--| Update in case the current call stack's object changed
			get_current_call_stack
		end

	has_thread_id (tid: INTEGER): BOOLEAN is
		do
			Result := all_thread_ids /= Void and then all_thread_ids.has (tid)
		end
	refresh_current_thread_id is
			-- Get fresh value of Thread ID from debugger
		deferred
		end

	set_active_thread_id (tid: INTEGER) is
			-- Set active thread id
		require
			id_valid: has_thread_id (tid)
		do
			debug ("DEBUGGER_TRACE")
				print (generator + ".set_active_thread_id (" + tid.out + " ~ 0x" + tid.to_hex_string + ") %N")
			end
			active_thread_id := tid
		end

	set_current_thread_id (tid: INTEGER) is
			-- Set current thread id, and refresh `current_call_stack'
		require
			id_valid: has_thread_id (tid)
		do
			debug ("DEBUGGER_TRACE")
				print (generator + ".set_current_thread_id (" + tid.out + " ~ 0x" + tid.to_hex_string + ") %N")
			end
			current_thread_id := tid
			if has_call_stack_by_thread_id (current_thread_id) then
				get_current_call_stack
			end
		end

	switch_to_current_thread_id	is
			-- Switch debugger context thread id to `current_thread_id'.
		do
			--| Mainly use for Classical debugger purpose
		end

	add_thread_id (tid: INTEGER) is
		require
			all_thread_ids = Void or else not all_thread_ids.has (tid)
		do
			if all_thread_ids = Void then
				create all_thread_ids.make (5)
			end
			all_thread_ids.force (tid)
			refresh_threads_information
		ensure
			all_thread_ids.has (tid)
		end

	remove_thread_id (tid: INTEGER) is
		require
			all_thread_ids.has (tid)
		do
			all_thread_ids.prune_all (tid)
			refresh_threads_information
		ensure
			not all_thread_ids.has (tid)
		end

	refresh_threads_information is
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

feature {NONE} -- Call stack implementation

	current_eiffel_call_stack_element: EIFFEL_CALL_STACK_ELEMENT is
			-- Current call stack element being displayed
		do
			Result ?= current_call_stack.i_th (Application.current_execution_stack_number)
		end

	call_stack (tid: INTEGER): like current_call_stack is
			-- Call stack associated with thread id `tid'.
		do
			Result := call_stack_list.item (tid)
		ensure
			Result /= Void implies call_stack_list.has (tid)
		end

	call_stack_list: HASH_TABLE [like current_call_stack, INTEGER]
			-- Call Stack list, associating Call Stack and their Thread Id.

feature -- Access

	valid_reason: BOOLEAN is
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

	is_at (f_body_index: INTEGER; index: INTEGER): BOOLEAN is
			-- Is the program stopped at the given index in the given feature ?
			-- Returns False when the couple ('f','index') cannot be found on the stack.
			--         or is on the stack but not currently active.
			-- Returns True when the couple ('f','index') is active (i.e is the current
			--	       active feature on stack)
		local
			stack_elem: EIFFEL_CALL_STACK_ELEMENT
			current_execution_stack_number: INTEGER
			l_ccs: EIFFEL_CALL_STACK
		do
			if is_stopped then
				l_ccs := current_call_stack
				if l_ccs /= Void and then not l_ccs.is_empty then
					current_execution_stack_number := Application.current_execution_stack_number
					stack_elem ?= l_ccs.i_th (Application.current_execution_stack_number)
					Result := stack_elem /= Void
							and then stack_elem.routine /= Void
							and then f_body_index = stack_elem.body_index
							and then index = stack_elem.break_index
				end
			end
		end

	is_top (f_body_index: INTEGER; index: INTEGER): BOOLEAN is
			-- Return True if the couple ('f','index') is the top position on the stack,
			-- Return False if the couple ('f','index') is somewhere else in the stack,
			-- 		or if the couple ('f','index') is not in the stack.
		local
			stack_elem: EIFFEL_CALL_STACK_ELEMENT
			l_ccs: EIFFEL_CALL_STACK
		do
			if is_stopped then
				l_ccs := current_call_stack
				if l_ccs /= Void and then not l_ccs.is_empty then
					stack_elem ?= l_ccs.i_th (1)
					Result := stack_elem /= Void
							and then stack_elem.routine /= Void
							and then f_body_index = stack_elem.body_index
							and then index = stack_elem.break_index
				end
			end
		end

	has_valid_call_stack: BOOLEAN is
			-- Has a valid callstack ?
		do
			if is_stopped then
				if current_call_stack /= Void and then current_call_stack.count > 0 then
					Result := True
				end
			end
		end

	has_valid_current_eiffel_call_stack_element: BOOLEAN is
			-- Is current call stack element a valid Eiffel Call Stack Element ?
		do
			Result := current_eiffel_call_stack_element /= Void
		end

	has_breakpoint_enabled: BOOLEAN is
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

	replay_depth_limit: INTEGER
			-- Maximum depth which can be replayed

	replay_depth: INTEGER
			-- Current replayed depth

	set_replay_recording (b: BOOLEAN) is
			-- Enable or disable execution replay recording
		require
			stop_recording_only_if_not_replaying: b implies not replay_activated
		do
			replay_recording := b
		end

	set_replay_activated (b: BOOLEAN) is
			-- Enable or Disable Execution replaying
		require
			activate_replay_only_if_recording: b implies replay_recording
		do
			replay_activated := b
		end

	set_replay_depth_limit (d: INTEGER) is
			-- Set maximum replay depth
		require
			d_positive_or_zero: d >= 0
		do
			replay_depth_limit := d
		end

	set_replay_depth (d: INTEGER) is
			-- Set current replay depth
		require
			d_in_range: d >= 0 and d <= replay_depth_limit
		do
			replay_depth := d
		end

	set_catcall_data (v: like catcall_data) is
			-- Set `catcall_data' to `v'
		do
			catcall_data := v
		end

feature -- Update

	update_on_pre_stopped_state is
			-- Update data which need update before application is really stopped
		do
		end

	update_on_stopped_state is
			-- Update data which need update after application is really stopped
		do
		end

feature -- Setting

	set_is_stopped (b: BOOLEAN) is
			-- set is_stopped to `b'
		do
			if b and then not is_stopped then
					--| When we switch from running to stopped state
					--| we reset the call stack list
				clear_callstack_data
			end
			is_stopped := b
		end

	set_exception (e: EXCEPTION_DEBUG_VALUE) is
			-- Set exception
		require
			exception_occurred: e /= Void implies exception_occurred
		do
			exception := e
		end

	set_max_depth (n: INTEGER) is
			-- Set the maximum number of stack elements that should be retrieved to `n'.
			-- -1 retrieves all elements.
		require
			valid_n: n = -1 or n > 0
		do
			stack_max_depth := n
		end

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

end
