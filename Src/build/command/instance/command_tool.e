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
	EB_WINDOW
		redefine
			make, destroy, set_geometry
		end

	CONSTANTS

	WINDOWS
		redefine
			popuper_parent
		end
	
	CLOSEABLE

	ERROR_POPUPER

	EV_COMMAND

creation
	make

feature {NONE} -- Initialization

	make (par: EV_WINDOW) is
			-- Create widgets.
		local
			vbox: EV_VERTICAL_BOX
			hbox: EV_HORIZONTAL_BOX
			menu_bar: EV_STATIC_MENU_BAR
			file_category: EV_MENU
			action_category: EV_MENU
			help_category: EV_MENU
--			menu_separator: EV_MENU_SEPARATOR
--			new_command_entry: NEW_COMMAND_BUTTON
			separator: EV_HORIZONTAL_SEPARATOR
			toolbar: EV_TOOL_BAR
			fixed: EV_FIXED
		do
			{EB_WINDOW} Precursor (par)
			create vbox.make (Current)
 				--| Menu bar
			create menu_bar.make (Current)
 			create file_category.make_with_text (menu_bar, Menu_names.File)
 			create action_category.make_with_text (menu_bar, Menu_names.Actions)
 			create help_category.make_with_text (menu_bar, Menu_names.Help)
 				--| Entries in the File category
 			create generate_entry.make_with_text (file_category, Menu_names.Generate)
--			create menu_separator.make (file_category)
 			create exit_tool_entry.make_with_text (file_category, Menu_names.Exit_tool)
 			create exit_entry.make_with_text (file_category, Menu_names.Exit)
 				--| Entries in the Actions category
--			create new_command_entry.make_with_text (action_category, Menu_names.create_command)
--			create menu_separator.make (action_category)
--			create add_formal_argument_entry.make_with_text (action_category, Menu_names.Add_formal_argument)
--			create remove_formal_argument_entry.make_with_text (action_category, Menu_names.Remove_formal_argument)

				--| Toolbar
			create separator.make (vbox)
			create toolbar.make (vbox)
			create command_hole.make (toolbar)
			create trash_hole.make (toolbar)
--			create tbseparator.make (toolbar)
--			create search_class_name_button.make (Current, toolbar)
--			create popup_instances_button.make (Current, toolbar)
--			create popup_contexts_button.make (Current, toolbar)

				--| Split window
			create split_area.make (Void)
				-- Void parent, in order to unmanaged the bottom part.
					--| Top split form
			create top_box.make (vbox)
			create hbox.make (top_box)
			hbox.set_spacing (3)

			create arguments.make (hbox)
			arguments.set_column_title (Widget_names.Argument_label, 1)
			arguments.set_column_title ("description", 2)
			arguments.set_minimum_height (55)
--			create add_argument_hole.make (command_editor, hbox1)

			create observers.make (hbox)
			observers.set_column_title ("Observers:", 1)
			observers.set_column_title ("description", 2)
			observers.set_minimum_height (55)
		--XX set column pixmap to observer hole symbol
--			create observer_hole.make (Current, hbox1)

--			create toolbar.make (top_box)
--			create fixed.make (hbox)
--			fixed.set_minimum_width (300)
			create details_button.make_with_text (top_box, Widget_names.Detail_label)
			details_button.set_expand (False)

					--| Bottom split form
			create command_editor.make (Current)
				-- Void parent, in order to unmanaged the bottom part.

			set_values
			set_callbacks
		end

	set_values is
			-- Set values for GUI elements.
		do
 			set_title (Widget_names.command_tool)
--			new_command_entry.set_command_editor (command_editor)
			set_icon_pixmap (Pixmaps.command_instance_pixmap)
