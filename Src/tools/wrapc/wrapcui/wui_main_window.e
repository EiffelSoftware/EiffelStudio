note
	description: "WrapC UI Application Main Window"
	purpose: "[
		This is the primary window of a one-window application.
		The window provides the user with the capacity to set up the 
		same options as what one finds in the WrapC command line options.
		For example: Instead of typing out the full-path to the
		`*.h' header file (i.e. --full-header=?), the user may click
		the ellipses button (i.e. "...") and select the directory
		from a directory selection dialog, thereby filling in the
		full-header field in the UI.
		]"

class
	WUI_MAIN_WINDOW

inherit
	EV_TITLED_WINDOW
		redefine
			create_interface_objects,
			initialize
		end

create
	make_with_title

feature {NONE} -- Initialization

	create_interface_objects
			--<Precursor>
			-- Also has `force' calls for `actions'.
		do
			Precursor

			create main_box

			create full_header_box
			create full_header_textbox
			create full_header_label.make_with_text ("Full_header=<...>")
			full_header_label.select_actions.force (agent on_full_header_label_link_click)
			full_header_label.set_tooltip ("Command Line Options Help - see full-header option")
			create full_header_button.make_with_text_and_action ("...", agent on_full_header_click)
			full_header_textbox.focus_out_actions.force (agent on_full_header_textbox_focus_out)

			create output_dir_box
			create output_dir_textbox
			create output_dir_label.make_with_text ("Output-dir=<...>")
			output_dir_label.select_actions.force (agent on_output_dir_label_link_click)
			output_dir_label.set_tooltip ("Command Line Options Help - see output-dir option")
			create output_dir_button.make_with_text_and_action ("...", agent on_output_dir_click)
			output_dir_textbox.focus_out_actions.force (agent on_output_dir_textbox_focus_out)

			create cmd_box
			create run_wrapc_cmd_button.make_with_text_and_action ("Run", agent on_run_wrapc_cmd_button_click)
			create clean_generated_files_checkbox.make_with_text ("Clean")

			create c_compile_box
			create c_compile_textbox
			create c_compile_label.make_with_text ("C-compile Options: ")
			c_compile_label.select_actions.force (agent on_c_compile_label_link_click)
			c_compile_label.set_tooltip ("Command Line Options Help - see c_compile_options option")

			create script_pre_box
			create script_pre_textbox
			create script_pre_label.make_with_text ("Script pre-process Options: ")
			script_pre_label.select_actions.force (agent on_script_pre_label_link_click)
			script_pre_label.set_tooltip ("Command Line Options Help - see script_pre_process option")

			create script_post_box
			create script_post_textbox
			create script_post_label.make_with_text ("Script post-process Options: ")
			script_post_label.select_actions.force (agent on_script_post_label_link_click)
			script_post_label.set_tooltip ("Command Line Options Help - see script_post_process option")

			create config_file_box
			create config_file_textbox
			create config_file_label.make_with_text ("Config file: ")
			config_file_label.select_actions.force (agent on_config_file_label_link_click)
			config_file_label.set_tooltip ("Command Line Options Help - see config option")
			create config_file_button.make_with_text_and_action ("...", agent on_config_file_click)

			create output_box
			create output_text
		end

	initialize
			--<Precursor>
			-- Mostly about extending, expanding, borders, and padding
			-- and then putting it all in `main_box'
		do
			Precursor {EV_TITLED_WINDOW}

				-- full-header
			main_box.extend (full_header_box)
			full_header_box.extend (full_header_label)
			full_header_box.extend (full_header_textbox)
			full_header_box.extend (full_header_button)
			full_header_box.disable_item_expand (full_header_label)
			full_header_box.disable_item_expand (full_header_button)
			full_header_box.set_border_width (3)
			full_header_box.set_padding_width (3)
			full_header_textbox.set_tooltip ("Filename (including pathname) to the C header to be preprocessed,%Nand name of header file, that should be used in eiffel external clauses.")
			main_box.disable_item_expand (full_header_box)

				-- output-dir
			main_box.extend (output_dir_box)
			output_dir_box.extend (output_dir_label)
			output_dir_box.extend (output_dir_textbox)
			output_dir_box.extend (output_dir_button)
			output_dir_box.extend (clean_generated_files_checkbox)
			clean_generated_files_checkbox.disable_sensitive
			clean_generated_files_checkbox.set_tooltip ("Clean generated files before Run.")
			output_dir_box.disable_item_expand (output_dir_label)
			output_dir_box.disable_item_expand (output_dir_button)
			output_dir_box.disable_item_expand (clean_generated_files_checkbox)
			output_dir_box.set_border_width (3)
			output_dir_box.set_padding_width (3)
			output_dir_textbox.set_tooltip ("Directory where generated files will be placed.%NLocation of the target Eiffel application folder.")
			main_box.disable_item_expand (output_dir_box)

				-- Options: C-compile
			main_box.extend (c_compile_box)
			c_compile_box.extend (c_compile_label)
			c_compile_box.extend (c_compile_textbox)
			c_compile_box.disable_item_expand (c_compile_label)
			c_compile_box.set_border_width (3)
			c_compile_box.set_padding_width (3)
			c_compile_textbox.set_tooltip ("Optional c compile options.")
			main_box.disable_item_expand (c_compile_box)

				-- Options: Script-pre-process
			main_box.extend (script_pre_box)
			script_pre_box.extend (script_pre_label)
			script_pre_box.extend (script_pre_textbox)
			script_pre_box.disable_item_expand (script_pre_label)
			script_pre_box.set_border_width (3)
			script_pre_box.set_padding_width (3)
			script_pre_textbox.set_tooltip ("Optional pre-processing script, to be executed before C header preprocessing.")
			main_box.disable_item_expand (script_pre_box)

				-- Options: Script-post-process
			main_box.extend (script_post_box)
			script_post_box.extend (script_post_label)
			script_post_box.extend (script_post_textbox)
			script_post_box.disable_item_expand (script_post_label)
			script_post_box.set_border_width (3)
			script_post_box.set_padding_width (3)
			script_post_textbox.set_tooltip ("Optional post-processing script, to be executed after Eiffel code wrapping.")
			main_box.disable_item_expand (script_post_box)

				-- Options: Config file
			main_box.extend (config_file_box)
			config_file_box.extend (config_file_label)
			config_file_box.extend (config_file_textbox)
			config_file_box.extend (config_file_button)
			config_file_box.disable_item_expand (config_file_label)
			config_file_box.disable_item_expand (config_file_button)
			config_file_box.set_border_width (3)
			config_file_box.set_padding_width (3)
			config_file_textbox.set_tooltip ("Name of config file to use. A config file allows to customize the wrapping process.")
			main_box.disable_item_expand (config_file_box)

				-- Output
			main_box.extend (output_box)
			output_box.extend (output_text)

				-- Run button
			main_box.extend (cmd_box)
			cmd_box.extend (create {EV_CELL})
			cmd_box.extend (run_wrapc_cmd_button)
			run_wrapc_cmd_button.disable_sensitive
			cmd_box.extend (create {EV_CELL})
			cmd_box.disable_item_expand (run_wrapc_cmd_button)
			cmd_box.set_border_width (3)
			cmd_box.set_padding_width (3)
			main_box.disable_item_expand (cmd_box)

			extend (main_box)
		end

feature {WUI_EWG} -- Implementation: Output

	add_output (a_string: STRING)
			--
		do
			output_text.append_text (a_string)
			if output_text.text.count > 0 then
				output_text.set_caret_position (output_text.text.count)
			end
		end

feature {NONE} -- GUI Actions

	on_full_header_click
			-- What happens when user clicks `full_header_button'
		local
			l_file_open: EV_FILE_OPEN_DIALOG
		do
			create l_file_open.make_with_title ("Locate header file ...")
			l_file_open.show_modal_to_window (Current)

			full_header_textbox.set_text (l_file_open.file_name)
			on_full_header_textbox_focus_out
		end

	on_output_dir_click
			-- What happens when user clicks `output_dir_button'
		local
			l_dir: EV_DIRECTORY_DIALOG
		do
			create l_dir.make_with_title ("Locate output directory ...")
			l_dir.show_modal_to_window (Current)

			output_dir_textbox.set_text (l_dir.directory)
			on_output_dir_textbox_focus_out
		end

	on_config_file_click
			-- What happens whenuser clicks "..." for config file?
		local
			l_file_open: EV_FILE_OPEN_DIALOG
		do
			create l_file_open.make_with_title ("Locate config file ...")
			l_file_open.show_modal_to_window (Current)

			config_file_textbox.set_text (l_file_open.file_name)
		end

	on_clean_generated_files_button_checked
			-- What happens when user clicks `clean_generated_files_checkbox'.
		note
			design: "[
				1. Delete generated files from previous WrapC `run'.
					1a. Requires an output directory target.
				2. Delete generated folders once files are deleted.
				]"
		local
			l_dir_structure: EWG_DIRECTORY_STRUCTURE
			l_config_system: EWG_CONFIG_SYSTEM
			l_dir: DIRECTORY
			l_message: STRING
			l_msg: EV_MESSAGE_DIALOG
			l_file_utilities: FILE_UTILITIES
		do
			create l_message.make_empty
			create l_config_system.make (full_header_textbox.text.to_string_8)
			create l_dir_structure.make (l_config_system)
				-- c
			create l_dir.make_with_name (output_dir_textbox.text + {OPERATING_ENVIRONMENT}.Directory_separator.out + l_dir_structure.config_system.directory_structure.c_directory_name)
			if l_dir.exists then
				l_dir.recursive_delete
				l_message.append_string_general ("Deleted output c/include and c/src folders.%N")
			end
				-- eiffel
			create l_dir.make_with_name (output_dir_textbox.text + {OPERATING_ENVIRONMENT}.Directory_separator.out + l_dir_structure.config_system.directory_structure.eiffel_directory_name)
			if l_dir.exists then
				l_dir.recursive_delete
				l_message.append_string_general ("Deleted output eiffel folders.%N")
			end
				-- Message
			if l_message.is_empty then
				l_message := "There was nothing to clean."
			end
			create l_msg.make_with_text (l_message)
			l_msg.set_buttons_and_actions ({ARRAY [READABLE_STRING_GENERAL]} <<"OK">>, <<agent l_msg.destroy_and_exit_if_last>>)
			l_msg.show_modal_to_window (Current)
			rescue
				create l_msg.make_with_text (clean_exception_msg)
				l_msg.set_buttons_and_actions ({ARRAY [READABLE_STRING_GENERAL]} <<"OK">>, <<agent l_msg.destroy_and_exit_if_last>>)
				l_msg.show_modal_to_window (Current)
		end

	on_run_wrapc_cmd_button_click
			-- What happens when user clicks `run_wrapc_cmd'.
			-- `run' is in the `make' from `make_with_window'
		local
			l_ewg: WUI_EWG
			l_msg: EV_MESSAGE_DIALOG
		do
			if clean_generated_files_checkbox.is_selected then
				on_clean_generated_files_button_checked
			end
			create l_ewg.make_with_window (Current)
		end

	clean_exception_msg: STRING = "[
		Due to a bug (file handles left open), you will not be able to run the Clean
		operation after a Run options. 
		
		Save your current configuration (if needed) and then re-open the app and
		then click Clean. Closing the app will release any open file-handles.
		
		NOTE: There will be an error message right after closing this dialog.
				Click the "Ignore" button to continue safely.
		]"

	on_full_header_textbox_focus_out
			-- What happens on focus-out of `full_header_textbox'?
		note
			design: "[
				There are reasons for allowing the user to access or
				not access clicking the Run button. This routine helps
				resolve that question.
				]"
		do
			enable_disable_sensitive_on_cmd_buttons
		end

	on_output_dir_textbox_focus_out
			-- What happend on focus-out of `output_dir_textbox'?
		note
			design: "[
				There are reasons for allowing the user to access or
				not access clicking the Run button. This routine helps
				resolve that question.
				]"
		do
			enable_disable_sensitive_on_cmd_buttons
		end

