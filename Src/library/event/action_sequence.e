indexing
	description:
		"A sequence of actions to be performed on `call'"
	instructions: 
		"Use features inherited from LIST to add/remove actions. %
		%An action is a procedure of ANY class that takes EVENT_DATA. %
		%When `call' is called the actions in the list will be executed %
		%in order stating at `first'. %
		%An action may call `abort' which will cause `call' to stop exectuing %
		%actions in the sequence. (Untill the next call to `call'). %
		%Decendants may redefine `initialize' to arrange for `call' to %
		%be called by an event source. %
		%Use `block', `pause', `flush' and `resume' to change the behaviour %
		%of `call'."
	instructions: 
		"eg. %
		% birthday_data: TUPLE [INTEGER, STRING] -- (age, name) %
		% birthday_actions: ACTIONS_SEQUENCE [like birthday_data] %
		% create birthday_actions.make (%"birthday%", <<%"age%",%"name%">>) %
		% send_card (age: INTEGER, name, from: STRING) is ...%
		% increase_carma_points is ...  %
		% birthday_actions.extend (~send_card (?, ?, %"Sam%") %
		% birthday_actions.extend (~increase_carma_points) %
		% birthday_actions.call ([35, %"Bretrand%"]) %
		% causes calls to: send_card (35, %"Bertrand%", %"Sam%") %
		%                  increase_carma_points"
	status:
		"See notice at end of class"
	keywords:
		"event, action"
	date:
		"$Date$"
	revision:
		"$Revision$"

class
	ACTION_SEQUENCE [EVENT_DATA -> TUPLE]

inherit
	LINKED_LIST [PROCEDURE [ANY, EVENT_DATA]]
		rename
			make as linked_list_make
		redefine
			new_cell,
			merge_left,
			merge_right
		end

creation
	make

feature {NONE} -- Initialization

	make (a_name: STRING; some_event_data_names: ARRAY [STRING]) is
			-- Create with `a_name' and
			-- `some_event_data_names' decribing each event datum.
			-- Begin in `Normal_state'.
		require
			name_not_void: a_name /= Void
			name_not_empty: not a_name.empty
			event_data_names_not_void: some_event_data_names /= Void
--			correct_event_data_names_count:
--				 some_event_data_names.count = dummy_event_data_count
		do
			linked_list_make
			create is_aborted_stack.make
			create cursor_stack.make
			create call_buffer.make
--			create dummy_event_data.make
			name_internal := a_name
			event_data_names_internal := some_event_data_names
			state := Normal_state
		end

	initialize is
			-- Called when the first action is added.
			-- Can be redefined to perform setup tasks such as
			-- connecting a callback from the event source.
		require
			not_already_called: not is_initialized
		do
			is_initialized := True
		ensure
			is_initialized
		end

feature -- Basic operations

	call (event_data: EVENT_DATA) is
			-- Call each procedure in order unless `is_blocked'.
			-- If `is_paused' delay execution until `resume'.
			-- Stop at current point in list on `abort'.
		do
			debug ("EVENT_TRACE") print (call_log (event_data)) end
			inspect
				state
			when
				Normal_state
			then
				debug ("EVENT_TRACE") print (" calling actions...%N") end
				from
					cursor_stack.extend (index)
					is_aborted_stack.extend (False)
					start
				until
					after
					or is_aborted_stack.item
				loop
					item.call (event_data)
					forth
				end
				is_aborted_stack.remove
				go_i_th (cursor_stack.item)
				cursor_stack.remove
			when
				Paused_state
			then
				debug ("EVENT_TRACE") print (" while paused, buffering.%N") end
				call_buffer.extend (event_data)
			when
				 Blocked_state
			then
				debug ("EVENT_TRACE") print (" while blocked, ignoring.%N") end
				-- do_nothing
			end
		ensure
			is_aborted_stack_unchanged:
				old is_aborted_stack.is_equal (is_aborted_stack)
			cursor_stack_unchanged:
				old cursor_stack.is_equal (cursor_stack)
		end

	wrapper (d: EVENT_DATA; p: PROCEDURE [ANY, TUPLE]) is
			-- 
		do
			p.call (d)
		end

feature -- Access

	name: STRING is
			-- Textual description.
		do
			Result := clone (name_internal)
		ensure
			equal_to_name_internal: Result.is_equal (name_internal)
		end

	dummy_event_data: EVENT_DATA
			-- Attribute of the generic type.
			-- Useful for introspection and use in like statements.

--	dummy_event_data_count: INTEGER is
--		do
--			if dummy_event_data = Void then
--				create dummy_event_data.make
--			end
--			Result := dummy_event_data.count
--		end

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
			debug ("EVENT_TRACE") print (name_internal + ".block%N") end
			state := Blocked_state
		ensure
			blocked_state: state = Blocked_state
		end

	pause is
			-- Buffer subsequent `call's for later execution.
			-- If `is_blocked' calls will simply be ignored.
		do
			debug ("EVENT_TRACE") print (name_internal + ".pause%N") end
			state := Paused_state
		ensure
			paused_state: state = Paused_state
		end

	resume is
			-- Used after `block' or `pause' to resume normal `call'
			-- execution.  Executes any buffered `call's.
		do
			debug ("EVENT_TRACE") print (name_internal + ".resume%N") end
			state := Normal_state
			from
			until
				call_buffer.empty
			loop
				debug ("EVENT_TRACE") print ("from buffer: ") end
				call (call_buffer.item)
				call_buffer.remove
			end
		ensure
			normal_state: state = Normal_state
		end

	flush is
			-- Disgard any buffered `call's.
		do
			debug ("EVENT_TRACE") print (name_internal + ".flush%N") end
			call_buffer.wipe_out
		ensure
			call_buffer_empty: call_buffer.empty
		end

feature -- Status report

	state: INTEGER    
			-- One of `Normal_state' `Paused_state' or `Blocked_state'

	Normal_state: INTEGER is 1
	Paused_state: INTEGER is 2
	Blocked_state: INTEGER is 3

	is_initialized: BOOLEAN
			-- Initiailze has been called

	call_is_underway: BOOLEAN is
			-- Is `call' currently being executed?
		do
			Result := not is_aborted_stack.empty
		ensure
			Result = not is_aborted_stack.empty
		end

feature  -- Element Change

	merge_left (other: like Current) is
			-- Merge `other' into current structure after cursor
			-- position. Do not move cursor. Empty `other'
		do
			Precursor (other)
			if not is_initialized then
				initialize
			end
		ensure then
			is_initialized
		end

	merge_right (other: like Current) is
			-- Merge `other' into current structure before cursor
			-- position. Do not move cursor. Empty `other'
		do
			Precursor (other)
			if not is_initialized then
				initialize
			end
		ensure then
			is_initialized
		end

feature  {LINKED_LIST} -- Implementation

	new_cell (v: like item): like first_element is
			-- 
		do
			Result := Precursor (v)
			if not is_initialized then
				initialize
			end
		ensure then
			is_initialized
		end

feature {NONE} -- Implementation

	is_aborted_stack: LINKED_STACK [BOOLEAN]
			-- `item' holds abort status of
			-- innermost of possibly recursive `call's.

	cursor_stack: LINKED_STACK [INTEGER]
			-- `item' holds position of cursor in
			-- second from innermost of possibly recursive `call's.

	call_buffer: LINKED_QUEUE [EVENT_DATA]
			-- Holds calls made while `is_paused'
			-- to be executed on `resume'.

	name_internal: STRING
			-- Textual description.

	event_data_names_internal: ARRAY [STRING]
			-- Textual description of each event datum.

feature {NONE} -- Debug

	call_log (event_data: EVENT_DATA): STRING is
			-- Textual description of the input to `call'.
		local
			i, j: INTEGER
		do
			Result := name_internal + ".call ("
				from
					i := event_data.lower
					j := event_data_names_internal.lower
				until
					i > event_data.upper
				loop
					Result.append (event_data_names_internal.entry (j))
					Result.append (" = ")
					Result.append (event_data.entry (i).out)
					if i /=  event_data.upper then
							Result.append (", ")
					end
					i := i + 1
					j := j + 1
				end
			Result.append (")")
		end

invariant
	is_aborted_stack_not_void: is_aborted_stack /= Void
	cursor_stack_not_void: cursor_stack /= Void
	call_buffer_not_void: call_buffer /= Void
	name_not_void: name_internal /= Void
	name_not_empty: not name_internal.empty
	event_data_names_not_void: event_data_names_internal /= Void
--	dummy_event_data_not_void: dummy_event_data /= Void
--	correct_event_data_names_count: event_data_names_internal.count = dummy_event_data.count

	valid_state: state = Normal_state or state = Paused_state or state = Blocked_state
	call_buffer_consistent: state = Normal_state implies call_buffer.empty

	first_addition_caught: not empty implies is_initialized
		--| We redefine new_cell, merge_left and merge_right from LINKED_LIST
		--| to call initialize if it has not been called before. This should
		--| catch any possible way of adding the action item to the list.
		--| If it turns out that there is a LINKED_LIST feature that can add
		--| an action without calling any of these then this invariant fails.
		--| In this case the guilty feature should be redefined to call
		--| initialize.

end

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--| 
--| $Log$
--| Revision 1.2  1999/10/26 22:16:25  oconnor
--| experimental: added wrapper to side step type checks
--|
--| Revision 1.1.1.1  1999/10/26 21:02:09  oconnor
--| initail import of proposed event classes
--|
--| 
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
