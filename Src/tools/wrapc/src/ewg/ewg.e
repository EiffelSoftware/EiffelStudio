note
	description:"[
		Command line tool that parses an (already preprocessed) C header file 
		and generates Eiffel wrappers for it
		]"
	copyright: "Copyright (c) 2004, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"


class EWG

inherit
	EWG_KERNEL
		redefine
			make,
			process_arguments
		end

	EWG_COMMAND_LINE_PARSER
		rename
			make as make_ewg_command_line_parser
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make
			--<Precursor>
			-- Prep as command line tool.
		do
			Arguments.set_program_name ("wrap_c")
			make_ewg_command_line_parser
			Precursor
		end

feature -- Basic Operations

	process_arguments
			--<Precursor>
			-- Process command line arguments passed from the operating system
			-- A simple recursive decendant parser is used (just as in gexace)
		do
			if match_long_option ("version") then
				error_handler.enable_verbose
				error_handler.report_version_message
				error_handler.disable_verbose
				Exceptions.die (0)
			end
			if match_long_option ("verbose") then
				error_handler.enable_verbose
				consume_option
			end

			Precursor
		end

	process_c_compiler_options
			--<Precursor>
		local
			l_compiler_options: like compiler_options
		do
			if match_long_option ("c_compile_options") then
				if is_next_option_long_option and then has_next_option_value then
					l_compiler_options := next_option_value
					consume_option
					from

					until
						 match_long_option ("script_pre_process") or  match_long_option ("script_post_process") or match_long_option ("output-dir") or  match_long_option ("full-header") or not has_next_option
					loop
						l_compiler_options.append (" ")
						l_compiler_options.append (next_option_value)
						consume_option
					end
				else
					report_missing_command_line_parameter_value_error ("--c_compile_options=<...>")
					report_usage_error
					exceptions_die
				end
			end
			compiler_options := l_compiler_options
		end

	process_extension_scripts_options
			--<Precursor>
		do
			if match_long_option ("script_pre_process") then
				if is_next_option_long_option and then has_next_option_value then
					script_pre_process := next_option_value
					consume_option
				else
					report_missing_command_line_parameter_value_error ("--script_pre_process=<...>")
					report_usage_error
					exceptions_die
				end
			end
			if match_long_option ("script_post_process") then
				if is_next_option_long_option and then has_next_option_value then
					script_post_process := next_option_value
					consume_option
				else
					report_missing_command_line_parameter_value_error ("--script_post_process=<...>")
					report_usage_error
					exceptions_die
				end
			end
		end

	process_other_arguments
			--<Precursor>
			-- Process arguments (using the obsolete syntax)
		local
			header_file_name: STRING
			l_path: PATH
		do
			if
				match_long_option ("output-dir") and then
				is_next_option_long_option and then
				has_next_option_value
			then
				output_directory_name := next_option_value
				consume_option
			end

			if not match_long_option ("full-header")  then
				report_missing_command_line_parameter_error ("--full-header=<...>")
				report_usage_error
				exceptions_die
			end

			if not has_next_option_value then
				report_missing_command_line_parameter_value_error ("--full-header=<...>")
				report_usage_error
				exceptions_die
			end

			full_header_file_name := next_option_value
			header_file_name := full_header_file_name.twin
			consume_option

			if match_long_option ("full-header")  then
				if not has_next_option_value then
					report_missing_command_line_parameter_value_error ("--full-header=<...>")
					report_usage_error
					exceptions_die
				end
				full_header_file_name := next_option_value
				header_file_name := full_header_file_name.twin
				consume_option
			end

			create l_path.make_from_string (header_file_name)
			if attached  l_path.entry as l_entry  then
				header_file_name := l_entry.out

				if match_long_option ("config") then
					if is_next_option_long_option and then has_next_option_value then
						config_file_name := next_option_value
						consume_option
					else
						report_missing_command_line_parameter_value_error ("--config=<...>")
						report_usage_error
						exceptions_die
					end
				end
			end
			create config_system.make (header_file_name)
			config_system.set_include_path (l_path.parent)
			config_system.set_comile_options (compiler_options)
		end

	exceptions_die
		do
			exceptions.die (1)
		end

feature {NONE} -- Implementation: Error Reporting

	report_cannot_read_error (a_message: STRING)
			-- Report cannot read config file.
		do
			error_handler.report_cannot_read_error (a_message)
		end

	report_missing_command_line_parameter_error (a_message: STRING)
			--
		do
			error_handler.report_missing_command_line_parameter_error (a_message)
		end

	report_missing_command_line_parameter_value_error (a_message: STRING)
			--<Precursor>
		do
			error_handler.report_missing_command_line_parameter_value_error (a_message)
		end

	report_usage_error
			--<Precursor>
		do
			error_handler.report_usage_error
		end

	report_quitting_because_of_config_file_errors_error (a_message: STRING)
			--<Precursor>
		do
			error_handler.report_quitting_because_of_config_file_errors_error (a_message)
		end

	report_info_message (a_message: STRING)
			--<Precursor>
		do
			error_handler.report_info_message (a_message)
		end

end