--			initialize_window_attributes
			command_hole.set_data (Current)
			command_hole.set_callbacks
			command_hole.set_empty_symbol
		end

	set_callbacks is
			-- Add action on `details_button'.
		local
			cmd: EV_ROUTINE_COMMAND
		do
			set_close_callback (Void)
			create cmd.make (~close)
			exit_tool_entry.add_select_command (cmd, Void) 
			create cmd.make (~exit_build)
			exit_entry.add_select_command (cmd, Void)
			details_button.add_toggle_command (Current, Void)
		end

feature {NONE} -- Graphical interface

	split_area: EV_VERTICAL_SPLIT_AREA

	top_box: EV_VERTICAL_BOX

		--| Entries in the File category
	generate_entry: EV_MENU_ITEM
	exit_tool_entry: EV_MENU_ITEM
	exit_entry: EV_MENU_ITEM
		--| Entries in the Action category
--	add_formal_argument_entry: EV_MENU_ITEM
--	remove_formal_argument_entry: EV_MENU_ITEM

		--| Tool-bar
	command_hole: COMMAND_TOOL_HOLE
			-- Hole used to accept command instances
	trash_hole: CUT_HOLE
			-- Trash hole	
--	search_class_name_button: CMD_ED_POPUP_CLASS_NAME
--			-- Button used to display a dialog in order to retarget the
--			-- current tool according to the name of the command
--	popup_instances_button: CMD_ED_POPUP_INST
--			-- Button used to popup every instances of the current command
--	popup_contexts_button: CMD_ED_POPUP_CONTEXT
			-- Button used to popup every context that could be used as
			-- instances for the argument of this command

		--| Elements corresponding to the instance editor
--	observer_hole: OBSERVER_HOLE
--			-- Hole used to add observers
--	add_argument_hole: ARG_HOLE
--			-- Hole used to add an ancestor
	details_button: EV_TOGGLE_BUTTON
			-- Button used to display the command editor part

feature -- Text editor

	command_editor: COMMAND_EDITOR
			--  Editor to edit Eiffel Code of a command

feature -- COMMAND features

	execute (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
		do
			if command_instance /= Void then
				if not details_button.state and then command_editor.shown then
					hide_command_editor
				else
					show_command_editor
				end
			end
		end

	hide_command_editor is
			-- Hide command editor.
		local
			ct: EV_CONTAINER
		do
			command_editor.clear
			if shown then
				set_height (height - command_editor.height)
			end
			edited_command.reset
			ct := split_area.parent
			command_editor.set_parent (Void)
			split_area.set_parent (Void)
			top_box.set_parent (ct)
		end

	show_command_editor is
			-- Show command editor
		local
			ct: EV_CONTAINER
		do
			hide_other_command_editor
			command_editor.edit_command (command_instance.associated_command)
			ct := top_box.parent
			top_box.set_parent (Void)
			split_area.set_parent (ct)
			top_box.set_parent (split_area)
			command_editor.set_parent (split_area)
			set_height (height + Resources.cmd_ed_height)
			command_editor.update_boxes
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

feature -- Geometry

	set_geometry is
		do
			set_size (Resources.cmd_inst_ed_width,
						Resources.cmd_inst_ed_height)
		end
	
feature {COMMAND_EDITOR}

		--| Elements corresponding to the command editor
	arguments: EB_ICON_LIST
			-- Arguments of command_instance

feature

	command_instance: CMD_INSTANCE
			-- Currently command_instance

	clear is
			-- Clear current editor.
		do
--			command_hole.set_empty_symbol
			set_title (Widget_names.cmd_instance_editor)
--			set_icon_name (Widget_names.cmd_instance_editor)
--			save_previous_instance
--			arguments.wipe_out
--			command_editor.clear
		end


	close (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is 
			-- Close Current Editor
		do
--			if edited_command /= Void then
--				edited_command.reset
--			end
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
				if current_command /= c.associated_command then
					command_editor.set_command (c.associated_command)
					if shown and then command_editor.shown then
						command_editor.edit_command (c.associated_command)
					end
				end	
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
--			arguments.set (command_instance.arguments)
--			observers.set (command_instance.observers)
--			observed_commands.set (command_instance.observed_commands)
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
			create cmd_inst.session_init (c)
			set_instance (cmd_inst)
		end

-- 	add_observer (inst: CMD_INSTANCE) is
-- 			-- Add an observer.
-- 		do
-- 			observers.extend (inst)
-- 		end
-- 
-- 	add_observed_command (inst: CMD_INSTANCE) is
-- 			-- Add an observed_command.
-- 		do
-- 			observed_commands.extend (inst)
-- 		end
-- 
-- 	remove_observer (inst: CMD_INSTANCE) is
-- 			-- Remove an observer.
-- 		do
-- 			observers.start
-- 			observers.prune (inst)
-- 		end
-- 
-- 	remove_observed_command (inst: CMD_INSTANCE) is
-- 			-- Remove an observer.
-- 		do
-- 			observed_commands.start
-- 			observed_commands.prune (inst)
-- 		end

	observers: EB_ICON_LIST
			-- Observers box of the command tool

	observed_commands: EB_ICON_LIST is
			-- Observed commands box of the command editor
		do
			Result := command_editor.observed_commands
		end
			
	save_command is
			-- Save command currently edited in command editor.
		require
			command_editor_shown: command_editor.shown
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

-- feature {CMD_INSTANCE} -- Update
-- 
-- 	add_argument_icon (an_argument: ARG_INSTANCE) is
-- 			-- Add a formal argument in the argument box.
-- 		do
-- 			arguments.extend (an_argument)
-- 		end
-- 
-- 	add_argument_at (an_arg: ARG_INSTANCE; i: INTEGER)is
-- 			-- Add a formal argument in the argument box.
-- 		require
-- 			valid_position: i > 0
-- 		do
-- 			arguments.go_i_th (i - 1)
-- 			arguments.put_right (an_arg)
-- 		end
-- 
-- 	remove_argument_icon (i: INTEGER) is
-- 			-- Remove icon in `arguments' at position `i'.
-- 		do
-- 			arguments.go_i_th (i)
-- 			arguments.remove
-- 		end
-- 
-- feature {ARG_HOLE} -- Argument
--
-- 	add_argument (ts: TYPE_STONE) is
-- 			-- Add a formal argument to Currently edited
-- 			-- command. If several instances exist, the user
-- 			-- has to choose between creating a new command, editing
-- 			-- the current command (and update every instance) or
-- 			-- cancelling the operation.
-- 		local
-- 			new_argument: ARG
-- 			add_argument_cmd: CMD_ADD_ARGUMENT
-- 			user_command: USER_CMD
-- 		do
-- 			user_command ?= edited_command
-- 			if user_command /= Void then
--  				if user_command.has_descendents then
--  					popup_error_box (Messages.instance_add_arg_er)
--  				else
-- 					!! add_argument_cmd.make (Current)
-- 					!! new_argument.session_init (ts)
-- 					add_argument_cmd.set_element (new_argument)
-- 					add_argument_cmd.execute (user_command)	
-- 				end
-- 			end
-- 		end

