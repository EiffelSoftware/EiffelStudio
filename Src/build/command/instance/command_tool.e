indexing
	description: "A command tool: represents actually an instance of %
				% a command with the possibility to edit the command %
				% source code."
	Id: "$Id$"
	Date: "$Date$"
	Revision: "$Revision$"

deferred class 

	COMMAND_TOOL
	
inherit

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

feature {NONE} -- Initialization

	set_values is
			-- Set values for GUI elements.
		do
			details_button.set_right
			command_hole.set_parent_command_tool (Current)
			command_hole.set_empty_symbol
		end

feature {NONE} -- Graphical interface

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

	menu_separator: THREE_D_SEPARATOR
			
		--| Elements corresponding to the instance editor
	observer_hole: OBSERVER_HOLE
			-- Hole used to add observers
	arguments_scrolled_w: SCROLLED_W
			-- Scrolled window enclosing `arguments'
	details_button: ARROW_B
			-- Button used to display the command editor part
	argument_label,
			-- Label specifying "Arguments"
	details_label: LABEL
			-- Label specifying "Details"

		--| Elements corresponding to the command editor
	command_editor: COMMAND_EDITOR is
			--  Editor to edit Eiffel Code of a command
		deferred
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
		deferred
		end


	close is
			-- Close Current Editor
		deferred
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
			-- Currently edited command.
		do
			Result := command_instance.associated_command
		end

	set_instance (c: CMD_INSTANCE) is
			-- Set command_instance to `c' and update
			-- the editor.
		require
			c_not_being_edited: not c.edited
			not_void_c: c /= Void
		do
			set_instance_only (c)
			if realized and then command_editor_shown and then
				command_editor.current_command /= c.associated_command
			then
				command_editor.set_command (c.associated_command)
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

	remove_observer (inst: CMD_INSTANCE) is
			-- Remove an observer.
		do
			observers.start
			observers.prune (inst)
		end

	observers: OBSERVER_BOX is
			-- Observer box of the command editor
		do
			Result := command_editor.observers
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
		deferred
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
		deferred
		end

	display is
			-- Raise current command tool
		deferred
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
			if command_instance /= Void then
				an_arrow ?= arg
				if an_arrow /= Void and then an_arrow = details_button then
					details_action
				end
			end
		end

	details_action is
			-- Display the command editor
		do
			if command_editor_shown then
				details_button.set_right
				hide_command_editor
			else
				details_button.set_down
				show_command_editor
			end
		end

	set_callbacks is
			-- Add action on `details_button'.
		do
			details_button.add_activate_action (Current, details_button)
		end

	command_editor_shown: BOOLEAN is
			-- Is command editor shown?
		deferred
		end

	hide_command_editor is
			-- Hide command editor.
		deferred
		end

	show_command_editor is
			-- Show command editor
		deferred
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

end -- COMMAND_TOOL
