indexing

	description:	
		"Command to display the history of a feature.";
	date: "$Date$";
	revision: "$Revision$"

class SHOW_PAST

inherit

	FILTERABLE
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
			Result := bm_Showaversions 
		end;
 
	dark_symbol: PIXMAP is 
		once 
			Result := bm_Dark_showaversions 
		end;
 
feature {NONE} -- Properties

	name: STRING is
		do
			Result := l_Showpast
		end;

	title_part: STRING is
		do
			Result := l_Past
		end;

	create_structured_text (f: FEATURE_STONE): STRUCTURED_TEXT is
			-- Display history of `f'.
		local
			cmd: E_SHOW_ROUTINE_ANCESTORS;
		do
			!! Result.make;
			!! cmd.make (f.e_feature, Result);
			if cmd.has_valid_feature then
				cmd.execute
			end
		end;

feature {NONE} -- Implementation

	display_temp_header (stone: STONE) is
			-- Display a temporary header during the format processing.
		do
			tool.set_title ("Searching system for ancestor versions...")
		end;

end -- class SHOW_PAST
