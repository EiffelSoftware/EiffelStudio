indexing
	description: "Form used to edit the Eiffel code of a command. %
				% It is a children of a command tool."
	id: "$ID: $"
	date: "$Date$"
	revision: "$Revision$"

class
	COMMAND_EDITOR

inherit
	EV_VERTICAL_BOX
		rename
			make as box_make
		redefine
			destroy
		end

	CONSTANTS

	EV_COMMAND

	WINDOWS

	ERROR_POPUPER

creation 
	make

feature {NONE} -- Initialization

	make (par: COMMAND_TOOL) is
			-- Create the interface of a command editor.
		local
			hbox, hbox1: EV_HORIZONTAL_BOX
			vbox: EV_VERTICAL_BOX
			label: EV_LABEL
			scroll: EV_SCROLLABLE_AREA
			fixed: EV_FIXED
			tbar: EV_TOOL_BAR
		do
			command_tool := par

			box_make (Void)
			create hbox.make (Current)
			hbox.set_spacing (3)
			set_child_expandable (hbox, False)
				--| Labels
			create vbox.make (hbox)
			create labels.make (vbox)
			labels.set_column_title ("Labels:", 1)
			labels.set_minimum_height (55)
			create hbox1.make (vbox)
			set_child_expandable (hbox1, False)
			create label.make_with_text (hbox1, "New label:")
			set_child_expandable (label, False)
			create new_label_text.make (hbox1)
				--| Observed commands
			create vbox.make (hbox)
			create observed_commands.make (vbox)
			observed_commands.set_column_title ("Observed commands:", 1)
			observed_commands.set_column_title ("description", 2)
			observed_commands.set_minimum_height (53)
			create hbox.make (vbox)
			set_child_expandable (hbox, False)
			create undoable_check.make (hbox)
			set_child_expandable (undoable_check, False)
			create fixed.make (hbox)
			create tbar.make (hbox)
			create add_ancestor_hole.make_with_editor (tbar, Current)

			create text_editor.make (Current)
			set_values
			set_callbacks
		end

	set_values is
			-- Set the values for the GUI elements.
		do
			undoable_check.set_text ("Undoable")
		end

	set_callbacks is
			-- Add callbacks on GUI elements.
		local
			arg: EV_ARGUMENT1 [INTEGER]
		do
			create arg.make (1)
			new_label_text.add_return_command (Current, arg)
			create arg.make (2)
			undoable_check.add_toggle_command (Current, arg)
		end

feature {NONE} -- GUI attributes

	new_label_text: EV_TEXT_FIELD
			-- Text field to enter the value of a new label
	undoable_check: EV_CHECK_BUTTON
			-- Check button to specify if a command is undoable
	add_ancestor_hole: CMD_INH_HOLE
			-- Hole used to add an ancestor to the edited command

feature {COMMAND_TOOL, CMD_COMMAND} -- Graphical interface

	observed_commands: EB_ICON_LIST
			-- Observers of command_instance
	labels: EB_ICON_LIST
			-- Labels of current edited command

feature {USER_CMD}

	text_editor: EV_RICH_TEXT
			-- Text editing area containing the code of the Eiffel
			-- class representing the edited command

feature -- Access

	command_tool: COMMAND_TOOL
			-- Parent command tool if so

	is_child_of_command_tool: BOOLEAN is
			-- Is the command editor child of a command tool?
		do
			Result := command_tool /= Void
		end

feature -- Realization

	update_user_eiffel_text_from_disk is
			-- Retieve the Eiffel code of the command on disk.
		require
			editing_user_cmd: edited_command /= Void
		do
			if text_editor /= Void then
				edited_command.retrieve_text_from_disk
				text_editor.set_text (edited_command.eiffel_text)
			end
		end

--	realize is
--		do
--			Precursor
--			if edited_command = Void then
--				add_ancestor_hole.hide
--			else
--				update_user_eiffel_text_from_disk
--			end
--		end

feature -- Attributes

	edited_command: USER_CMD
			-- Currently edited command. Void if `current_command'
			-- is not editable.

	current_command: CMD
			-- Current command

feature -- Eiffel code

	eiffel_text: STRING is
			-- Eiffel code in `text_editor'
		do
			Result := text_editor.text
		end

