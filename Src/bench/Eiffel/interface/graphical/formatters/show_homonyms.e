indexing

	description:	
		"Command to display the homonyms of the routine.";
	date: "$Date$";
	revision: "$Revision$"

class SHOW_HOMONYMS

inherit

	LONG_FORMATTER
		redefine
			dark_symbol, display_temp_header
		end;
	SHARED_SERVER

creation

	make
	
feature -- Porperties

	symbol: PIXMAP is 
		once 
			Result := bm_Showhomonyms 
		end;
 
	dark_symbol: PIXMAP is 
		once 
			Result := bm_Dark_showhomonyms 
		end;
 
feature {NONE} -- Properties

	name: STRING is
		do
			Result := l_Showhomonyms
		end;

	title_part: STRING is
		do
			Result := l_Homonyms_of
		end;

	create_structured_text (f: FEATURE_STONE): STRUCTURED_TEXT is
			-- Display homononyms of the routine.
		local
			cmd: E_SHOW_ROUTINE_HOMONYMNS;
		do
			!! Result.make;
			!! cmd.make (f.e_feature, Result);
			cmd.execute;
		end;

feature {NONE} -- Implementation

	display_temp_header (stone: STONE) is
			-- Display a temporary header during the format processing.
		do
			tool.set_title ("Searching system for homonyms...")
		end;

end -- class SHOW_HOMONYMS
