indexing

	description:	
		"Command to search for a string.";
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

	close_search_window is
			-- Close the search window.
		do
			if search_window /= Void then
				search_window.close
			end
		end

feature -- Properties

	search_window: SEARCH_W
			-- The search window.

	symbol: PIXMAP is 
			-- Pixmap for the button.
		once 
			Result := Pixmaps.bm_Search
		end

feature {NONE} -- Implementation

	work (arg: ANY) is
			-- Popup seach window in `tool'.
		do
			if search_window = Void then
				!! search_window.make (tool)
			end
			search_window.call
		end

feature {NONE} -- Attributes

	name: STRING is
			-- Name of the command.
		once
			Result := Interface_names.f_Find
		end

	menu_name: STRING is
			-- Name used in menu entry
		once
			Result := Interface_names.m_old_Find
		end

	accelerator: STRING is
			-- Accelerator action for menu entry
		once
			Result := Interface_names.a_Find
		end

end -- class SEARCH_STRING
