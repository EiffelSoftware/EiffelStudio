indexing
	description: "Parser for command line arguments"
	date: "$Date$"
	revision: "$Revision$"

class
	ARGUMENTS_PARSER

inherit
	ARGUMENTS
	
	MESSAGE_CONSTANTS
	
	SHARED_OBJECTS

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
					argument_error := (create {MESSAGE_CONSTANTS}).invalid_project_file
				end
			end
	
			if is_gui then
				args_ok := True
			elseif l_has_project then
				if file_generation and then file_generation_types.has (file_generation_type) then
					args_ok := True
				else
					argument_error := (create {MESSAGE_CONSTANTS}).no_generation_type
				end
				
				if help_generation and then not Help_generation_types.has (help_generation_type) then
					args_ok := False					
				end
				
				if output_filtered and then not Shared_constants.Application_constants.Output_list.has (output_filter_type) then
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
			count: INTEGER;
			first_char, flag: STRING;
		do
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
						file_generation_type := "xml2html"
					elseif equal (flag, "html2help") then
						file_generation_type := "html2help"
					elseif equal (flag, "xml2help") then
						file_generation_type := "xml2help"
					elseif equal (flag, "web") then
						help_generation_type := "web"
					elseif equal (flag, "mshtml") then
						help_generation_type := "mshtml"
					elseif equal (flag, "vsip") then
						help_generation_type := "vsip"
					elseif equal (flag, "studio") then
						output_filter_type := "studio"
					elseif equal (flag, "envision") then
						output_filter_type := "envision"
					elseif equal (flag, "all") then
						output_filter_type := "all"
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
			l_html_directory, l_help_directory: DIRECTORY
			l_output_file: PLAIN_TEXT_FILE
			l_toc: XML_TABLE_OF_CONTENTS
		do
			l_project := Shared_project
			l_project.load (project_file)
			l_constants := Shared_constants.Application_constants
			l_output_file := l_constants.Script_output
			l_output_file.open_append
			
					-- HTML output directory
			create l_html_directory.make (l_constants.temporary_html_directory)
			if l_html_directory.exists then
				l_html_directory.recursive_delete
			end
			l_html_directory.create_dir
			
					-- Prepare project files			
			if not Shared_document_manager.has_xsl then
				l_output_file.putstring ((create {MESSAGE_CONSTANTS}).missing_xsl)
			end
			
			if not Shared_document_manager.has_schema then
				l_output_file.putstring ((create {MESSAGE_CONSTANTS}).missing_schema)
			end
			
					-- Conversion from XML to HTML
			if file_generation_type.is_equal ("xml2html") or file_generation_type.is_equal ("xml2help") then
				l_output_file.putstring ("%NConverting XML to HTML in " + l_constants.temporary_html_directory + ":-%N")
				if output_filter_type = Void or output_filter_type.is_equal ("/all") then
--					l_constants.set_output_filter (l_constants.All_filter)
				elseif output_filter_type.is_equal ("studio") then
--					l_constants.set_output_filter (l_constants.Studio_filter)
				elseif output_filter_type.is_equal ("envision") then
--					l_constants.set_output_filter (l_constants.Envision_filter)
				end
				l_output_file.close
				create l_html_generator.make (l_toc.files, create {DIRECTORY_NAME}.make_from_string (l_html_directory.name))
				l_html_generator.generate
			end
			
					-- Help generation
			if help_generation then
				create l_help_directory.make (l_constants.Temporary_help_directory)
				l_output_file.open_append
				l_output_file.putstring ("%N%NCreating help project in " + l_constants.Temporary_help_directory + ":-%N")
				l_output_file.close
				if l_help_directory.exists then
					l_help_directory.recursive_delete
				end
				l_help_directory.create_dir
				
						-- Build TOC from XML
				-- Create TOC
				create l_toc.make_from_directory (create {DIRECTORY}.make (l_project.root_directory))
--				l_constants.set_include_skipped_sub_directories (True)
--				l_constants.set_include_empty_directories (False)
--				l_constants.set_include_directories_no_index (False)
--				l_constants.set_make_index_root (True)
--				l_constants.set_html_location (l_constants.Temporary_html_directory)
				create l_toc.make_from_directory (create {DIRECTORY}.make (l_project.root_directory))
				
						-- Generate Help from TOC
				if help_generation_type.is_equal ("mshtml") then
					l_help_project := create {HTML_HELP_PROJECT}.make (l_help_directory, l_project.name, l_toc)
				elseif help_generation_type.is_equal ("vsip") then
					l_help_project := create {MSHELP_PROJECT}.make (l_help_directory, l_project.name, l_toc)
				else
					-- TO DO: Web Help
				end
				create l_help_generator.make (l_help_project)
				l_help_generator.generate
			end
			
			l_output_file.open_append
			l_output_file.putstring ("%N%NGeneration completed.  Review information above in case of errors.")
			l_output_file.close
		end

feature {NONE} -- Commands

	terminate_with_error (a_error: STRING) is
			-- Terminate execution with `a_error' message 
		do
			io.putstring (a_error)
			io.put_new_line
			io.put_string ((create {MESSAGE_CONSTANTS}).command_read_line)
			io.read_character
			if io.last_character /= Void then
--				feature {ENVIRONMENT}.exit (0)	
			end
		end		

feature {NONE} -- Implementation
			
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

	file_generation_types: ARRAYED_LIST [STRING] is
			-- Valid file generation options
		once
			create Result.make (3)
			Result.compare_objects
			Result.extend ("xml2html")
			Result.extend ("html2help")
			Result.extend ("xml2help")
		end
		
	help_generation_types: ARRAYED_LIST [STRING] is
			-- Valid help generation options
		once
			create Result.make (3)
			Result.compare_objects
			Result.extend ("web")
			Result.extend ("mshtml")
			Result.extend ("vsip")
		end

end -- class ARGUMENTS_PARSER
