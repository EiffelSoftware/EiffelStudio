indexing
	description:
		"Facilities for pick and drop mechanism.%N%
		%Decendents can act both as pick and drop sources and as targets.%N%
		%When the user picks a `pebble' from a source and drops on a target,%
		%the `drop_actions' of the target receive the `pebble' as input.%N%
		%The user interface can be either pick and drop or drag and drop,%
		%selected by `set_pick_and_drop' and `set_drag_and_drop'."
	example:
		"Create two buttons one with the string %"Hello world!%" as pebble%
		%and the other with io~put_string as a drop action.%N%
		%Picking the first button and dropping on the second will print:%N%
		%%"Hello world!%".%N%
		%b1, b2: BUTTON%N%
		%create b1; create b2%N%
		%b1.set_pebble (%"Hello world!%")%N%
		%b2.drop_actions.extend (io~put_string)"
	status: "See notice at end of class"
	keywords: "pick and drop, drag and drop, source, PND, DND"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_PICK_AND_DROPABLE

inherit
	EV_ANY
		redefine
			implementation,
			is_in_default_state
		end

	EV_ABSTRACT_PICK_AND_DROPABLE
		undefine
			default_create,
			is_equal,
			copy
		redefine
			set_pebble_function
		end

	EV_PICK_AND_DROPABLE_ACTION_SEQUENCES
		redefine
			implementation
		end

feature -- Access

	pebble: ANY is
		-- Data to be transported by pick and drop mechanism.
		do
			check
				not_destroyed: not is_destroyed
			end
			Result := implementation.pebble
		ensure then
			bridge_ok: Result = implementation.pebble
		end

	pebble_function: FUNCTION [ANY, TUPLE [], ANY] is
			-- Returns data to be transported by pick and drop mechanism.
		do
			check
				not_destroyed: not is_destroyed
			end
			Result := implementation.pebble_function
		ensure then
			bridge_ok: Result = implementation.pebble_function
		end

	pebble_x_position: INTEGER is
			-- Initial x position for pick and drop relative to `Current'.
		do
			check
				not_destroyed: not is_destroyed
			end
			Result := implementation.pebble_x_position
		ensure then
			bridge_ok: Result = implementation.pebble_x_position
		end

	pebble_y_position: INTEGER is
			-- Initial y position for pick and drop relative to `Current'.
		do
			check
				not_destroyed: not is_destroyed
			end
			Result := implementation.pebble_y_position
		ensure then
			bridge_ok: Result = implementation.pebble_y_position
		end

	pebble_positioning_enabled: BOOLEAN is
			-- If `True' then pick and drop start coordinates are
			-- `pebble_x_position', `pebble_y_position'.
			-- If `False' then pick and drop start coordinates are
			-- the pointer coordinates.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.pebble_positioning_enabled
		ensure then
			bridge_ok: Result = implementation.pebble_positioning_enabled
		end

	accept_cursor: EV_CURSOR is
			-- `Result' is cursor displayed when the screen pointer is over a
			-- target that accepts `pebble' during pick and drop.
		do
			check
				not_destroyed: not is_destroyed
			end
			Result := implementation.accept_cursor
		ensure then
			bridge_ok: Result = implementation.accept_cursor
		end

	deny_cursor: EV_CURSOR is
			-- `Result' is cursor displayed when the screen pointer is over a
			-- target that does not accept `pebble' during pick and drop.
		do
			check
				not_destroyed: not is_destroyed
			end
			Result := implementation.deny_cursor
		ensure then
			bridge_ok: Result = implementation.deny_cursor
		end


feature -- Status setting

	set_pebble (a_pebble: like pebble) is
			-- Assign `a_pebble' to `pebble'.
			-- Overrides `set_pebble_function'.
		do
			check
				not_destroyed: not is_destroyed
			end
			implementation.set_pebble (a_pebble)
		end

	remove_pebble is
			-- Make `pebble' `Void' and `pebble_function' `Void,
			-- Removing transport.
		do
			check
				not_destroyed: not is_destroyed
			end
			implementation.remove_pebble
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
		do
			check
				not_destroyed: not is_destroyed
			end
			implementation.set_pebble_function (a_function)
		end

	set_pick_and_drop_mode is
			-- Set user interface mode to pick and drop.
		require
			not_destroyed: not is_destroyed
		do
			implementation.set_pick_and_drop_mode
		ensure
			pick_and_drop_set: mode_is_pick_and_drop
		end

	set_drag_and_drop_mode is
			-- Set user interface mode to drag and drop.
		require
			not_destroyed: not is_destroyed
		do
			implementation.set_drag_and_drop_mode
		ensure
			drag_and_drop_set: mode_is_drag_and_drop
		end

	set_target_menu_mode is
			-- Set user interface mode to pop-up menu of targets.
		require
			not_destroyed: not is_destroyed
		do
			implementation.set_target_menu_mode
		ensure
			target_menu_mode_set: mode_is_target_menu
		end

	set_pebble_position (a_x, a_y: INTEGER) is
			-- Set the initial position for pick and drop
			-- Coordinates are in pixels and are relative to position of `Current'.
			-- Pebble_positioning_enabled must be `True' for the position to be used,
			-- use enable_pebble_positioning.
		require
			not_destroyed: not is_destroyed
		do
			implementation.set_pebble_position (a_x, a_y)
		ensure
			pebble_position_assigned: pebble_x_position = a_x and
				pebble_y_position = a_y
		end

	set_accept_cursor (a_cursor: EV_CURSOR) is
			-- Set `a_cursor' to be displayed when the screen pointer is over a
			-- target that accepts `pebble' during pick and drop.
		do
			check
				not_destroyed: not is_destroyed
			end
			implementation.set_accept_cursor (a_cursor)
		end

	set_deny_cursor (a_cursor: EV_CURSOR) is
			-- Set `a_cursor' to be displayed when the screen pointer is not
			-- over a valid target.
		do
			check
				not_destroyed: not is_destroyed
			end
			implementation.set_deny_cursor (a_cursor)
		end

	enable_pebble_positioning is
			-- Assign `True' to `pebble_positioning_enabled'.
			-- Use `pebble_x_position' and `pebble_y_position' as the initial coordinates
			-- for the pick and drop in pixels relative to `Current'.
		require
			not_destroyed: not is_destroyed
		do
			implementation.enable_pebble_positioning
		ensure
			pebble_positioning_updated: pebble_positioning_enabled
		end

	disable_pebble_positioning is
			-- Assign `False' to `pebble_positioning_enabled'.
			-- The pick and drop will start at the pointer position.
		require
			not_destroyed: not is_destroyed
		do
			implementation.disable_pebble_positioning
		ensure
			pebble_positioning_updated: not pebble_positioning_enabled
		end

