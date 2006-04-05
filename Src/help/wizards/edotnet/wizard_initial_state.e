indexing
	description	: "Initial State"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author		: "Arnaud PICHERY [aranud@mail.dotcom.fr]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	WIZARD_INITIAL_STATE

inherit
	BENCH_WIZARD_INITIAL_STATE_WINDOW
		redefine
			proceed_with_current_info,
			make
		end

creation
	make

feature {NONE} -- Implementation

	make (an_info: like wizard_information) is
			-- Set `help_filename' with `h_filename'.
		do
			set_help_filename (h_filename)
			Precursor {BENCH_WIZARD_INITIAL_STATE_WINDOW} (an_info)
		end

feature -- Access

	h_filename: STRING is "help/wizards/edotnet/docs/reference/01_welcome/index.html"
			-- Path to HTML help file

feature -- basic Operations

	proceed_with_current_info is 
		do
			Precursor
			proceed_with_new_state(Create {DOTNET_WIZARD_PROJECT_NAME_AND_LOCATION_STATE}.make(wizard_information))
		end

	display_state_text is
			-- Dispay the text for the current state.
		do
			title.set_text (Interface_names.m_Welcome_title)
			message.set_text (Interface_names.m_Welcome_message)
		end

	pixmap_icon_location: FILE_NAME is
			-- Icon for the Eiffel Dotnet Wizard.
		once
			 create Result.make_from_string (Wizard_icon_name)
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
