indexing
	description : "[
			Objects that control a few EV_GRID_ROW behavior (at the ROW level).
			to be linked with ES_OBJECT_GRID.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

class
	ES_GRID_ROW_CONTROLLER
inherit
	EV_GRID_HELPER

	EV_SHARED_APPLICATION
		undefine
			copy
		end

create
	default_create

feature -- Change

	reset_row_actions is
		do
			expand_action := Void
			collapse_action := Void
		end

feature -- Properties

	data: ANY
			-- Data attached to Current

feature -- Settings

	set_data (v: like data) is
		do
			data := v
		ensure
			data = v
		end

feature -- Pebble

	item_pebble_details (i: INTEGER): TUPLE [pebble: ANY; accept_cursor: EV_POINTER_STYLE; deny_cursor: EV_POINTER_STYLE] is
		do
		end

	item_pebble (i: INTEGER): ANY is
		local
			t: like item_pebble_details
		do
			t := item_pebble_details (i)
			if t /= Void then
				Result := t.pebble
			end
		end

	item_pnd_accept_cursor (i: INTEGER): EV_POINTER_STYLE is
		require
			item_pebble (i) /= Void
		local
			t: like item_pebble_details
		do
			t := item_pebble_details (i)
			if t /= Void then
				Result := t.accept_cursor
			end
		end

	item_pnd_deny_cursor (i: INTEGER): EV_POINTER_STYLE is
		require
			item_pebble (i) /= Void
		local
			t: like item_pebble_details
		do
			t := item_pebble_details (i)
			if t /= Void then
				Result := t.deny_cursor
			end
		end

	pebble: ANY is
		do
			Result := item_pebble (0)
		end

	pnd_accept_cursor: EV_POINTER_STYLE is
		require
			pebble /= Void
		do
			Result := item_pnd_accept_cursor (0)
		end

	pnd_deny_cursor: EV_POINTER_STYLE is
		require
			pebble /= Void
		do
			Result := item_pnd_deny_cursor (0)
		end

feature -- Change

	set_expand_action (a: like expand_action) is
		do
			expand_action := a
		end

	set_collapse_action (a: like collapse_action) is
		do
			collapse_action := a
		end

	set_key_pressed_action (a: like key_pressed_action) is
		do
			key_pressed_action := a
		end

feature -- Actions

	call_expand_action (r: EV_GRID_ROW) is
		do
			if expand_action /= Void then
				expand_action.call ([r])
			end
		end

	call_collapse_action (r: EV_GRID_ROW) is
		do
			if collapse_action /= Void then
				collapse_action.call ([r])
			end
		end

	call_key_pressed_action (k: EV_KEY) is
		do
			if key_pressed_action /= Void then
				key_pressed_action.call ([k])
			end
		end

feature {NONE} -- Implementation

	expand_action: PROCEDURE [ANY, TUPLE [EV_GRID_ROW]]
			-- Action to be perform on row expanded.

	collapse_action: PROCEDURE [ANY, TUPLE [EV_GRID_ROW]];
			-- Action to be perform on row collapsed.

	key_pressed_action: PROCEDURE [ANY, TUPLE [EV_KEY]];
			-- Action to be perform on key pressed.

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class ES_GRID_ROW_CONTROLLER
