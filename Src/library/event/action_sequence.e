indexing
	description:
		"A sequence of actions to be performed on `call'"
	instructions: 
		"Use features inherited from LIST to add/remove actions. %
		%An action is a procedure of ANY class that takes EVENT_DATA. %
		%When `call' is called the actions in the list will be executed %
		%in order stating at `first'. %
		%An action may call `abort' which will cause `call' to stop executing %
		%actions in the sequence. (Until the next call to `call'). %
		%Descendants may redefine `initialize' to arrange for `call' to %
		%be called by an event source. %
		%Use `block', `pause', `flush' and `resume' to change the behavior %
		%of `call'.%
		%eg. %
		% birthday_data: TUPLE [INTEGER, STRING] -- (age, name) %
		% birthday_actions: ACTIONS_SEQUENCE [like birthday_data] %
		% create birthday_actions.make (%"birthday%", <<%"age%",%"name%">>) %
		% send_card (age: INTEGER, name, from: STRING) is ...%
		% buy_gift (age: INTEGER, name, gift, from: STRING) is ...%
		% birthday_actions.extend (~send_card (?, ?, %"Sam%") %
		% birthday_actions.extend (~buy_gift (?, ?, %"Wine%", %"Sam%") %
		% birthday_actions.call ([35, %"Bertrand%"]) %
		% causes call to: send_card (35, %"Bertrand%", %"Sam%") %
		%                 buy_gift (35, %"Bertrand%", %"Wine%", %"Sam%")"

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
			merge_right
		end

creation
	make

feature {NONE} -- Initialization

	make (a_name: STRING; some_event_data_names: ARRAY [STRING]) is
			-- Create with `a_name' and
			-- `some_event_data_names' describing each event datum.
			-- Begin in `Normal_state'.
		require
			name_not_void: a_name /= Void
			name_not_empty: not a_name.empty
			event_data_names_not_void: some_event_data_names /= Void
			correct_event_data_names_ok:
				 some_event_data_names.count = dummy_event_data.count
		do
			linked_list_make
			create is_aborted_stack.make
			create cursor_stack.make
			create call_buffer.make
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
				debug ("EVENT_TRACE") print (" calling "+count.out+" actions...%N") end
				from
					cursor_stack.extend (cursor)
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
				go_to (cursor_stack.item)
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
			-- Discard any buffered `call's.
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
			-- Initialize has been called

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

	cursor_stack: LINKED_STACK [CURSOR]
			-- `item' holds position in second from innermost
			-- of possibly recursive `call's.

	call_buffer: LINKED_QUEUE [EVENT_DATA]
			-- Holds calls made while `is_paused'
			-- to be executed on `resume'.

	name_internal: STRING
			-- See name.

	event_data_names_internal: ARRAY [STRING]
			-- See event_data_names.

	dummy_event_data_internal: EVENT_DATA
			-- See dummy_event_data.

feature {NONE} -- Debug

	call_log (event_data: EVENT_DATA): STRING is
			-- Textual description of the input to `call'.
		local
			i, j: INTEGER
		do
			Result := "action_sequence ("+ cursor_stack.count.out + " nests) " + name_internal + ".call ("
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
	event_data_names_count_ok: event_data_names_internal.count = dummy_event_data.count

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

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-1999 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license.
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!-----------------------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--| 
--| $Log$
--| Revision 1.9  1999/11/05 20:00:11  oconnor
--| modified to stack CURSORs not just indexs
--|
--| Revision 1.8  1999/10/28 22:08:58  oconnor
--| improved debug trace message
--|
--| Revision 1.7  1999/10/27 20:36:31  oconnor
--| improved logging message
--|
--| Revision 1.6  1999/10/27 18:01:51  oconnor
--| spelling
--|
--| Revision 1.5  1999/10/27 17:57:13  oconnor
--| merged instructions in indexing clause
--|
--| Revision 1.4  1999/10/27 17:54:20  oconnor
--| fixed invariant/precondition to check number of event_data_names
--| added logging of neting level
--| fixed instructions
--|
--| Revision 1.3  1999/10/27 02:11:14  oconnor
--| removed infeasible wrapper code
--|
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
