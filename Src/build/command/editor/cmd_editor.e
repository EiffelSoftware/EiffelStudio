
class CMD_EDITOR 

inherit

	TOP_SHELL
		rename
			make as top_shell_create,
			realize as shell_realize
		export
			{NONE} all
		undefine
			init_toolkit
		redefine
			delete_window_action
		end;
	TOP_SHELL
		undefine
			init_toolkit
		redefine
			realize, make,
			delete_window_action
		select
			realize, make
		end;
	WIDGET_NAMES;
	COMMAND;
	WINDOWS;
	ERROR_POPUPER
		undefine
			continue_after_popdown
		end;
	WARN_POPUPER
		undefine
			continue_after_popdown
		end

creation

	make

-- ******************
-- Editing attributes
-- ******************

	
feature {NONE}

	edited_command: USER_CMD;
			-- Currently edited command.
			-- Void if `current_command' is
			-- not editable.
 
feature {TOP_I}

	delete_window_action is
		do
			close;
			iterate;
		end;
feature 

	current_command: CMD;
			-- Current command

	eiffel_text: STRING is
			-- Editor text
		do
			Result := text_editor.text
		end;

	arguments: ARG_BOX;
			-- Arguments of edited command
 
	labels: LABEL_BOX;
			-- Labels of edited command
 
feature -- Editing

	close is
			-- Close Current editor
		do
			if edited_command /= Void then
				edited_command.save;
			end;
			clear;
			window_mgr.close (Current)
		end;

	reset_inherit_stone is
		do
			inherit_hole.reset;
		end;

	set_inherit_stone (c: CMD) is
		do
			inherit_hole.set_inherit_command (c);
		end;

	clear is
			-- Clear Current editor
		local
			void_command: CMD
		do
			save_previous_command;
			arguments.wipe_out;
			labels.wipe_out;
			edit_hole.reset;
			inherit_hole.reset;
			text_editor.set_text ("");
			current_command := Void;
			edited_command := Void;
		end;

	empty: BOOLEAN is
		do
			Result := (current_command = Void)
		end;

	set_command (cmd: CMD) is
			-- If `cs' is a user defined command then
			-- set the editable_command of the command_editor to the
			-- stone dropped. Otherwise, set the command_editor to allow
			-- read only.
		require
			not_void_cmd: not (cmd = Void);
			cmd_not_being_edited: not cmd.edited
		local
			ud_cmd: USER_CMD;
			pr_cmd: PREDEF_CMD
		do
			ud_cmd ?= cmd;
			pr_cmd ?= cmd;
			save_previous_command;
			if not (ud_cmd = Void) then
				set_editable_command (ud_cmd)
			elseif not (pr_cmd = Void) then
				set_read_only_command (pr_cmd)
			end
		end;

	update_name is
			-- Update the name of the command edit stone
		do
			edit_hole.update_name;
		end;
 
feature {NONE}

	set_editable_command (cmd: USER_CMD) is
			-- Set `cmd' to edited_command. Update the editor to
			-- reflect the contents of `cmd'. (Allows editing).
		require
			not_void_cmd: not (cmd = Void)
		do
			edited_command := cmd;
			current_command := cmd;
			arguments.set (cmd.arguments);
			labels.set (cmd.labels);
			text_editor.set_text (cmd.eiffel_text);
			current_command.set_editor (Current);
			text_editor.set_editable;
			edited_command.set_arguments (arguments);
			edited_command.set_labels (labels);
			edit_hole.set_command (cmd);
			if inherit_hole.realized and not shown then
				inherit_hole.show
			end;
			if
				cmd.parent_type /= Void
			then
				inherit_hole.set_inherit_command (cmd.parent_type);
			else
				inherit_hole.reset;
			end;
		end;
 
	set_read_only_command (cmd: PREDEF_CMD) is
			-- Update the editor to reflect the contents of `cmd'
			-- and do not allow editing or adding more arguments.
		require
			not_void_cmd: not (cmd = Void)
		do
			edited_command := Void;
			current_command := cmd;
			arguments.set (cmd.arguments);
			labels.set (cmd.labels);
			text_editor.set_text (cmd.eiffel_text);
			current_command.set_editor (Current);
			edit_hole.set_command (cmd);
			text_editor.set_read_only;
			if inherit_hole.realized then
				inherit_hole.hide
			end;
			inherit_hole.reset;
		end;
 
	save_previous_command is
			-- Save values of currently
			-- edited command.
		do
			if
				not (edited_command = Void)
			then
				edited_command.save;
			end;
			if not (current_command = Void) then
				current_command.reset;
			end;
		end;

feature -- Argument

	add_argument (ts: TYPE_STONE) is
			-- Add an argument to Currently edited
			-- command.
		local
			new_argument: ARG;
			add_argument_cmd: CMD_ADD_ARGUMENT
		do
			if not (edited_command = Void) then
				if edited_command.has_instances then
					popup_error_box ("Command has instances: Cannot add argument !!");
				else
					edited_command.add_argument (ts)
				end
			end
		end;
 
	remove_argument (a: ARG) is
			-- Remove `a' from the list of arguments
			-- of currently edited command.
		local
			remove_argument_cmd: CMD_CUT_ARGUMENT
		do
			if not (edited_command = Void) then
				if edited_command.has_instances then
					popup_error_box ("Command has instances: Cannot remove argument !!")
				else
					edited_command.remove_argument (a)
				end
			end
		end;