feature -- GUI Actions: Link Labels

	on_full_header_label_link_click
			--
		local
			l_launcher: URI_LAUNCHER
		do
			create l_launcher
			l_launcher.launch ("https://github.com/eiffel-wrap-c/WrapC/blob/master/doc/Readme.md#commands").do_nothing
		end

	on_output_dir_label_link_click
			--
		local
			l_launcher: URI_LAUNCHER
		do
			create l_launcher
			l_launcher.launch ("https://github.com/eiffel-wrap-c/WrapC/blob/master/doc/Readme.md#commands").do_nothing
		end

	on_c_compile_label_link_click
			--
		local
			l_launcher: URI_LAUNCHER
		do
			create l_launcher
			l_launcher.launch ("https://github.com/eiffel-wrap-c/WrapC/blob/master/doc/Readme.md#commands").do_nothing
		end

	on_script_pre_label_link_click
			--
		local
			l_launcher: URI_LAUNCHER
		do
			create l_launcher
			l_launcher.launch ("https://github.com/eiffel-wrap-c/WrapC/blob/master/doc/Readme.md#commands").do_nothing
		end

	on_script_post_label_link_click
			--
		local
			l_launcher: URI_LAUNCHER
		do
			create l_launcher
			l_launcher.launch ("https://github.com/eiffel-wrap-c/WrapC/blob/master/doc/Readme.md#commands").do_nothing
		end

	on_config_file_label_link_click
			--
		local
			l_launcher: URI_LAUNCHER
		do
			create l_launcher
			l_launcher.launch ("https://github.com/eiffel-wrap-c/WrapC/blob/master/doc/Readme.md#config_file").do_nothing
		end

