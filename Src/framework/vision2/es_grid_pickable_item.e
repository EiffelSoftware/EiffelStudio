note
	description: "Grid item which supports customized defined pick behavior"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ES_GRID_PICKABLE_ITEM

feature -- Access

	grid_item: EV_GRID_ITEM
			-- Grid item
		deferred
		ensure
			result_attached: Result /= Void
		end

	last_picked_item: INTEGER
			-- Index of last picked component

	set_last_picked_item (a_index: INTEGER)
			-- Set `last_picked_item' with `a_index'.
		require
			not_a_index_is_negative: a_index >= 0
		do
			last_picked_item := a_index
		ensure
			last_picked_item_set: last_picked_item = a_index
		end

	pebble_at_position: ANY
			-- Pebble at pointer position
			-- Void if no pebble found at that position
		deferred
		end

feature -- Actions

	on_pick (a_orignal_pointer_position: EV_COORDINATE): ANY
			-- Action to be performed when pick starts
			-- Return value is the picked pebble if any.
		require
			not_void: a_orignal_pointer_position /= Void
		deferred
		end

	on_pick_ends
			-- Action to be performed hwne pick-and-drop finishes
		deferred
		end

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
