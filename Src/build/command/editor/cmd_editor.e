class CMD_EDITOR 

inherit

	EB_TOP_SHELL
		rename
			make as top_shell_create,
			destroy as shell_destroy
		export
			{NONE} all
		redefine
			set_geometry
		end
	EB_TOP_SHELL
		redefine
			make, destroy,set_geometry
		select
			make, destroy
		end
	COMMAND;
	WINDOWS;
	ERROR_POPUPER
		redefine
			continue_after_popdown
		end
	QUEST_POPUPER
		redefine
			continue_after_popdown
		end;
	CLOSEABLE

creation

	make

feature {NONE, CMD_INH_HOLE}

	-- Currently edited command.
	-- Void if `current_command' is
	-- not editable.
	edited_command: USER_CMD

feature -- Geometry

	set_geometry is
		do
			set_size (Resources.cmd_type_ed_width,
					Resources.cmd_type_ed_height)
		end;
 
feature 

	current_command: CMD
		-- Current command

	eiffel_text: STRING is
		-- Editor text
		do
			Result := text_editor.text
		end

	arguments: ARG_BOX
		-- Arguments of edited command
 
	labels: LABEL_BOX
		-- Labels of edited command
 
feature -- Editing

	destroy is
		do
			shell_destroy;
			argument_hole.unregister;
			edit_hole.unregister;
			inherit_hole.unregister;
			instance_hole.unregister;
			arguments.unregister_holes;
			labels.unregister_holes;
		end;

	close is
		-- Close Current editor
		do
			if edited_command /= Void then
				edited_command.save
			end
			clear;
			window_mgr.close (Current)
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
		end

	empty: BOOLEAN is
		do
			Result := (current_command = Void)
		end

	set_command (cmd: CMD) is
			-- If `cs' is a user defined command then
			-- set the editable_command of the command_editor to the
			-- stone dropped. Otherwise, set the command_editor to allow
			-- read only.
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
			if not (ud_cmd = Void) then
				set_editable_command (ud_cmd)
			elseif not (pr_cmd = Void) then
				set_read_only_command (pr_cmd)
			end;
			update_title
		end;

	update_title is
		local
			tmp: STRING
		do
			!! tmp.make (0);
			tmp.append (Widget_names.command_label);
			tmp.append (": ");
			tmp.append (current_command.label);
			set_title (tmp);
			set_icon_name (tmp);
		end;
 
feature {NONE}

	set_editable_command (cmd: USER_CMD) is
			-- Set `cmd' to edited_command. Update the editor to
			-- reflect the contents of `cmd'. (Allows editing).
		require
			not_void_cmd: not (cmd = Void)
		do
			edited_command := cmd
			current_command := cmd
			arguments.set (cmd.arguments)
			labels.set (cmd.labels)
			text_editor.set_text (cmd.eiffel_text)
			current_command.set_editor (Current)
			text_editor.set_editable
			edited_command.set_arguments (arguments)
			edited_command.set_labels (labels)
			if not inherit_hole.managed then
				inherit_hole.manage
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
			arguments.set (cmd.arguments)
			labels.set (cmd.labels)
			text_editor.set_text (cmd.eiffel_text)
			current_command.set_editor (Current)
			text_editor.set_read_only
			inherit_hole.unmanage 
		end
 
	save_previous_command is
			-- Save values of currently
			-- edited command.
		do
			if edited_command /= Void then
				edited_command.save
			end
			if not (current_command = Void) then
				current_command.reset
			end
		end