feature {NONE} -- GUI Actions Support

	enable_disable_sensitive_on_cmd_buttons
			-- Determine if Run button is sensitive or not.
		note
			design: "[
				There are reasons for allowing the user to access or
				not access clicking the Run button. This routine helps
				resolve that question.
				]"
		do
			if has_full_header_dir_and_file then
				run_wrapc_cmd_button.enable_sensitive
			else
				run_wrapc_cmd_button.disable_sensitive
			end

			if has_output_dir then
				clean_generated_files_checkbox.enable_sensitive
			else
				clean_generated_files_checkbox.disable_sensitive
			end
		end

	has_full_header_dir_and_file: BOOLEAN
			-- Does `full_header_textbox' text directory exist and have file?
		note
			design: "[
				There are reasons for allowing the user to access or
				not access clicking the Run button. This routine helps
				resolve that question.
				]"
		local
			l_dir: DIRECTORY
			l_path_string: STRING
			l_list: LIST [STRING]
		do
			l_path_string := full_header_textbox.text.to_string_8.twin
			l_list := l_path_string.split ({OPERATING_ENVIRONMENT}.Directory_separator)
			l_path_string.remove_tail (l_list [l_list.count].count + 1)
			create l_dir.make (l_path_string)
			Result := l_dir.exists and then l_dir.has_entry (l_list [l_list.count])
		end

	has_output_dir: BOOLEAN
			-- Does `output_dir_textbox' have directory?
		do
			Result := (create {DIRECTORY}.make (output_dir_textbox.text.to_string_8.twin)).exists
		end

