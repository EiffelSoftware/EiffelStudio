indexing
	description: "Objects that represent the general tab in the project settings."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_SYSTEM_GENERAL_TAB

inherit
	
	GB_SYSTEM_TAB

feature {NONE} -- Initialization

	initialize is
			-- Initialize `Current' and build widget structure.
		local
			label: EV_LABEL
		do
			create label.make_with_text ("Project location:")
			extend (label)
			create location_field
			extend (location_field)
			location_field.disable_edit
			is_initialized := True
			disable_all_items (Current)
			align_labels_left (Current)
		end
		
feature -- Basic operation

	update_attributes (project_settings: GB_PROJECT_SETTINGS) is
			-- Update all attributes of `Current' to reflect information
			-- in `project_settings'.
		do
			location_field.set_text (system_status.current_project_settings.project_location)
			location_field.set_tooltip ("%"" + location_field.text + "%" (This entry is the location of the project, and may not be modified)")
		end
		
	save_attributes (project_settings: GB_PROJECT_SETTINGS) is
			-- Save all attributes of `Current' into `project_settings'.
		do
			-- Currently nothing to save, as fields in `Current'
			-- are not modifyable by the user.
		end	
	
feature -- Access

	name: STRING is "General"
		-- Name to be displayed for `Current'.
		
feature {GB_SYSTEM_WINDOW} -- Implementation

	validate is
			-- Validate input fields of `Current'.
		do
				-- There are no fields the user may
				-- modify in this tab, so validation
				-- must always succeed.
			validate_successful := True
		end
		
feature {NONE} -- Implementation

	location_field: EV_TEXT_FIELD;
		
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


end -- class GB_SYSTEM_GENERAL_TAB
