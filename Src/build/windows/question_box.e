
class QUESTION_BOX 

inherit

	QUESTION_D
		rename
			popup as old_popup,
			make as question_d_create
		end;

	COMMAND_ARGS
		export
			{NONE} all
		end;

	COMMAND
		export
			{NONE} all
		end


creation

	make

	
feature {NONE}

	caller: QUEST_POPUPER;

feature 

	popup (c: QUEST_POPUPER; s: STRING) is
		do
			caller := c;
			set_message (s);
			old_popup
		end;

	make (a_name: STRING; a_parent: COMPOSITE) is
		do
			question_d_create (a_name, a_parent);
			hide_help_button;
			set_exclusive_grab;
			add_ok_action (Current, First);
			add_cancel_action (Current, Second);
			set_ok_label ("Yes");
			set_cancel_label ("No");
		end;

	
feature {NONE}

	execute (argument: ANY) is
		do
			popdown;
			caller.continue_after_popdown (Current, argument = First)
		end

end

