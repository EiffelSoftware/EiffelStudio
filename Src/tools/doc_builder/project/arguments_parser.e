indexing
	description: "Parser for command line arguments"
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
					else
						args_ok := False
					end
				elseif equal (first_char, "/") then
					flag := argument (count).substring (2, argument (count).count);
					if equal (flag, "xml2html") then
						file_generation_type := op.xml_to_html_flag
					elseif equal (flag, "html2help") then
						file_generation_type := op.html_to_help_flag
					elseif equal (flag, "xml2help") then
						file_generation_type := op.xml_to_help_flag
					elseif equal (flag, "web") then
						help_generation_type := op.web_help_flag
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
				elseif count = Argument_count then
						-- Last argument
					project_file := argument (count)			
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
			io.putstring ("			/envision	ENViSioN! specific content%N")
			io.putstring ("			/all 		Unfiltered content (default)%N")
			io.putstring ("	-t [/web /mshtml /vsip]%N")
			io.putstring ("		Types of Help generation:%N")
			io.putstring ("			/web 		HTML based help%N")
			io.putstring ("			/mshtml 	Microsoft HTML 1.x Help (.chm)%N")
			io.putstring ("			/vsip 		Microsoft Visual Studio .NET Integration Help (MSHelp 2.0)%N")
			io.putstring (" project_file	Project file to open.%N")
			io.putstring ("Press any key to finish terminate...")
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
			l_html_directory,
			l_help_directory: DIRECTORY			
			l_toc: TABLE_OF_CONTENTS		
			l_filter: DOCUMENT_FILTER
		do
			l_constants := Shared_constants.Application_constants								
				
			output_file.open_append
			output_file.put_string ("Starting generation for project with the following options:%N")
			if file_generation then
				output_file.put_string ("%TFile generation type: " + file_generation_type + "%N")
			end
			if help_generation then
				output_file.put_string ("%THelp generation type: " + help_generation_type + "%N")
			end
			if output_filtered then
				output_file.put_string ("%TFiltered for: " + output_filter_type + "%N")
			end
			
				-- Load project
			l_project := Shared_project
			report ("Loading project " + project_file + "...")
			l_project.load (project_file)
			report ("success%N")			
			create l_root_dir.make (l_project.root_directory)
			if not Shared_document_manager.has_schema then
				print (Message_constants.missing_schema)
				output_file.put_string (Message_constants.missing_schema)
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
				l_toc.sort				
				shared_constants.help_constants.set_help_toc (l_toc)
				report ("success%N")
		
					-- Generate HTML from written documentation files
				report ("Generating HTML written documentation...")
				create l_html_generator.make (l_toc.files (True), create {DIRECTORY_NAME}.make_from_string (l_html_directory.name))
				l_html_generator.generate
				report ("success%N")
				
					-- Generate HTML for libraries
				report ("Generating HTML libraries documentation...")
				generate_code_html
				report ("success%N")
			end
			
					-- Help generation
			if help_generation then
				create l_help_directory.make (l_constants.Temporary_help_directory)	
				report ("Creating directory for storage of temporary Help Project Files...")
				if l_help_directory.exists then
					l_help_directory.recursive_delete
				end
				l_help_directory.create_dir
				output_file.put_string ("success%N")
				
						-- Generate Help project from TOC						
				report ("Creating help project in " + l_constants.Temporary_help_directory + "...")
				if help_generation_type.is_equal ("mshtml") then
					l_help_project := create {HTML_HELP_PROJECT}.make (l_help_directory, l_project.name, l_toc)
				elseif help_generation_type.is_equal ("vsip") then
					l_help_project := create {MSHELP_PROJECT}.make (l_help_directory, l_project.name, l_toc)
				else
					-- TO DO: Web Help
				end
				create l_help_generator.make (l_help_project)
				l_help_generator.generate
				output_file.put_string ("success%N")
			end
			
			report ("%NGeneration completed.  Review information above in case of errors.")
			output_file.close
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
			-- show help?	

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
			output_file.put_string (a_message)
			debug ("console_output")
				print (a_message)
			end
		end		

end -- class ARGUMENTS_PARSER
