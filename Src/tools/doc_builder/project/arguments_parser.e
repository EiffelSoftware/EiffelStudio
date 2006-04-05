indexing
	description: "Parser for command line arguments"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ARGUMENTS_PARSER

inherit
	ARGUMENTS	
	
	SHARED_OBJECTS
	
	XML_ROUTINES
	
create
	make
	
feature -- Creation

	make is
			-- Create with `args'
		do
			parse_arguments
			process_arguments
		end		

feature -- Access

	process_arguments is
			-- Process arguments.  Set `args_ok' and `argument_error' value accordingly.
		local
			l_project: PLAIN_TEXT_FILE
			l_has_project: BOOLEAN
		do
			if display_usage_prompt then
				display_usage
			else
				if project_file /= Void then
					create l_project.make (project_file)
					if l_project.exists then
						l_has_project := True
					end
				else
					argument_error := Message_constants.invalid_project_file
				end
			end
	
			if is_gui then
				args_ok := True
			elseif l_has_project then
				if file_generation and then shared_constants.output_constants.file_generation_types.has (file_generation_type) then
					args_ok := True
				else
					argument_error := Message_constants.no_generation_type
				end
				
				if help_generation and then not shared_constants.output_constants.Help_generation_types.has (help_generation_type) then
					args_ok := False					
				end
				
				if output_filtered and then not shared_constants.output_constants.Output_list.has_item (output_filter_type) then
					args_ok := False
				end
			end
		end

	is_gui: BOOLEAN
			-- Run in graphical mode?

	args_ok: BOOLEAN
			-- Arguments valid?

	argument_error: STRING
			-- Error for wrong argument string

