indexing
	description	: "Initial State"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author		: "pascalf"
	date		: "$Date$"
	revision	: "$Revision$"

class
	WIZARD_INITIAL_STATE

inherit
	BENCH_WIZARD_INITIAL_STATE_WINDOW
		redefine
			proceed_with_current_info
		end
		
	WIZARD_WIZARD_CONSTANTS
		export
			{NONE} all
		end

create
	make

feature -- basic Operations

	proceed_with_current_info is 
			-- Process user entries, and perform actions accordingly.
			-- This is executed when user press 'Next'.
		do
			Precursor
			proceed_with_new_state(Create {WIZARD_PROJECT_NAME_AND_LOCATION_STATE}.make(wizard_information))
		end

	display_state_text is
			-- Display message text relative to current state.
		do
			title.set_text (Interface_names.t_Initial_state)
			message.set_text (Interface_names.m_Initial_state)
		end

	pixmap_icon_location: FILE_NAME is
			-- Icon for the Eiffel Store Wizard
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
