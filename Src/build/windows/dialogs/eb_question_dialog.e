
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

	popup (c: QUEST_POPUPER; s: STRING; extra_message: STRING) is
		require
			valid_c: c /= Void;
			valid_parent_comp: c.popuper_parent /= Void;
			valid_s: s /= Void;
			valid_extra_message: extra_message /= Void implies
				not extra_message.empty
		local
			tmp: STRING;
		do
			make (c.popuper_parent);
			caller := c;
			if extra_message = Void then
				tmp := s;
			else
				tmp := clone (s);
				tmp.replace_substring_all ("%%X", extra_message)
			end;
			quest_d.set_message (tmp);
			quest_d.popup;
		end;

	popdown is
		do
			if quest_d /= Void then	
				quest_d.popdown
			end
		end;
	
	quest_d: QUESTION_D

	make (a_parent: COMPOSITE) is
		local
			set_dialog_att: SET_DIALOG_ATTRIBUTES_COM
		do
			!! quest_d.make (Widget_names.question_window, a_parent);
			quest_d.set_title (Widget_names.question_window);
			quest_d.hide_help_button;
			quest_d.set_exclusive_grab;
			quest_d.add_ok_action (Current, First);
			quest_d.add_cancel_action (Current, Second);
			quest_d.set_ok_label (Widget_names.yes_label);
			quest_d.set_cancel_label (Widget_names.no_label);
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
					caller.continue_after_question_popdown (argument = First);
				end;
			end
		end

end

