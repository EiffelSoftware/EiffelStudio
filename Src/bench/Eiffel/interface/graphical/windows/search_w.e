
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

	make (a_composite: COMPOSITE; t_w: TEXT_WINDOW) is
			-- Create a file selection dialog
		local
			void_argument: ANY
		do
			text_window := t_w;
			prompt_dialog_create (l_Search, a_composite);
			set_title (l_Search);
			set_selection_label ("search for...");
			hide_apply_button;
			hide_help_button;
			!!ok_it;
			!!cancel_it;
			set_width (200);
			set_ok_label ("next");
			add_ok_action (Current, ok_it);
			text_window.set_action ("Ctrl<Key>d", Current, ok_it);
			add_cancel_action (Current, cancel_it)
		end;

	
feature {NONE}

	ok_it, cancel_it: ANY;
			-- Arguments for the command

feature 

	call is
			-- Record calling text_window `a_text_window' and popup current.
		do
			set_exclusive_grab;
			popup
		end;

feature {NONE}

	work (argument: ANY) is
        do
			if argument = ok_it then
				text_window.search (selection_text);
				if text_window.found then
					--popdown
				end
			elseif argument = cancel_it then
				popdown
			end
		end;

	text_window: TEXT_WINDOW
			-- Text_window which popped up current

end
