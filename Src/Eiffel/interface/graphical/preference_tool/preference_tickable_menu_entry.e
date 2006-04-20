indexing

	description:
		"Menu entry for the preference tool with a tick."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class PREFERENCE_TICKABLE_MENU_ENTRY

inherit
	TOGGLE_B
		rename
			make as button_make
		end;
	ISE_MENU_ENTRY
		redefine
			associated_command
		end

create
	make

feature -- Initialization

	make (a_cmd: like associated_command; a_parent: MENU) is
			-- Initialize the button in preference tool.
		do
			button_make (menu_entry_name, a_parent)
			set_text (a_cmd.name)
			add_activate_action (a_cmd, Void)
		end

feature -- Status setting

	set_selected (b:BOOLEAN) is
			-- Set the tick or un set it, according to `b'.
		do
			if b then
				set_toggle_on
			else
				set_toggle_off
			end
		end

feature -- Properties

	associated_command: PREFERENCE_CATEGORY is
			-- Command type that menu entry expects
		do
		end;

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

end -- class PREFERENCE_TICKABLE_MENU_ENTRY
