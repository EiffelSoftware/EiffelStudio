indexing
	description	: "Page in which the user choose to create an EXE or a DLL"

class
	WIZARD_SECOND_STATE

inherit
	BENCH_WIZARD_INTERMEDIARY_STATE_WINDOW
		redefine
			update_state_information,
			proceed_with_current_info,
			build,
			make
		end

create
	make

feature {NONE} -- Implementation

	make (an_info: like wizard_information) is
			-- Set `help_filename' with `h_filename'.
		do
			set_help_filename (h_filename)
			Precursor {BENCH_WIZARD_INTERMEDIARY_STATE_WINDOW} (an_info) 
		end
		
feature -- Access

	h_filename: STRING is "help/wizards/edotnet/docs/reference/20_application_type_and_project_settings/index.html"
			-- Path to HTML help file
			
feature -- Basic Operation

	build is 
			-- Build entries.
		do 
			create rb_project_type_exe.make_with_text (Exe_type)
			create rb_project_type_dll.make_with_text (Dll_type)

			create root_class_name.make (Current)
			root_class_name.set_label_string_and_size (interface_names.l_Root_class_name, 10)
			root_class_name.set_textfield_string (wizard_information.root_class_name)
			root_class_name.generate
			root_class_name.change_actions.extend (agent on_change_root_class_name)

--			create root_class_external_name.make (Current)
--			root_class_external_name.set_label_string_and_size (interface_names.l_Root_class_external_name, 10)
--			root_class_external_name.set_textfield_string (wizard_information.root_class_external_name)
--			root_class_external_name.generate
--			root_class_external_name.change_actions.extend (agent on_change_root_class_external_name)
			
			create creation_routine_name.make (Current)
			creation_routine_name.set_label_string_and_size (interface_names.l_Creation_routine_name, 10)
			creation_routine_name.set_textfield_string (wizard_information.creation_routine_name)
			creation_routine_name.generate
			creation_routine_name.change_actions.extend (agent on_change_creation_routine_name)

--			create creation_routine_external_name.make (Current)
--			creation_routine_external_name.set_label_string_and_size (interface_names.l_Creation_routine_external_name, 10)
--			creation_routine_external_name.set_textfield_string (wizard_information.creation_routine_external_name)
--			creation_routine_external_name.generate
--			creation_routine_external_name.change_actions.extend (agent on_change_creation_routine_external_name)
			
			choice_box.set_padding (dialog_unit_to_pixels(1))
			choice_box.extend (rb_project_type_exe)
			choice_box.disable_item_expand (rb_project_type_exe)
			choice_box.extend (rb_project_type_dll)
			choice_box.disable_item_expand (rb_project_type_dll)
			choice_box.extend (create {EV_CELL}) -- expandable item

			choice_box.set_padding (dialog_unit_to_pixels(1))
			choice_box.set_minimum_width (choice_box.width)
			choice_box.extend (root_class_name.widget)
			choice_box.disable_item_expand (root_class_name.widget)
			--choice_box.extend (root_class_external_name.widget)
			--choice_box.disable_item_expand (root_class_external_name.widget)
			
			choice_box.extend (creation_routine_name.widget)
			choice_box.disable_item_expand (creation_routine_name.widget)
			--choice_box.extend (creation_routine_external_name.widget)
			--choice_box.disable_item_expand (creation_routine_external_name.widget)
			choice_box.extend (create {EV_CELL}) -- expandable item

			if wizard_information.generate_dll then
				rb_project_type_dll.enable_select
			else
				rb_project_type_exe.enable_select
			end
			
			set_updatable_entries(<<
				rb_project_type_exe.select_actions,
				rb_project_type_dll.select_actions,
				root_class_name.change_actions,
				--root_class_external_name.change_actions,
				creation_routine_name.change_actions
				--creation_routine_external_name.change_actions
				>>)
		end

	change_preview is
			-- Change the pixmap used to preview the application.
		do
		end

	proceed_with_current_info is 
		local
			root_class_name_text: STRING
			next_window: WIZARD_STATE_WINDOW
			retried, com_problem: BOOLEAN
		do
			if not retried then				
				if root_class_name.text /= Void and then not root_class_name.text.is_empty then
					root_class_name_text := clone (root_class_name.text)
					root_class_name_text.to_lower
					if root_class_name_text.is_equal (None_class) then
						Precursor
						create {WIZARD_THIRD_STATE} next_window.make (wizard_information)
					else
						if is_valid_identifier (root_class_name.text) then
							if creation_routine_name.text /= Void and then not creation_routine_name.text.is_empty then
								if is_valid_identifier (creation_routine_name.text) then
									Precursor
									create {WIZARD_THIRD_STATE} next_window.make (wizard_information)
								else
										-- Ask for a valid creation routine name (in the sense of an Eiffel valid identifier).
									create {WIZARD_ERROR_VALID_CREATION_ROUTINE_NAME} next_window.make (wizard_information)
								end
							else
									-- Ask for a valid creation routine name.
								create {WIZARD_ERROR_VALID_CREATION_ROUTINE_NAME} next_window.make (wizard_information)
							end
						else
								-- Ask for a valid root class name (in the sense of an Eiffel valid identifier).
							create {WIZARD_ERROR_VALID_ROOT_CLASS_NAME} next_window.make (wizard_information)
						end
					end
				else
						-- Ask for a valid root class name.
					create {WIZARD_ERROR_VALID_ROOT_CLASS_NAME} next_window.make (wizard_information)
				end
			else
				if com_problem then
					create {WIZARD_ERROR_COM_EXCEPTION} next_window.make (wizard_information)
				else
						-- Something went wrong when checking validity of the root class name or creation routine name,
						-- go to error.
					create {WIZARD_ERROR_INVALID_DATA} next_window.make (wizard_information)
				end
			end
			Precursor
			proceed_with_new_state (next_window)
		rescue
			if (create {EXCEPTIONS}).is_developer_exception_of_name ("com_exception") then
				com_problem := True
			end
			retried := True
			retry
		end

	update_state_information is
			-- Check User Entries
		do
			wizard_information.set_generate_dll (rb_project_type_dll.is_selected)
			wizard_information.set_root_class_name (root_class_name.text)
			--wizard_information.set_root_class_external_name (root_class_external_name.text)
			wizard_information.set_creation_routine_name (creation_routine_name.text)
			--wizard_information.set_creation_routine_external_name (creation_routine_external_name.text)
			Precursor
		end