feature -- Status report

	mode_is_pick_and_drop: BOOLEAN is
			-- Is the user interface mode pick and drop?
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.mode_is_pick_and_drop
		ensure then
			bridge_ok: Result = implementation.mode_is_pick_and_drop
		end

	mode_is_drag_and_drop: BOOLEAN is
			-- Is the user interface mode drag and drop?
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.mode_is_drag_and_drop
		ensure then
			bridge_ok: Result = implementation.mode_is_drag_and_drop
		end

	mode_is_target_menu: BOOLEAN is
			-- Is the user interface mode a pop-up menu of targets?
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.mode_is_target_menu
		ensure then
			bridge_ok: Result = implementation.mode_is_target_menu
		end

feature {NONE} -- Contract support
	
	is_in_default_state: BOOLEAN is
			-- Is `Current' in its default state?
		do
			Result := Precursor {EV_ANY} and mode_is_pick_and_drop
				and pebble = Void
		end

feature {EV_ANY_I} -- Implementation

	implementation: EV_PICK_AND_DROPABLE_I
			-- Responsible for interaction with native graphics toolkit.

invariant
	user_interface_modes_mutually_exclusive:
		mode_is_pick_and_drop.to_integer +
		mode_is_drag_and_drop.to_integer +
		mode_is_target_menu.to_integer = 1

end -- class EV_PICK_AND_DROPABLE

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

