indexing

	description:	
		"Command to display classes in the universe, in alphabetic order.";
	date: "$Date$";
	revision: "$Revision$"

class SHOW_CLASS_LIST 

inherit

	LONG_FORMATTER
		redefine
			dark_symbol, display_temp_header, post_fix
		end

creation

	make
	
feature -- Initialization

	make (c: COMPOSITE; a_text_window: TEXT_WINDOW) is 
			-- Initialize the command.
		do 
			init (c, a_text_window)
		end; 

feature -- Properties

	symbol: PIXMAP is 
			-- Pixmap for the button.
		once 
			Result := bm_Showclass_list 
		end;
 
	dark_symbol: PIXMAP is 
			-- Dark version of `symbol'.
		once 
			Result := bm_Dark_showclass_list 
		end;

feature {NONE} -- Properties

	name: STRING is
			-- Name of the command.
		do
			Result := l_Showclass_list
		end;

	title_part: STRING is
		do
			Result := l_Class_list_of
		end;

	post_fix: STRING is "alf";

feature {NONE} -- Implementation

	display_info (c: CLASSC_STONE) is
			-- Show universe: classes in alphabetic order, in `text_window'.
		local
			cmd: E_SHOW_CLASSES
		do
			!! cmd.make (text_window);
			cmd.execute
		end;

	display_temp_header (stone: STONE) is
			-- Display a temporary header during the format processing.
		do
			text_window.display_header ("Exploring and sorting classes...")
		end;

end -- class SHOW_CLASS_LIST
