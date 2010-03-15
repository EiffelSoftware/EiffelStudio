note
	description:
		"Facilities for pick and drop mechanism.%N%
		%Decendents can act both as pick and drop sources and as targets.%N%
		%When the user picks a `pebble' from a source and drops on a target,%
		%the `drop_actions' of the target receive the `pebble' as input.%N%
		%The user interface can be either pick and drop or drag and drop,%
		%selected by `set_pick_and_drop' and `set_drag_and_drop'."
	legal: "See notice at end of class."
	example:
		"Create two buttons one with the string %"Hello world!%" as pebble%
		%and the other with agent io.put_string as a drop action.%N%
		%Picking the first button and dropping on the second will print:%N%
		%%"Hello world!%".%N%
		%b1, b2: BUTTON%N%
		%create b1; create b2%N%
		%b1.set_pebble (%"Hello world!%")%N%
		%b2.drop_actions.extend (agent io.put_string)"
	status: "See notice at end of class."
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

	EV_POSITIONED
		undefine
			initialize
		redefine
			implementation,
			is_in_default_state
		end

	EV_PICK_AND_DROPABLE_ACTION_SEQUENCES
		redefine
			implementation
		end

feature -- Access

	pebble: ANY
		-- Data to be transported by pick and drop mechanism.
		do
			check
				not_destroyed: not is_destroyed
			end
			Result := implementation.pebble
		ensure then
			bridge_ok: Result = implementation.pebble
		end

	pebble_function: FUNCTION [ANY, TUPLE, ANY]
			-- Returns data to be transported by pick and drop mechanism.
		do
			check
				not_destroyed: not is_destroyed
			end
			Result := implementation.pebble_function
		ensure then
			bridge_ok: Result = implementation.pebble_function
		end

	pebble_x_position: INTEGER
			-- Initial x position for pick and drop relative to `Current'.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.pebble_x_position
		ensure then
			bridge_ok: Result = implementation.pebble_x_position
		end

	pebble_y_position: INTEGER
			-- Initial y position for pick and drop relative to `Current'.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.pebble_y_position
		ensure then
			bridge_ok: Result = implementation.pebble_y_position
		end

	pebble_positioning_enabled: BOOLEAN
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

	accept_cursor: EV_POINTER_STYLE
			-- `Result' is cursor displayed when the screen pointer is over a
			-- target that accepts `pebble' during pick and drop.
		local
			l_result: detachable EV_POINTER_STYLE
		do
			check
				not_destroyed: not is_destroyed
			end
			l_result := implementation.accept_cursor
			if l_result = Void then
				Result := Default_pixmaps.Standard_cursor
			else
				Result := l_result
			end
		ensure then
			cursor_valid: (attached implementation.accept_cursor implies Result = implementation.accept_cursor) or else Result = Default_pixmaps.standard_cursor
		end

	deny_cursor: EV_POINTER_STYLE
			-- `Result' is cursor displayed when the screen pointer is over a
			-- target that does not accept `pebble' during pick and drop.
		local
			l_result: detachable EV_POINTER_STYLE
		do
			check
				not_destroyed: not is_destroyed
			end
			l_result := implementation.deny_cursor
			if l_result = Void then
				Result := Default_pixmaps.No_cursor
			else
				Result := l_result
			end
		ensure then
			cursor_valid: (attached implementation.deny_cursor implies Result = implementation.deny_cursor) or else Result = Default_pixmaps.no_cursor
		end


	configurable_target_menu_handler: PROCEDURE [ANY, TUPLE [menu: EV_MENU; target_list: ARRAYED_LIST [EV_PND_TARGET_DATA]; source: EV_PICK_AND_DROPABLE; source_pebble: ANY]]
			-- Agent used for customizing the Pick and Drop Target Menu of `Current'.
		do
			Result := implementation.configurable_target_menu_handler
		end

feature -- Status setting

	set_pebble (a_pebble: like pebble)
			-- Assign `a_pebble' to `pebble'.
			-- Overrides `set_pebble_function'.
		do
			check
				not_destroyed: not is_destroyed
			end
			implementation.set_pebble (a_pebble)
		end

	remove_pebble
			-- Make `pebble' `Void' and `pebble_function' `Void,
			-- Removing transport.
		do
			check
				not_destroyed: not is_destroyed
			end
			implementation.remove_pebble
		end

	set_pebble_function (a_function: FUNCTION [ANY, TUPLE, ANY])
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

	set_pick_and_drop_mode
			-- Set user interface mode to pick and drop.
		require
			not_destroyed: not is_destroyed
		do
			implementation.set_pick_and_drop_mode
		ensure
			pick_and_drop_set: mode_is_pick_and_drop
		end

	set_drag_and_drop_mode
			-- Set user interface mode to drag and drop.
		require
			not_destroyed: not is_destroyed
		do
			implementation.set_drag_and_drop_mode
		ensure
			drag_and_drop_set: mode_is_drag_and_drop
		end

	set_target_menu_mode
			-- Set user interface mode to pop-up menu of targets.
		require
			not_destroyed: not is_destroyed
		do
			implementation.set_target_menu_mode
		ensure
			target_menu_mode_set: mode_is_target_menu
		end

	set_configurable_target_menu_mode
			-- Set user interface mode to pop-up menu of targets.
			-- Target menu is configurable as the first option can be used to
			-- initiate a regular 'pick and drop' of the source pebble.
		require
			not_destroyed: not is_destroyed
		do
			implementation.set_configurable_target_menu_mode
		ensure
			target_menu_mode_set: mode_is_configurable_target_menu
		end

	set_configurable_target_menu_handler (a_handler: PROCEDURE [ANY, TUPLE [menu: EV_MENU; target_list: ARRAYED_LIST [EV_PND_TARGET_DATA]; source: EV_PICK_AND_DROPABLE; source_pebble: ANY]])
			-- Set Configurable Target Menu Handler to `a_handler'.
		do
			implementation.set_configurable_target_menu_handler (a_handler)
		ensure
			configurable_target_menu_hander_assigned: configurable_target_menu_handler = a_handler
		end

	set_pebble_position (a_x, a_y: INTEGER)
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

	set_accept_cursor (a_cursor: like accept_cursor)
			-- Set `a_cursor' to be displayed when the screen pointer is over a
			-- target that accepts `pebble' during pick and drop.
		do
			check
				not_destroyed: not is_destroyed
			end
			implementation.set_accept_cursor (a_cursor)
		end

	set_deny_cursor (a_cursor: like deny_cursor)
			-- Set `a_cursor' to be displayed when the screen pointer is not
			-- over a valid target.
		do
			check
				not_destroyed: not is_destroyed
			end
			implementation.set_deny_cursor (a_cursor)
		end

	enable_pebble_positioning
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

	disable_pebble_positioning
			-- Assign `False' to `pebble_positioning_enabled'.
			-- The pick and drop will start at the pointer position.
		require
			not_destroyed: not is_destroyed
		do
			implementation.disable_pebble_positioning
		ensure
			pebble_positioning_updated: not pebble_positioning_enabled
		end

	show_configurable_target_menu (a_x, a_y: INTEGER)
			-- Show the configurable target menu at position `a_x', `a_y' relative to `Current'.
		require
			not_destroyed: not is_destroyed
			mode_is_configurable_target_menu: mode_is_configurable_target_menu
			configurable_menu_handler_set: configurable_target_menu_handler /= Void
		do
			implementation.show_configurable_target_menu (a_x, a_y)
		end

