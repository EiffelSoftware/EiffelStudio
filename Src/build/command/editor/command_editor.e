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
--			make,
--			make_unmanaged,
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

-- 	make (a_name: STRING; a_parent: COMPOSITE) is
-- 			-- Create the command editor managed.
-- 		do
-- 			Precursor (a_name, a_parent)
-- 			command_tool ?= a_parent.parent
-- 			create_interface
-- 		end
-- 
-- 	make_unmanaged (a_name: STRING; a_parent: COMPOSITE) is
-- 			-- Create the command editor managed.
-- 		do
-- 			Precursor (a_name, a_parent)
-- 			command_tool ?= a_parent
-- 			create_interface
-- 		end

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
			!! add_argument_hole.make (Current, editing_button_form)
			!! add_ancestor_hole.make (Current, editing_button_form)
			!! new_command_button.make ("New", editing_button_form)
			!! undoable_toggle_b.make ("Undoable", editing_button_form)
			!! new_label_label.make ("New label", editing_button_form)
			!! new_label_text.make ("", editing_button_form)
			!! separator_2.make ("", Current)
			!! observers_scrolled_w.make (Widget_names.scroll2, observer_form)
			!! observers.make ("Observer box", observers_scrolled_w, command_tool)
			!! label_scrolled_w.make (Widget_names.scroll3, label_form)
			!! labels.make ("Label box", label_scrolled_w, Current)
			!! separator_3.make ("", Current)
			!! text_editor.make ("Text editor", Current)
			set_values
			attach_all
			set_callbacks
		end

	set_values is
			-- Set the values for the GUI elements.
		do
			observers.set_row_layout
			observers.set_spacing (5)
			new_command_button.set_command_editor (Current)
			label_scrolled_w.set_height (75)
			label_form.set_height (75)
			observers_scrolled_w.set_height (75)
			observer_form.set_height (75)
		end

	attach_all is
			-- Perform attachments.
		do
			attach_top (editing_button_form, 0)
			attach_left (editing_button_form, 0)
			attach_right (editing_button_form, 0)
			attach_top_widget (editing_button_form, separator_2, 0)
			attach_left (separator_2, 0)
			attach_right (separator_2, 0)
			attach_top_widget (separator_2, list_form, 0)
			attach_left (list_form, 0)
			attach_right (list_form, 0)
			attach_top_widget (list_form, separator_3, 0)
			attach_left (separator_3, 0)
			attach_right (separator_3, 0)
			attach_top_widget (separator_3, text_editor, 0)
			attach_left (text_editor, 5)
			attach_right (text_editor, 5)
			attach_bottom (text_editor, 5)

			editing_button_form.attach_top (add_argument_hole, 3)
			editing_button_form.attach_top (add_ancestor_hole, 3)
			editing_button_form.attach_top (new_command_button, 3)
			editing_button_form.attach_top (undoable_toggle_b, 3)
			editing_button_form.attach_top (new_label_label, 6)
			editing_button_form.attach_top (new_label_text, 3)
			editing_button_form.attach_left (add_argument_hole, 0)
			editing_button_form.attach_left_widget (add_argument_hole, add_ancestor_hole, 0)
			editing_button_form.attach_left_widget (add_ancestor_hole, new_command_button, 0)
			editing_button_form.attach_left_widget (new_command_button, undoable_toggle_b, 5)
			editing_button_form.attach_right (new_label_text, 0)
			editing_button_form.attach_right_widget (new_label_text, new_label_label, 5)
			editing_button_form.attach_bottom (add_argument_hole, 0)
			editing_button_form.attach_bottom (add_ancestor_hole, 0)
			editing_button_form.attach_bottom (new_command_button, 0)
			editing_button_form.attach_bottom (undoable_toggle_b, 0)
			editing_button_form.attach_bottom (new_label_label, 0)
			editing_button_form.attach_bottom (new_label_text, 0)

			list_form.set_fraction_base (2)
			list_form.attach_top (observer_form, 0)
			list_form.attach_top (label_form, 0)
			list_form.attach_left (observer_form, 0)
			list_form.attach_right_position (observer_form, 1)
			list_form.attach_left_position (label_form, 1)
			list_form.attach_right (label_form, 0)
			list_form.attach_bottom (observer_form, 0)
			list_form.attach_bottom (label_form, 0)

			observer_form.attach_top (observers_scrolled_w, 0)
			observer_form.attach_left (observers_scrolled_w, 0)
			observer_form.attach_right (observers_scrolled_w, 0)
			observer_form.attach_bottom (observers_scrolled_w, 0)

			label_form.attach_top (label_scrolled_w, 0)
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

	observers_scrolled_w: SCROLLED_W
			-- Scrolled window enclosing `observers'
	add_argument_hole: ARG_HOLE
			-- Hole used to add a formal argument
	add_ancestor_hole: CMD_INH_HOLE
			-- Hole used to add an ancestor to the edited command
	new_command_button: NEW_COMMAND_BUTTON
			-- Button used to create a new command
	new_label_label: LABEL
			-- Label specifying "New label"
	new_label_text: TEXT_FIELD
			-- Text field to enter the value of a new label
	undoable_toggle_b: TOGGLE_B
			-- Toggle button to specify if a command is undoable
	label_scrolled_w: SCROLLED_W
			-- Scrolled window enclosing `labels'
	separator_2,
			-- Separator between the row of button and the two boxes
	separator_3: THREE_D_SEPARATOR
			-- Separator between the two boxes and the text editor

