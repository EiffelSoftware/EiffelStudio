indexing
	description: "Enable or disable the edit text field where the user can put%
			%the inlining size."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	INLINING_ACE_COMMAND

inherit
	COMMAND

create
	make

feature -- Initialization

	make (toggle: TOGGLE_B; edit_field: TEXT_FIELD) is
			-- Creation routine
		do
			toggle_button := toggle
			text_field := edit_field
		end

feature -- Basic operations

	execute (argument: ANY) is
			-- When the command is executed it will change the
			-- status of the edit text field where the user can
			-- put the size of the inlining.
		do
			if toggle_button.state then
				text_field.set_sensitive
			else
				text_field.set_insensitive
			end
		end

feature {NONE} -- Implementation

	text_field: TEXT_FIELD
			-- Text field where the user enters the inlining size.

	toggle_button: TOGGLE_B;
			-- Toggle button which controls the status of `text_field'.

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class INLINING_ACE_COMMAND
