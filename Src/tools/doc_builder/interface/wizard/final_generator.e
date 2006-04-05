indexing
	description: "Object for performing generation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	FINAL_GENERATOR

inherit	
	SHARED_OBJECTS
	
	UTILITY_FUNCTIONS

feature -- Commands

	generate is
			-- Generate
		do
			generation_data.set_generating (True)
			if generation_data.is_html_to_help_convert then
				generate_html
				generate_help						
			elseif generation_data.is_help_convert then
				generate_help
			elseif generation_data.is_html_convert then
				generate_html
			end
			copy_files
			generation_data.set_generating (False)
		end
		
feature {NONE} -- Implmentation

	generate_html is
			-- Generate HTML
		do
			generate_documentation_html
			generate_code_html
		end		

	generate_documentation_html is
			-- Generate HTML for documentation
		local
			html: HTML_GENERATOR
			l_dir_name: DIRECTORY_NAME
			l_files: ARRAYED_LIST [STRING]
			l_toc: TABLE_OF_CONTENTS
			l_toc_name: STRING
		do
			create l_dir_name.make_from_string (Shared_constants.Application_constants.Temporary_html_directory)			
			if generation_data.is_help_convert then
					-- Since we are also converting into a help project, for speed purposes 
					-- convert only the files necessary for the toc
				l_toc := Shared_constants.Help_constants.toc
				if l_toc /= Void and then shared_constants.help_constants.is_web_help then
					if (create {PLAIN_TEXT_FILE}.make (l_toc.name)).exists then
						l_toc_name := file_no_extension (short_name (l_toc.name))
						l_dir_name.extend (l_toc_name)
					else						
						l_dir_name.extend (l_toc.name)	
					end
				end
				l_files := l_toc.files (True)
			else
					-- Since there is no help project to be generated use all files in loaded project
				shared_project.load_documents
				create l_files.make_from_array (Shared_document_manager.documents.current_keys)				
			end
			create html.make (l_files, l_dir_name)
			html.generate
		end
		
	generate_code_html is
			-- Generate Eiffel code HTML
		local
			l_code_dir, 
			l_code_target_dir,
			l_sub_dir,
			l_target_sub_dir: DIRECTORY
			l_code_dir_name: FILE_NAME
			l_code_html_filter: CODE_HTML_FILTER
			l_cnt: INTEGER
			l_curr_dir,
			l_toc_name: STRING
			l_generate: BOOLEAN
		do
				-- Target directory for libraries HTML
			create l_code_dir_name.make_from_string (Shared_constants.Application_constants.Temporary_html_directory)
			if shared_constants.help_constants.is_web_help then				
				if (create {PLAIN_TEXT_FILE}.make (shared_constants.help_constants.toc.name)).exists then
					l_toc_name := file_no_extension (short_name (shared_constants.help_constants.toc.name))
					l_code_dir_name.extend (l_toc_name)
				else
					l_code_dir_name.extend (shared_constants.help_constants.toc.name)
				end
			end
			l_code_dir_name.extend ("libraries")		
			create l_code_target_dir.make (l_code_dir_name.string)
			if l_code_target_dir /= Void then
				if not l_code_target_dir.exists then
					l_code_target_dir.create_dir
				end
			end
			
				-- Src directory of XML code files				
			create l_code_dir_name.make_from_string (Shared_project.root_directory)
			l_code_dir_name.extend ("libraries")
			create l_code_dir.make (l_code_dir_name.string)
			
			if l_code_dir.exists then
					-- Build directories and code HTML into 'reference' directory of top-level cluster				
				from
					l_code_dir.open_read
					l_code_dir.start
					create l_curr_dir.make_empty
				until
					l_curr_dir = Void
				loop
					l_code_dir.readentry
					l_curr_dir := l_code_dir.lastentry
					if l_curr_dir /= Void and then not l_curr_dir.is_equal (".") and not l_curr_dir.is_equal ("..") then	
						create l_code_dir_name.make_from_string (l_code_dir.name)
						l_code_dir_name.extend (l_curr_dir)
						create l_sub_dir.make (l_code_dir_name.string)
						if l_sub_dir.exists then
							l_generate := 
								(shared_project.filter_manager.filter.description.has_substring ("EiffelEnvision") and 
								shared_constants.application_constants.envision_libraries.has (l_curr_dir)) or
								(shared_project.filter_manager.filter.description.has_substring ("EiffelStudio") and 
								shared_constants.application_constants.studio_libraries.has (l_curr_dir))
						end
						if l_generate then					
							create l_code_dir_name.make_from_string (l_code_dir.name)
							l_code_dir_name.extend (l_curr_dir)
							l_code_dir_name.extend ("reference")
							create l_sub_dir.make (l_code_dir_name.string.twin)
							if l_sub_dir.exists then
									-- We are in `project_root/libraries/library_name/reference', a code directory	
								Shared_constants.Application_constants.add_code_directory (l_sub_dir.name)
								l_code_dir_name.make_from_string (l_code_target_dir.name)
								l_code_dir_name.extend (l_curr_dir)
								create l_target_sub_dir.make (l_code_dir_name.string)
								if not l_target_sub_dir.exists then
									l_target_sub_dir.create_dir							
								end
								l_code_dir_name.extend ("reference")
								create l_target_sub_dir.make (l_code_dir_name.string)
								if not l_target_sub_dir.exists then
									l_target_sub_dir.create_dir							
								end
								create l_code_html_filter.make (l_target_sub_dir, l_sub_dir)
							end	
						end					
					end
					l_cnt := l_cnt + 1
				end		
			end
		end		
	
	generate_help is
			-- Generate help	
		local			
			help: HELP_GENERATOR
			l_loc: DIRECTORY
			l_help_settings: HELP_SETTING_CONSTANTS
			l_toc: TABLE_OF_CONTENTS
			l_name: STRING
		do			
			l_help_settings := Shared_constants.Help_constants
			l_name := l_help_settings.help_project_name
			create l_loc.make (Shared_constants.Application_constants.temporary_html_directory)
			l_toc := l_help_settings.toc
			if l_help_settings.is_html_help then
				create help.make (create {HTML_HELP_PROJECT}.make (l_loc, l_name, l_toc))
				help.generate
			elseif l_help_settings.is_vsip_help then				
				create help.make (create {MSHELP_PROJECT}.make (l_loc, l_name, l_toc))
				help.generate				
			elseif l_help_settings.is_web_help then				
				if l_help_settings.is_tree_web_help then					
					create help.make (create {WEB_HELP_PROJECT_TREE}.make (l_loc, l_name, l_toc))
				else					
					create help.make (create {WEB_HELP_PROJECT_SIMPLE}.make (l_loc, l_name, l_toc))
				end
				help.generate
			end
		end

	copy_files is
			-- Copy generated files to user chosen output directory
		local
			l_src, l_target: DIRECTORY
		do
			create l_target.make (generation_data.generated_file_location)
			if generation_data.is_html_to_help_convert then
				create l_src.make (shared_constants.application_constants.temporary_html_directory.string)				
			elseif generation_data.is_html_convert then
				create l_src.make (shared_constants.application_constants.temporary_html_directory.string)	
			end
			copy_directory (l_src, l_target)
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
end -- class FINAL_GENERATOR

