indexing
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_ERROR_ENV_VAR_STATE

inherit
	WIZARD_ERROR_STATE_WINDOW

	WIZARD_PROJECT_SHARED

create
	make

feature -- Access

	final_message: STRING_GENERAL is
		local
			l_str: STRING_32
		do
			create l_str.make (100)
			l_str.append (interface_names.m_following_evironment_variables_not_set)
			if eiffel_layout.eiffel_install = Void then
				l_str.append (" - ISE_EIFFEL%N")
			end
			if eiffel_layout.eiffel_platform = Void then
				l_str.append (" - ISE_PLATFORM%N")
			end
			l_str.append ("%N%N")
			l_str.append (interface_names.m_fix_and_restart)
			Result := l_str
		end

	pixmap_icon_location: FILE_NAME is
			-- Icon for the Eiffel Precompile Wizard.
		once
			create Result.make_from_string ("eiffel_wizard_icon")
			Result.add_extension (pixmap_extension)
		end

feature {NONE} -- Implementation

	display_state_text is
		do
			title.set_text (interface_names.t_variables_error)
			message.set_text (final_message)
		end

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
end -- class WIZARD_ERROR_ENV_VAR_STATE
