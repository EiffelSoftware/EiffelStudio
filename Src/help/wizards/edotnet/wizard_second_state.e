indexing
	description	: "Page in which the user choose to create an EXE or a DLL"
	legal: "See notice at end of class."
	status: "See notice at end of class."

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
		local
			l_horiz_box: EV_HORIZONTAL_BOX
			l_vert: EV_VERTICAL_BOX
			l_lab: EV_LABEL
			l_il_env: IL_ENVIRONMENT
			l_runtimes: DS_LINEAR [STRING]
			l_item: EV_LIST_ITEM
		do 
			create rb_project_type_exe.make_with_text (Exe_type)
			rb_project_type_exe.select_actions.extend (agent on_change_generation_type)
			create rb_project_type_dll.make_with_text (Dll_type)
			rb_project_type_dll.select_actions.extend (agent on_change_generation_type)

			create l_horiz_box
			l_horiz_box.set_padding (dialog_unit_to_pixels(20))
			create l_vert
			create console_app_b.make_with_text (l_Console_application)
			if wizard_information.console_application then
				console_app_b.enable_select
			else
				console_app_b.disable_select
			end
			l_vert.extend (rb_project_type_exe)
			l_vert.disable_item_expand (rb_project_type_exe)
			l_vert.extend (rb_project_type_dll)
			l_vert.disable_item_expand (rb_project_type_dll)
			
			l_horiz_box.extend (l_vert)
			l_horiz_box.disable_item_expand (l_vert)
			
			create l_vert
			l_vert.extend (console_app_b)
			l_vert.disable_item_expand (console_app_b)
			l_vert.extend (create {EV_CELL})
			l_horiz_box.extend (l_vert)

			choice_box.set_padding (dialog_unit_to_pixels(10))
			choice_box.extend (l_horiz_box)
			choice_box.disable_item_expand (l_horiz_box)
			
			choice_box.extend (create {EV_HORIZONTAL_SEPARATOR})

			create root_class_name.make (Current)
			root_class_name.set_label_string_and_size (interface_names.l_Root_class_name, 10)
			root_class_name.set_textfield_string (wizard_information.root_class_name)
			root_class_name.generate
			root_class_name.change_actions.extend (agent on_change_root_class_name)

			create creation_routine_name.make (Current)
			creation_routine_name.set_label_string_and_size (interface_names.l_Creation_routine_name, 10)
			creation_routine_name.set_textfield_string (wizard_information.creation_routine_name)
			creation_routine_name.generate

			create l_vert
			l_vert.set_padding (dialog_unit_to_pixels (5))
			l_vert.set_minimum_width (choice_box.width)
			l_vert.extend (root_class_name.widget)
			l_vert.disable_item_expand (root_class_name.widget)
			l_vert.extend (creation_routine_name.widget)
			l_vert.disable_item_expand (creation_routine_name.widget)

			choice_box.extend (l_vert)
			choice_box.extend (create {EV_CELL})
			
			create l_il_env
			l_runtimes := l_il_env.installed_runtimes
			most_recent_clr_version := l_il_env.default_version
			
			create clr_version_cb
			clr_version_cb.set_minimum_width (130)
			
			from
				l_runtimes.start
			until
				l_runtimes.after
			loop
				create l_item.make_with_text (l_runtimes.item_for_iteration)
				clr_version_cb.extend (l_item)
				l_runtimes.forth
			end
			
			clr_version_cb.disable_edit

			from
				clr_version_cb.start
			until
				clr_version_cb.after
			loop
				if clr_version_cb.item.text.is_equal (wizard_information.clr_version) then
					clr_version_cb.item.enable_select
				end
				clr_version_cb.forth
			end		
			
			create clr_version_lab.make_with_text (interface_names.l_clr_version)
			create clr_version_check.make_with_text (interface_names.l_clr_most_recent_version)
			clr_version_check.select_actions.extend (agent on_change_clr_version_combo)
			if wizard_information.is_most_recent_clr_version then
				clr_version_check.enable_select
			else			
				clr_version_check.disable_select
			end
			
			create l_horiz_box
			l_horiz_box.extend (clr_version_check)
			l_horiz_box.disable_item_expand (clr_version_check)
			l_horiz_box.set_padding (dialog_unit_to_pixels (10))
			l_horiz_box.extend (clr_version_lab)
			l_horiz_box.disable_item_expand (clr_version_lab)
			l_horiz_box.extend (clr_version_cb)
			l_horiz_box.disable_item_expand (clr_version_cb)
			l_horiz_box.extend (create {EV_CELL})
			clr_version_check.enable_select
			choice_box.extend (l_horiz_box)
			choice_box.disable_item_expand (l_horiz_box)
			
			if wizard_information.generate_dll then
				rb_project_type_dll.enable_select
			else
				rb_project_type_exe.enable_select
			end

			set_updatable_entries (<<
				rb_project_type_exe.select_actions,
				rb_project_type_dll.select_actions,
				root_class_name.change_actions,
				creation_routine_name.change_actions,
				console_app_b.select_actions,
				clr_version_check.select_actions,
				clr_version_cb.select_actions				
				>>)
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
					if is_valid_identifier (root_class_name.text) then
						if creation_routine_name.text /= Void and then not creation_routine_name.text.is_empty then
							if is_valid_identifier (creation_routine_name.text) then
								Precursor
								create {WIZARD_FINAL_STATE} next_window.make (wizard_information)
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
			wizard_information.set_creation_routine_name (creation_routine_name.text)
			if rb_project_type_dll.is_selected then
				wizard_information.set_console_application (False)
			else
				wizard_information.set_console_application (console_app_b.is_selected)
			end
			if clr_version_check.is_selected then				
				wizard_information.set_clr_version (most_recent_clr_version)
			else
				wizard_information.set_clr_version (clr_version_cb.text)
			end
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
	creation_routine_name: WIZARD_SMART_TEXT_FIELD

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
				if lower_case_root_class_name.is_equal (interface_names.l_none_class) then
					creation_routine_name.widget.disable_sensitive
				else
					creation_routine_name.widget.enable_sensitive
					creation_routine_name.set_text ("make")
				end
			end
		end
		
	on_change_generation_type is
			-- action performed when user changes generation type of application
		do
			if rb_project_type_exe.is_selected then
				console_app_b.enable_sensitive
			else
				console_app_b.disable_sensitive
			end
		end
		
	on_change_clr_version_combo is
			-- Action to perform when user changes the CLR version check button
		do			
			if clr_version_check.is_selected then
				clr_version_lab.disable_sensitive
				clr_version_cb.disable_sensitive				
			else
				clr_version_lab.enable_sensitive
				clr_version_cb.enable_sensitive
			end	
			wizard_information.set_is_most_recent_clr_version (clr_version_check.is_selected)
		end			

feature {NONE} -- Constants

	most_recent_clr_version: STRING
			-- The most recent clr version found on this system

	Exe_type: STRING is "Executable"
			-- Meaning of EXE

	Dll_type: STRING is "Dynamic-Link Library"
			-- Meaning of DLL

	Subtitle_text: STRING is "You can choose to create a .exe or a .dll file%N%
					%and select the names of the root class and its creation routine."

	l_Console_application: STRING is "Console application"
			-- Text associated to `console_app_b'.

	console_app_b: EV_CHECK_BUTTON
			-- Console application check box.
			
	clr_version_check: EV_CHECK_BUTTON
			-- Check button for using most recent CLR version
			
	clr_version_lab: EV_LABEL
			-- Label to indicate CLR version selection combo
			
	clr_version_cb: EV_COMBO_BOX;
			-- Clr versions selection combo box

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
end -- class WIZARD_SECOND_STATE
