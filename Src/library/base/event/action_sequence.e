indexing
	description:
		"A sequence of actions to be performed on `call'"

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
		 birthday_actions.extend (~send_card (?, ?, "Sam")
		 birthday_actions.extend (~buy_gift (?, ?, "Wine", "Sam")
		 birthday_actions.call ([35, "Julia"])
		 causes call to: send_card (35, "Julia", "Sam")
		                 buy_gift (35, "Julia", "Wine", "Sam")
		]"

	status:
		"See notice at end of class"
	keywords:
		"event, action"
	date:
		"$Date$"
	revision:
		"$Revision$"

class
	ACTION_SEQUENCE [EVENT_DATA -> TUPLE create make end]

inherit
	LINKED_LIST [PROCEDURE [ANY, EVENT_DATA]]
		rename
			make as linked_list_make
		redefine
			new_cell,
			merge_left,
			merge_right,
			cleanup_after_remove,
			wipe_out,
			default_create
		end

create
	default_create,
	make

feature {NONE} -- Initialization

	make is
		obsolete
			"use default_create"
		do
			default_create
		end

	default_create is
			-- Begin in `Normal_state'.
		do
			linked_list_make
			create is_aborted_stack.make
			create call_buffer.make
			state := Normal_state
			create not_empty_actions.make
			create empty_actions.make
		end

feature -- Basic operations

	call (event_data: EVENT_DATA) is
			-- Call each procedure in order unless `is_blocked'.
			-- If `is_paused' delay execution until `resume'.
			-- Stop at current point in list on `abort'.
		local
			snapshot: LINKED_LIST [PROCEDURE [ANY, EVENT_DATA]]
		do
			create snapshot.make
			snapshot.fill (Current)
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
					snapshot.start
				variant
					snapshot.count + 1 - snapshot.index
				until
					snapshot.after
					or is_aborted_stack.item
				loop
					snapshot.item.call (event_data)
					snapshot.forth
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
		ensure
			is_aborted_stack_unchanged:
				old is_aborted_stack.is_equal (is_aborted_stack)
		end

feature -- Access

	name: STRING is
			-- Textual description.
		do
			Result := clone (name_internal)
		ensure
			equal_to_name_internal: Result.is_equal (name_internal)
		end

	dummy_event_data: EVENT_DATA is
			-- Attribute of the generic type.
			-- Useful for introspection and use in like statements.
		do
			if dummy_event_data_internal = Void then
				create dummy_event_data_internal.make
			end
			Result := dummy_event_data_internal
		end

	event_data_names: ARRAY [STRING] is
			-- Textual description of each event datum.
		do
			Result := deep_clone (event_data_names_internal)
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
				create kamikazes.make
			end
			kamikazes.extend (~prune_all (an_action))
		end

	merge_left (other: like Current) is
			-- Merge `other' into current structure after cursor
			-- position. Do not move cursor. Empty `other'
		do
			if count = 0 then
				Precursor (other)
				if count > 0 then
					call_action_list (not_empty_actions)
				end
			else
				Precursor (other)
			end
		end

	merge_right (other: like Current) is
			-- Merge `other' into current structure before cursor
			-- position. Do not move cursor. Empty `other'
		do
			if count = 0 then
				Precursor (other)
				if count > 0 then
					call_action_list (not_empty_actions)
				end
			else
				Precursor (other)
			end
		end

	wipe_out is
			-- Remove all items.
		do
			Precursor
			call_action_list (empty_actions)
		end

	set_source_connection_agent
				(a_source_connection_agent: PROCEDURE [ANY, TUPLE []]) is
			-- Set `a_source_connection_agent' that will connect sequence to an
			-- actual event source. The agent will be called when the first action is
			-- added to the sequence. If there are already actions in the
			-- sequence the agent is called immediately.
		obsolete
			"use not_empty_actions"
		do
			not_empty_actions.extend (a_source_connection_agent)
			if not is_empty then
				a_source_connection_agent.call ([])
			end 
		end

feature -- Event handling

	not_empty_actions: LINKED_LIST [PROCEDURE [ANY, TUPLE []]]
			-- Actions to be performed on transition from `is_empty' to not `is_empty'.

	empty_actions: LINKED_LIST [PROCEDURE [ANY, TUPLE []]]
			-- Actions to be performed on transition from not `is_empty' to `is_empty'.

feature {LINKED_LIST} -- Implementation

	new_cell (v: like item): like first_element is
			-- Create new cell with `v'.
		do
			if count = 0 then
				Result := Precursor (v)
				call_action_list (not_empty_actions)
			else
				Result := Precursor (v)
			end
		end

	cleanup_after_remove (v: like first_element) is
			-- Clean-up a just removed cell.
		do
			Precursor (v)
			if count = 0 then
				call_action_list (empty_actions)
			end
		end

feature {NONE} -- Implementation

	call_action_list (actions: LINKED_LIST [PROCEDURE [ANY, TUPLE []]]) is
			-- Call each action in `actions'.
		require
			actions_not_void: actions /= Void
		local
			snapshot: like actions
		do
			create snapshot.make
			snapshot.fill (actions)
			from
				snapshot.start
			until
				snapshot.after
			loop
				snapshot.item.call ([])
				--snapshot.item.call (Void)
				snapshot.forth
			end
		end

	source_connection_agent: PROCEDURE [ANY, TUPLE []]

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
	
	kamikazes: LINKED_LIST [PROCEDURE [ANY, TUPLE []]]
			-- Used by `prune_when_called'.

invariant
	is_aborted_stack_not_void: is_aborted_stack /= Void
	call_buffer_not_void: call_buffer /= Void
	not_has_void: not has (Void)
	valid_state:
		state = Normal_state or state = Paused_state or state = Blocked_state
	call_buffer_consistent: state = Normal_state implies call_buffer.is_empty
	not_empty_actions_not_void: not_empty_actions /= Void
	empty_actions_not_void: empty_actions /= Void
	source_connection_agent_disgarded_after_call:

indexing

	library: "[
			EiffelBase: Library of reusable components for Eiffel.
			]"

	status: "[
			Copyright 1986-2001 Interactive Software Engineering (ISE).
			For ISE customers the original versions are an ISE product
			covered by the ISE Eiffel license and support agreements.
			]"

	license: "[
			EiffelBase may now be used by anyone as FREE SOFTWARE to
			develop any product, public-domain or commercial, without
			payment to ISE, under the terms of the ISE Free Eiffel Library
			License (IFELL) at http://eiffel.com/products/base/license.html.
			]"

	source: "[
			Interactive Software Engineering Inc.
			ISE Building
			360 Storke Road, Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Electronic mail <info@eiffel.com>
			Customer support http://support.eiffel.com
			]"

	info: "[
			For latest info see award-winning pages: http://eiffel.com
			]"

end -- class ACTION_SEQUENCE 
