indexing

	description:	
		"Window to search for a string in a text.";
	date: "$Date$";
	revision: "$Revision: "

class SEARCH_W 

inherit

	COMMAND_W;
	NAMER;
	PROMPT_D
		rename
			make as prompt_dialog_create
		end;
	SET_WINDOW_ATTRIBUTES

creation

	make
	
feature -- Initialization

	make (a_tool: TOOL_W) is
			-- Create a file selection dialog
		local
			void_argument: ANY
		do
			tool := a_tool;
			prompt_dialog_create (l_Search, a_tool.popup_parent);
			set_title (l_Search);
			set_selection_label ("Search");
			hide_apply_button;
			hide_help_button;
			set_width (200);
			set_ok_label ("Next");
			add_ok_action (Current, ok_it);
			add_cancel_action (Current, cancel_it);
			set_composite_attributes (Current)
		end;

feature -- Closing

	close is
		do
			if is_popped_up then
				unrealize;
				popdown
			end
		end;

feature -- Access

	call is
			-- Record calling text_window `a_text_window' and popup current.
		do
			popup;
			raise
		end;

feature {NONE} -- Properties

	ok_it: ANY is
			-- Argument for `work' if ok button pressed
		once
			!! Result
		end;

	cancel_it: ANY is
			-- Argument for `work' if cancel button pressed
		once
			!! Result
		end;

	tool: TOOL_W
			-- Tool which popped up current

feature {NONE} -- Implementation

	work (argument: ANY) is
        do
			if last_warner /= Void then
				last_warner.popdown
			end;
			if argument = ok_it then
				tool.text_window.search (selection_text);
			elseif argument = cancel_it then
				popdown
			end
		end;

end -- class SEARCH_W
