note
	description: "[
		User interface related constants.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author     : "$Author$"
	date       : "$Date$"
	revision   : "$Revision$"

class
	EC_CHECKER_CONSTANTS

inherit
	EC_CHECKER_CONSTANTS_IMP
		redefine
			pixmaps
		end

feature -- Directories

	application_directory: STRING 
			-- Directory where application is located
		local
			l_args: ARGUMENTS
			l_path: STRING
			i: INTEGER
		once
			create l_args
			l_path := l_args.argument (0)
			i := l_path.last_index_of ('\', l_path.count)
			if i > 1 then
				l_path.keep_head (i)
			end
			create Result.make (l_path.count + 9)
			Result.append (l_path)
		ensure
			result_not_void: Result /= Void
			not_result_is_empty: not Result.is_empty
		end
		
	help_file: STRING
			-- Complied help file name
		once
			create Result.make (application_directory.count + 13)
			Result.append (application_directory)
			Result.append ("help\help.chm")
		ensure
			result_not_void: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

	pixmaps: STRING
			-- `Result' is DIRECTORY constant named `pixmaps'.
		once
			create Result.make (application_directory.count + 9)
			Result.append (application_directory)
			Result.append ("resources")
		end

feature -- Tooltip

	tooltip_reference_path_not_found: STRING = "The specified reference path cannot be found!"
	tooltip_browse_for_reference_path: STRING = "Browse for a assembly reference path."
	
	tooltip_interface_illegally_compliant: STRING = "Type's public interface contains non-CLS-compliant members but is declared as CLS-compliant!"
	tooltip_type_is_cls_compliant: STRING = "Type is CLS-compliant"
	tooltip_type_is_eiffel_compliant: STRING = "Type is Eiffel-compliant"
	tooltip_type_is_marked: STRING = "Type has been marked, either at the type or assembly level,%Nwith the System.ClsCompliantAttribute attribute"
	tooltip_type_is_not_marked: STRING = "Type has *not* been marked with the System.ClsCompliantAttribute attribute"

	tooltip_member_is_cls_compliant: STRING = "Member is CLS-compliant"
	tooltip_member_is_eiffel_compliant: STRING = "Member is Eiffel-compliant"
	tooltip_member_is_marked: STRING = "Member has been marked, either at the memeber, type or assembly level,%Nwith the System.ClsCompliantAttribute attribute"
	tooltip_member_is_not_marked: STRING = "Member has *not* been marked with the System.ClsCompliantAttribute attribute"

feature -- Labels

	label_path: STRING = "Path"
	label_type_feature: STRING = "Type/Feature"
	label_cls_compliant: STRING = "CLS"
	label_eiffel_compliant: STRING = "Eiffel"
	label_marked: STRING = "Marked"

feature -- Messages

	question_new_project: STRING = "Are you sure you want to create a new project?"
	question_close_project_not_save: STRING = "The current project has been modified%NAre you sure you want to close the application?"
	question_check_completed: STRING = "Assembly has been fully checked."
	
	information_no_non_compliant_member: STRING = "The assembly has been fully checked and no%Nnon-complaint members were found."

	error_cannot_find_help_file: STRING = "The find help documentation file:%N%N%T{1}"
	error_help_launch_failed: STRING = "Failed to launch help documentation for:%N%N%T{1}%N%NPlease ensure the help launcher %%SystemRoot%%\hh.exe exists!"
	error_already_added: STRING = "The selected reference path has already been added."
	error_assembly_not_specified: STRING = "You have not specified an assembly to check!"
	error_could_not_find_assembly: STRING = "The specified assembly could not be found:%N%N%TPath: {1}"
	error_could_not_load_assembly: STRING = "The specified assembly, or one of its dependendies, could not be loaded:%N%N%TAssembly: {1}%N%NPlease ensure that the specified assembly exists and is a valid .NET assembly.%NPlease also ensure that any dependencies can be located in the project reference paths."
	error_report_generation_failed: STRING = "The report was not successfully generated.%NThe following .NET exception occurred:%N%N{1}"
	error_export_failed: STRING = "Exporting the report failed:%N%N{1}"
	
	warning_new_project_unsaved: STRING = "This project has been modified since it was last saved.%NDo you want to continue creating a new project?"
	
feature -- Dialog Title/Filters

	title_browse_for_assembly: STRING = "Please select an assembly to check Eiffel-compliance for"
	title_browse_for_reference_path: STRING = "Please select a reference location"
	title_browse_export_file_name: STRING = "Please choose a file name to export the report to"
	
	filter_name_project: STRING = "Eiffel-Compliance Project (*.ecmp)"
	filter_project: STRING = "*.ecmp"	
	
	filter_name_assembly: STRING = "Assembly (*.exe; *.dll)"
	filter_assembly: STRING = "*.exe; *.dll"

	filter_name_xml_files: STRING = "Xml Document (*.xml)"
	filter_xml_files: STRING = "*.xml"
	
	filter_name_all_files: STRING = "All Files (*.*)"
	filter_all_files: STRING = "*.*";
	
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
end -- class EC_CHECKER_CONSTANTS
