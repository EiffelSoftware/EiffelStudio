indexing
	description: "Form used to edit the Eiffel code of a command. %
				% It is a children of a command tool."
	id: "$ID: $"
	date: "$Date$"
	revision: "$Revision$"

class
	COMMAND_EDITOR

inherit

	FORM
		rename
			init_toolkit as g_any_init_toolkit
		redefine
			realize,
			destroy
		end

	CONSTANTS

	COMMAND

	WINDOWS
		select
			init_toolkit
		end

	ERROR_POPUPER

creation 

	make,
	make_unmanaged

feature -- Creation

	set_command_tool (a_command_tool: COMMAND_TOOL) is
			-- Set `command_tool' to `a_command_tool'.
		do
			command_tool := a_command_tool
		end

	create_interface is
			-- Create the interface of a command editor.
		do
			!! editing_button_form.make ("Editing Button Form", Current)
			!! list_form.make ("List form", Current)
			!! observer_form.make ("Observer form", list_form)
			!! label_form.make ("Label form", list_form)
			!! add_ancestor_hole.make (Current, editing_button_form)
			!! undoable_toggle_b.make ("Undoable", editing_button_form)
			!! observed_instances_label.make ("Observed commands:", observer_form)
			!! new_label_label.make ("New label", label_form)
			!! new_label_text.make ("", label_form)
			!! observed_commands_scrolled_w.make (Widget_names.scroll2, observer_form)
			!! observed_commands.make ("Observer box", observed_commands_scrolled_w, command_tool)
			!! label_scrolled_w.make (Widget_names.scroll3, label_form)
			!! labels.make ("Label box", label_scrolled_w, Current)
			!! text_editor.make ("Text editor", Current)
			set_values
			attach_all
			set_callbacks
		end

	set_values is
			-- Set the values for the GUI elements.
		do
			list_form.set_height (75)
			label_scrolled_w.set_height (55)
			label_form.set_height (55)
			observed_commands_scrolled_w.set_height (55)
			observer_form.set_height (55)
		end

	attach_all is
			-- Perform attachments.
		do
			attach_top (list_form, 0)
			attach_left (list_form, 0)
			attach_right (list_form, 0)
			attach_top_widget (list_form, editing_button_form, 0)
			attach_left (editing_button_form, 0)
			attach_right (editing_button_form, 0)
			attach_top_widget (editing_button_form, text_editor, 0)
			attach_left (text_editor, 0)
			attach_right (text_editor, 0)
			attach_bottom (text_editor, 0)

			editing_button_form.attach_top (add_ancestor_hole, 0)
			editing_button_form.attach_top (undoable_toggle_b, 0)
			editing_button_form.attach_left (add_ancestor_hole, 0)
			editing_button_form.attach_right (undoable_toggle_b, 0)
			editing_button_form.attach_bottom (add_ancestor_hole, 0)
			editing_button_form.attach_bottom (undoable_toggle_b, 0)

			list_form.set_fraction_base (5)
			list_form.attach_top (observer_form, 0)
			list_form.attach_top (label_form, 0)
			list_form.attach_left (observer_form, 0)
			list_form.attach_right_position (observer_form, 2)
			list_form.attach_left_position (label_form, 2)
			list_form.attach_right (label_form, 0)
			list_form.attach_bottom (observer_form, 2)
			list_form.attach_bottom (label_form, 2)

			observer_form.attach_top (observed_instances_label, 5)
			observer_form.attach_left (observed_instances_label, 0)
			observer_form.attach_right (observed_instances_label, 0)
			observer_form.attach_top_widget (observed_instances_label, observed_commands_scrolled_w, 2)
			observer_form.attach_left (observed_commands_scrolled_w, 0)
			observer_form.attach_right (observed_commands_scrolled_w, 0)
			observer_form.attach_bottom (observed_commands_scrolled_w, 0)

			label_form.attach_top (new_label_label, 5)
			label_form.attach_top (new_label_text, 0)
			label_form.attach_left (new_label_label, 0)
			label_form.attach_right (new_label_text, 0)
			label_form.attach_left_widget (new_label_label, new_label_text, 5)
			label_form.attach_top_widget (new_label_text, label_scrolled_w, 0)
			label_form.attach_top_widget (new_label_label, label_scrolled_w, 2)
			label_form.attach_left (label_scrolled_w, 0)
			label_form.attach_right (label_scrolled_w, 0)
			label_form.attach_bottom (label_scrolled_w, 0)
		end

	set_callbacks is
			-- Add callbacks on GUI elements.
		do
			new_label_text.add_activate_action (Current, new_label_text)
			undoable_toggle_b.add_activate_action (Current, undoable_toggle_b)
		end

