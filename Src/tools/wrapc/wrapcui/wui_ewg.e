note
	description: "WrapC UI EWG"

class
	WUI_EWG

inherit
	EWG_KERNEL

create
	make_with_window

feature {NONE} -- Initialization

	make_with_window (a_ui: WUI_MAIN_WINDOW)
			-- Initialize Current with `main_window'
		require
			has_ui: attached a_ui
		do
			main_window := a_ui
			report_info_message ("Starting Run ...")
			make
			report_info_message ("Run complete.")
		ensure
			has_window: attached main_window
		end

	main_window: WUI_MAIN_WINDOW

feature -- Basic Ops: Sub-supporting

	process_c_compiler_options
			-- `process_c_compiler_options'.
		do
			if not main_window.c_compile_textbox.text.is_empty then
				compiler_options := main_window.c_compile_textbox.text.to_string_8
				report_info_message ("Set compiler options.")
			else
				report_info_message ("No compiler options.")
			end
		end

	process_extension_scripts_options
			-- `process_extension_scripts_options'.
		do
			if not main_window.script_pre_textbox.text.is_empty then
				script_pre_process := main_window.script_pre_textbox.text.to_string_8
				report_info_message ("Set pre-process script options.")
			else
				report_info_message ("No pre-process script options.")
			end
			if not main_window.script_post_textbox.text.is_empty then
				script_post_process := main_window.script_post_textbox.text.to_string_8
				report_info_message ("Set post-process script options.")
			else
				report_info_message ("No pre-process script options.")
			end
		end

	process_other_arguments
			-- `process_other_arguments'.
		local
			l_header_file_name: STRING
			l_path: PATH
		do
			if not main_window.output_dir_textbox.text.is_empty then
				output_directory_name := main_window.output_dir_textbox.text.to_string_8
				report_info_message ("Set output directory option.")
			else
				report_info_message ("No output directory option.")
			end
			if not main_window.full_header_textbox.text.is_empty then
				full_header_file_name := main_window.full_header_textbox.text.to_string_8
				l_header_file_name := full_header_file_name.twin

				create l_path.make_from_string (l_header_file_name)
				l_header_file_name := l_path.entry.out

				create config_system.make (l_header_file_name)
				report_info_message ("Set full-header option.")
			else
				report_info_message ("No full-header option.")
			end
			if not main_window.config_file_textbox.text.is_empty then
				config_file_name := main_window.config_file_textbox.text.to_string_8
				report_info_message ("Set config file option.")
			else
				report_info_message ("No config file option.")
				config_file_name := Void
			end
		end

feature {NONE} -- Implementation: Error Reporting

	report_cannot_read_error (a_message: STRING)
			-- Report cannot read config file.
		do
			main_window.add_output ("ERROR: Report cannot read file: " + a_message + "%N")
		end

	report_missing_command_line_parameter_error (a_message: STRING)
			--
		do
			main_window.add_output ("ERROR: Missing command line parameter: " + a_message + "%N")
		end

	report_missing_command_line_parameter_value_error (a_message: STRING)
			--<Precursor>
		do
			main_window.add_output ("ERROR: Missage command line paramter value: " + a_message + "%N")
		end

	report_usage_error
			--<Precursor>
		do
			main_window.add_output (Usage_message)
		end

	Usage_message: STRING
			-- Usage_message from `error_handler'
		once
			Result := error_handler.Usage_message.parameters [1]
		end

	exceptions_die
			--<Precursor>
		do
			main_window.add_output ("DIE.%N")
		end

	report_quitting_because_of_config_file_errors_error (a_message: STRING)
			--<Precursor>
		do
			main_window.add_output ("ERROR: Quitting because of config file errors: " + a_message + "%N")
		end

	report_info_message (a_message: STRING)
			--<Precursor>
		do
			main_window.add_output ("INFO: " + a_message + "%N")
		end

end
