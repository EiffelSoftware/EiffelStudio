indexing
	description:
		"Abstract interface for all pick and dropable classes.%N%
		%Descendants include: widgets, items and figures."
	status: "See notice at end of class"
	keywords: "pick and drop, figure, widget, item"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_ABSTRACT_PICK_AND_DROPABLE

inherit
	IDENTIFIED
		export
			{NONE} free_id, id_freed
		end

feature -- Access

	pebble: ANY is
			-- Data to be transported by pick and drop mechanism.
		deferred
		end
	
	target_name: STRING
			-- Optional textual name describing `Current' pick and drop hole.

	pebble_function: FUNCTION [ANY, TUPLE [], ANY] is
			-- Returns data to be transported by pick and drop mechanism.
		deferred
		end

	accept_cursor: EV_CURSOR is
			-- `Result' is cursor displayed when the screen pointer is over a
			-- target that accepts `pebble' during pick and drop.
		deferred
		end

	deny_cursor: EV_CURSOR is
			-- `Result' is cursor displayed when the screen pointer is over a
			-- target that does not accept `pebble' during pick and drop.
		deferred
		end 

feature -- Status setting

	set_pebble (a_pebble: like pebble) is
			-- Assign `a_pebble' to `pebble'.
		require
			a_pebble_not_void: a_pebble /= Void
		deferred
		ensure
			pebble_assigned: pebble = a_pebble
		end

	remove_pebble is
			-- Make `pebble' `Void' and `pebble_function' `Void,
			-- Removing transport.
		deferred
		ensure
			pebble_removed: pebble = Void and pebble_function = Void
		end

	set_pebble_function (a_function: FUNCTION [ANY, TUPLE [], ANY]) is
			-- Set `a_function' to compute `pebble'.
			-- It will be called once each time a pick occurs, the result
			-- will be assigned to `pebble' for the duration of transport.
			-- When a pick occurs, the pick position in widget coordinates,
			-- <<x, y>> in pixels, is passed.
			-- To handle this data use `a_function' of type
			-- FUNCTION [ANY, TUPLE [INTEGER, INTEGER], ANY] and return the
			-- pebble as a function of x and y.
			-- Overrides `set_pebble'.
		require
			a_function_not_void: a_function /= Void
			a_function_takes_two_integer_open_operands:
				a_function.valid_operands ([1,1])
				-- Note that `a_function' with no operands or one integer
				-- operand meets this criteria.
		deferred
		ensure
			pebble_function_assigned: pebble_function = a_function
		end

	set_target_name (a_name: STRING) is
			-- Assign `a_name' to `target_name'.
		require
			a_name_not_void: a_name /= Void
		do
			target_name := clone (a_name)
		ensure
			target_name_assigned:
				a_name /= target_name and a_name.is_equal (target_name)
		end

	set_accept_cursor (a_cursor: EV_CURSOR) is
			-- Set `a_cursor' to be displayed when the screen pointer is over a
			-- target that accepts `pebble' during pick and drop.
		deferred
		ensure
			accept_cursor_assigned: accept_cursor.is_equal (a_cursor)
		end

	set_deny_cursor (a_cursor: EV_CURSOR) is
			-- Set `a_cursor' to be displayed when the screen pointer is not
			-- over a valid target.
		deferred
		ensure
			deny_cursor_assigned: deny_cursor.is_equal (a_cursor)
		end

feature -- User input events

	pick_actions: EV_PND_START_ACTION_SEQUENCE is
			-- Actions to be performed when `pebble' is picked up.
		deferred
		end

	conforming_pick_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Actions to be performed when a pebble that fits this hole is
			-- picked up from another source.
			-- (when drop_actions.accepts_pebble (pebble))
		deferred
		end

	pointer_motion_actions: EV_POINTER_MOTION_ACTION_SEQUENCE is
			-- Actions to be performed when screen pointer moves.
		deferred
		end

	drop_actions: EV_PND_ACTION_SEQUENCE is
			-- Actions to take when pick and drop transport drops on `Current'.
		deferred
		end

feature {EV_ANY_I, EV_ABSTRACT_PICK_AND_DROPABLE} -- Initialization

	init_drop_actions (a_drop_actions: EV_PND_ACTION_SEQUENCE) is
			-- Setup drop action sequence.
		local
			pnd_targets: ARRAYED_LIST [INTEGER]
		do
			pnd_targets := (create {EV_ENVIRONMENT})
				.application.implementation.pnd_targets
			a_drop_actions.not_empty_actions.extend (
					pnd_targets~extend (object_id)
			)
			a_drop_actions.empty_actions.extend (
					pnd_targets~prune_all (object_id)
			)
		end

end -- class EV_ABSTRACT_PICK_AND_DROPABLE

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