feature {NONE} -- Graphical interface
		--| Forms
	editing_button_form,
			-- Button form in the command editor part
	list_form,
			-- Form in ` in which will be diplayed
			-- the observer list and the label list
	observer_form,
			-- Form in ` containing the  observer box
	label_form: FORM
			-- Form in ` containing the label box

		--| Graphical elements

	observed_commands_scrolled_w: SCROLLED_W
			-- Scrolled window enclosing `observed_commands'
	add_ancestor_hole: CMD_INH_HOLE
			-- Hole used to add an ancestor to the edited command
	observed_instances_label,
			-- Label for observed instances list
	new_label_label: LABEL
			-- Label specifying "New label"
	new_label_text: TEXT_FIELD
			-- Text field to enter the value of a new label
	undoable_toggle_b: TOGGLE_B
			-- Toggle button to specify if a command is undoable
	label_scrolled_w: SCROLLED_W
			-- Scrolled window enclosing `labels'

feature {COMMAND_TOOL, CMD_COMMAND} -- Graphical interface

	observed_commands: OBSERVED_INSTANCE_BOX
			-- Observers of command_instance
	labels: LABEL_BOX
			-- Labels of current edited command

feature {USER_CMD}

	text_editor: SCROLLED_T
			-- Text editing area containing the code of the Eiffel
			-- class representing the edited command

feature 

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
			if realized then
				edited_command.retrieve_text_from_disk
				text_editor.set_text (edited_command.eiffel_text)
			end
		end

	realize is
		do
			Precursor
			if edited_command = Void then
				add_ancestor_hole.hide
			else
				update_user_eiffel_text_from_disk
			end
		end

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

	update_parent_symbol is
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
			add_ancestor_hole.unregister
			argument_box.unregister_holes
			labels.unregister_holes
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
			save_command
			arguments.wipe_out
			observed_commands.wipe_out
			labels.wipe_out
			text_editor.set_text ("")
--			current_command := Void
--			edited_command := Void
			update_parent_symbol;
		end

	empty: BOOLEAN is
			-- Does `Current' have an edited command
		do
			Result := (current_command = Void)
		end

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
			update_parent_symbol
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
			
feature

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
			labels.refresh_display
			observed_commands.set (instance_of_command_tool.observed_commands)
			observed_commands.refresh_display
		end

feature {NONE}

	set_editable_command (cmd: USER_CMD) is
			-- Set `cmd' to edited_command. Update the editor to
			-- reflect the contents of `cmd'. (Allows editing).
		require
			not_void_cmd: not (cmd = Void)
		do
--			edited_command := cmd
--			current_command := cmd
			labels.set (cmd.labels)
			update_user_eiffel_text_from_disk
