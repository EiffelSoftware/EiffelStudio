indexing

	description:	
		"Command to serch for a string.";
	date: "$Date$";
	revision: "$Revision$"

class SEARCH_STRING 

inherit

	PIXMAP_COMMAND
		rename
			init as make
		end

creation

	make

feature -- Close window

	close is
			-- Close the search window.
		do
			if search_window /= Void then
				search_window.close
			end
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
			-- Popup seach window in `tool'.
		do
			if search_window = Void then
				!! search_window.make (tool);
			end;
			search_window.call 
		end;

feature {NONE} -- Attributes

	name: STRING is
			-- Name of the command.
		do
			Result := l_Search
		end

end -- class SEARCH_STRING
