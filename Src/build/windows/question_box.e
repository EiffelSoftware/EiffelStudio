
class QUESTION_BOX 

inherit

	COMMAND_ARGS;
	COMMAND;
	CONSTANTS;

feature {NONE}

	caller: QUEST_POPUPER;

feature 

	is_popped_up: BOOLEAN is
		do
			Result := quest_d /= Void
		end;

	popup_with_labels (c: QUEST_POPUPER; 
				s: STRING; 
				extra_message: STRING;
				ok_label, cancel_label, help_label: STRING) is
			-- Popup Current question box.
			-- Set ok_label to `ok_label' and cancel_label to `cancel_label'
			-- and hide_label to `help_label' (hide help button if
			-- help_label is void).
		require
			valid_c: c /= Void;
			valid_parent_comp: c.popuper_parent /= Void;
			valid_s: s /= Void;
			valid_labels: ok_label /= Void and then cancel_label /= Void;
			valid_extra_message: extra_message /= Void implies
				not extra_message.empty
		local
			tmp: STRING;
			top: TOP
		do
			make (c.popuper_parent, ok_label,
								cancel_label, help_label);
			caller := c;
			if extra_message = Void then
				tmp := s;
			else
				tmp := clone (s);
				tmp.replace_substring_all ("%%X", extra_message)
			end;
			quest_d.set_message (tmp);
			quest_d.popup;

			top ?= c.popuper_parent
			if top /= Void and then top.is_iconic_state then
				quest_d.set_x_y (0, 0)
			end
		end;

	popup (c: QUEST_POPUPER; s: STRING; extra_message: STRING) is
			-- Popup Current question box.
			-- Set ok_label to `yes' and cancel_label to `no'
			-- and hide the help_button.
		require
			valid_c: c /= Void;
			valid_parent_comp: c.popuper_parent /= Void;
			valid_s: s /= Void;
			valid_extra_message: extra_message /= Void implies
				not extra_message.empty
		local
			tmp: STRING;
			top: TOP
		do
			make (c.popuper_parent, Widget_names.yes_label,
								Widget_names.no_label, Void);
			caller := c;
			if extra_message = Void then
				tmp := s;
			else
				tmp := clone (s);
				tmp.replace_substring_all ("%%X", extra_message)
			end;
			quest_d.set_message (tmp);
			quest_d.popup;

			top ?= c.popuper_parent
			if top /= Void and then top.is_iconic_state then
				quest_d.set_x_y (0, 0)
			end
		end;

	popdown is
		do
			if quest_d /= Void then	
				quest_d.popdown
			end
		end;

feature {NONE}
	
	quest_d: QUESTION_D

	make (a_parent: COMPOSITE; ok_label: STRING; 
								cancel_label: STRING;
								help_label: STRING) is
		require
			valid_labels: ok_label /= Void and then
						cancel_label /= Void
		local
			set_dialog_att: SET_DIALOG_ATTRIBUTES_COM
		do
			!! quest_d.make (Widget_names.question_window, a_parent);
			quest_d.set_title (Widget_names.question_window);
			if help_label = Void then
				quest_d.hide_help_button;
			else
				quest_d.set_help_label (help_label);
			end;
			quest_d.set_ok_label (ok_label);
			quest_d.set_cancel_label (cancel_label);
			quest_d.set_exclusive_grab;
			quest_d.add_ok_action (Current, First);
			quest_d.add_cancel_action (Current, Second);
			quest_d.add_help_action (Current, Third);

			!! set_dialog_att; 
			set_dialog_att.execute (quest_d);
			quest_d.set_action ("<Unmap>", Current, Void);
		end;

feature {NONE}

	execute (argument: ANY) is
		do
			if quest_d /= Void then
				quest_d.popdown;
				quest_d.destroy;
				quest_d := Void;
			end;
			if argument /= Void then
				-- Not an unmap event
				if caller /= Void then
					if argument = First then
						caller.question_ok_action
					elseif argument = Second then
						caller.question_cancel_action
					elseif argument = Third then
						caller.question_help_action
					end
				end;
			end
		end

end

