indexing
	description: "Command tool that is displayed in the main panel."
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class
	COMMAND_TOOL_WIDGET

inherit
	FORM
		undefine
			init_toolkit
		redefine
			make, destroy, realize
		select
			implementation, realize
		end

	COMMAND_TOOL
		undefine
			parent
		redefine
			set_values
		end

creation
	make

feature -- Creation

	make (a_name: STRING; a_parent: COMPOSITE) is
			-- Create widgets.
		do
			Precursor (a_name, a_parent)
				--| Button row
			!! top_form.make ("Top form", Current)
			!! command_hole.make (top_form)
			!! title_label.make ("", top_form)
			!! search_class_name_button.make (Current, top_form)
			!! popup_instances_button.make (Current, top_form)
			!! popup_contexts_button.make (Current, top_form)
			!! menu_separator.make ("", Current)
				--| Argument box
			!! argument_label.make (Widget_names.Argument_label, Current)
			!! arguments_scrolled_w.make (Widget_names.scroll1, Current)
			!! arguments.make ("Arguments box", arguments_scrolled_w, Current)
			!! observer_hole.make (Current, Current)
			!! details_label.make (Widget_names.Detail_label, Current)
			!! details_button.make ("Arrow button", Current)

			set_values
			attach_all
			set_callbacks
		end

	set_values is
		do
			Precursor
			set_empty_title
		end

	attach_all is
			-- Perform attachments.
		do
				--| Top form
			top_form.attach_top (command_hole, 0)
			top_form.attach_top (title_label, 0)
			top_form.attach_top (search_class_name_button, 0)
			top_form.attach_top (popup_instances_button, 0)
			top_form.attach_top (popup_contexts_button, 0)
			top_form.attach_bottom (command_hole, 0)
			top_form.attach_bottom (title_label, 0)
			top_form.attach_bottom (search_class_name_button, 0)
			top_form.attach_bottom (popup_contexts_button, 0)
			top_form.attach_bottom (popup_instances_button, 0)
			top_form.attach_left (command_hole, 0)
			top_form.attach_left_widget (command_hole, title_label, 10)
			top_form.attach_right (popup_contexts_button, 0)
			top_form.attach_right_widget (popup_contexts_button, popup_instances_button, 0)
			top_form.attach_right_widget (popup_instances_button, search_class_name_button, 0)

			attach_top (top_form, 0)
			attach_left (top_form, 0)
			attach_right (top_form, 0)
			attach_top_widget (top_form, menu_separator, 0)
			attach_left (menu_separator, 0)
			attach_right (menu_separator, 0)
			attach_top_widget (menu_separator, argument_label, 0)
			attach_left (argument_label, 5)
			attach_top_widget (argument_label, arguments_scrolled_w, 0)
			attach_left (arguments_scrolled_w, 5)
			attach_right (arguments_scrolled_w, 5)
			attach_top_widget (arguments_scrolled_w, observer_hole, 0)
			attach_left (observer_hole, 5)
			attach_bottom (observer_hole, 0)
			attach_top_widget (arguments_scrolled_w, details_label, 0)
			attach_top_widget (arguments_scrolled_w, details_button, 0)
			attach_right (details_button, 5)
			attach_right_widget (details_button, details_label, 5)
			attach_bottom (details_label, 0)
			attach_bottom (details_button, 0)
		end

feature

	clear is
			-- Clear current editor.
		do
			save_previous_instance
			arguments.wipe_out
			command_editor.clear
		end

	close is
			-- Close current editor
		do
			clear
		end

feature -- Update

	update_title is
		local
			tmp: STRING
		do
			if command_instance = Void then
				set_empty_title
			else
				!! tmp.make (15)
				tmp.append (command_instance.label)
				title_label.set_text (tmp)
			end			
		end

	set_empty_title is
		do
			title_label.set_text ("Empty tool")
		end

feature -- Destroy

	destroy is
		do
		end

feature

	display is
			-- Raise Current command tool
		do
			main_panel.raise
		end

	show_command_editor is
		do
			main_panel.show_command_editor
		end

	hide_command_editor is
		do
			main_panel.hide_command_editor
		end

	command_editor_shown: BOOLEAN  is
		do
			Result := main_panel.command_editor_shown
		end

	realize is
		do
			Precursor
			hide_command_editor
		end

feature {NONE} -- Attributes

	top_form: FORM
			-- Form corresponding to the button row

	title_label: LABEL
			-- Label used to display current edited instance
	
	command_editor: COMMAND_EDITOR is
			--  Editor to edit Eiffel Code of a command
		do
			Result := main_panel.command_editor
		end

end -- class COMMAND_TOOL_WIDGET
