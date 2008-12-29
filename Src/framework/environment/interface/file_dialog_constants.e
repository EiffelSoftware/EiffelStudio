note
	description: "[
		Objects that contain constants used with EiffelVision2 file dialogs.
		To add a new file type for use in EiffelStudio, you must declare the two constants
		of the form "*_file_filter" and "*_files_description" and update both `supported_filters'
		and `file_description_from_filter'.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	FILE_DIALOG_CONSTANTS

feature -- Access

	Eiffel_project_files_filter: STRING = "*.epr"

	Eiffel_project_files_description: STRING = "Eiffel Project Files (*.epr)"

	All_files_filter: STRING = "*.*"

	All_files_description: STRING = "All Files (*.*)"

	Text_files_filter: STRING = "*.txt"

	Text_files_description: STRING = "Text Files (*.txt)"

	Png_files_filter: STRING = "*.png"

	Png_files_description: STRING = "PNG Files (*.png)"

	Xml_files_filter: STRING = "*.xml"

	Xml_files_description: STRING = "XML Files (*.xml)"

	Config_files_filter: STRING = "*.ecf"

	Config_files_description: STRING = "Eiffel Configuration Files (*.ecf)"

	Ace_files_filter: STRING = "*.ace"

	Ace_files_description: STRING = "Eiffel Ace Files (*.ace)"

	Strong_name_key_files_filter: STRING = "*.snk"

	Strong_name_key_files_description: STRING = "Strong Name Key Files (*.snk)"

	Eiffel_class_files_filter: STRING = "*.e"

	Eiffel_class_files_description: STRING = "Eiffel Class Files (*.e)"

	Resx_files_filter: STRING = "*.resx"

	Resx_files_description: STRING = "Resx Files (*.resx)"

	Definition_files_filter: STRING = "*.def"

	Definition_files_description: STRING = "Dynamic Library Definition (*.def)"

	Dll_files_filter: STRING = "*.dll"

	Dll_files_description: STRING = ".NET library (*.dll)"

	Exe_files_filter: STRING = "*.exe"

	Exe_files_description: STRING = ".NET Application (*.exe)"

	All_assemblies_filter: STRING = "*.exe;*.dll"

	All_assemblies_description: STRING = "All Assemblies (*.exe; *.dll)"

	Profile_files_filter: STRING = "*.pfi"

	Profile_files_description: STRING = "Profile files (*.pfi)"

	supported_filters: ARRAYED_LIST [STRING]
			-- `Result' is list of all supported filters.
		do
			create Result.make (14)
			Result.compare_objects
			Result.extend (Eiffel_project_files_filter)
			Result.extend (Config_files_filter)
			Result.extend (All_files_filter)
			Result.extend (Text_files_filter)
			Result.extend (Png_files_filter)
			Result.extend (Xml_files_filter)
			Result.extend (Ace_files_filter)
			Result.extend (Strong_name_key_files_filter)
			Result.extend (Eiffel_class_files_filter)
			Result.extend (Resx_files_filter)
			Result.extend (Definition_files_filter)
			Result.extend (Dll_files_filter)
			Result.extend (Exe_files_filter)
			Result.extend (All_assemblies_filter)
			Result.extend (Profile_files_filter)
		ensure
			result_not_void: Result /= Void
		end

feature -- Status report

	file_description_from_filter (a_filter: STRING): STRING
			-- For filter `a_filter', return corresponding file description.
		require
			supported_filter: supported_filters.has (a_filter)
		do
			if a_filter.is_equal (eiffel_project_files_filter) then
				Result := eiffel_project_files_description
			elseif a_filter.is_equal (all_files_filter) then
				Result := all_files_description
			elseif a_filter.is_equal (text_files_filter) then
				Result := text_files_description
			elseif a_filter.is_equal (png_files_filter) then
				Result := png_files_description
			elseif a_filter.is_equal (xml_files_filter) then
				Result := xml_files_description
			elseif a_filter.is_equal (config_files_filter) then
				Result := config_files_description
			elseif a_filter.is_equal (ace_files_filter) then
				Result := ace_files_description
			elseif a_filter.is_equal (strong_name_key_files_filter) then
				Result := strong_name_key_files_description
			elseif a_filter.is_equal (eiffel_class_files_filter) then
				Result := eiffel_class_files_description
			elseif a_filter.is_equal (resx_files_filter) then
				Result := resx_files_description
			elseif a_filter.is_equal (definition_files_filter) then
				Result := definition_files_description
			elseif a_filter.is_equal (dll_files_filter) then
				Result := dll_files_description
			elseif a_filter.is_equal (exe_files_filter) then
				Result := exe_files_description
			elseif a_filter.is_equal (all_assemblies_filter) then
				Result := all_assemblies_description
			elseif a_filter.is_equal (profile_files_filter) then
				Result := profile_files_description
			else
				check
					unhandled_file_type: False
				end
			end
		ensure
			result_not_void: Result /= Void
		end

note
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

end -- class EB_FILE_DIALOG_CONSTANTS
