indexing

	description:
		"Command to save and validate all changes in resources.";
	date: "$Date$";
	revision: "$Revision$"

class SAVE_PREF_CMD

inherit
	PREFERENCE_COMMAND;
	EXECUTION_ENVIRONMENT;
	RESOURCES

creation
	make

feature -- Properties

	name: STRING is "Save"

feature {NONE} -- Useless

	symbol: PIXMAP is
		do
			check
				do_not_call: false
			end
		end;

	dark_symbol: PIXMAP is
		do
			check
				do_not_call: false
			end
		end

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
			elseif argument = ok_it then
					--| OK chosen from the save interface

				save_resources
			elseif argument = cancel_it then
					--| Cancel chosen from the save interface

				dialog.popdown;
				dialog.destroy;
				dialog := Void
			elseif tool /= Void then
				if argument /= Void then
						--| Current is called from
						--| the OK command.
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
			wd: WARNING_D
		do
			if install_button.state then
				if general_button.state then
					!! fn.make_from_string (file_names.system_general)
				else
					!! fn.make_from_string (file_names.system_specific)
				end
			elseif home_dir_button.state then
				if general_button.state then
					!! fn.make_from_string (file_names.user_general)
				else
					!! fn.make_from_string (file_names.user_specific)
				end
			elseif project_button.state then
				if general_button.state then
				else
				end
			end
			if fn /= Void then
				!! file.make (fn)
				if file.exists and then file.is_writable then
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
					msg.append ("Unappropriate permissions to%Nsafe to that file.");
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
			check_form, button_form: FORM
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
			dialog.popup;
			dialog.raise
		end;

	build_buttons (form: FORM) is
			-- Build the button forms.
		require
			form_not_void: form /= Void
		local
			ok_button, cancel_button: PUSH_B
		do
			!! cancel_button.make ("Cancel", form);
			cancel_button.add_activate_action (Current, cancel_it);
			!! ok_button.make ("Ok", form);
			ok_button.add_activate_action (Current, ok_it);

			form.set_fraction_base (2);
			form.attach_bottom (ok_button, 1);
			form.attach_top (ok_button, 1);
			form.attach_left_position (ok_button, 0);
			form.attach_right_position (ok_button, 1);
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
			label: LABEL
		do
			!! frame_1.make ("Directories", form);
			!! frame_2.make ("File", form);

			!! box_1.make ("Directory Box", frame_1);
			box_1.set_always_one (True);

			!! box_2.make ("File Box", frame_2);
			box_2.set_always_one (True);

			!! label.make ("Where do you want to save the resources?", form);

			!! general_button.make ("General resource file", box_2);
			general_button.set_toggle_on;
			!! platform_button.make ("Platform specific resource file", box_2);

			!! install_button.make ("Install Directory", box_1);
			install_button.set_toggle_on;
			!! home_dir_button.make ("Home Directory", box_1);
			if get ("EIF_DEFAULTS") /= Void then
				home_dir_button.set_text ("$EIF_DEFAULTS Directory")
			end;
			!! project_button.make ("Project Directory", box_1);

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

	ok_it: ANY is
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
	project_button,
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
			-- or from the OK button in the preference tool?
end -- class SAVE_PREF_CMD
