indexing
	description: "A command tool: represents actually an instance of %
				% a command with the possibility to edit the command %
				% source code."
	Id: "$Id$"
	Date: "$Date$"
	Revision: "$Revision$"

class 

	COMMAND_TOOL
	
inherit

	EB_TOP_SHELL
		redefine
			make, destroy, set_geometry, realize
		select
			implementation, realize
		end

	CONSTANTS

	WINDOWS
		select
			init_toolkit
		end
	
	CLOSEABLE

	ERROR_POPUPER

	COMPOSITE
		rename
			init_toolkit as composite_init_toolkit,
			implementation as composite_implementation,
			realize as composite_realize
		undefine
			destroy, set_x_y, top, screen, raise
		end

	COMMAND

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
			!! new_command_entry.make (Menu_names.create_command, action_category)
			!! separator_2.make ("", action_category)
			!! add_formal_argument_entry.make (Menu_names.Add_formal_argument, action_category)
			!! remove_formal_argument_entry.make (Menu_names.Remove_formal_argument, action_category)
				--| Top form
			!! separator_3.make ("", top_form)
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
					--| List form
			!! list_form.make ("List form", top_split_form)
			!! observers_form.make ("Observer form", list_form)
			!! arguments_form.make ("Label form", list_form)
			!! observers_label.make ("Observers:", observers_form)
			!! observers_scrolled_w.make (Widget_names.scroll2, observers_form)
			!! observers.make ("Observer box", observers_scrolled_w, Current)
			!! argument_label.make (Widget_names.Argument_label, arguments_form)
			!! arguments_scrolled_w.make (Widget_names.scroll1, arguments_form)
			!! arguments.make ("Arguments box", arguments_scrolled_w, Current)
			!! details_label.make (Widget_names.Detail_label, top_split_form)
			!! details_button.make ("Arrow button", top_split_form)
			
				--| Bottom split form
			!! command_editor.make ("", bottom_split_form)
				
				--| Holes
			!! observer_hole.make (Current, observers_form)
			!! add_argument_hole.make (command_editor, arguments_form)
			set_values
			attach_all
			set_callbacks
		end

feature {NONE} -- Initialization

	set_values is
			-- Set values for GUI elements.
		local
			
			del_com: DELETE_WINDOW
		do
			command_editor.set_command_tool (Current)
			command_editor.create_interface
			new_command_entry.set_command_editor (command_editor)
			if Pixmaps.command_instance_pixmap.is_valid then
				set_icon_pixmap (Pixmaps.command_instance_pixmap)
			end
			initialize_window_attributes
			!! del_com.make (Current)
			set_delete_command (del_com)
			details_button.set_right
			command_hole.set_parent_command_tool (Current)
			command_hole.set_empty_symbol
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
			top_form.attach_top (separator_3, 1)
			top_form.attach_left (separator_3, 0)
			top_form.attach_right (separator_3, 0)	
			top_form.attach_top_widget (separator_3, command_hole, 0)
			top_form.attach_top_widget (separator_3, trash_hole, 0)
			top_form.attach_top_widget (separator_3, search_class_name_button, 0)
			top_form.attach_top_widget (separator_3, popup_instances_button, 0)
			top_form.attach_top_widget (separator_3, popup_contexts_button, 0)
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
			top_split_form.attach_top (list_form, 0)
			top_split_form.attach_left (list_form, 0)
			top_split_form.attach_right (list_form, 0)
			top_split_form.attach_bottom_widget (details_label, list_form, 0)
			top_split_form.attach_bottom_widget (details_button, list_form, 0)
			top_split_form.attach_right (details_button, 5)
			top_split_form.attach_right_widget (details_button, details_label, 5)
			top_split_form.attach_bottom (details_label, 0)
			top_split_form.attach_bottom (details_button, 0)

						--| List form
			list_form.set_fraction_base (5)
			list_form.attach_top (observers_form, 0)
			list_form.attach_top (arguments_form, 0)
			list_form.attach_left (observers_form, 0)
			list_form.attach_right_position (observers_form, 2)
			list_form.attach_left_position (arguments_form, 2)
			list_form.attach_right (arguments_form, 0)
			list_form.attach_bottom (observers_form, 0)
			list_form.attach_bottom (arguments_form, 0)

			observers_form.attach_top (observer_hole, 0)
			observers_form.attach_left (observer_hole, 0)
			observers_form.attach_top (observers_label, 5)
			observers_form.attach_left_widget (observer_hole, observers_label, 0)
			observers_form.attach_top_widget (observer_hole, observers_scrolled_w, 0)
			observers_form.attach_top_widget (observers_label, observers_scrolled_w, 2)
			observers_form.attach_left (observers_scrolled_w, 0)
			observers_form.attach_right (observers_scrolled_w, 0)
			observers_form.attach_bottom (observers_scrolled_w, 0)

			arguments_form.attach_top (add_argument_hole, 0)
			arguments_form.attach_left (add_argument_hole, 0)
			arguments_form.attach_top (argument_label, 5)
			arguments_form.attach_left_widget (add_argument_hole, argument_label, 5)
			arguments_form.attach_top_widget (add_argument_hole, arguments_scrolled_w, 0)
			arguments_form.attach_top_widget (argument_label, arguments_scrolled_w, 2)
			arguments_form.attach_left (arguments_scrolled_w, 0)
			arguments_form.attach_right (arguments_scrolled_w, 0)
			arguments_form.attach_bottom (arguments_scrolled_w, 0)

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
	top_form,
			-- Button form of the top shell
	list_form,
			-- Form in which will be displayed the observers list
			-- and the arguments list.
	observers_form,
			-- Form containing the observer box
	arguments_form: FORM
			-- Form containing the argument box

		--| Split window
	split_window: SPLIT_WINDOW
			-- Split window containing basically the argument list
			-- and the command editor
	top_split_form,
			-- Top frame in `split_window'
	bottom_split_form: SPLIT_WINDOW_CHILD
			-- Bottom frame of `split_window'

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
	new_command_entry: NEW_COMMAND_BUTTON
	separator_2: SEPARATOR
	add_formal_argument_entry: PUSH_B
	remove_formal_argument_entry: PUSH_B

		--| Button row
	command_hole: COMMAND_TOOL_HOLE
			-- Hole used to accept command instances
	trash_hole: CUT_HOLE
			-- Trash hole	
	search_class_name_button: CMD_ED_POPUP_CLASS_NAME
			-- Button used to display a dialog in order to retarget the
			-- current tool according to the name of the command
	popup_instances_button: CMD_ED_POPUP_INST
			-- Button used to popup every instances of the current command
	popup_contexts_button: CMD_ED_POPUP_CONTEXT
			-- Button used to popup every context that could be used as
			-- instances for the argument of this command

	separator_3,

	menu_separator: THREE_D_SEPARATOR
			
		--| Elements corresponding to the instance editor
	observer_hole: OBSERVER_HOLE
			-- Hole used to add observers
	add_argument_hole: ARG_HOLE
			-- Hole used to add an ancestor
	observers_scrolled_w,
			-- Scrolled window enclosing `observers'
	arguments_scrolled_w: SCROLLED_W
			-- Scrolled window enclosing `arguments'
	details_button: ARROW_B
			-- Button used to display the command editor part
	observers_label,
			-- Label specifying "Observed by"
	argument_label,
			-- Label specifying "Arguments"
	details_label: LABEL
			-- Label specifying "Details"

		--| Elements corresponding to the command editor
	command_editor: COMMAND_EDITOR
			--  Editor to edit Eiffel Code of a command

