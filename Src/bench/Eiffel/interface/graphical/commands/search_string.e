indexing

	description:	
		"Command to serch for a string.";
	date: "$Date$";
	revision: "$Revision$"

class SEARCH_STRING 

inherit

	ICONED_COMMAND

creation

	make

feature -- Initialization

	make (c: COMPOSITE; a_text_window: TEXT_WINDOW) is
			-- Initialize the command. And create the window.
		do
			!!search_window.make (c, a_text_window);
			init (c, a_text_window);
		end;

feature -- Close window

	close is
			-- Close the search window.
		do
			search_window.close
		end; 

feature -- Properties

	search_window: SEARCH_W;
			-- The search window.

	symbol: PIXMAP is 
			-- Pixmap for the button.
		once 
			Result := bm_Search
		end;

feature {NONE} -- Implementation

	work (arg: ANY) is
			-- Change font in `a_text_window'.
		do
			search_window.call 
		end;

feature {NONE} -- Attributes

	command_name: STRING is
			-- Name of the command.
		do
			Result := l_Search
		end

end -- class SEARCH_STRING
