note
	description:
		"Abstract interface for all pick and dropable classes.%N%
		%Descendants include: widgets, items and figures."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "pick and drop, figure, widget, item"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_ABSTRACT_PICK_AND_DROPABLE

inherit
	IDENTIFIED
		export
			{NONE} free_id, id_freed, default_create
		end

feature -- Access

	pebble: detachable ANY
			-- Data to be transported by pick and drop mechanism.
		deferred
		end

	target_name: detachable STRING_GENERAL
			-- Optional textual name describing `Current' pick and drop hole.
		note
			option: stable
		attribute
		end

	target_data_function: detachable FUNCTION [ANY, TUPLE [like pebble], EV_PND_TARGET_DATA]
			-- Function for computing target meta data based on source pebble.
			-- Primarily used for Pick and Drop target menu.
		note
			option: stable
		attribute
		end

	pebble_function: detachable FUNCTION [ANY, TUPLE, detachable ANY]
			-- Returns data to be transported by pick and drop mechanism.
		deferred
		end

	accept_cursor: detachable EV_POINTER_STYLE
			-- `Result' is cursor displayed when the screen pointer is over a
			-- target that accepts `pebble' during pick and drop.
		deferred
		ensure
			result_not_void: Result /= Void
		end

	deny_cursor: detachable EV_POINTER_STYLE
			-- `Result' is cursor displayed when the screen pointer is over a
			-- target that does not accept `pebble' during pick and drop.
		deferred
		ensure
			result_not_void: Result /= Void
		end

feature -- Status setting

	set_pebble (a_pebble: like pebble)
			-- Assign `a_pebble' to `pebble'.
		require
			a_pebble_not_void: a_pebble /= Void
		deferred
		ensure
			pebble_assigned: pebble = a_pebble
		end

	remove_pebble
			-- Make `pebble' `Void' and `pebble_function' `Void,
			-- Removing transport.
		deferred
		ensure
			pebble_removed: pebble = Void and pebble_function = Void
		end

	set_pebble_function (a_function: FUNCTION [ANY, TUPLE, detachable ANY])
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
				a_function.valid_operands ([1, 1])
				-- Note that `a_function' with no operands or one integer
				-- operand meets this criteria.
		deferred
		ensure
			pebble_function_assigned: pebble_function = a_function
		end

	set_target_name (a_name: STRING_GENERAL)
			-- Assign `a_name' to `target_name'.
		require
			a_name_not_void: a_name /= Void
		do
			target_name := a_name.twin
		ensure
			target_name_assigned:
				attached target_name as l_target_name and then a_name /= l_target_name and then a_name.is_equal (l_target_name)
		end

	set_target_data_function (a_function: FUNCTION [ANY, TUPLE [like pebble], EV_PND_TARGET_DATA])
			-- Set `a_function' to compute target meta data based on transport source.
			-- Overrides any `target_name' set with `set_target_name'.
		require
			a_function_not_void: a_function /= Void
		do
			target_data_function := a_function.twin
		ensure
			target_data_function_assigned: target_data_function /= Void and then target_data_function.is_equal (a_function)
		end

	set_accept_cursor (a_cursor: like accept_cursor)
			-- Set `a_cursor' to be displayed when the screen pointer is over a
			-- target that accepts `pebble' during pick and drop.
		require
			a_cursor_not_void: a_cursor /= Void
		deferred
		ensure
			accept_cursor_assigned: attached accept_cursor as l_accept_cursor and then l_accept_cursor.is_equal (a_cursor)
		end

	set_deny_cursor (a_cursor: like deny_cursor)
			-- Set `a_cursor' to be displayed when the screen pointer is not
			-- over a valid target.
		require
			a_cursor_not_void: a_cursor /= Void
		deferred
		ensure
			deny_cursor_assigned: attached deny_cursor as l_deny_cursor and then l_deny_cursor.is_equal (a_cursor)
		end

feature -- User input events

	pick_actions: EV_PND_START_ACTION_SEQUENCE
			-- Actions to be performed when `pebble' is picked up.
		deferred
		end

	conforming_pick_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions to be performed when a pebble that fits this hole is
			-- picked up from another source.
			-- (when drop_actions.accepts_pebble (pebble))
		deferred
		end

	pointer_motion_actions: EV_POINTER_MOTION_ACTION_SEQUENCE
			-- Actions to be performed when screen pointer moves.
		deferred
		end

	drop_actions: EV_PND_ACTION_SEQUENCE
			-- Actions to take when pick and drop transport drops on `Current'.
		deferred
		end

feature {EV_ANY_I, EV_ABSTRACT_PICK_AND_DROPABLE} -- Initialization

	init_drop_actions (a_drop_actions: EV_PND_ACTION_SEQUENCE)
			-- Setup drop action sequence.
		local
			l_pnd_targets: HASH_TABLE [INTEGER, INTEGER]
			l_object_id: like object_id
		do
			l_object_id := object_id
			l_pnd_targets := pnd_targets
			a_drop_actions.not_empty_actions.extend (agent
					l_pnd_targets.put (l_object_id, l_object_id)
			)
			a_drop_actions.empty_actions.extend (agent
					l_pnd_targets.remove (l_object_id)
			)
		end

feature {NONE} -- Implementation

	create_interface_objects
			-- <Precursor>
		do

		end

	pnd_targets: HASH_TABLE [INTEGER, INTEGER]
			-- Hash table of current pnd targets.
		once
			Result := (create {EV_ENVIRONMENT}).implementation.application_i.pnd_targets
		end

	Default_pixmaps: EV_STOCK_PIXMAPS
			-- Default pixmaps and cursors.
		once
			create Result
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_ABSTRACT_PICK_AND_DROPABLE