feature

	update_ancestor_symbol is
			-- Update the pixmap on `add_ancestor_hole'. If the edited
			-- command has an ancestor, set the pixmap to represent a
			-- "full" symbol.
		do
			add_ancestor_hole.update_symbol
		end

feature -- Editing

	destroy is
			-- destroy Current
		do
			Precursor
--			add_ancestor_hole.unregister
--			argument_box.unregister_holes
--			labels.unregister_holes
		end;

	close is
			-- Close Current editor
		do
			clear
--			window_mgr.close (Current)
			-- TODO: when able to display only one child of a split
			-- window, implement this feature.
		end

	clear is
			-- Clear Current editor
		do
-- 			save_command
-- 			arguments.wipe_out
-- 			observed_commands.wipe_out
-- 			labels.wipe_out
-- 			text_editor.set_text ("")
-- --			current_command := Void
-- --			edited_command := Void
-- 			update_ancestor_symbol
		end

-- 	empty: BOOLEAN is
-- 			-- Does `Current' have an edited command
-- 		do
-- 			Result := (current_command = Void)
-- 		end

feature -- Command tool access

	set_command_tool_command (a_cmd: CMD) is
			-- Target the parent command tool to `a_cmd' creating
			-- an instance of this command.
		require
			parent_tool_not_void: command_tool /= Void
		local
			user_cmd: USER_CMD
		do
			command_tool.set_command (a_cmd)
			user_cmd ?= a_cmd 
		end

	set_command_tool_instance (an_instance: CMD_INSTANCE) is
			-- Target the parent command tool to `an_instance'.
		require
			parent_tool_not_void: command_tool /= Void
		do
			command_tool.set_instance (an_instance)
		end

	instance_of_command_tool: CMD_INSTANCE is
			-- Currrent instance in the parent command tool.
		require
			parent_tool_not_void: command_tool /= Void
		do
			Result := command_tool.command_instance
		end

feature {COMMAND_TOOL}

	edit_command (cmd: CMD) is
			-- If `cmd' is a user defined command then
			-- set the editable_command of the command_editor to the
			-- stone dropped. Otherwise, set the command_editor to allow
			-- read only.
			-- TODO: must be call from COMMAND_TOOL. The command tool have
			-- to take care of the arguments of the command.
		require
			not_void_cmd: not (cmd = Void)
			cmd_not_being_edited: not cmd.edited
		local
			pr_cmd: PREDEF_CMD
		do
			current_command.set_editor (Current)
			pr_cmd ?= cmd
			if pr_cmd /= Void then
				set_read_only_command (pr_cmd)
			elseif edited_command /= Void then
				set_editable_command (edited_command)
			end
			update_ancestor_symbol
			update_title
		end

	set_command (cmd: CMD) is
			-- Set the currently edited command.
		require
			not_void_cmd: not (cmd = Void)
		do
			if current_command /= Void and then current_command /= cmd then
				save_command
				current_command.reset
			end
			current_command := cmd
			edited_command ?= cmd
		end

feature -- Basic action

	update_title is
			-- Update the title of the command tool parent
		do
			if command_tool /= Void then
				command_tool.update_title
			end
		end

	update_boxes is
			-- Update `labels' and the argument box in 
			-- `command_tool'.
		do
--			labels.refresh_display
--			observed_commands.set (instance_of_command_tool.observed_commands)
--			observed_commands.refresh_display
		end

feature {NONE} -- Implementation

	set_editable_command (cmd: USER_CMD) is
			-- Set `cmd' to edited_command. Update the editor to
			-- reflect the contents of `cmd'. (Allows editing).
		require
			not_void_cmd: not (cmd = Void)
		do
			labels.set (cmd.labels)
			update_user_eiffel_text_from_disk
			text_editor.set_text (current_command.eiffel_text)
			text_editor.set_editable (True)
			undoable_check.set_insensitive (False)
			if edited_command.undoable then
				undoable_check.set_state (True)
			else
				undoable_check.set_state (False)
			end
			add_ancestor_hole.set_insensitive (False)
		end

	set_read_only_command (cmd: PREDEF_CMD) is
			-- Update the editor to reflect the contents of `cmd'
			-- and do not allow editing or adding more arguments.
		require
			not_void_cmd: not (cmd = Void)
		do
			edited_command := Void
			labels.set (cmd.labels)
			text_editor.set_text (cmd.eiffel_text)
			text_editor.set_editable (False)
			undoable_check.set_insensitive (True)
			add_ancestor_hole.set_insensitive (True)
		end