feature -- Argument

	add_argument (ts: TYPE_STONE) is
			-- Add an argument to Currently edited
			-- command.
		local
			new_argument: ARG
			add_argument_cmd: CMD_ADD_ARGUMENT
		do
			if edited_command /= Void then
				if edited_command.has_instances then
					popup_error_box (Messages.instance_add_arg_er)
				else
					edited_command.add_argument (ts)
				end
			end
		end
 
	remove_argument (a: ARG) is
			-- Remove `a' from the list of arguments
			-- of currently edited command.
		local
			remove_argument_cmd: CMD_CUT_ARGUMENT
		do
			if not (edited_command = Void) then
				if edited_command.has_instances then
					popup_error_box (Messages.instance_rem_arg_er)
				else
					edited_command.remove_argument (a)
				end
			end
		end

feature -- Labels
 
	add_label is
			-- Add a label to currently
			-- edited command.
		do
			if
				not ((edited_command = Void))
			then
				edited_command.add_label (label_text.text)
			else
				popup_error_box (Messages.add_label_er)
			end
		end
 
	remove_label (l: CMD_LABEL) is
			-- Remove `l' from the list of labels
			-- of currently edited command.
		do
			if edited_command /= Void then
				edited_command.remove_label (l)
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
			if
				not (edited_command = Void)
			then
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
	
feature {NONE} -- Interface

	argument_hole: ARG_HOLE
			-- Hole associated with command
			-- editor, into which arguments
			-- type stones and descendants
			-- (currently only context stones)
			-- may be dropped

	label_text: LABEL_TEXT_FIELD
			-- Text field used to specify
			-- labels of currently edited
			-- command

	edit_hole: CMD_EDIT_HOLE
			-- Hole used to set the currently
			-- edited command.

			-- Stone representing currently 
			-- edited command

	
feature {NONE}

	inherit_hole: CMD_INH_HOLE
			-- Hole used to specify parent
			-- type of currently edited 
			-- command

	
feature 

	text_editor: SCROLLED_T
			-- Text editing area containing
			-- the text of the Eiffel Class
			-- representing the edited command.
	focus_label: FOCUS_LABEL;

feature {NONE}

	instance_hole: CMD_ED_INST_ED_H

			-- Close button associated with
			-- Current window

	form: FORM
	edit_bar_form, argument_form, label_form: FORM
	new_label: LABEL
	first_separator: SEPARATOR
	label_sw, argument_sw: SCROLLED_W
	undoable_t: TOGGLE_B
	close_b: CLOSE_WINDOW_BUTTON
	
