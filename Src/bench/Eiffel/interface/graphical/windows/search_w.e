indexing

	description:	
		"Window to search for a string in a text.";
	date: "$Date$";
	revision: "$Revision: "

class SEARCH_W 

inherit

	COMMAND_W;
	NAMER;
	SEARCH_REPLACE_DIALOG
		rename
			make as srd_make
		end;
	WINDOW_ATTRIBUTES

creation

	make
	
feature -- Initialization

	make (a_tool: TOOL_W) is
			-- Create a search and replace dialog.
		require
			a_tool_not_void: a_tool /= Void
		local
			void_argument: ANY
		do
			tool := a_tool;
			srd_make (Interface_names.n_X_resource_name, a_tool.popup_parent);
			set_title (Interface_names.t_Search);
			if a_tool.has_editable_text then
				set_replace
			else
				set_search
			end;
			add_find_action (Current, find_it);
			add_replace_action (Current, replace_it);
			add_replace_all_action (Current, replace_it_all);
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

	find_it: ANY is
			-- Argument for `work' if find button pressed
		once
			!! Result
		end;

	cancel_it: ANY is
			-- Argument for `work' if cancel button pressed
		once
			!! Result
		end;

	replace_it: ANY is
			-- Argument for `work' if replace button pressed
		once
			!! Result
		end;

	replace_it_all: ANY is
			-- Argument for `work' if replace all button pressed
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
			if argument = find_it then
				tool.text_window.search (search_text)
			elseif argument = cancel_it then
				popdown
			elseif argument = replace_it then
				tool.text_window.replace_text (search_text, replace_text, False)
			elseif argument = replace_it_all then
				tool.text_window.replace_text (search_text, replace_text, True)
			end
		end;

end -- class SEARCH_W