feature -- Geometry

	set_geometry is
		do
			set_size (Resources.cmd_inst_ed_width,
						Resources.cmd_inst_ed_height)
		end
	
feature {COMMAND_EDITOR}

		--| Elements corresponding to the command editor
	arguments: ARG_INST_BOX
			-- Arguments of command_instance

feature

	command_instance: CMD_INSTANCE
			-- Currently command_instance

	clear is
			-- Clear current editor.
		do
			command_hole.set_empty_symbol
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

feature {NONE}

	save_previous_instance is
		do
			if command_instance /= Void then
				command_instance.save_arguments
				command_instance.reset
				command_instance := Void
			end
		end

feature

	edited_command: CMD is
			-- Currently edited command in the `command_editor'.
		do
			if command_instance /= Void then
				Result := command_instance.associated_command
			else
				Result := Void
			end
		end

	current_command: CMD is
			-- Currently edited command.
		do
			Result := command_editor.current_command
		end

	set_instance (c: CMD_INSTANCE) is
			-- Set command_instance to `c' and update
			-- the editor.
		require
			c_not_being_edited: not (c.edited and then c = command_instance)
			not_void_c: c /= Void
		do
			if c /= command_instance then
				set_instance_only (c)
--				if current_command /= c.associated_command then
					command_editor.set_command (c.associated_command)
					if realized and then command_editor_shown then
						command_editor.edit_command (c.associated_command)
					end
--				end	
			end
		end

feature {COMMAND_TOOL_HOLE}

	set_instance_only (c: CMD_INSTANCE) is
			-- Set `command_instance' to `c'. DO NOT update
			-- the editor
		do
			save_previous_instance
			if command_instance /= Void then
				command_instance.set_editor (Void)
			end
			command_instance := c
			c.set_editor (Current)
			arguments.set (command_instance.arguments)
			observers.set (command_instance.observers)
			observed_commands.set (command_instance.observed_commands)
			update_title
			command_hole.set_full_symbol
		end