feature {NONE}

	create_widgets is
		-- create the editor's widget set
		local
			del_com: DELETE_WINDOW;
		do
			top_shell_create (a_name, a_screen)
			!! form.make (Widget_names.form, Current)
			!! text_editor.make (Widget_names.text, form)
			!! edit_bar_form.make (Widget_names.form1, form)
			!! argument_form.make (Widget_names.form2, form)
			!! label_form.make (Widget_names.form3, form)
			!! edit_hole.make (Current, edit_bar_form)
			!! first_separator.make (Widget_names.separator, form)
			!! undoable_t.make (Widget_names.undoable_label, edit_bar_form)
			!! focus_label.make (edit_bar_form);
			!! inherit_hole.make (Current, edit_bar_form)
			!! instance_hole.make (Current, edit_bar_form)
			!! close_b.make (Current, edit_bar_form, focus_label)
			!! argument_hole.make (Current, argument_form)
			!! argument_sw.make (Widget_names.scroll1, argument_form)
			!! arguments.make (Widget_names.icon_box1, argument_sw, Current)
			!! label_text.make (Widget_names.label, label_form)
			!! new_label.make (Widget_names.new_label_label, label_form)
			!! label_sw.make (Widget_names.scroll2, label_form)
			!! labels.make (Widget_names.icon_box3, label_sw, Current)
			!! del_com.make (Current);
			initialize_window_attributes;
			inherit_hole.unmanage;
			set_delete_command (del_com);
		end

	perform_attachments is
		-- effect a resize policy
		do
			form.set_fraction_base (2);
			form.attach_top (edit_bar_form, 0)
			form.attach_right (edit_bar_form, 0)
			form.attach_left (edit_bar_form, 0)
			form.attach_top_widget (edit_bar_form, first_separator, 2)
			form.attach_left (first_separator, 0)
			form.attach_right (first_separator, 0)

			form.attach_right_position (argument_form, 1)
			form.attach_left_position (label_form, 1)
			form.attach_left (argument_form, 0)
			form.attach_right (label_form, 0)
			form.attach_top_widget (first_separator, label_form, 2)
			form.attach_top_widget (first_separator, argument_form, 2)
			form.attach_top_widget (argument_form, text_editor, 2)
			form.attach_top_widget (label_form, text_editor, 2)
			form.attach_bottom (text_editor, 0)
			form.attach_right (text_editor, 0)
			form.attach_left (text_editor, 0)

			edit_bar_form.attach_left (edit_hole, 0)
			edit_bar_form.attach_top (edit_hole, 0)
			edit_bar_form.attach_top (close_b, 0)
			edit_bar_form.attach_top (inherit_hole, 0)
			edit_bar_form.attach_top (instance_hole, 0)
			edit_bar_form.attach_top (undoable_t, 0)
			edit_bar_form.attach_top (focus_label, 0)
			edit_bar_form.attach_bottom (focus_label, 0)
			edit_bar_form.attach_bottom (edit_hole, 0)
			edit_bar_form.attach_bottom (inherit_hole, 0)
			edit_bar_form.attach_bottom (close_b, 0)
			edit_bar_form.attach_bottom (instance_hole, 0)
			edit_bar_form.attach_left_widget (edit_hole, inherit_hole, 0)
			edit_bar_form.attach_left_widget (inherit_hole, instance_hole, 0)
			edit_bar_form.attach_left_widget (instance_hole, focus_label, 0);
			edit_bar_form.attach_right_widget (undoable_t, focus_label, 0)
			edit_bar_form.attach_right_widget (close_b, undoable_t, 0)
			edit_bar_form.attach_top (close_b, 0)
			edit_bar_form.attach_right (close_b, 0)

			argument_form.attach_top (argument_hole, 0)
			argument_form.attach_left (argument_hole, 0)
			argument_form.attach_left (argument_sw, 0)
			argument_form.attach_top_widget (argument_hole, argument_sw, 5)
			argument_form.attach_right (argument_sw, 0)
			argument_form.attach_bottom (argument_sw, 0);

			label_form.attach_left (new_label, 0)
			label_form.attach_top (new_label, 10)
			label_form.attach_top (label_text, 0)
			label_form.attach_right (label_text, 0);
			label_form.attach_left_widget (new_label, label_text, 5)
			label_form.attach_top_widget (label_text, label_sw, 1);
			label_form.attach_left (label_sw, 0)
			label_form.attach_right (label_sw, 0);
			label_form.attach_bottom (label_sw, 0);
		end

	set_values is
		-- set some inital values for certain widgets
		do
			first_separator.set_horizontal (True)
			argument_sw.set_working_area (arguments)
			arguments.set_row_layout
			label_sw.set_working_area (labels)
			labels.set_row_layout
		end

	set_callbacks is
		-- set up event handler
		do
			label_text.add_activate_action (Current, label_text)
			undoable_t.add_activate_action (Current, undoable_t)
		end

	a_name: STRING
	a_screen: SCREEN

feature

	make (in_name: STRING in_screen: SCREEN) is
		-- Create interface.
		do
			a_name := in_name
			a_screen := in_screen
			create_widgets
			perform_attachments
			set_values
			set_callbacks
		end

	
feature {NONE}

	execute (argument: ANY) is
			-- Execute routine. Used:
			--	 . To add a label
			--	 . To toggle between non-undoable and doable
		local
			non_undo_cmd: CMD_NON_UNDOABLE
			undo_cmd: CMD_UNDOABLE
		do
			if (argument = label_text) then
				if	not label_text.text.empty then
					add_label
					label_text.set_text ("")
				end
			elseif (argument = undoable_t and then
						(edited_command /= Void)) then
				if undoable_t.state then
					!!undo_cmd
					undo_cmd.execute (edited_command)
				else
					!!non_undo_cmd
					non_undo_cmd.execute (edited_command)
				end
			elseif (argument = edit_hole and then
						(edited_command /= Void)) then
				question_box.popup (Current, Messages.reset_text_qu, Void)
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


feature -- Top shell features

	continue_after_popdown (box: MESSAGE_D ok: BOOLEAN) is
		do
			if (box = question_box) then
				if ok then
					text_editor.set_text (edited_command.template)
				end
			end
		end

end
