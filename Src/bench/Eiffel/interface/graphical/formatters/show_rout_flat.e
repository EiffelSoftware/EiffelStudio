indexing

	description:	
		"Command to flat of routine.";
	date: "$Date$";
	revision: "$Revision$"

class SHOW_ROUT_FLAT

inherit

	FILTERABLE
		rename
			create_structured_text as rout_flat_context_text
		redefine
			dark_symbol, display_temp_header
		end;
	SHARED_SERVER;
	SHARED_FORMAT_TABLES

creation

	make

feature -- Properties

	symbol: PIXMAP is
		once
			Result := bm_Showflat
		end;

	dark_symbol: PIXMAP is
		once
			Result := bm_Dark_showflat
		end;

feature {NONE} -- Properties

	title_part: STRING is
		do
			Result := l_Feature_flat_form_of
		end;

	name: STRING is
		do
			Result := l_Showflat
		end;

feature {NONE} -- Implementation

	display_temp_header (stone: STONE) is
			-- Display a temporary header during the format processing.
		do
			tool.set_title ("Exploring ancestors to produce flat form...")
		end;

end -- class SHOW_ROUT_FLAT
