indexing

	description:
		"Put your description here."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class TWO_STATE_CMD_HOLDER

inherit
	EB_HOLDER
		rename
			set_selected as change_state
		redefine
			change_state, associated_command
		end

create
	make, make_plain

feature -- State Changing

	change_state (b: BOOLEAN) is
			-- Change pixmap on `associated_button' to
			-- reflect `b'.
		do
			if b then
				associated_button.set_insensitive
				if associated_button.pixmap /= associated_command.inactive_symbol then
					associated_button.set_symbol (associated_command.inactive_symbol)
				end	
			else
				associated_button.set_sensitive
				if associated_button.pixmap /= associated_command.active_symbol then
					associated_button.set_symbol (associated_command.active_symbol)
				end
			end
		end

feature -- Access

	associated_command: TWO_STATE_CMD;

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

end -- class TWO_STATE_CMD_HOLDER