--			current_command.set_editor (Current)
			text_editor.set_text (current_command.eiffel_text)
			text_editor.set_editable
			undoable_toggle_b.set_sensitive
			if edited_command.undoable then
				undoable_toggle_b.set_toggle_on
			else
				undoable_toggle_b.set_toggle_off
			end
			if add_ancestor_hole.realized and then 
				not add_ancestor_hole.shown 
			then
				add_ancestor_hole.show
			end
		end
 
	set_read_only_command (cmd: PREDEF_CMD) is
			-- Update the editor to reflect the contents of `cmd'
			-- and do not allow editing or adding more arguments.
		require
			not_void_cmd: not (cmd = Void)
		do
			edited_command := Void
--			current_command := cmd
			labels.set (cmd.labels)
			text_editor.set_text (cmd.eiffel_text)
--			current_command.set_editor (Current)
			text_editor.set_read_only
			undoable_toggle_b.set_insensitive
			if add_ancestor_hole.realized and then 
				add_ancestor_hole.shown 
			then
				add_ancestor_hole.hide
			end
		end;

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

	argument_box: ARG_INST_BOX is
			-- Argument box in parent command tool.
		do
			Result := command_tool.arguments
		end

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
					!! new_cmd_label.make (new_label_text.text)
					edited_command.add_label (new_cmd_label)
					labels.extend (new_cmd_label)
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
						labels.start
						labels.search (l)
						labels.remove
					end
					labels.refresh_display
				end
			end
		end

feature -- Parent
 
	set_parent (c: CMD) is
			-- Make `c' parent of Current.
		require
			not_void_c: not (c = Void)
		do
			if (edited_command /= Void) then
				if (c /= edited_command and then 
					(edited_command.parent_type /= c)) then
					if
						edited_command.has_instances
						and not c.arguments.empty
					then
						popup_error_box (Messages.instance_add_inh_er)
					else
						edited_command.set_parent (c)
					end
				end
			else
				popup_error_box (Messages.add_parent_er)
			end
		end
 
	remove_parent is
		do
			if edited_command /= Void then
				if
					edited_command.has_instances and
					not edited_command.parent_type.arguments.empty
				then
					popup_error_box (Messages.instance_rem_inh_er)
				else
					edited_command.remove_parent 
				end
			else
				popup_error_box (Messages.remove_parent_er)
			end
		end

feature {NONE}

	execute (argument: ANY) is
			-- Execute routine. Used:
			--	 . To add a label
			--	 . To toggle between non-undoable and doable
		local
			non_undo_cmd: CMD_NON_UNDOABLE
			undo_cmd: CMD_UNDOABLE
			id: IDENTIFIER
		do
			if edited_command /= Void then
				if argument = new_label_text then
					if not new_label_text.text.empty then
						!! id.make (new_label_text.text.count)
						id.append (new_label_text.text)
						if id.is_valid then
							add_label
							new_label_text.set_text ("")
						else
							error_box.popup (Current, 
								Messages.invalid_feature_name_er, 
								new_label_text.text)
						end
					end
				elseif argument = undoable_toggle_b then
					if undoable_toggle_b.state then
						!! undo_cmd
						undo_cmd.execute (edited_command)
					else
						!! non_undo_cmd
						non_undo_cmd.execute (edited_command)
					end
					-- TODO: move this part in COMMAND_TOOL
--				elseif argument = Void then
--					-- configure event
--					popup_instances_button.update_popup_position;
--					popup_contexts_button.update_popup_position
				end
			end
		end 

	popup_error_box (s: STRING) is
			-- Popup error box with message `s'.
		require
			not_void_s: s /= Void
		do
			error_box.popup (Current, s, Void)
		end

feature {USER_CMD}
	
	set_unsaved_application is
		do
			if history_window.saved_application then
				history_window.set_unsaved_application
			end
		end

feature -- POPUPER

	popuper_parent: COMPOSITE is
		do
			Result := Current
		end 

feature

	arguments: EB_LINKED_LIST [ARG] is
			-- Box containing the arguments of the command
			-- TODO: Check this behavior!!!!
		local
			arg_box: ARG_INST_BOX
			an_arg: ARG
		do
			!! Result.make
			arg_box := command_tool.arguments
			from
				arg_box.start
			until
				arg_box.after
			loop
				!! an_arg.session_init (arg_box.item.type)
				Result.extend (an_arg)
				arg_box.forth
			end
		end

feature 

	hide_yourself is
			-- Hide current command editor
		do
			command_tool.hide_command_editor
		end

end -- class COMMAND_EDITOR