feature {WUI_EWG} -- GUI Components

	main_box: EV_VERTICAL_BOX

	full_header_box: EV_HORIZONTAL_BOX
	full_header_textbox: EV_TEXT_FIELD
	full_header_label: EVS_LINK_LABEL
	full_header_button: EV_BUTTON

	output_dir_box: EV_HORIZONTAL_BOX
	output_dir_textbox: EV_TEXT_FIELD
	output_dir_label: EVS_LINK_LABEL
	output_dir_button: EV_BUTTON

	cmd_box: EV_HORIZONTAL_BOX
	clean_generated_files_checkbox: EV_CHECK_BUTTON
	run_wrapc_cmd_button: EV_BUTTON

	c_compile_box: EV_HORIZONTAL_BOX
	c_compile_textbox: EV_TEXT_FIELD
	c_compile_label: EVS_LINK_LABEL

	script_pre_box: EV_HORIZONTAL_BOX
	script_pre_textbox: EV_TEXT_FIELD
	script_pre_label: EVS_LINK_LABEL

	script_post_box: EV_HORIZONTAL_BOX
	script_post_textbox: EV_TEXT_FIELD
	script_post_label: EVS_LINK_LABEL

	config_file_box: EV_HORIZONTAL_BOX
	config_file_textbox: EV_TEXT_FIELD
	config_file_label: EVS_LINK_LABEL
	config_file_button: EV_BUTTON

	output_box: EV_VERTICAL_BOX
	output_text: EV_RICH_TEXT

