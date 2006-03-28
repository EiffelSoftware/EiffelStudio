indexing
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
	EB_FILE_DIALOG_CONSTANTS

feature -- Access

	Eiffel_project_files_filter: STRING is "*.epr"
	
	Eiffel_project_files_description: STRING is "Eiffel Project Files (*.epr)"
	
	All_files_filter: STRING is "*.*"
	
	All_files_description: STRING is "All Files (*.*)"
	
	Text_files_filter: STRING is "*.txt"
	
	Text_files_description: STRING is "Text Files (*.txt)"
	
	Png_files_filter: STRING is "*.png"
	
	Png_files_description: STRING is "PNG Files (*.png)"
	
	Xml_files_filter: STRING is "*.xml"
	
	Xml_files_description: STRING is "XML Files (*.xml)"
	
	Config_files_filter: STRING is "*.acex"
	
	Config_files_description: STRING is "Eiffel Config Files (*.acex)"

	Ace_files_filter: STRING is "*.ace"
	
	Ace_files_description: STRING is "Eiffel Ace Files (*.ace)"
	
	Strong_name_key_files_filter: STRING is "*.snk"
	
	Strong_name_key_files_description: STRING is "Strong Name Key Files (*.snk)"
	
	Eiffel_class_files_filter: STRING is "*.e"
	
	Eiffel_class_files_description: STRING is "Eiffel Class Files (*.e)"
	
	Resx_files_filter: STRING is "*.resx"
	
	Resx_files_description: STRING is "Resx Files (*.resx)"
	
	Definition_files_filter: STRING is "*.def"
	
	Definition_files_description: STRING is "Dynamic Library Definition (*.def)"
	
	Dll_files_filter: STRING is "*.dll"
	
	Dll_files_description: STRING is ".NET library (*.dll)"
	
	Exe_files_filter: STRING is "*.exe"
	
	Exe_files_description: STRING is ".NET Application (*.exe)"
	
	All_assemblies_filter: STRING is "*.exe;*.dll"
	
	All_assemblies_description: STRING is "All Assemblies (*.exe; *.dll)"
	
	Profile_files_filter: STRING is "*.pfi"
	
	Profile_files_description: STRING is "Profile files (*.pfi)"
	
	supported_filters: ARRAYED_LIST [STRING] is
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

	file_description_from_filter (a_filter: STRING): STRING is
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

feature -- Status setting

	set_dialog_filters (a_dialog: EV_FILE_DIALOG; filters: ARRAY [STRING]) is
			-- Add filters to `a_dialog' corresponding to all items in `filters'.
		require
			dialog_not_void: a_dialog /= Void
			filters_not_void: filters /= Void
			filters_not_empty: not filters.is_empty
		local
			i: INTEGER
			filter: STRING
		do
				-- Remove any existing filters from `a_dialog'.
			if not a_dialog.filters.is_empty then
				a_dialog.filters.wipe_out
			end
			
			from
				i := filters.lower
			until
				i > filters.upper
			loop
				filter := filters.item (i)
				a_dialog.filters.extend ([filter, file_description_from_filter (filter)])
				i := i + 1
			end
		ensure
			filters_set: a_dialog.filters.count = filters.count
		end
		
	set_dialog_filters_and_add_all (a_dialog: EV_FILE_DIALOG; filters: ARRAY [STRING]) is
			-- Add filters to `a_dialog' corresponding to all items in `filters' and also add a final `all_files' option.
		require
			dialog_not_void: a_dialog /= Void
			filters_not_void: filters /= Void
			filters_not_empty: not filters.is_empty
		do
			set_dialog_filters (a_dialog, filters)

				-- Add all files filter.
			a_dialog.filters.extend ([all_files_filter, file_description_from_filter (all_files_filter)])
		ensure
			filters_set: a_dialog.filters.count = filters.count + 1
		end

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

end -- class EB_FILE_DIALOG_CONSTANTS
