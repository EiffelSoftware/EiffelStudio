indexing

	description:
		"A tool button for the preference tool."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class PREFERENCE_BUTTON

inherit
	ISE_BUTTON
		rename
			make as ise_button_make
		end

feature {NONE} -- Initialization

	make (cmd: PREFERENCE_CATEGORY; a_parent: COMPOSITE) is
			-- Initialize Current
		do
			ise_button_make (button_name, a_parent);
			set_focus_string (cmd.name)
			set_symbol (cmd.symbol);
			add_activate_action (cmd, cmd.name);
			initialize_focus 
		end

feature -- Access

	symbol: PIXMAP is
			-- Not needed
		do
		end

feature -- Status Setting

	set_selected (b: BOOLEAN) is
		do
			set_pressed (b)
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

end -- class PREFERENCE_BUTTON