feature {NONE} -- Implementation

	display_state_text is
		do
			title.set_text (interface_names.t_Second_state)
			subtitle.set_text (Subtitle_text)
			message.set_text (interface_names.m_Second_state)
		end

	preview_pixmap: EV_PIXMAP
			-- Pixmap used to preview the application.
			
	rb_project_type_exe: EV_RADIO_BUTTON
	rb_project_type_dll: EV_RADIO_BUTTON

	root_class_name: WIZARD_SMART_TEXT_FIELD
--	root_class_external_name: WIZARD_SMART_TEXT_FIELD
	creation_routine_name: WIZARD_SMART_TEXT_FIELD
--	creation_routine_external_name: WIZARD_SMART_TEXT_FIELD
	
	is_valid_identifier (a_name: STRING): BOOLEAN is
			-- Is `a_name' a valid Eiffel identifier?
		require
			non_void_name: a_name /= Void
			not_empty_name: not a_name.is_empty
		local
			first_character: CHARACTER
			i: INTEGER
			a_character: CHARACTER			
		do
			first_character := a_name.item (1)
			if not first_character.is_alpha then
				Result := False
			else
				from
					i := 2
					Result := True
				until
					i > a_name.count or not Result
				loop
					a_character := a_name.item (i)
					Result := a_character.is_alpha or a_character.is_digit or a_character.is_equal ('_')
					i := i + 1
				end
			end
		end

	on_change_root_class_name is
			-- Action performed when the user changes the root class name of the application
		local
			lower_case_root_class_name: STRING
		do
			lower_case_root_class_name := clone (root_class_name.text)
			if lower_case_root_class_name /= Void then
				lower_case_root_class_name.to_lower
				if lower_case_root_class_name.is_equal (None_class) then
					--root_class_external_name.set_text (Unrelevant_data)
					creation_routine_name.set_text (Unrelevant_data)
					--creation_routine_external_name.set_text (Unrelevant_data)
				else
--					if root_class_external_name.text /= Void and then root_class_external_name.text.is_equal (Unrelevant_data) then
--						root_class_external_name.remove_text
--						creation_routine_name.remove_text
--						--creation_routine_external_name.remove_text			
--					end
				end
			end
		end

--	on_change_root_class_external_name is
--			-- Action performed when the user changes the root class external name of the application
--		do
--		end

	on_change_creation_routine_name is
			-- Action performed when the user changes the creation routine name of the application
		do
		end

--	on_change_creation_routine_external_name is
--			-- Action performed when the user changes the creation routine external name of the application
--		do
--		end
		
feature {NONE} -- Constants

	Exe_type: STRING is "Executable"
			-- Meaning of EXE
	
	Dll_type: STRING is "Dynamic-Link Library"
			-- Meaning of DLL
	
	None_class: STRING is "none"
			-- `NONE' class
		
	Subtitle_text: STRING is "You can choose to create a .exe or a .dll file%N%
					%and select the names of the root class and its creation routine."
			
end -- class WIZARD_SECOND_STATE
