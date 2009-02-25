note
	description:
		"A sequence of actions to be performed on `call'"
	legal: "See notice at end of class."

	instructions: "[ 
		Use features inherited from LIST to add/remove actions.
		An action is a procedure of ANY class that takes EVENT_DATA.
		When `call' is called the actions in the list will be executed
		in order stating at `first'.
		An action may call `abort' which will cause `call' to stop executing
		actions in the sequence. (Until the next call to `call').
		Descendants may redefine `initialize' to arrange for `call' to
		be called by an event source.
		Use `block', `pause', `flush' and `resume' to change the behavior
		of `call'.
		eg.
		 birthday_data: TUPLE [INTEGER, STRING] -- (age, name)
		 birthday_actions: ACTIONS_SEQUENCE [like birthday_data]
		 create birthday_actions.make ("birthday", <<"age","name">>)
		 send_card (age: INTEGER, name, from: STRING) is ...
		 buy_gift (age: INTEGER, name, gift, from: STRING) is ...
		 birthday_actions.extend (agent send_card (?, ?, "Sam")
		 birthday_actions.extend (agent buy_gift (?, ?, "Wine", "Sam")
		 birthday_actions.call ([35, "Julia"])
		 causes call to: send_card (35, "Julia", "Sam")
		                 buy_gift (35, "Julia", "Wine", "Sam")
		]"

	status: "See notice at end of class."
	keywords:
		"event, action"
	date:
		"$Date$"
	revision:
		"$Revision$"

class
	ACTION_SEQUENCE [EVENT_DATA -> ?TUPLE create default_create end]

inherit
	ARRAYED_LIST [PROCEDURE [ANY, EVENT_DATA]]
		rename
			make as arrayed_list_make
		export
			{ACTION_SEQUENCE} same_items, subarray
		redefine
			default_create,
			set_count,
			prune
		end

create
	default_create,
	make

create {ACTION_SEQUENCE}
	array_make,
	arrayed_list_make,
	make_filled

feature {NONE} -- Initialization

	default_create
			-- Begin in `Normal_state'.
		do
			arrayed_list_make (0)
			state := Normal_state
		end

feature -- Basic operations

	call (event_data: detachable EVENT_DATA)
			-- Call each procedure in order unless `is_blocked'.
			-- If `is_paused' delay execution until `resume'.
			-- Stop at current point in list on `abort'.
		local
			l_routines_snapshot: SPECIAL [like item]
			l_count: INTEGER
			l_action: like item
			l_kamikazes: SPECIAL [like item]
			l_kamikazes_internal: like kamikazes_internal
			l_is_aborted_stack: like is_aborted_stack
			i: INTEGER
		do
			if count > 0 then
					-- Create a snapshot of the routine objects in `Current'.
				create l_routines_snapshot.make (count)
				l_routines_snapshot.copy_data (area, 0, 0, count)
					-- Iterate agents contained in `kamikazes' and remove them from `Current'
					-- The agents will still be called from `l_routines_snapshot'.
				l_kamikazes_internal := kamikazes_internal
				if l_kamikazes_internal /= Void and then not l_kamikazes_internal.is_empty then
					from
						l_kamikazes := l_kamikazes_internal.area
						l_count := l_kamikazes_internal.count
						i := 0
					until
						i = l_count
					loop
						prune_all (l_kamikazes @ i)
						i := i + 1
					end
						-- Reset kamikazes list.
					l_kamikazes_internal.wipe_out
				end
				inspect
					state
				when
					Normal_state
				then
					from
						l_is_aborted_stack := is_aborted_stack
						l_is_aborted_stack.extend (False)
						l_count := l_routines_snapshot.count
						i := 0
					until
						i = l_count
						or l_is_aborted_stack.item
					loop
						l_action := l_routines_snapshot @ i
						if l_action /= Void then
							l_action.call (event_data)
						end
						i := i + 1
					variant
						l_count - i
					end
					l_is_aborted_stack.remove
				when
					Paused_state
				then
					call_buffer.extend (event_data)
				when
					 Blocked_state
				then
					-- do_nothing
				end
			end
		ensure
			is_aborted_stack_unchanged:
				(old is_aborted_stack) ~ is_aborted_stack
		end

	extend_kamikaze (an_item: like item)
			-- Extend `an_item' and remove it again after it is called.
		do
			extend (an_item)
			prune_when_called (an_item)
		end

feature -- Access

	name: detachable STRING
			-- Textual description.
		local
			i: like name_internal
		do
			i := name_internal
			if i /= Void then
				Result := i.twin
			end
		ensure
			equal_to_name_internal: Result ~ name_internal
		end

	dummy_event_data: EVENT_DATA
			-- Attribute of the generic type.
			-- Useful for introspection and use in like statements.
		obsolete "Not implemented. To be removed"
		local
			r: detachable EVENT_DATA
		do
			r := dummy_event_data_internal
			if r = Void then
				create r
				dummy_event_data_internal := r
			end
			Result := r
		end

	event_data_names: detachable ARRAY [STRING]
			-- Textual description of each event datum.
		obsolete "Not implemented. To be removed"
		local
			i: like event_data_names_internal
		do
			i := event_data_names_internal
			if i /= Void then
				Result := i.deep_twin
			end
		ensure
			equal_to_event_data_names_internal:
				 deep_equal (Result, event_data_names_internal)
		end

feature -- Status setting

	abort
			-- Abort the current `call'.
			-- (The current item.call will be completed.)
		require
			call_is_underway: call_is_underway
		do
			is_aborted_stack.replace (True)
		ensure
			is_aborted_set: is_aborted_stack.item
		end

	block
			-- Ignore subsequent `call's.
		do
			state := Blocked_state
		ensure
			blocked_state: state = Blocked_state
		end

	pause
			-- Buffer subsequent `call's for later execution.
			-- If `is_blocked' calls will simply be ignored.
		do
			state := Paused_state
		ensure
			paused_state: state = Paused_state
		end

	resume
			-- Used after `block' or `pause' to resume normal `call'
			-- execution.  Executes any buffered `call's.
		local
			l_call_buffer: like call_buffer
		do
			state := Normal_state
			from
				l_call_buffer := call_buffer
			until
				l_call_buffer.is_empty
			loop
				call (l_call_buffer.item)
				l_call_buffer.remove
			end
		ensure
			normal_state: state = Normal_state
		end

	flush
			-- Discard any buffered `call's.
		do
			call_buffer.wipe_out
		ensure
			call_buffer_empty: call_buffer.is_empty
		end

feature -- Status report

	state: INTEGER
			-- One of `Normal_state' `Paused_state' or `Blocked_state'

	Normal_state: INTEGER = 1
	Paused_state: INTEGER = 2
	Blocked_state: INTEGER = 3

	call_is_underway: BOOLEAN
			-- Is `call' currently being executed?
		do
			Result := not is_aborted_stack.is_empty
		ensure
			Result = not is_aborted_stack.is_empty
		end

feature -- Removal

	prune (v: like item)
			-- Remove first occurrence of `v', if any,
			-- after cursor position.
			-- Move cursor to right neighbor.
			-- (or `after' if no right neighbor or `v' does not occur)
		local
			l_compare_objects: BOOLEAN
			l_kamikazes: like kamikazes_internal
		do
			Precursor {ARRAYED_LIST}(v)
			l_kamikazes := kamikazes_internal
			if l_kamikazes /= Void then
				if object_comparison then
					l_compare_objects := l_kamikazes.object_comparison
					l_kamikazes.compare_objects
					l_kamikazes.start
					l_kamikazes.prune (v)
					if not l_compare_objects then
						l_kamikazes.compare_references
					end
				else
					l_kamikazes.prune (v)
				end
			end
		end

	prune_when_called (an_action: like item)
			-- Remove `an_action' after the next time it is called.
		require
			has (an_action)
		do
			kamikazes.extend (an_action)
		end

feature -- Element status

	has_kamikaze_action (an_action: like item): BOOLEAN
			-- Return True is `an_action' is found and will be pruned when called.
		require
			has (an_action)
		do
			Result := has (an_action) and then kamikazes.has (an_action)
		end

feature -- Event handling

	not_empty_actions: ARRAYED_LIST [PROCEDURE [ANY, TUPLE]]
			-- Actions to be performed on transition from `is_empty' to not `is_empty'.
		local
			r: like not_empty_actions_internal
		do
			r := not_empty_actions_internal
			if r = Void then
				create r.make (0)
				not_empty_actions_internal := r
			end
			Result := r
		end

	empty_actions: ARRAYED_LIST [PROCEDURE [ANY, TUPLE]]
			-- Actions to be performed on transition from not `is_empty' to `is_empty'.
		local
			r: like empty_actions_internal
		do
			r := empty_actions_internal
			if r = Void then
				create r.make (0)
				empty_actions_internal := r
			end
			Result := r
		end

feature {NONE} -- Implementation, ARRAYED_LIST

	set_count (new_count: INTEGER)
			-- Set `count' to `new_count'
		do
			if empty_actions_internal /= Void and then count /= 0 and new_count = 0 then
					-- Transition from not `is_empty' to `is_empty'.
				call_action_list (empty_actions)
			elseif not_empty_actions_internal /= Void and then count = 0 and new_count /= 0 then
					-- Transition from `is_empty' to not `is_empty'.
				call_action_list (not_empty_actions)
			end

				-- Adjust `count'
			count := new_count
		end

feature {NONE} -- Implementation

	call_action_list (actions: ARRAYED_LIST [PROCEDURE [ANY, TUPLE]])
			-- Call each action in `actions'.
		require
			actions_not_void: actions /= Void
		local
			snapshot: like actions
			i: INTEGER
		do
			if not actions.is_empty then
				snapshot := actions.twin
				from
					i := 1
				until
					i > snapshot.count
				loop
					if snapshot @ i /= Void then
						snapshot.i_th (i).call (Void)
					end
					i := i + 1
				end
			end
		end

	is_aborted_stack: LINKED_STACK [BOOLEAN]
			-- `item' holds abort status of
			-- innermost of possibly recursive `call's.
		local
			r: like is_aborted_stack_internal
		do
			r := is_aborted_stack_internal
			if r = Void then
				create r.make
				is_aborted_stack_internal := r
			end
			Result := r
		end

	is_aborted_stack_internal: detachable like is_aborted_stack
		-- Internal storage for `is_aborted_stack'.

	call_buffer: LINKED_QUEUE [detachable EVENT_DATA]
			-- Holds calls made while `is_paused'
			-- to be executed on `resume'.
		local
			r: like call_buffer_internal
		do
			r := call_buffer_internal
			if r = Void then
				create r.make
				call_buffer_internal := r
			end
			Result := r
		end

	call_buffer_internal: detachable like call_buffer
			-- Internal storage for `call_buffer'.

	name_internal: detachable STRING
			-- See name.

	event_data_names_internal: detachable ARRAY [STRING]
			-- See event_data_names.

	dummy_event_data_internal: detachable EVENT_DATA
			-- See dummy_event_data.

	kamikazes: ARRAYED_LIST [like item]
			-- Used by `prune_when_called'.
		local
			r: detachable ARRAYED_LIST [like item]
		do
			r := kamikazes_internal
			if r = Void then
				create r.make (0)
				kamikazes_internal := r
			end
			Result := r
		end

	kamikazes_internal: detachable like kamikazes
			-- Internal storage for `kamikazes'.

	not_empty_actions_internal: detachable like not_empty_actions
			-- Internal storage for `not_empty_actions'.

	empty_actions_internal: detachable like empty_actions
			-- Internal storage for `empty_actions'.

feature -- Obsolete

	make
		obsolete
			"use default_create"
		do
			default_create
		end

	set_source_connection_agent
				(a_source_connection_agent: PROCEDURE [ANY, TUPLE])
			-- Set `a_source_connection_agent' that will connect sequence to an
			-- actual event source. The agent will be called when the first action is
			-- added to the sequence. If there are already actions in the
			-- sequence the agent is called immediately.
		obsolete
			"use not_empty_actions"
		do
			not_empty_actions.extend (a_source_connection_agent)
			if not is_empty then
				a_source_connection_agent.call (Void)
			end
		end

invariant
	is_aborted_stack_not_void: is_aborted_stack /= Void
	call_buffer_not_void: call_buffer /= Void
	valid_state:
		state = Normal_state or state = Paused_state or state = Blocked_state
	call_buffer_consistent: state = Normal_state implies call_buffer.is_empty
	not_empty_actions_not_void: not_empty_actions /= Void
	empty_actions_not_void: empty_actions /= Void

note
	library:	"EiffelBase: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2009, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class ACTION_SEQUENCE
