note
	description: "Editable grid item used in Info tool."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_EIS_GRID_EDITABLE_ITEM

inherit
	EV_GRID_EDITABLE_ITEM
		redefine
			handle_key
		end

create
	default_create,
	make_with_text

feature -- Element change

	set_key_press_action (a_action: like key_press_action)
			-- Set `key_press_action' with `a_action'
		do
			key_press_action := a_action
		end

feature {NONE} -- Implementation

	handle_key (a_key: EV_KEY)
			-- Handle the Escape key for cancelling activation.
		do
			Precursor {EV_GRID_EDITABLE_ITEM} (a_key)
			if attached key_press_action as l_action then
				l_action.call ([a_key])
			end
		end

feature {NONE} -- Access

	key_press_action: detachable PROCEDURE [ANY, TUPLE [key: EV_KEY]];
			-- Actions to be performed when a keyboard key is pressed on the choice list.

note
	copyright: "Copyright (c) 1984-2011, Eiffel Software"
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