feature -- Labels
 
	add_label is
			-- Add a label to currently
			-- edited command.
		do
			if
				not ((edited_command = Void))
			then
				edited_command.add_label (label_name.text);
			else
				popup_error_box ("Cannot add labels to predefined commands%N");
			end
		end;
 
	remove_label (l: CMD_LABEL) is
			-- Remove `l' from the list of labels
			-- of currently edited command.
		do
			if
				not (edited_command = Void)
			then
				edited_command.remove_label (l)
			end
		end;

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
						popup_error_box ("Command has instances: Cannot inherit command with arguments!");
					else
						edited_command.set_parent (c)
					end
				end
			else
				popup_error_box ("Cannot add parent for predefined command !");
			end
		end;
 
	remove_parent is
		do
			if
				not (edited_command = Void)
			then
				if
					edited_command.has_instances and
					not edited_command.parent_type.arguments.empty
				then
					popup_error_box ("Command has instances: Cannot remove parent with a rguments!");
				else
					edited_command.remove_parent 
				end
			else
				popup_error_box ("Cannot remove parent for predefined command !");
			end;
		end;
	
-- ********************
-- EiffelVision Section
-- ********************

	
feature {NONE}

	argument_hole: ARG_HOLE;
			-- Hole associated with command
			-- editor, into which arguments
			-- type stones and descendants
			-- (currently only context stones)
			-- may be dropped

	label_name: TEXT_FIELD;
			-- Text field used to specify
			-- labels of currently edited
			-- command

	edit_hole: CMD_EDIT_HOLE;
			-- Hole used to set the currently
			-- edited command.

			-- Stone representing currently 
			-- edited command

	
feature {NONE}

	inherit_hole: CMD_INH_HOLE;
			-- Hole used to specify parent
			-- type of currently edited 
			-- command

	
feature 

	text_editor: SCROLLED_T;
			-- Text editing area containing
			-- the text of the Eiffel Class
			-- representing the edited command.

feature {NONE}

	instance_hole: CMD_ED_INST_ED_H;

	close_b: CMD_EDIT_CLOSE_B;
			-- Close button associated with
			-- Current window

	form: FORM;
	form1, form2, form3: FORM;
	label1: LABEL;
	separator, separator1: SEPARATOR;
	label_sw, argument_sw: SCROLLED_W;
	undoable_t: TOGGLE_B;
	
feature 

	make (a_name: STRING; a_screen: SCREEN) is
			-- Create interface.
		local
			Nothing: ANY
		do
				-- **************
				-- Create widgets
				-- **************
			top_shell_create (a_name, a_screen);
			!!form.make (F_orm, Current);
			!!text_editor.make (T_ext, form);
			!!form1.make (F_orm1, form);
			!!form2.make (F_orm2, form);
			!!form3.make (F_orm3, form);
			!!edit_hole.make (Current);
			!!separator.make (S_eparator, form);
			!!undoable_t.make (T_oggle, form1);
			!!separator1.make (S_eparator1, form);
			edit_hole.make_visible (form1);
			!!inherit_hole.make (Current);
			inherit_hole.make_visible (form1);
			!!instance_hole.make (Current);
			instance_hole.make_visible (form1);
			!!close_b.make (Current);
			close_b.make_visible (form1);
			!!argument_hole.make (Current);
			argument_hole.make_visible (form2);
			!!argument_sw.make (S_croll1, form2);
			!!arguments.make (I_con_box1, argument_sw, Current);
			!!label_name.make (L_abel, form3);
			!!label1.make (L_abel1, form3);
			!!label_sw.make (S_croll2, form3);
			!!labels.make (I_con_box3, label_sw, Current);
				-- *******************
				-- Perform attachments
				-- *******************
			form.attach_top (form1, 10);
			form.attach_right (form1, 10);
			form.attach_left (form1, 10);
			form.attach_left (separator, 10);
			form.attach_right (separator, 10);
			form.attach_top (separator, 70);
			form.attach_right (form2, 10);
			form.attach_left (form2, 10);
			form.attach_top_widget (separator, form2, 10);
			form.attach_left (separator1, 10);
			form.attach_right (separator1, 10);
			form.attach_top_widget (form2, separator1, 10);
			form.attach_right (form3, 10);
			form.attach_left (form3, 10);
			form.attach_top_widget (separator1, form3, 0);
			form.attach_bottom (text_editor, 0);
			form.attach_right (text_editor, 0);
			form.attach_left (text_editor, 0);
			form.attach_top_widget (form3, text_editor, 0);
			form1.attach_top (edit_hole, 0);
			form1.attach_bottom (edit_hole, 0);
			form1.attach_left (edit_hole, 0);
			form1.attach_top (inherit_hole, 0);
			form1.attach_bottom (inherit_hole, 0);
			form1.attach_top (instance_hole, 0);
			form1.attach_top (undoable_t, 0);
			form1.attach_right_widget (close_b, instance_hole, 40);
			form1.attach_right_widget (instance_hole, undoable_t, 10);
			form1.attach_top (close_b, 0);
			form1.attach_left_widget (edit_hole, inherit_hole, 40);
			form1.attach_right (close_b, 0);
			form2.attach_left (argument_hole, 0);
			form2.attach_left_widget (argument_hole, argument_sw, 5);
			form2.attach_right (argument_sw, 0);
			form3.attach_left (label1, 10);
			form3.attach_top (label1, 10);
			form3.attach_left (label_name, 30);
			form3.attach_left_widget (label1, label_name, 5);
			form3.attach_left_widget (label_name, label_sw, 5);
			form3.attach_right (label_sw, 10);
				-- **********
				-- Set values
				-- **********
			separator.set_single_line;
			separator.set_horizontal (True);
			separator1.set_single_line;
			separator1.set_horizontal (True);
			argument_sw.set_working_area (arguments);
			arguments.set_row_layout;
			label_sw.set_working_area (labels);
			labels.set_row_layout;
			label1.set_text ("New label:");
			undoable_t.set_text ("Undoable");
				-- *************
				-- Set Callbacks
				-- *************
			label_name.add_activate_action (Current, label_name);
			edit_hole.add_button_press_action (2, Current, edit_hole);
			undoable_t.add_activate_action (Current, undoable_t);
		end;

	
feature {NONE}

	execute (argument: ANY) is
			-- Execute routine. Used:
			--	 . To add a label
			--	 . To toggle between non-undoable and doable
		local
			non_undo_cmd: CMD_NON_UNDOABLE;
			undo_cmd: CMD_UNDOABLE;
			msg: STRING
		do
			if (argument = label_name) then
				if	not label_name.text.empty then
					add_label;
					label_name.set_text ("");
				end
			elseif (argument = undoable_t and then
						(edited_command /= Void)) then
				if undoable_t.state then
					!!undo_cmd;
					undo_cmd.execute (edited_command)
				else
					!!non_undo_cmd;
					non_undo_cmd.execute (edited_command)
				end
			elseif (argument = edit_hole and then
						(edited_command /= Void)) then
				!!msg.make (0);
				msg.append ("Do you wish to reset%N");
				msg.append ("command text");
				warning_box.popup (Current, msg);
			end;
		end; 

	popup_error_box (s: STRING) is
			-- Popup error box with message `s'.
		require
			not_void_s: not (s = Void)
		do
			error_box.popup (Current, s);
		end;

feature {USER_CMD}
	
	set_unsaved_application is
		do
			if history_window.saved_application then
				history_window.set_unsaved_application;
			end;
		end;


feature -- Top shell features

	realize is
			-- Realize Current window.
		do
			shell_realize;
			if (current_command = Void) then
				inherit_hole.hide
			end;				
		end;


	continue_after_popdown (box: MESSAGE_D; ok: BOOLEAN) is
		do
			if (box = warning_box) then
				if ok then
					text_editor.set_text (edited_command.template)
				end
			end
		end;

end