feature {COMMAND_TOOL}

	save_command is
			-- Save values of currently
			-- edited command.
		do
			if edited_command /= Void and then edited_command.edited then
				edited_command.save
				edited_command.save_to_disk
			end
		end

feature -- Argument box

-- 	argument_box: ARG_INST_BOX is
-- 			-- Argument box in parent command tool.
-- 		do
-- 			Result := command_tool.arguments
-- 		end

feature -- Labels

	add_label is
			-- Add a label to currently
			-- edited command.
		local
			new_cmd_label: CMD_LABEL
		do
			if edited_command /= Void then
				if edited_command.has_descendents then
					popup_error_box (Messages.instance_add_label_er)
				else
--					!! new_cmd_label.make (new_label_text.text)
--					edited_command.add_label (new_cmd_label)
--					labels.extend (new_cmd_label)
				end
			else
				popup_error_box (Messages.add_label_er)
			end
		end

	remove_label (l: CMD_LABEL) is
			-- Remove `l' from the list of labels
			-- of currently edited command.
		do
			if edited_command /= Void then
				if edited_command.has_descendents then
					popup_error_box (Messages.instance_rem_label_er)
				else
					edited_command.remove_label (l)
					if shown then
--						labels.start
--						labels.search (l)
--						labels.remove
					end
--					labels.refresh_display
				end
			end
		end

feature -- Parent

	set_ancestor (c: CMD) is
			-- Make `c' ancestor of Current.
		require
			not_void_c: c /= Void
		do
			if edited_command /= Void then
				if c /= edited_command
				and then edited_command.ancestor_type /= c
				then
					if edited_command.has_instances
					and not c.arguments.empty
					then
						popup_error_box (Messages.instance_add_inh_er)
					else
						edited_command.set_ancestor (c)
					end
				end
			else
				popup_error_box (Messages.add_parent_er)
			end
		end

	remove_ancestor is
		do
			if edited_command /= Void then
				if
					edited_command.has_instances and
					not edited_command.ancestor_type.arguments.empty
				then
					popup_error_box (Messages.instance_rem_inh_er)
				else
					edited_command.remove_ancestor 
				end
			else
				popup_error_box (Messages.remove_parent_er)
			end
		end

feature {NONE} -- Command

	execute (argument: EV_ARGUMENT1 [INTEGER]; data: EV_EVENT_DATA) is
			-- Execute routine. Used:
			--	 . To add a label
			--	 . To toggle between non-undoable and doable
		local
--			non_undo_cmd: CMD_NON_UNDOABLE
--			undo_cmd: CMD_UNDOABLE
--			id: IDENTIFIER
		do
--			if edited_command /= Void then
				if argument.first = 1 then
					if not new_label_text.text.empty then
--						!! id.make (new_label_text.text.count)
--						id.append (new_label_text.text)
--						if id.is_valid then
--							add_label
--							new_label_text.set_text ("")
--						else
--							error_box.popup (Current, 
--								Messages.invalid_feature_name_er, 
--								new_label_text.text)
--						end
					end
				elseif argument.first = 2 then
--					if undoable_check.state then
--						!! undo_cmd
--						undo_cmd.execute (edited_command)
--					else
--						!! non_undo_cmd
--						non_undo_cmd.execute (edited_command)
--					end
				end
--			end
		end 

	popup_error_box (s: STRING) is
			-- Popup error box with message `s'.
		require
			not_void_s: s /= Void
		do
			error_dialog.popup (Current, s, Void)
		end

feature {USER_CMD}
	
	set_unsaved_application is
		do
			if history_window.saved_application then
				history_window.set_unsaved_application
			end
		end

feature -- POPUPER

-- 	popuper_parent: COMPOSITE is
-- 		do
-- 			Result := Current
-- 		end 

feature

-- 	arguments: EB_LINKED_LIST [ARG] is
-- 			-- Box containing the arguments of the command
-- 			-- TODO: Check this behavior!!!!
-- 		local
-- 			arg_box: ARG_INST_BOX
-- 			an_arg: ARG
-- 		do
-- 			!! Result.make
-- 			arg_box := command_tool.arguments
-- 			from
-- 				arg_box.start
-- 			until
-- 				arg_box.after
-- 			loop
-- 				!! an_arg.session_init (arg_box.item.type)
-- 				Result.extend (an_arg)
-- 				arg_box.forth
-- 			end
-- 		end

feature 

	hide_yourself is
			-- Hide current command editor
		do
			command_tool.hide_command_editor
		end

end -- class COMMAND_EDITOR

