note
	description: "Summary description for {ER_CONSTANTS}."
	date: "$Date$"
	revision: "$Revision$"

class
	ER_MISC_CONSTANTS

feature -- Query

	xml_file_name: STRING = "eiffel_ribbon.xml"
			-- File name for saving ribbon makrup xml file

	bml_file_name: STRING = "ribbon.bml"
			--

	header_file_name: STRING = "ribbon.h"
			--

	rc_file_name: STRING = "eiffelribbon.rc"
			--

	project_configuration_file_name: STRING = "ribbon_project.er"
			--

	tool_info_file_name: STRING = "eiffel_ribbon_info.sed"
			--

	template: STRING = "template"
			-- Template folder name
			
	xml_full_file_name: detachable STRING_8
			-- (export status {NONE})
		local
			l_singleton: ER_SHARED_SINGLETON
			l_file_name: detachable FILE_NAME
			l_constants: ER_MISC_CONSTANTS
		do
			create l_singleton
			if attached l_singleton.Project_info_cell.item as l_info then
				if attached l_info.project_location as l_location then
					create l_file_name.make_from_string (l_location)
					create l_constants
					l_file_name.set_file_name (l_constants.Xml_file_name)
					Result := l_file_name
				end
			end
		end

	project_full_file_name: detachable STRING
			--
		local
			l_singleton: ER_SHARED_SINGLETON
			l_file_name: detachable FILE_NAME
		do
			create l_singleton
			if attached l_singleton.project_info_cell.item as l_info then
				if attached l_info.project_location as l_location and then not l_location.is_empty then
					create l_file_name.make_from_string (l_location)
					l_file_name.set_file_name (project_configuration_file_name)
				end
			end
			Result := l_file_name
		end
end
