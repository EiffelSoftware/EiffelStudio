indexing

	description:
		"Command to save and validate all changes in resources.";
	date: "$Date$";
	revision: "$Revision$"

class SAVE_PREF_CMD

inherit
	PREFERENCE_COMMAND;
	EXECUTION_ENVIRONMENT;
	EB_RESOURCES

creation
	make

feature {PREFERENCE_COMMAND} -- Execution

	execute (argument: ANY) is
			-- Execute Current.
		local
			wd: WARNING_D
		do
			wd ?= argument
			if wd /= Void then
				wd.popdown;
				wd.destroy
			elseif argument = save_it then
					--| Save chosen from the save interface

				save_resources
			elseif argument = cancel_it then
					--| Cancel chosen from the save interface

				dialog.popdown;
				dialog.destroy;
				dialog := Void
			elseif tool /= Void then
				if argument /= Void then
						--| Current is called from
						--| the Save command.
					close_tool := True
				end;
				tool.validate_all;
				if tool.is_valid then
					build_interface
				end
			end
		end

	save_resources is
			-- Save the resources
		local
			file: PLAIN_TEXT_FILE;
			fn: FILE_NAME;
			msg: STRING;
			wd: WARNING_D;
			file_names: RESOURCE_FILES
		do
			!! file_names.make ("bench");
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
				!! file.make (fn)
				if
					(file.exists and then file.is_writable)
					or else (not file.exists and then file.is_creatable)
				then
					tool.validate_all
					if tool.is_valid then
						file.open_write;
						save_resources_to_file (file);
						file.close;
						dialog.popdown;
						dialog.destroy;
						if close_tool then
							close_tool := False
							tool.close
						end
					end
				else
					!! wd.make ("Warning", dialog);
					!! msg.make (0);
					msg.append ("Do not have appropriate permissions to%Nsave to file ");
					msg.append (fn);
					wd.set_message (msg);
					wd.hide_help_button;
					wd.hide_cancel_button;
					wd.add_ok_action (Current, wd);
					wd.set_title ("Warning");
					wd.popup;
					wd.raise;
				end
			end
		end

	save_resources_to_file (file: PLAIN_TEXT_FILE) is
			-- Save all resources to `file'.
		require
			file_not_void: file /= Void;
			file_is_open_write: file.is_open_write
		local
			cats: LINKED_LIST [PREFERENCE_CATEGORY];
		do
			from
				cats := tool.category_list;
				cats.start
			until
				cats.after
			loop
				cats.item.save_resources (file);
				cats.forth
			end
		end;

feature {NONE} -- Implementation

	build_interface is
			-- Build the interface for the save command.
		local
			check_form, button_form: FORM;
			att: WINDOW_ATTRIBUTES
		do
			!! dialog.make ("Save Shell", tool);
			!! button_form.make ("Button Form", dialog);
			!! check_form.make ("Check Form", dialog);

			build_radio_boxes (check_form);

			build_buttons (button_form);

			dialog.attach_left (button_form, 0);
			dialog.attach_right (button_form, 0);
			dialog.attach_bottom (button_form, 0);

			dialog.attach_left (check_form, 0);
			dialog.attach_right (check_form, 0);
			dialog.attach_top (check_form, 0);
			dialog.attach_bottom_widget (button_form, check_form, 0)

			dialog.set_exclusive_grab;
			!! att;
			att.set_composite_attributes (dialog);
			dialog.popup;
			dialog.raise
		end;

	build_buttons (form: FORM) is
			-- Build the button forms.
		require
			form_not_void: form /= Void
		local
			save_button, cancel_button: PUSH_B
		do
			!! cancel_button.make ("Cancel", form);
			cancel_button.add_activate_action (Current, cancel_it);
			!! Save_button.make ("Save", form);
			save_button.add_activate_action (Current, save_it);

			form.set_fraction_base (2);
			form.attach_bottom (save_button, 1);
			form.attach_top (save_button, 1);
			form.attach_left_position (save_button, 0);
			form.attach_right_position (save_button, 1);
			form.attach_left_position (cancel_button, 1);
			form.attach_right_position (cancel_button, 2);
			form.attach_bottom (cancel_button, 1);
			form.attach_top (cancel_button, 1);
		end;

	build_radio_boxes (form: FORM) is
			-- Build both radio boxes.
		require
			form_not_void: form /= Void
		local
			frame_1, frame_2: FRAME;
			box_1, box_2: RADIO_BOX;
			label: LABEL;
			resource_files: RESOURCE_FILES
		do
			!! frame_1.make ("Directories", form);
			!! frame_2.make ("File", form);

			!! box_1.make ("Directory Box", frame_1);
			box_1.set_always_one (True);

			!! box_2.make ("File Box", frame_2);
			box_2.set_always_one (True);

			!! label.make ("Where do you want to save the resources?", form);

			!! general_button.make ("General resource file", box_2);
			!! platform_button.make ("Platform specific resource file", box_2);
			platform_button.set_toggle_on;

			!! resource_files.make ("bench");

			!! install_button.make ("Install Directory", box_1);
			install_button.set_toggle_on;
			if resource_files.user_specific /= Void then
				!! home_dir_button.make ("Home Directory", box_1)
			end;

			if resource_files.defaults_general /= Void then
				!! defaults_button.make ("$EIF_DEFAULTS Directory", box_1);
			end;

			form.attach_left (label, 1);
			form.attach_top (label, 1);
			form.attach_top_widget (label, frame_1, 1);
			form.attach_left (frame_1, 1);
			form.attach_right (frame_1, 1);
			form.attach_top_widget (frame_1, frame_2, 1);
			form.attach_left (frame_2, 1);
			form.attach_right (frame_2, 1);
			form.attach_bottom (frame_2, 1);

		end

feature {NONE} -- Arguments

	save_it: ANY is
		once
			!! Result
		end;

	cancel_it: ANY is
		once
			!! Result
		end

feature {NONE} -- User Interface

	install_button,
	home_dir_button,
	defaults_button,
			-- Buttons that specify a directory

	general_button,
	platform_button: TOGGLE_B;
			-- Buttons that specify files

	dialog: FORM_D
			-- The dialog for Current

feature {NONE} -- Properties

	close_tool: BOOLEAN
			-- Should the preference tool be closed
			-- after saving?
			-- Ie.: is Current called from the menu entry
			-- or from the Cancel button in the preference tool?
end -- class SAVE_PREF_CMD
