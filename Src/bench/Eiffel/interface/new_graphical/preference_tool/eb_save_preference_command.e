indexing

	description:
		"Command to save and validate all changes in resources."
	date: "$Date$"
	revision: "$Revision$"

class EB_SAVE_PREFERENCE_COMMAND

inherit
	EB_PREFERENCE_COMMAND
	EXECUTION_ENVIRONMENT
--	EB_RESOURCES

creation
	make

feature {EB_PREFERENCE_COMMAND} -- Execution

	execute (arg: EV_ARGUMENT1 [ANY]; data: EV_EVENT_DATA) is
			-- Execute Current.
		local
			wd: EV_WARNING_DIALOG
		do
			wd ?= arg.first
			if wd /= Void then
				wd.destroy
			elseif arg = save_it then
					--| Save chosen from the save interface

				save_resources
			elseif arg = cancel_it then
					--| Cancel chosen from the save interface

				dialog.hide
				dialog.destroy
				dialog := Void
			elseif tool /= Void then
				if arg /= Void then
						--| Current is called from
						--| the Save command.
					close_tool := True
				end
				tool.validate_all
				if tool.is_all_valid then
					build_interface
				end
			end
		end

	save_resources is
			-- Save the resources
		local
			file: PLAIN_TEXT_FILE
			fn: FILE_NAME
			msg: STRING
			wd: EV_WARNING_DIALOG
			arg: EV_ARGUMENT
			file_names: RESOURCE_FILES
		do
			!! file_names.make ("bench")
			if install_button.state then
				if general_button.state then
					!! fn.make_from_string (file_names.system_general)
				else
					!! fn.make_from_string (file_names.system_specific)
				end
			elseif home_dir_button /= Void and then home_dir_button.state then
				if general_button.state then
					!! fn.make_from_string (file_names.user_general)
				else
					!! fn.make_from_string (file_names.user_specific)
				end
			elseif defaults_button /= Void and then defaults_button.state then
				if general_button.state then
					!! fn.make_from_string (file_names.defaults_general)
				else
					!! fn.make_from_string (file_names.defaults_specific)
				end
			end
			if fn /= Void then
				!! fn.make_from_string ("/miami3/bonnard/toto")
				!! file.make (fn)
				if  file.is_writable then
					tool.validate_all
					if tool.is_all_valid then
						file.open_write
						save_resources_to_file (file)
						file.close
						dialog.hide
						dialog.destroy
						if close_tool then
							close_tool := False
							tool.destroy
						end
					end
				else
					Create msg.make (0)
					msg.append ("Do not have appropriate permissions to%Nsave to file ")
					msg.append (fn)
					Create wd.make_with_text (dialog, "Warning", msg)
					Create {EV_ARGUMENT1 [ANY]} arg.make(wd)
					wd.add_ok_command (Current, arg)
					wd.show
				end
			end
		end

	save_resources_to_file (file: PLAIN_TEXT_FILE) is
			-- Save all resources to `file'.
		require
			file_not_void: file /= Void
			file_is_open_write: file.is_open_write
		local
			pl: LINKED_LIST [EB_ENTRY_PANEL]
		do
			from
				pl := tool.panel_list
				pl.start
			until
				pl.after
			loop
				pl.item.save_resources (file)
				pl.forth
			end
		end

feature {NONE} -- Implementation

	build_interface is
			-- Build the interface for the save command.
		do
			Create dialog.make (tool.parent)
			dialog.set_title ("Save Shell")

			build_radio_boxes (dialog.display_area)

			build_buttons (dialog.action_area)

--			dialog.set_exclusive_grab

			dialog.show
		end

	build_buttons (form: EV_HORIZONTAL_BOX) is
			-- Build the button forms.
		require
			form_not_void: form /= Void
		local
			save_button, cancel_button: EV_BUTTON
		do
			Create cancel_button.make_with_text (form, "Cancel")
			cancel_button.add_click_command (Current, cancel_it)
			Create Save_button.make_with_text (form, "Save")
			save_button.add_click_command (Current, save_it)

		end

	build_radio_boxes (form: EV_VERTICAL_BOX) is
			-- Build both radio boxes.
		require
			form_not_void: form /= Void
		local
			frame_1, frame_2: EV_FRAME
			box_1, box_2: EV_VERTICAL_BOX
			label: EV_LABEL
			resource_files: RESOURCE_FILES
		do
			Create label.make_with_text (form, "Where do you want to save the resources?")

			Create frame_1.make_with_text (form, "Directories")
			Create frame_2.make_with_text (form, "File")

			Create box_1.make (frame_1)
		
			Create box_2.make (frame_2)

			Create general_button.make_with_text (box_2, "General resource file")
			Create platform_button.make_with_text (box_2, "Platform specific resource file")
			platform_button.set_state (true)

			Create resource_files.make ("bench")

			Create install_button.make_with_text (box_1, "Install Directory")
			install_button.set_state (true)
			if resource_files.user_specific /= Void then
				Create home_dir_button.make_with_text (box_1, "Home Directory")
			end

			if resource_files.defaults_general /= Void then
				Create defaults_button.make_with_text (box_1, "$EIF_DEFAULTS Directory")
			end

		end

feature {NONE} -- Arguments

	save_it: EV_ARGUMENT1 [ANY] is
		once
			Create Result.make (void)
		end

	cancel_it: EV_ARGUMENT1 [ANY] is
		once
			Create Result.make (void)
		end

feature {NONE} -- User Interface

	install_button,
	home_dir_button,
	defaults_button,
			-- Buttons that specify a directory

	general_button,
	platform_button: EV_RADIO_BUTTON
			-- Buttons that specify files

	dialog: EV_DIALOG
			-- The dialog for Current

feature {NONE} -- Implementation

	close_tool: BOOLEAN
			-- Should the preference tool be closed
			-- after saving?
			-- Ie.: is Current called from the menu entry
			-- or from the OK button in the preference tool?
end -- class EV_SAVE_PREFERENCE_COMMAND
