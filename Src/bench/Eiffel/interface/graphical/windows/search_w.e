
-- Window to search for a string in a text

class SEARCH_W 

inherit

	COMMAND_W;
	NAMER;
	PROMPT_D
		rename
			make as prompt_dialog_create
		end

creation

	make
	
feature 

	make (a_composite: COMPOSITE) is
			-- Create a file selection dialog
		local
			void_argument: ANY
		do
			prompt_dialog_create (l_Search, a_composite);
			hide_apply_button;
			!!ok_it;
			!!cancel_it;
			add_ok_action (Current, ok_it);
			add_cancel_action (Current, cancel_it)
		end;

	
feature {NONE}

	ok_it, cancel_it: ANY;
			-- Arguments for the command

feature 

	call (a_text_window: TEXT_WINDOW) is
			-- Record calling text_window `a_text_window' and popup current.
		do
			last_text_window := a_text_window;
			set_exclusive_grab;
			popup
		ensure
			last_text_window_recorded: last_text_window = a_text_window
		end;

feature {NONE}

	work (argument: ANY) is
        do
			if argument = ok_it then
				last_text_window.search (selection_text);
				if last_text_window.found then
					popdown
				end
			elseif argument = cancel_it then
				popdown
			end
		end;

	last_text_window: TEXT_WINDOW
			-- Last text_window which popped up current

end
