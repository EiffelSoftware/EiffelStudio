
deferred class QUEST_POPUPER 

inherit

	POPUPER

feature 

	continue_after_question_popdown (ok: BOOLEAN) is
			-- Perform necessary action after question_box has popdown
			-- according to `ok' (indicates whether ok button
			-- was pressed). (By default do nothing). 
		do
		end;

	question_cancel_action is
			-- Action perform if cancel button is pressed.
		deferred
		end;

	question_ok_action is
			-- Action perform if ok button is pressed.
		deferred
		end;

	question_help_action is
			-- Action perform if help button is pressed.
			-- (By default do nothing)
		do
		end;

end
