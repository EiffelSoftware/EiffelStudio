indexing
	description: "An independant command tool."
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class
	COMMAND_TOOL_TOP_SHELL

inherit

	EB_TOP_SHELL
		redefine
			make, destroy, set_geometry, realize
		select
			implementation, realize
		end

	COMMAND_TOOL
		redefine
			set_values
		select
			init_toolkit
		end

creation
	make

feature -- Creation

	make (a_name: STRING; a_screen: SCREEN) is
			-- Create widgets.
		local
			close_b: CLOSE_WINDOW_BUTTON
		do
			Precursor (a_name, a_screen)
			set_title (a_name)
			set_icon_name (a_name)
				--| Forms
			!! form.make (Widget_names.form, Current)
			!! top_form.make (Widget_names.form, form)
				--| Menu bar
			!! menu_bar.make (Menu_names.Menu_bar, Current)
			!! file_category.make (Menu_names.File, menu_bar)
			!! action_category.make (Menu_names.Actions, menu_bar)
			!! help_category.make (Menu_names.Help, menu_bar)
				--| Entries in the File category
			!! generate_entry.make (Menu_names.Generate, file_category)
			!! separator_1.make ("", file_category)
			!! exit_tool_entry.make (Menu_names.Exit_tool, file_category)
			!! exit_entry.make (Menu_names.Exit, file_category)
				--| Entries in the Actions category
			!! add_formal_argument_entry.make (Menu_names.Add_formal_argument, action_category)
			!! remove_formal_argument_entry.make (Menu_names.Remove_formal_argument, action_category)
				--| Top form
--			!! command_hole.make (Current, top_form)
			!! command_hole.make (top_form)
			!! trash_hole.make (top_form)
			!! search_class_name_button.make (Current, top_form)
			!! popup_instances_button.make (Current, top_form)
			!! popup_contexts_button.make (Current, top_form)
				--| Split window
			!! menu_separator.make ("", form)
			!! split_window.make_horizontal ("Split window", form)
			!! top_split_form.make ("Top split form", split_window)
			!! bottom_split_form.make ("Bottom split form", split_window)
				--| Top split form
			!! argument_label.make (Widget_names.Argument_label, top_split_form)
			!! arguments_scrolled_w.make (Widget_names.scroll1, top_split_form)
			!! arguments.make ("Arguments box", arguments_scrolled_w, Current)
			!! observer_hole.make (Current, top_split_form)
			!! details_label.make (Widget_names.Detail_label, top_split_form)
			!! details_button.make ("Arrow button", top_split_form)
			
				--| Bottom split form
			!! command_editor.make ("", bottom_split_form)
			set_values
			attach_all
			set_callbacks
		end

	set_values is
			-- Set the values for the GUI elements.
		local
			
			del_com: DELETE_WINDOW
		do
			if Pixmaps.command_instance_pixmap.is_valid then
				set_icon_pixmap (Pixmaps.command_instance_pixmap)
			end
			initialize_window_attributes
			!! del_com.make (Current)
			set_delete_command (del_com)
			command_editor.set_command_tool (Current)
			Precursor
		end

	attach_all is
			-- Performs attachments.
		do
				--| Entire window
			form.attach_top (top_form, 0)
			form.attach_left (top_form, 0)
			form.attach_right (top_form, 0)
			form.attach_top_widget (top_form, menu_separator, 0)
			form.attach_right (menu_separator, 0)
			form.attach_left (menu_separator, 0)
			form.attach_top_widget (menu_separator, split_window, 0)
			form.attach_left (split_window, 0)
			form.attach_right (split_window, 0)
			form.attach_bottom (split_window, 0)
				--| Top form
			top_form.attach_top (command_hole, 0)
			top_form.attach_top (trash_hole, 0)
			top_form.attach_top (search_class_name_button, 0)
			top_form.attach_top (popup_instances_button, 0)
			top_form.attach_top (popup_contexts_button, 0)
			top_form.attach_bottom (command_hole, 0)
			top_form.attach_bottom (trash_hole, 0)
			top_form.attach_bottom (search_class_name_button, 0)
			top_form.attach_bottom (popup_contexts_button, 0)
			top_form.attach_bottom (popup_instances_button, 0)
			top_form.attach_left (command_hole, 0)
			top_form.attach_left_widget (command_hole, trash_hole, 0)
			top_form.attach_right (popup_contexts_button, 0)
			top_form.attach_right_widget (popup_contexts_button, popup_instances_button, 0)
			top_form.attach_right_widget (popup_instances_button, search_class_name_button, 0)
				--| Top split window
			top_split_form.attach_top (argument_label, 0)
			top_split_form.attach_left (argument_label, 5)
			top_split_form.attach_top_widget (argument_label, arguments_scrolled_w, 0)
			top_split_form.attach_left (arguments_scrolled_w, 5)
			top_split_form.attach_right (arguments_scrolled_w, 5)
			top_split_form.attach_top_widget (arguments_scrolled_w, observer_hole, 0)
			top_split_form.attach_left (observer_hole, 5)
			top_split_form.attach_bottom (observer_hole, 0)
