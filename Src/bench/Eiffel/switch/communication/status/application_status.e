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

	SHARED_DEBUG
		export
			{NONE} all
		end

	SHARED_EIFFEL_PROJECT
		export
			{NONE} all
		end

	IPC_SHARED
		export
			{NONE} all
			{ANY} Pg_break, Pg_interrupt,
				Pg_raise, Pg_viol
		end
	SHARED_APPLICATION_EXECUTION
		export
			{NONE} all
		end

--creation {APPLICATION_STATUS_EXPORTER}
--
--	do_nothing

feature {NONE} -- Initialization

	make is
			-- Create Current
		do
			debug ("debugger_trace")
				print (generator + ".make %N")
			end
			initialize
		end

feature {NONE} -- Initialization

	initialize is
			-- Initialize Current
		do
			create_kept_objects
			reset_call_stack_list
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

	keep_object_for_gui	(add: STRING) is
		do
			keep_object (add)
		end

feature -- Call Stack List management

	reset_call_stack_list is
			-- Reset `call_stack_list' or create it
		do
			if call_stack_list = Void then
				create call_stack_list.make (5)
			else
				call_stack_list.wipe_out
			end
		end

feature -- Callstack

	reload_current_call_stack is
			-- reload the call stack from application (after having edited an
			-- object for example to make sure the modification was successful).
		local
			ecs: like current_call_stack
		do
				-- re-create the call stack
			ecs := new_current_callstack_with (stack_max_depth)
			set_call_stack (current_thread_id, ecs)
		end

feature {NONE} -- CallStack Impl

	new_current_callstack_with (a_stack_max_depth: INTEGER): like current_call_stack is
		deferred
		end

feature -- Values

	is_stopped: BOOLEAN
			-- Is the debugged application stopped ?

	e_feature: E_FEATURE
			-- Feature in which we are currently stopped

	body_index: INTEGER
			-- Body index of the feature in which we are currently stopped

	dynamic_class: CLASS_C
			-- Class type of object in which we are currently
			-- stopped

	origin_class: CLASS_C
			-- Origin of feature in which we are currently
			-- stopped

	break_index: INTEGER
			-- Breakpoint at which we are currently stopped
			-- (first, second...)

	reason: INTEGER
			-- Reason for the applicaiton being stopped

	object_address: STRING
			-- Address of object in which we are stopped
			-- (hector address with an indirection)

	exception_occurred: BOOLEAN is
		deferred
		end

	exception_code: INTEGER
			-- Exception code if any

	exception_tag: STRING
			-- Exception tag if any

	exception_message: STRING is
			-- Exception message if any
		require
			exception_occurred: exception_occurred
		deferred
		end

feature -- Query

	reason_is_overflow: BOOLEAN is
		do
			Result := reason = pg_overflow
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
		do
			Result := current_call_stack.i_th (Application.current_execution_stack_number)
		end

feature -- Thread related access

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

--	set_thread_ids (a: ARRAY [INTEGER]) is
--			-- set thread's ids with `a'
--		require
--			a_not_empty: a /= Void and then not a.is_empty
--		do
--			create all_thread_ids.make_from_array (a)
--			refresh_threads_information
--		end

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
			from
				all_thread_ids.start
			until
				all_thread_ids.after
			loop
				all_thread_ids.forth
			end
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

	class_name: STRING is
			-- Class name of object in which we are currently
			-- stopped
		do
			Result := dynamic_class.name
		end

	valid_reason: BOOLEAN is
			-- Is the reason valid for stopping of execution?
		do
			Result := reason = Pg_break or else
				reason = Pg_interrupt or else
				reason = Pg_raise or else
				reason = Pg_viol or else
				reason = Pg_new_breakpoint or else
				reason = Pg_step
		ensure
			true_implies_correct_reason:
				Result implies (reason = Pg_break) or else
						(reason = Pg_interrupt) or else
						(reason = Pg_raise) or else
						(reason = Pg_viol) or else
						(reason = Pg_new_breakpoint) or else
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

feature -- Update

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
				reset_call_stack_list
			end
			is_stopped := b
		end

	set_exception (i: INTEGER; s: STRING) is
		do
			exception_code := i
			exception_tag := s
		end

	set_max_depth (n: INTEGER) is
			-- Set the maximum number of stack elements that should be retrieved to `n'.
			-- -1 retrieves all elements.
		require
			valid_n: n = -1 or n > 0
		do
			stack_max_depth := n
		end

feature -- Output

	display_status (st: TEXT_FORMATTER) is
			-- Display the status of the running application.
		local
			c, oc: CLASS_C
			cs: CALL_STACK_ELEMENT
			stack_num: INTEGER
			ccs: EIFFEL_CALL_STACK
		do
			if not is_stopped then
				st.add_string ("System is running")
				st.add_new_line
			else -- Application is stopped.
				-- Print object address.
				st.add_string ("Stopped in object [")
				c := dynamic_class
				st.add_address (object_address, e_feature.name, c)
				st.add_string ("]")
				st.add_new_line
					-- Print class name.
				st.add_indent
				st.add_string ("Class: ")
				c.append_name (st)
				st.add_new_line
					-- Print routine name.
				st.add_indent
				st.add_string ("Feature: ")
				if e_feature /= Void then
					oc := origin_class
					e_feature.append_name (st)
					if oc /= c then
						st.add_string (" (From ")
						oc.append_name (st)
						st.add_string (")")
					end
				else
					st.add_string ("Void")
				end
				st.add_new_line
					-- Print the reason for stopping.
				st.add_indent
				st.add_string ("Reason: ")
				inspect reason
				when Pg_break then
					st.add_string ("Stop point reached")
					st.add_new_line
				when Pg_interrupt then
					st.add_string ("Execution interrupted")
					st.add_new_line
				when Pg_raise then
					st.add_string ("Explicit exception pending")
					st.add_new_line
					display_exception (st)
				when Pg_viol then
					st.add_string ("Implicit exception pending")
					st.add_new_line
					display_exception (st)
				when Pg_new_breakpoint then
					st.add_string ("New breakpoint(s) to commit")
					st.add_new_line
					display_exception (st)
				when Pg_step then
					st.add_string ("Step completed")
					st.add_new_line
				else
					st.add_string ("Unknown")
					st.add_new_line
				end
				ccs := current_call_stack
				if not ccs.is_empty then
					stack_num := Application.current_execution_stack_number
					cs := ccs.i_th (stack_num)
					cs.display_arguments (st)
					cs.display_locals (st)
					ccs.display_stack (st)
				end
			end
		end

	display_exception (st: TEXT_FORMATTER) is
			-- Display exception in `st'.
		require
			non_void_st: st /= Void
			valid_code: exception_code > 0
		local
			e: EXCEPTIONS
			m: STRING
		do
			st.add_indent
			st.add_indent
			st.add_string ("Code: ")
			st.add_int (exception_code)
			st.add_string (" (")
			create e
			m := e.meaning (exception_code)
			if m = Void then
				m := "Undefined"
			end
			st.add_string (m)
			st.add_string (")")
			st.add_new_line
			st.add_indent
			st.add_indent
			st.add_string ("Tag: ")
			st.add_string (exception_tag)
			st.add_new_line
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