feature {COMMAND_TOOL, CMD_UPDATE_PARENT} -- Graphical interface

	observers: OBSERVER_BOX
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
			add_argument_hole.unregister
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
		local
			void_command: CMD
		do
			save_previous_command
			arguments.wipe_out
			labels.wipe_out
			text_editor.set_text ("")
			current_command := Void
			edited_command := Void
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

	set_command (cmd: CMD) is
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
			ud_cmd: USER_CMD
			pr_cmd: PREDEF_CMD
		do
			ud_cmd ?= cmd
			pr_cmd ?= cmd
			save_previous_command
			if ud_cmd /= Void then
				set_editable_command (ud_cmd)
			elseif not (pr_cmd = Void) then
				set_read_only_command (pr_cmd)
			end
			update_parent_symbol
			update_title
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
			labels.update_display
			argument_box.update_display
		end

feature {NONE}

	set_editable_command (cmd: USER_CMD) is
			-- Set `cmd' to edited_command. Update the editor to
			-- reflect the contents of `cmd'. (Allows editing).
		require
			not_void_cmd: not (cmd = Void)
		do
			edited_command := cmd
			current_command := cmd
			labels.set (cmd.labels)
			update_user_eiffel_text_from_disk
			current_command.set_editor (Current)
			text_editor.set_text (current_command.eiffel_text)
			text_editor.set_editable
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
			current_command := cmd
			labels.set (cmd.labels)
			text_editor.set_text (cmd.eiffel_text)
			current_command.set_editor (Current)
			text_editor.set_read_only
			if add_ancestor_hole.realized and then 
				add_ancestor_hole.shown 
			then
				add_ancestor_hole.hide
			end
		end;

	save_previous_command is
			-- Save values of currently
			-- edited command and reset the editor.
		do
			save_command
			if current_command /= Void then
				current_command.reset
			end
		end

feature {COMMAND_TOOL}

	save_command is
			-- Save values of currently
			-- edited command.
		do
			if edited_command /= Void then
				edited_command.save
				edited_command.save_to_disk
			end
		end

feature -- Argument

	add_argument (ts: TYPE_STONE) is
			-- Add a formal argument to Currently edited
			-- command. If several instances exist, the user
			-- has to choose between creating a new command, editing
			-- the current command (and update every instance) or
			-- cancelling the operation.
		local
			new_argument: ARG
			add_argument_cmd: CMD_ADD_ARGUMENT
		do
			if edited_command /= Void then
 				if edited_command.has_descendents then
 					popup_error_box (Messages.instance_add_arg_er)
 				else
					!! add_argument_cmd
					!! new_argument.session_init (ts)
					add_argument_cmd.set_element (new_argument)
					add_argument_cmd.execute (current_command)	
				end
			end
		end
 
	remove_argument (a: ARG) is
			-- Remove `a' from the list of arguments
			-- of currently edited command. If several instances 
			-- exist, the user has to choose between creating a 
			-- new command, editing the current command (and 
			-- update every instance) or cancelling the operation.

		local
			remove_argument_cmd: CMD_CUT_ARGUMENT
			argument_index: INTEGER	
		do
			if edited_command /= Void then
				if edited_command.has_descendents then
					popup_error_box (Messages.instance_rem_arg_er)
				else
					argument_index := edited_command.index_of_argument (a)
					if edited_command.instances.count > 1 then
--						popup_question_box (Void, a)
					else
--						edited_command.remove_argument (a)
					end
--					if not canceled then
--						command_tool.remove_argument (argument_index)
--					else
--					end
				end
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
					edited_command.add_label (new_label_text.text)
					!! new_cmd_label.make (new_label_text.text)
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
					labels.remove_label (l)
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