feature -- Status report

	mode_is_pick_and_drop: BOOLEAN
			-- Is the user interface mode pick and drop?
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.mode_is_pick_and_drop
		ensure then
			bridge_ok: Result = implementation.mode_is_pick_and_drop
		end

	mode_is_drag_and_drop: BOOLEAN
			-- Is the user interface mode drag and drop?
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.mode_is_drag_and_drop
		ensure then
			bridge_ok: Result = implementation.mode_is_drag_and_drop
		end

	mode_is_target_menu: BOOLEAN
			-- Is the user interface mode a pop-up menu of targets?
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.mode_is_target_menu
		ensure then
			bridge_ok: Result = implementation.mode_is_target_menu
		end

	mode_is_configurable_target_menu: BOOLEAN
			-- Is the user interface mode a configurable pop-up menu of targets?
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.mode_is_configurable_target_menu
		ensure then
			bridge_ok: Result = implementation.mode_is_configurable_target_menu
		end

feature {NONE} -- Contract support

	is_in_default_state: BOOLEAN
			-- Is `Current' in its default state?
		do
			Result := Precursor {EV_ANY} and Precursor {EV_POSITIONED} and mode_is_pick_and_drop
				and pebble = Void
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	implementation: EV_PICK_AND_DROPABLE_I
			-- Responsible for interaction with native graphics toolkit.

invariant
	user_interface_modes_mutually_exclusive:
		mode_is_pick_and_drop.to_integer +
		mode_is_drag_and_drop.to_integer +
		mode_is_target_menu.to_integer = 1

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




end -- class EV_PICK_AND_DROPABLE