feature {WUI_APP} -- Menu implementation

	standard_menu_bar: EV_MENU_BAR -- Standard menu bar for this window.
	file_menu: EV_MENU -- "File" menu for this window (contains Exit...)
	help_menu: EV_MENU -- "Help" menu for this window (contains About...)

	build_menu_bar
			-- Create and populate standard_menu_bar.
		require
			menu_bar_not_yet_created: not attached standard_menu_bar
		local
			l_menu_item: EV_MENU_ITEM
		do
				-- Create the menu bar.
			create standard_menu_bar

				-- File Menu
			create file_menu.make_with_text ("&File")
			standard_menu_bar.extend (file_menu)
				-- File->Open
			create l_menu_item.make_with_text ("O&pen")
			l_menu_item.select_actions.extend (agent on_file_open_click)
			file_menu.extend (l_menu_item)
				-- File->Save
			create l_menu_item.make_with_text ("Save")
			l_menu_item.select_actions.extend (agent on_file_save_click)
			file_menu.extend (l_menu_item)
				-- File->Close
			create l_menu_item.make_with_text ("Close")
			l_menu_item.select_actions.extend (agent on_file_close_click)
			file_menu.extend (l_menu_item)
				-- File->Exit
			create l_menu_item.make_with_text ("E&xit")
			l_menu_item.select_actions.extend (agent on_file_exit_click)
			file_menu.extend (l_menu_item)

				-- Help Menu
			create help_menu.make_with_text ("&Help")
			standard_menu_bar.extend (help_menu)
				-- Help->About
			create l_menu_item.make_with_text ("&About")
			l_menu_item.select_actions.extend (agent on_help_about_click)
			help_menu.extend (l_menu_item)
				-- Help->Documentation
			create l_menu_item.make_with_text ("&Documentation")
			l_menu_item.select_actions.extend (agent on_help_documentation_click)
			help_menu.extend (l_menu_item)

			set_menu_bar (standard_menu_bar)
		ensure
			menu_bar_created: attached standard_menu_bar and then
								not standard_menu_bar.is_empty
		end

feature -- Menu: GUI Actions

	on_file_open_click
			-- What happens when the user selects File->Open
		local
			l_file: PLAIN_TEXT_FILE
			l_open: EV_FILE_OPEN_DIALOG
			l_content,
			l_local_part,
			l_local_part_content: STRING
			l_parser: XML_STANDARD_PARSER
			l_callbacks: WUI_XML_CALLBACKS
		do
				-- Identify WUI file
			create l_open.make_with_title ("Open WUI configuration ...")
			l_open.show_modal_to_window (Current)
			if not l_open.file_name.is_empty then
					-- fetch content
				create l_file.make_open_read (l_open.file_name)
				l_file.read_stream (l_file.count)
				l_content := l_file.last_string
				l_file.close
					-- parse it
				l_parser := (create {XML_PARSER_FACTORY}).new_standard_parser
				create l_callbacks
				l_parser.set_callbacks (l_callbacks)
				l_parser.parse_from_string (l_content)
					-- store it
				across
					l_callbacks.contents as ic
				loop
					l_local_part := ic.item.local_part.to_string_8
					l_local_part_content := ic.item.content.to_string_8
					if l_local_part.same_string ("config") then
						do_nothing
					elseif l_local_part.same_string ("full_header") then
						full_header_textbox.set_text (l_local_part_content)
					elseif l_local_part.same_string ("output_dir") then
						output_dir_textbox.set_text (l_local_part_content)
					elseif l_local_part.same_string ("c_compile") then
						c_compile_textbox.set_text (l_local_part_content)
					elseif l_local_part.same_string ("script_pre_process") then
						script_pre_textbox.set_text (l_local_part_content)
					elseif l_local_part.same_string ("script_post_process") then
						script_post_textbox.set_text (l_local_part_content)
					elseif l_local_part.same_string ("config_file") then
						config_file_textbox.set_text (l_local_part_content)
					end
				end
				enable_disable_sensitive_on_cmd_buttons
			end
		end

	on_file_save_click
			-- What happens when the user selects File->Save
		local
			l_dir: DIRECTORY
			l_list: LIST [STRING_32]
			l_file: PLAIN_TEXT_FILE
			l_full_path,
			l_file_name: STRING_32
			l_save_as: EV_FILE_SAVE_DIALOG
		do
			create l_save_as.make_with_title ("Save configuration ...")
			l_save_as.show_modal_to_window (Current)
			if not l_save_as.file_name.is_empty then
				create l_file.make_create_read_write (l_save_as.file_name)
				l_file.put_string (config_file_content_as_xml)
				l_file.flush
				l_file.close
			end
		end

	config_file_content_as_xml: STRING
			-- The content of a "saved" configuration as XML.
		do
			create Result.make_empty
			Result.append_string_general ("<config>%N%T")
					-- full-header
				Result.append_string_general ("<full_header>")
				Result.append_string_general (full_header_textbox.text)
				Result.append_string_general ("</full_header>%N%T")
					-- output-dir
				Result.append_string_general ("<output_dir>")
				Result.append_string_general (output_dir_textbox.text)
				Result.append_string_general ("</output_dir>%N%T")
					-- c_compile
				Result.append_string_general ("<c_compile>")
				Result.append_string_general (c_compile_textbox.text)
				Result.append_string_general ("</c_compile>%N%T")
					-- script_pre_process
				Result.append_string_general ("<script_pre_process>")
				Result.append_string_general (script_pre_textbox.text)
				Result.append_string_general ("</script_pre_process>%N%T")
					-- script_post_process
				Result.append_string_general ("<script_post_process>")
				Result.append_string_general (script_post_textbox.text)
				Result.append_string_general ("</script_post_process>%N%T")
					-- config_file
				Result.append_string_general ("<config_file>")
				Result.append_string_general (config_file_textbox.text)
				Result.append_string_general ("</config_file>%N")

			Result.append_string_general ("</config>%N")
		end

	on_file_close_click
			-- What happens when the user selects File->Close
		do
			full_header_textbox.set_text ("")
			output_dir_textbox.set_text ("")
			config_file_textbox.set_text ("")
			script_pre_textbox.set_text ("")
			script_post_textbox.set_text ("")
			config_file_textbox.set_text ("")
		end

	on_file_exit_click
			-- What happens when the user selects File->Exit
		do
			destroy_and_exit_if_last
		end

	on_help_about_click
			-- What happens when the user selected Help->About
		local
			l_msg: EV_MESSAGE_DIALOG
		do
			create l_msg.make_with_text ("Eiffel Sotware WrapC-UI%NCopyright 2019 (c)")
			l_msg.set_buttons_and_actions ({ARRAY [READABLE_STRING_GENERAL]} <<"OK">>, <<agent l_msg.destroy_and_exit_if_last>>)
			l_msg.show_modal_to_window (Current)
		end

	on_help_documentation_click
			-- What happens when the user selects Help->Documentation
		local
			l_launcher: URI_LAUNCHER
		do
			create l_launcher
			l_launcher.launch ("https://github.com/eiffel-wrap-c/WrapC/blob/master/doc/Readme.md").do_nothing
		end