feature

	set_command (c: CMD) is
			-- Create a command tool with a new instance
			-- of `c'.
		local
			cmd_inst: CMD_INSTANCE
		do
			!! cmd_inst.session_init (c)
			set_instance (cmd_inst)
		end

	add_observer (inst: CMD_INSTANCE) is
			-- Add an observer.
		do
			observers.extend (inst)
		end

	add_observed_command (inst: CMD_INSTANCE) is
			-- Add an observed_command.
		do
			observed_commands.extend (inst)
		end

	remove_observer (inst: CMD_INSTANCE) is
			-- Remove an observer.
		do
			observers.start
			observers.prune (inst)
		end

	remove_observed_command (inst: CMD_INSTANCE) is
			-- Remove an observer.
		do
			observed_commands.start
			observed_commands.prune (inst)
		end

	observers: OBSERVER_BOX
			-- Observers box of the command tool

	observed_commands: OBSERVER_BOX is
			-- Observed commands box of the command editor
		do
			Result := command_editor.observed_commands
		end
			
	save_command is
			-- Save command currently edited in command editor.
		require
			command_editor_shown: command_editor_shown
		do
			command_editor.save_command
		end

feature -- Update

	update_title is
			-- Update the title of the command tool
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

feature {CMD_INSTANCE} -- Update

	add_argument (an_argument: ARG_INSTANCE) is
			-- Add a formal argument in the argument box.
		do
			arguments.extend (an_argument)
		end

	add_argument_at (an_arg: ARG_INSTANCE; i: INTEGER)is
			-- Add a formal argument in the argument box.
		require
			valid_position: i > 0
		do
			arguments.go_i_th (i - 1)
			arguments.put_right (an_arg)
		end

	remove_argument_icon (i: INTEGER) is
			-- Remove icon in `arguments' at position `i'.
		do
			arguments.go_i_th (i)
			arguments.remove
		end

feature {ARG_INST_ICON}

	remove_argument (arg_inst: ARG_INSTANCE; arg_icon: ARG_INST_ICON) is
			-- Remove a local argument.
			-- If several instances exist, the user
			-- has to choose between creating a new command, editing
			-- the current command (and update every instance) or
			-- cancelling the operation.
		local
			i: INTEGER
			cut_arg: CMD_CUT_ARGUMENT
			user_command: USER_CMD
		do
			user_command ?= edited_command
			if  user_command /= Void then
 				if user_command.has_descendents then
 					popup_error_box (Messages.instance_rem_arg_er)
 				else
					i := arguments.index_of (arg_inst, 1)
					!! cut_arg.make (Current)
					cut_arg.set_index (i)
					cut_arg.execute (user_command)
				end
			end
		end

feature 

	empty: BOOLEAN is
			-- Is `Current' empty?
		do
			Result := command_instance = Void
		end

	destroy is	
			-- Destroy current command tool
		do
			trash_hole.unregister
			command_hole.unregister
			arguments.unregister_holes
			command_hole.set_empty_symbol
			Precursor
		end

	display is
			-- Raise current command tool
		do
--			hide_other_command_editor
--			command_editor.set_command (command_instance.associated_command)
			window_mgr.display (Current)
		end

feature -- ERROR_POPUPER features

	popup_error_box (s: STRING) is
			-- Popup error box with message `s'.
		require
			not_void_s: s /= Void
		do
			error_box.popup (Current, s, Void)
		end

	popuper_parent: COMPOSITE is
		do
			Result := Current
		end

feature -- COMMAND features

	execute (arg: ANY) is
		local
			an_arrow: ARROW_B
		do
			an_arrow ?= arg
			if an_arrow = details_button then 
				if command_instance /= Void then
					if command_editor_shown then
						hide_command_editor
					else
						show_command_editor
					end
				end
			else
				close
			end
		end

	set_callbacks is
			-- Add action on `details_button'.
		local
			exit_cmd: EXIT_EIFFEL_BUILD_CMD
		do
			exit_tool_entry.add_activate_action (Current, Void) 
			!! exit_cmd
			exit_entry.add_activate_action (exit_cmd, Void)
			details_button.add_activate_action (Current, details_button)
		end

	command_editor_shown: BOOLEAN is
			-- Is command editor shown?
		do
			Result := bottom_split_form.managed
		end

	hide_command_editor is
			-- Hide command editor.
		do
			details_button.set_right
			command_editor.clear
			if already_open then
				set_height (height - bottom_split_form.height)
			end
			command_editor.hide
			bottom_split_form.unmanage
		end

	show_command_editor is
			-- Show command editor
		do
			details_button.set_down
			hide_other_command_editor
			split_window.set_proportion (100 * top_split_form.height // 
						(top_split_form.height + Resources.cmd_ed_height))
			set_height (height + Resources.cmd_ed_height)
			command_editor.edit_command (command_instance.associated_command)
			command_editor.show
			bottom_split_form.manage
		end

	hide_other_command_editor is
			-- Before showing attached command editor, hide the
			-- other one if exist.
		require
			command_instance_set: command_instance /= Void
		do
			if command_instance.associated_command.edited then
				command_instance.associated_command.command_editor.hide_yourself
			end
		end

	realize is
		do
			Precursor
			bottom_split_form.unmanage
			already_open := true
		end

feature {NONE} -- Attribute

	already_open: BOOLEAN
			-- 	Has the command window been already opened

end -- COMMAND_TOOL
