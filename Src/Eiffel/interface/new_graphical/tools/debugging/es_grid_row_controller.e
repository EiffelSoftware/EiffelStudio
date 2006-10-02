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
		redefine
			default_create
		end

	EV_SHARED_APPLICATION
		undefine
			copy, default_create
		end

create
	default_create

feature {NONE} -- Initialization

	default_create is
			-- Initialize `Current'.
		do
			create expand_actions
			create collapse_actions
		end

feature -- Change

	reset_row_actions is
		do
			expand_actions.wipe_out
			collapse_actions.wipe_out
		end

feature -- Access

	data: ANY

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

	set_data (v: like data) is
		do
			data := v
		ensure
			data = v
		end

feature -- Actions

	call_expand_actions (r: EV_GRID_ROW) is
		do
			expand_actions.call ([r])
		end

	expand_actions: EV_GRID_ROW_ACTION_SEQUENCE

	call_collapse_actions (r: EV_GRID_ROW) is
		do
			collapse_actions.call ([r])
		end

	collapse_actions: EV_GRID_ROW_ACTION_SEQUENCE

invariant
	collapse_actions /= Void
	expand_actions /= Void

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
