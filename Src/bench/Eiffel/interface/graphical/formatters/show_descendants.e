indexing

	description:	
		"Command to display class descendants.";
	date: "$Date$";
	revision: "$Revision$"

class SHOW_DESCENDANTS 

inherit

	FILTERABLE
		redefine
			dark_symbol, display_temp_header, post_fix
		end

creation

	make

feature -- Initialization

	make (a_text_window: CLASS_TEXT) is
		do
			init (a_text_window);
			indent := 4
		ensure
			default_indent: indent = 4
		end;

feature -- Properties

	symbol: PIXMAP is 
		once 
			Result := bm_Showdescendants 
		end;
 
	dark_symbol: PIXMAP is 
		once 
			Result := bm_Dark_showdescendants 
		end;

feature {NONE} -- Properties

	name: STRING is
		do
			Result := l_Showdescendants
		end;

	title_part: STRING is
		do
			Result := l_Descendants_of
		end;

	post_fix: STRING is "des";

feature {NONE} -- Attributes

	create_structured_text (c: CLASSC_STONE): STRUCTURED_TEXT is
			-- Display the descendants of `c' in tree form.
		local
			cmd: E_SHOW_DESCENDANTS;
		do
			!! Result.make;
			!! cmd.make (c.e_class, Result);
			cmd.execute
		end;

feature {NONE} -- Implementation

	display_temp_header (stone: STONE) is
			-- Display a temporary header during the format processing.
		do
			text_window.display_header ("Searching for descendants...")
		end;

end -- class SHOW_DESCENDANTS