note
	command_line_help_example: "[
		wrap_c --help
		wrap_c: You must specify '--full-header=<...>'
		usage: wrap_c   [--version] [--verbose]
		                [--c_compile_options=<...>] [--script_pre_process=<...>] [--script_post_process=<...>]
		                [--output-dir=<...>] --full-header=<...>
		                [--config=<...>]
		]"
	online_description: "[
		options:
			--version ... Output WrapC (EWG) version number.
			--verbose ... Output progress information on STDOUT
			--c_compile_options: Optional c compile options
			--script_pre_process: Optional pre-processing script, to be executed before C header preprocessing
			--scrtip_post_process: Optional post-processing script, to be executed after Eiffel code wrapping.

		arguments:
			--output-dir  ... Directory where generated files will be placed
			--full-header ... Filename (including pathname) to the C header to be preprocessed,
				          and name of header file, that should be used in eiffel external clauses
			--config      ... Name of config file to use. A config file allows to customize the wrapping process
		]"
	EIS: "name=readme_md", "src=https://github.com/eiffel-wrap-c/WrapC/blob/master/doc/Readme.md"
	corresponding_ui_elements: "[
		REQUIRED:
		--full-header=<...>				... Filename (including pathname) to the C header to be preprocessed,
				          					and name of header file, that should be used in eiffel external clauses
		
		OPTIONAL:
		[--output-dir=<...>]			... Directory where generated files will be placed.
		[--c_compile_options=<...>]		... Optional c compile options.
		[--script_pre_process=<...>]	... Optional pre-processing script, to be executed before C header preprocessing.
		[--script_post_process=<...>]	... Optional post-processing script, to be executed after Eiffel code wrapping.
		[--config=<...>]				... Name of config file to use. A config file allows to customize the wrapping process.
		]"

end
