indexing

	description:	
		"Command to display the history of a feature.";
	date: "$Date$";
	revision: "$Revision$"

class SHOW_FUTURE

inherit

	FORMATTER_2
		redefine
			dark_symbol, display_temp_header
		end;
	SHARED_SERVER

creation

	make

feature -- Initialization

	make (a_text_window: TEXT_WINDOW) is
		do
			init (a_text_window)
		end;

feature -- Properties

	symbol: PIXMAP is 
		once 
			Result := bm_Showdversions 
		end;
 
	dark_symbol: PIXMAP is 
		once 
			Result := bm_Dark_showdversions 
		end;
 
feature {NONE} -- Properties

	name: STRING is
		do
			Result := l_Showfuture
		end;

	title_part: STRING is
		do
			Result := l_Future
		end;

feature {NONE} -- Implementation

	display_info (f: FEATURE_STONE)  is
			-- Display history of `f;
		local
			cmd: E_SHOW_ROUTINE_DESCENDANTS;
		do
			!! cmd.make (f.e_feature, f.e_class, text_window);
			if cmd.has_valid_feature then
				cmd.execute
			end
		end;

	display_temp_header (stone: STONE) is
			-- Display a temporary header during the format processing.
		do
			text_window.display_header ("Searching system for descendant versions...")
		end;

end -- class SHOW_FUTURE
