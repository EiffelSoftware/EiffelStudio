indexing
	description: "[
		User interface related constants.
	]"
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

	pixmaps: STRING is
			-- `Result' is DIRECTORY constant named `pixmaps'.
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
			Result.append ("resources")
		end

feature -- Tooltip

	tooltip_reference_path_not_found: STRING is "The specified reference path cannot be found!"
	tooltip_browse_for_reference_path: STRING is "Browse for a assembly reference path."
	
	tooltip_interface_illegally_compliant: STRING is "Type's public interface contains non-CLS-compliant members but is declared as CLS-compliant!"
	tooltip_type_is_cls_compliant: STRING is "Type is CLS-compliant"
	tooltip_type_is_eiffel_compliant: STRING is "Type is Eiffel-compliant"
	tooltip_type_is_marked: STRING is "Type has been marked, either at the type or assembly level,%Nwith the System.ClsCompliantAttribute attribute"
	tooltip_type_is_not_marked: STRING is "Type has *not* been marked with the System.ClsCompliantAttribute attribute"

	tooltip_member_is_cls_compliant: STRING is "Member is CLS-compliant"
	tooltip_member_is_eiffel_compliant: STRING is "Member is Eiffel-compliant"
	tooltip_member_is_marked: STRING is "Member has been marked, either at the memeber, type or assembly level,%Nwith the System.ClsCompliantAttribute attribute"
	tooltip_member_is_not_marked: STRING is "Member has *not* been marked with the System.ClsCompliantAttribute attribute"

feature -- Labels

	label_path: STRING is "Path"
	label_type_feature: STRING is "Type/Feature"
	label_cls_compliant: STRING is "CLS"
	label_eiffel_compliant: STRING is "Eiffel"
	label_marked: STRING is "Marked"

feature -- Messages

	question_new_project: STRING is "Are you sure you want to create a new project?"
	question_close_project_not_save: STRING is "The current project has been modified%NAre you sure you want to close the application?"
	question_check_completed: STRING is "Assembly has been fully checked."
	
	information_no_non_compliant_member: STRING is "The assembly has been fully checked and no%Nnon-complaint members were found."

	error_already_added: STRING is "The selected reference path has already been added."
	error_assembly_not_specified: STRING is "You have not specified an assembly to check!"
	error_could_not_find_assembly: STRING is "The specified assembly could not be found:%N%N%TPath: {1}"
	error_could_not_load_assembly: STRING is "The specified assembly, or one of its dependendies, could not be loaded:%N%N%TAssembly: {1}%N%NPlease ensure that the specified assembly exists and is a valid .NET assembly.%NPlease also ensure that any dependencies can be located in the project reference paths."
	error_report_generation_failed: STRING is "The report was not successfully generated.%NThe following .NET exception occurred:%N%N{1}"
	error_export_failed: STRING is "Exporting the report failed:%N%N{1}"
	
	warning_new_project_unsaved: STRING is "This project has been modified since it was last saved.%NDo you want to continue creating a new project?"
	
feature -- Dialog Title/Filters

	title_browse_for_assembly: STRING is "Please select an assembly to check Eiffel-compliance for"
	title_browse_for_reference_path: STRING is "Please select a reference location"
	title_browse_export_file_name: STRING is "Please choose a file name to export the report to"
	
	filter_name_project: STRING is "Eiffel-Compliance Project (*.ecmp)"
	filter_project: STRING is "*.ecmp"	
	
	filter_name_assembly: STRING is "Assembly (*.exe; *.dll)"
	filter_assembly: STRING is "*.exe; *.dll"
	
	filter_name_all_files: STRING is "All Files (*.*)"
	filter_all_files: STRING is "*.*"
	
end -- class EC_CHECKER_CONSTANTS
