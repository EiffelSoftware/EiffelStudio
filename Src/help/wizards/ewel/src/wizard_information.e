indexing
	description	: "All information about the wizard ... This class is inherited in each state "
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author		: "davids"
	date		: "$Date$"
	revision	: "$Revision$"

class
	WIZARD_INFORMATION

inherit
	BENCH_WIZARD_INFORMATION
		redefine
			make
		end

creation
	make

feature  -- Initialization

	make is
			-- Assign default values
		local
			icon_path: FILE_NAME
		do
			Precursor

			create icon_path.make_from_string (wizard_resources_path)
			icon_path.set_file_name ("eiffel")
			icon_path.add_extension ("ico")
			set_icon_location (icon_path)

			set_dialog_application (False)
		end

feature -- Setting

	set_dialog_application (b: BOOLEAN) is
		do
			dialog_application := b
		end

	set_icon_location (s: STRING) is
		do
			icon_location := s
		end

feature -- Access

	icon_location: STRING
			-- Location of the icon choose by the user
	
	dialog_application: BOOLEAN
			-- Does the user want to generate a dialog application

feature {NONE} -- Implementation

	Default_project_name: STRING is
			-- Default project name
		do
			Result := "my_wel_application"
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
end -- class WIZARD_INFORMATION