feature -- Commands

	parse_arguments is
			-- Parse arguments.
		local
			count: INTEGER
			first_char, flag: STRING
			op: OUTPUT_CONSTANTS
		do
			op := Shared_constants.Output_constants
			shared_constants.help_constants.set_compile (True)
			from
				count := 1
				is_gui := Argument_count = 0
			until
				count > Argument_count
			loop			
				first_char := argument (count).substring (1, 1);
				if equal (first_char, "-") then
					flag := argument (count).substring (2, argument (count).count);
					if equal (flag, "g") then						
							-- Launch GUI
						is_gui := True
					elseif equal (flag, "h") then
						display_usage_prompt := True
					elseif equal (flag, "gen") then
						file_generation := True
					elseif equal (flag, "t") then
						help_generation := True
					elseif equal (flag, "o") then
						output_filtered := True
					elseif equal (flag, "nohtml") then
						shared_constants.help_constants.set_compile (False)
					else
						args_ok := False
					end
				elseif count = Argument_count then
						-- Last argument
					project_file := argument (count)
				elseif equal (first_char, "/") then
					flag := argument (count).substring (2, argument (count).count);
					if equal (flag, "xml2html") then
						file_generation_type := op.xml_to_html_flag
					elseif equal (flag, "html2help") then
						file_generation_type := op.html_to_help_flag
					elseif equal (flag, "xml2help") then
						file_generation_type := op.xml_to_help_flag
					elseif equal (flag, "web_tree") then
						help_generation_type := op.web_help_tree_flag
					elseif equal (flag, "web_simple") then
						help_generation_type := op.web_help_simple_flag
					elseif equal (flag, "mshtml") then
						help_generation_type := op.mshtml_help_flag
					elseif equal (flag, "vsip") then
						help_generation_type := op.vsip_help_flag
					elseif equal (flag, "studio") then
						output_filter_type := op.studio_flag
					elseif equal (flag, "envision") then
						output_filter_type := op.envision_flag
					elseif equal (flag, "all") then
						output_filter_type := op.unfiltered_flag
					end							
				end
				count := count + 1
			end
		end
	
	display_usage is
		do
			io.putstring ("Usage: docbuilder [-h] [-g] [-gen /xml2html /html2help /xml2help] [-o /studio /envision /all] [-t /web /mshtml /vsip] project_file%N")
			io.putstring ("	-h	Display this help message%N")
			io.putstring ("	-g	Launch in graphical mode%N")
			io.putstring ("	-gen [/xml2html /html2help /xml2help]	Perform generation on project file%N")
			io.putstring ("		You may generate:%N")
			io.putstring ("			/xml2html 	HTML files from project XML files%N")
			io.putstring ("			/html2help 	Help project from HTML files%N")
			io.putstring ("			/xml2help 	Help project from XML files%N")
			io.putstring ("	-o [/studio /env /all] 	Output content options%N")
			io.putstring ("		Types of conversion output:%N")
			io.putstring ("			/studio 	EiffelStudio specific content%N")
			io.putstring ("			/envision	EiffelEnvision specific content%N")
			io.putstring ("			/all 		Unfiltered content (default)%N")
			io.putstring ("	-t [/web_tree /web_simple /mshtml /vsip]%N")
			io.putstring ("		Types of Help generation:%N")
			io.putstring ("			/web_tree 		HTML based help (tree toc)%N")
			io.putstring ("			/web_simple 		HTML based help (simple toc)%N")
			io.putstring ("			/mshtml 	Microsoft HTML 1.x Help (.chm)%N")			
			io.putstring ("			/vsip 		Microsoft Visual Studio .NET Integration Help (MSHelp 2.0)%N")
			io.putstring ("	-nohtml	Do not compile HTML Help project after generation")
			io.putstring (" project_file	Project file to open.%N")
			io.read_character
		end
		
	launch_command_line is
			-- Launch application from command prompt
		require
			not_gui: not is_gui
			arguments_valid: args_ok
		local
			l_project: DOCUMENT_PROJECT
			l_html_generator: HTML_GENERATOR
			l_help_generator: HELP_GENERATOR
			l_constants: APPLICATION_CONSTANTS
			l_help_project: HELP_PROJECT
			l_root_dir,
			l_html_directory: DIRECTORY			
			l_toc: TABLE_OF_CONTENTS		
			l_filter: DOCUMENT_FILTER
			l_date_time: DATE_TIME
			l_toc_files: ARRAYED_LIST [STRING]
		do
			generation_data.set_generating (True)
			l_constants := Shared_constants.Application_constants								

			report ("Starting generation for project with the following options:%N")
			if file_generation then
				report ("%TFile generation type: " + file_generation_type + "%N")
			end
			if help_generation then
				report ("%THelp generation type: " + help_generation_type + "%N")
			end
			if output_filtered then
				report ("%TFiltered for: " + output_filter_type + "%N")
			end
			
				-- Load project
			l_project := Shared_project
			report ("Loading project " + project_file + "...")
			l_project.load (project_file)
			report ("success%N")			
			create l_root_dir.make (l_project.root_directory)
			if not Shared_document_manager.has_schema then
				report (Message_constants.missing_schema)
			end
			
				-- Set content output filter
			if output_filtered then
				if output_filter_type.is_equal (shared_constants.output_constants.studio_flag) then
					l_filter := l_project.filter_manager.filter_by_description (shared_constants.output_constants.studio_desc)						
					l_project.filter_manager.set_filter (l_filter)
				elseif output_filter_type.is_equal (shared_constants.output_constants.envision_flag) then
					l_filter := l_project.filter_manager.filter_by_description (shared_constants.output_constants.envision_desc)
					l_project.filter_manager.set_filter (l_filter)
				end
			end
			
					-- Create HTML output directory
			report ("Creating directory for storage of temporary HTML...")
			create l_html_directory.make (l_constants.temporary_html_directory)
			if l_html_directory.exists then
				l_html_directory.recursive_delete
			end
			l_html_directory.create_dir
			report ("success%N")
		
					-- Conversion from XML to HTML
			if file_generation_type.is_equal ("xml2html") or file_generation_type.is_equal ("xml2help") then				
				
						-- Create TOC
				report ("Creating TOC from directory " + l_root_dir.name + "...")
				create l_toc.make_from_directory (l_root_dir)
				l_toc.set_name (help_generation_type)
				report ("success%N")

						-- Filter TOC
				if output_filter_type.is_equal (shared_constants.output_constants.studio_flag) then
						-- Studio Options
					l_toc.set_filter_alphabetically (False)
					l_toc.set_filter_nodes_no_index (True)
					l_toc.set_filter_empty_nodes (True)
					l_toc.set_filter_skipped_sub_nodes (False)
					l_toc.set_make_index_root (True)
				elseif output_filter_type.is_equal (shared_constants.output_constants.envision_flag) then
						-- ENViSioN! Options
					l_toc.set_filter_alphabetically (True)
					l_toc.set_filter_nodes_no_index (True)
					l_toc.set_filter_empty_nodes (True)
					l_toc.set_filter_skipped_sub_nodes (False)
					l_toc.set_make_index_root (True)
				end
				report ("Sorting Table of Contents...")
				shared_constants.help_constants.set_help_project_name (l_project.name)
				shared_constants.help_constants.set_help_toc (l_toc)
				if help_generation_type.is_equal ("web_tree") then										
					shared_constants.help_constants.set_help_type (shared_constants.help_constants.web_help_tree)
				elseif help_generation_type.is_equal ("web_simple") then
					shared_constants.help_constants.set_help_type (shared_constants.help_constants.web_help_simple)
				end
				l_toc.sort								
				report ("success%N")
		
					-- Generate HTML from written documentation files
				report ("Generating HTML written documentation...")
				report ("%N%TRetrieving recursive list of filenames of children for toc...")
				l_toc_files := l_toc.files (True)
				report ("complete%N")
				create l_html_generator.make (l_toc_files, create {DIRECTORY_NAME}.make_from_string (l_html_directory.name))
				l_html_generator.generate
				report ("success%N")
				
					-- Generate HTML for libraries
				report ("Generating HTML libraries documentation...")
				generate_code_html
				report ("success%N")
			end
			
					-- Help generation
			if help_generation then
				
						-- Generate Help project from TOC						
				report ("Creating help project...")
				if help_generation_type.is_equal ("mshtml") then
					l_help_project := create {HTML_HELP_PROJECT}.make (l_html_directory, l_project.name, l_toc)
					report ("success%N")
				elseif help_generation_type.is_equal ("vsip") then
					l_help_project := create {MSHELP_PROJECT}.make (l_html_directory, l_project.name, l_toc)
					report ("success%N")
				elseif help_generation_type.is_equal ("web_tree") then					
					l_help_project := create {WEB_HELP_PROJECT_TREE}.make (l_html_directory, l_project.name, l_toc)					
					shared_constants.help_constants.set_help_type (shared_constants.help_constants.web_help_tree)
					report ("success%N")
				elseif help_generation_type.is_equal ("web_simple") then					
					l_help_project := create {WEB_HELP_PROJECT_SIMPLE}.make (l_html_directory, l_project.name, l_toc)
					shared_constants.help_constants.set_help_type (shared_constants.help_constants.web_help_simple)
					report ("success%N")
				end				
				report ("Generating help from help project information...")
				create l_help_generator.make (l_help_project)
				l_help_generator.generate
				report ("success%N")
			end
			
			generation_data.set_generating (False)
			create l_date_time.make_now
			report ("%NGeneration completed.  Review information above in case of errors.  Generation completed at: " + l_date_time.date.out + " " + l_date_time.time.out + "%N")
		end

