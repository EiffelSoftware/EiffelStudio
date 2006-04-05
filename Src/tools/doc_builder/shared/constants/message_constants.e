indexing
	description: "Message string constants for dialogs, windows, etc."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	MESSAGE_CONSTANTS

feature -- Title

	invalid_files_title: STRING is
			-- Invalid files dialog title text
		once
			Result := "Invalid files"
		end

	invalid_xml_dialog_title: STRING is
			-- Invalid XML dialog title text
		once
			Result := "Invalid XML"
		end

	invalid_project_name_title: STRING is
			-- Invalid project name dialog title
		once
			Result := "Unable to create project"
		end	

	report_title: STRING is
			-- Report title
		once
			Result := "Report"
		end
	
	help_generation_progress_title: STRING is
			-- Help generation progress notice
		once
			Result := "Generating Help"
		end	

	empty_toc_title: STRING is
			-- Empty TOC title
		once
			Result := "Empty Table of Contents"
		end	

feature -- Messages

	file_schema_valid_report: STRING is
			-- Schema valid file
		once
			Result := "File valid to schema"
		end

	file_save_prompt: STRING is
			-- File save prompt
		once
			Result := "Document has not been saved since last edit.%NDo you want to save?"	
		end		

	invalid_xml_file_warning: STRING is 
			-- Text in context is not XMl valid
		once
			Result := "The text is not valid XML"	
		end

	invalid_project_name: STRING is
			-- Invalid project name
		once
			Result := "Empty project or path.  %NCannot create project"
		end	

	invalid_project_files_warning: STRING is
			-- Invalid project files warning
		once
			Result := "Some of the files in your project are not valid to your schema definition.%N%
				%Do you wish to continue?"	
		end

	invalid_project_files_toc_warning: STRING is
			-- Invalid project files warning for TOC rendering
		once
			Result := "Some of the files in your project are not valid to your schema definition.%N%
				%As a result the Table of Contents tree displayed here may not accurately%N%
				%represent a generated one.  Additionally generation will be slower.  Do you wish to continue?"	
		end

	document_name_change_warning: STRING is
			-- Warning for attempted document name change
		once
			Result := "You are trying to change the name of this document.  If you proceed links%N%
				%to this document from other documents will not work.  DocBuilder can attempt to%N%
				%fix these links automatically.  What would you like to do?"
		end

	help_generation_progress: STRING is
			-- Help generation progress notice
		once
			Result := "Help is being generated...please wait"
		end

	valid_files: STRING is
			-- Valid files
		once
			Result := "All files are valid"			
		end

	unknown_toc_title: STRING is
			-- Unknown TOC title
		once
			Result := "!Unknown Title!"
		end

	directory_not_exist: STRING is
			-- Unknown directory
		once
			Result := "Directory does not exist."
		end

	empty_location: STRING is
			-- Empty location
		once
			Result := "Location is empty.  Please choose a%Nlocation to generate the files."
		end
			
	empty_toc: STRING is 
			-- Empty location
		once
			Result := 
				"The generated Table of contents is empty.  Possible reasons for this are:%N%N%
				%- There are no directories with a index file%N%
				%- You have chosen to ignore sub-directories inside empty directories and have no%N%
				%  top level directories with content%N%
				%- The project is empty%N%N%
				%Please check your project and generation settings and try again."	
		end
		
	html_pre_tag_warning: STRING is
			-- Warning when attempting to auto-format tag containing 'pre' text
		once
			Result := "The text selected for formatting contains tags which %N%
				%apply their own formatting options.  If you continue this formatting will%N%
				%lost.  Do you wish to continue anyway?"
		end

	empty_html_document: STRING is
			-- Empty HTML document
		once
			Result := "Error: After filtering the document the content is empty.%N%
					%Possible reason for this are:%
					%<ul><li>The document does not contain any content associated with the output filter selected </li>%
					%<li>The originating document is not saved to disk yet</li>%
					%<li>The originating document is not valid XML</li>%
					%</list>"
		end		

feature -- Command prompt messages

	invalid_project_file: STRING is
			-- Invalid project file argument
		once
			Result := "Missing or invalid project file.  For usage details enter %"docbuilder -h%""
		end
		
	no_generation_type: STRING is
			-- No generation argument type
		once
			Result := "No generation options specified for generation.  For usage details enter %"docbuilder -h%""
		end
		
	command_read_line: STRING is
			-- Readline prompt
		once
			Result := "Press enter to terminate application..."
		end

	missing_xsl: STRING is
			-- Missing XSL
		once
			Result := "Could not find XSL file"
		end
		
	missing_schema: STRING is
			-- Readline promt
		once
			Result := "Could not find schema file"
		end

	output_report_header: STRING is
			-- Header for new output report
		local
			l_date_time: DATE_TIME
		once
			create l_date_time.make_now
			Result := "%N%N%N---------------------------------------------------------------------------%N%
				%DocBuilder output report for system execution on " +
				(l_date_time.date.out) + " " +
				(l_date_time.time.out) + 
				"%N---------------------------------------------------------------------------%N%N"
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
end -- class MESSAGE_CONSTANTS
