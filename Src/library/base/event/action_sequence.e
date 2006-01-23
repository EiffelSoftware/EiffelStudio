indexing
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
	ACTION_SEQUENCE [EVENT_DATA -> TUPLE create default_create end]

inherit
	ARRAYED_LIST [PROCEDURE [ANY, EVENT_DATA]]
		rename
			make as arrayed_list_make
		export
			{ACTION_SEQUENCE} same_items, subarray
		redefine
			default_create,
			set_count
		end

create
	default_create,
	make

create {ACTION_SEQUENCE}
	array_make,
	arrayed_list_make,
	make_filled

feature {NONE} -- Initialization

	default_create is
			-- Begin in `Normal_state'.
		do
			arrayed_list_make (0)
			create is_aborted_stack.make
			create call_buffer.make
			state := Normal_state
			create not_empty_actions.make (0)
			create empty_actions.make (0)
		end

feature -- Basic operations

	call (event_data: EVENT_DATA) is
			-- Call each procedure in order unless `is_blocked'.
			-- If `is_paused' delay execution until `resume'.
			-- Stop at current point in list on `abort'.
		local
			snapshot: ARRAYED_LIST [PROCEDURE [ANY, EVENT_DATA]]
			l_action: PROCEDURE [ANY, EVENT_DATA]
			i: INTEGER
		do
			if count > 0 then
				snapshot := twin
				if kamikazes /= Void then
					call_action_list (kamikazes)
					kamikazes := Void
				end
				inspect 
					state
				when
					Normal_state
				then
					from
						is_aborted_stack.extend (False)
						i := 1
					variant
						snapshot.count + 1 - i
					until
						i > snapshot.count
						or is_aborted_stack.item
					loop
						l_action := snapshot.i_th (i)
						if l_action /= Void then
							l_action.call (event_data)							
						end
						i := i + 1
					end
					is_aborted_stack.remove
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
				old is_aborted_stack.is_equal (is_aborted_stack)
		end

feature -- Access

	name: STRING is
			-- Textual description.
		do
			if name_internal /= Void then
				Result := name_internal.twin
			end
		ensure
			equal_to_name_internal: equal (Result, name_internal)
		end

	dummy_event_data: EVENT_DATA is
			-- Attribute of the generic type.
			-- Useful for introspection and use in like statements.
		obsolete "Not implemented. To be removed"
		do
			if dummy_event_data_internal = Void then
				create dummy_event_data_internal
			end
			Result := dummy_event_data_internal
		end

	event_data_names: ARRAY [STRING] is
			-- Textual description of each event datum.
		obsolete "Not implemented. To be removed"
		do
			if event_data_names_internal /= Void then
				Result := event_data_names_internal.deep_twin
			end
		ensure
			equal_to_event_data_names_internal:
				 deep_equal (Result, event_data_names_internal)
		end

feature -- Status setting

	abort is
			-- Abort the current `call'.
			-- (The current item.call will be completed.)
		require
			call_is_underway: call_is_underway
		do
			is_aborted_stack.replace (True)
		ensure
			is_aborted_set: is_aborted_stack.item
		end

	block is
			-- Ignore subsequent `call's.
		do
			state := Blocked_state
		ensure
			blocked_state: state = Blocked_state
		end

	pause is
			-- Buffer subsequent `call's for later execution.
			-- If `is_blocked' calls will simply be ignored.
		do
			state := Paused_state
		ensure
			paused_state: state = Paused_state
		end

	resume is
			-- Used after `block' or `pause' to resume normal `call'
			-- execution.  Executes any buffered `call's.
		do
			state := Normal_state
			from
			until
				call_buffer.is_empty
			loop
				call (call_buffer.item)
				call_buffer.remove
			end
		ensure
			normal_state: state = Normal_state
		end

	flush is
			-- Discard any buffered `call's.
		do
			call_buffer.wipe_out
		ensure
			call_buffer_empty: call_buffer.is_empty
		end

feature -- Status report

	state: INTEGER 
			-- One of `Normal_state' `Paused_state' or `Blocked_state'

	Normal_state: INTEGER is 1
	Paused_state: INTEGER is 2
	Blocked_state: INTEGER is 3

	call_is_underway: BOOLEAN is
			-- Is `call' currently being executed?
		do
			Result := not is_aborted_stack.is_empty
		ensure
			Result = not is_aborted_stack.is_empty
		end

feature -- Element Change

	prune_when_called (an_action: like item) is
			-- Remove `an_action' after the next time it is called.
		require
			has (an_action)
		do
			if kamikazes = Void then
				create kamikazes.make (1)
			end
			kamikazes.extend (agent prune_all (an_action))
		end

feature -- Event handling

	not_empty_actions: ARRAYED_LIST [PROCEDURE [ANY, TUPLE]]
			-- Actions to be performed on transition from `is_empty' to not `is_empty'.

	empty_actions: ARRAYED_LIST [PROCEDURE [ANY, TUPLE]]
			-- Actions to be performed on transition from not `is_empty' to `is_empty'.

feature {NONE} -- Implementation, ARRAYED_LIST

	set_count (new_count: INTEGER) is
			-- Set `count' to `new_count'
		do
			if count /= 0 and new_count = 0 then
					-- Transition from not `is_empty' to `is_empty'.
				call_action_list (empty_actions)
			elseif count = 0 and new_count /= 0 then
					-- Transition from `is_empty' to not `is_empty'.
				call_action_list (not_empty_actions)
			end
			
				-- Adjust `count'
			count := new_count
		end

feature {NONE} -- Implementation

	call_action_list (actions: ARRAYED_LIST [PROCEDURE [ANY, TUPLE]]) is
			-- Call each action in `actions'.
		require
			actions_not_void: actions /= Void
		local
			snapshot: like actions
			i: INTEGER
		do
			snapshot := actions.twin
			from
				i := 1
			until
				i > snapshot.count
			loop
				if snapshot.i_th (i) /= Void then
					snapshot.i_th (i).call (Void)
				end
				i := i + 1
			end
		end

	is_aborted_stack: LINKED_STACK [BOOLEAN]
			-- `item' holds abort status of
			-- innermost of possibly recursive `call's.

	call_buffer: LINKED_QUEUE [EVENT_DATA]
			-- Holds calls made while `is_paused'
			-- to be executed on `resume'.

	name_internal: STRING
			-- See name.

	event_data_names_internal: ARRAY [STRING]
			-- See event_data_names.

	dummy_event_data_internal: EVENT_DATA
			-- See dummy_event_data.
	
	kamikazes: ARRAYED_LIST [PROCEDURE [ANY, TUPLE]]
			-- Used by `prune_when_called'.

feature -- Obsolete

	make is
		obsolete
			"use default_create"
		do
			default_create
		end

	set_source_connection_agent
				(a_source_connection_agent: PROCEDURE [ANY, TUPLE]) is
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

indexing
	library:	"EiffelBase: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"







end -- class ACTION_SEQUENCE 