--  feature {ARG_INST_ICON} -- Argument
-- 
-- 	remove_argument (arg_inst: ARG_INSTANCE; arg_icon: ARG_INST_ICON) is
-- 			-- Remove a local argument.
-- 			-- If several instances exist, the user
-- 			-- has to choose between creating a new command, editing
-- 			-- the current command (and update every instance) or
-- 			-- cancelling the operation.
-- 		local
-- 			i: INTEGER
-- 			cut_arg: CMD_CUT_ARGUMENT
-- 			user_command: USER_CMD
-- 		do
-- 			user_command ?= edited_command
-- 			if  user_command /= Void then
--  				if user_command.has_descendents then
--  					popup_error_box (Messages.instance_rem_arg_er)
--  				else
-- 					i := arguments.index_of (arg_inst, 1)
-- 					!! cut_arg.make (Current)
-- 					cut_arg.set_index (i)
-- 					cut_arg.execute (user_command)
-- 				end
-- 			end
-- 		end

feature 

	empty: BOOLEAN is
			-- Is `Current' empty?
		do
			Result := command_instance = Void
		end

	destroy is	
			-- Destroy current command tool
		do
--			trash_hole.unregister
--			command_hole.unregister
--			arguments.unregister_holes
--			command_hole.set_empty_symbol
			{EB_WINDOW} Precursor
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
			error_dialog.popup (Current, s, Void)
		end

	popuper_parent: EV_CONTAINER is
		do
			Result := Current
		end

invariant
	editor_not_void: command_editor /= Void

end -- class COMMAND_TOOL