feature {NONE} -- Implementation
			
	output_file: PLAIN_TEXT_FILE is
			-- Output report file
		once
			Result :=  Shared_constants.Application_constants.Script_output
		end		
			
	file_generation: BOOLEAN
			-- Should generate files
			
	help_generation: BOOLEAN
			-- Should generate Help

	output_filtered: BOOLEAN
			-- Is content filtered

	file_generation_type: STRING
			-- Type of file generation
			
	help_generation_type: STRING
			-- Help generation type

	output_filter_type: STRING
			-- Output filter type

	project_file: STRING
			-- Project file name

	display_usage_prompt: BOOLEAN
			-- Show help?	
			
	compile_html: BOOLEAN
			-- Compile HTML Help after generation?

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
			l_curr_dir: STRING
		do
				-- Target directory for HTML
			create l_code_dir_name.make_from_string (Shared_constants.Application_constants.Temporary_html_directory)
			l_code_dir_name.extend ("libraries")		
			create l_code_target_dir.make (l_code_dir_name)
			if l_code_target_dir /= Void then
				if not l_code_target_dir.exists then
					l_code_target_dir.create_dir
				end
			end
			
				-- Src directory of XML code files				
			create l_code_dir_name.make_from_string (Shared_project.root_directory)
			l_code_dir_name.extend ("libraries")
			create l_code_dir.make (l_code_dir_name)
			
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
					l_code_dir_name.extend ("reference")
					create l_sub_dir.make (l_code_dir_name.string.twin)
					if l_sub_dir.exists then
							-- We are in `project_root/libraries/library_name/reference', a code directory
						Shared_constants.Application_constants.add_code_directory (l_sub_dir.name)
						l_code_dir_name.make_from_string (l_code_target_dir.name)
						l_code_dir_name.extend (l_curr_dir)
						l_code_dir_name.extend ("reference")
						create l_target_sub_dir.make (l_code_dir_name)
						if not l_target_sub_dir.exists then
							l_target_sub_dir.create_dir							
						end
						create l_code_html_filter.make (l_target_sub_dir, l_sub_dir)
					end
				end				
				l_cnt := l_cnt + 1
			end	
		end	
	
	message_constants: MESSAGE_CONSTANTS is
			-- Message constants
		once
			Result := Shared_constants.Message_constants
		end	

	report (a_message: STRING) is
			-- Report `a_message' to outputs
		do
			output_file.open_append
			output_file.put_string (a_message)
			output_file.close
			debug ("console_output")
				print (a_message)
			end
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
end -- class ARGUMENTS_PARSER
