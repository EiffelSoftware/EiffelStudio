indexing
	description: "Initial State"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "davids"
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_INITIAL_STATE

inherit
	WIZARD_INITIAL_STATE_WINDOW
		redefine
			proceed_with_current_info,
			wizard_information
		end

	WIZARD_PROJECT_SHARED

create
	make

feature -- Access

	wizard_information: WIZARD_INFORMATION
			-- Information about current state.

feature -- basic Operations

	proceed_with_current_info is
		do
			Precursor
			if (eiffel_layout.eiffel_platform /= Void and eiffel_layout.eiffel_install /= Void) or else eiffel_layout.is_unix_layout then
				proceed_with_new_state (create {WIZARD_FIRST_STATE}.make(wizard_information))
			else
				proceed_with_new_state (create {WIZARD_ERROR_ENV_VAR_STATE}.make(wizard_information))
			end
		end

	display_state_text is
		do
			title.set_text (interface_names.t_welcome_to_the_wizard)
			message.set_text (interface_names.m_wizard_introduction)
		end

	pixmap_icon_location: FILE_NAME is
			-- Icon for the Eiffel Precompile Wizard
		once
			create Result.make_from_string ("eiffel_wizard_icon")
			Result.add_extension (pixmap_extension)
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
end -- class WIZARD_INITIAL_STATE