--			top_split_form.attach_top_widget (arguments_scrolled_w, details_label, 0)
--			top_split_form.attach_top_widget (arguments_scrolled_w, details_button, 0)
			top_split_form.attach_bottom_widget (details_label, arguments_scrolled_w, 0)
			top_split_form.attach_bottom_widget (details_button, arguments_scrolled_w, 0)
			top_split_form.attach_right (details_button, 5)
			top_split_form. attach_right_widget (details_button, details_label, 5)
			top_split_form.attach_bottom (details_label, 0)
			top_split_form.attach_bottom (details_button, 0)

				--| Bottom split window
			bottom_split_form.attach_top (command_editor, 0)
			bottom_split_form.attach_left (command_editor, 0)
			bottom_split_form.attach_right (command_editor, 0)
			bottom_split_form.attach_bottom (command_editor, 0)
		end

feature {NONE} -- Graphical interface

		--| Forms
	form,
			-- Form for the top shell
	top_form: FORM
			-- Button form of the top shell

		--| Split window
	split_window: SPLIT_WINDOW
			-- Split window containing basically the argument list
			-- and the command editor
	top_split_form,
			-- Top frame in `split_window'
	bottom_split_form: SPLIT_WINDOW_CHILD
			-- Bottom frame of `split_wondow'

		--| Menu Row
	menu_bar: BAR
	file_category: MENU_PULL
	action_category: MENU_PULL
	help_category: MENU_PULL
		--| Entries in the File category
	generate_entry: PUSH_B
	separator_1: SEPARATOR
	exit_tool_entry: PUSH_B
	exit_entry: PUSH_B
		--| Entries in the Action category
	add_formal_argument_entry: PUSH_B
	remove_formal_argument_entry: PUSH_B

	command_editor: COMMAND_EDITOR 
			--  Editor to edit Eiffel Code of a command

feature -- Geometry

	set_geometry is
		do
			set_size (Resources.cmd_inst_ed_width,
						Resources.cmd_inst_ed_height)
		end

feature

	clear is
			-- Clear current editor.
		do
--			command_hole.set_empty_symbol
			set_title (Widget_names.cmd_instance_editor)
			set_icon_name (Widget_names.cmd_instance_editor)
			save_previous_instance
			arguments.wipe_out
			command_editor.clear
		end

	close is
			-- Close Current Editor
		do
			clear
			window_mgr.close (Current)
		end

feature -- Update

	update_title is
		local
			tmp: STRING
		do
			!! tmp.make (0)
			tmp.append ("Command Tool: ")
			tmp.append (command_instance.label)
			tmp.append (": ")
			tmp.append (command_instance.associated_command.eiffel_type)
			set_title (tmp)
			set_icon_name (tmp)
		end

feature -- Destroy

	destroy is
		do
			trash_hole.unregister
			command_hole.unregister
			arguments.unregister_holes
			command_hole.set_empty_symbol
			Precursor
		end

feature

	display is
			-- Raise Current command tool
		do
			window_mgr.display (Current)
		end

	show_command_editor is
		do
			bottom_split_form.manage
		end

	hide_command_editor is
		do
			bottom_split_form.unmanage
		end

	command_editor_shown: BOOLEAN  is
		do
			Result := bottom_split_form.managed
		end

	realize is
		do
			Precursor
			hide_command_editor
		end

end -- class COMMAND_TOOL_TOP_SHELL
