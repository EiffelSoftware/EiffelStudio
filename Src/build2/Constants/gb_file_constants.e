indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_FILE_CONSTANTS

feature -- Generation constants

	template_file_location: FILE_NAME is
			-- Location of templates.
		do
			create Result.make_from_string ((create {EIFFEL_ENV}).Eiffel_installation_dir_name)		
			Result.extend ("build")
			Result.extend ("templates")
		end
		

	window_template_file_name: FILE_NAME is
			-- `Result' is location of build template file,
			-- including the name.
		do
			Result := template_file_location
			Result.extend ("build_class_template.e")
		end
		
	window_template_imp_file_name: FILE_NAME is
			-- `Result' is location of build template file,
			-- including the name.
		do
			Result := template_file_location
			Result.extend ("build_class_template_imp.e")
		end
		
	application_template_file_name: FILE_NAME is
			-- `Result' is location of build application template file,
			-- including the name.
		do
			Result := template_file_location
			Result.extend ("build_application_template.e")
		end
		
	windows_ace_file_name: FILE_NAME is
			-- `Result' is location of windows ace file template.
		do
			Result := template_file_location
			Result.extend ("windows")
			Result.extend ("ace_template.ace")
		end
		
	unix_ace_file_name: FILE_NAME is
			-- `Result' is location of windows ace file template.
		do
			Result := template_file_location
			Result.extend ("Unix")
			Result.extend ("ace_template.ace")
		end
		
	eiffel_class_extension: STRING is ".e"
			-- String constant for class file extension to be used.

feature -- XML saving

	filename: FILE_NAME is
			-- File to be generated.
		local
			accessible_status: GB_SHARED_SYSTEM_STATUS
		do
			create accessible_status
			create Result.make_from_string (accessible_status.system_status.current_project_settings.project_location)
			Result.extend ("system_interface.xml")
		end		
		
	project_filename: STRING is "build_project.bpr"
		-- File name for project settings.
		
	project_file_filter: STRING is "*.bpr"
		-- Filter to be used for file dialogs searching
		-- for build projects.
		
	xml_format: STRING is "<?xml version=%"1.0%" encoding=%"UTF-8%"?>"
		-- XML format type, included at start of `document'.
		
	type_string: UCSTRING is
			-- String used to match type within XML.
		once
			create Result.make_from_string ("type")
		end
end -- class GB_FILE_CONSTANTS
