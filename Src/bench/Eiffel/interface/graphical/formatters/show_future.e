indexing

	description:	
		"Command to display the history of a feature.";
	date: "$Date$";
	revision: "$Revision$"

class SHOW_FUTURE

inherit

	FILTERABLE
		redefine
			dark_symbol, display_temp_header
		end;
	SHARED_SERVER

creation

	make

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

	create_structured_text (f: FEATURE_STONE): STRUCTURED_TEXT is
			-- Display future of `f'.
		local
			cmd: E_SHOW_ROUTINE_DESCENDANTS;
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
			tool.set_title ("Searching system for descendant versions...")
		end;

end -- class SHOW_FUTURE
