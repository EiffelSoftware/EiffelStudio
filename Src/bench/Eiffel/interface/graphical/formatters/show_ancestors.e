indexing

	description:	
		"Command to display class ancestors.";
	date: "$Date$";
	revision: "$Revision$"

class SHOW_ANCESTORS 

inherit

	FILTERABLE
		redefine
			dark_symbol, display_temp_header, post_fix
		end

creation

	make
	
feature -- Properties

	symbol: PIXMAP is 
			-- Pixmap for the button.
		once 
			Result := bm_Showancestors 
		end;
 
	dark_symbol: PIXMAP is 
			-- Dark version of `symbol'.
		once 
			Result := bm_Dark_showancestors
		end;
 
feature {NONE} -- Properties

	name: STRING is
			-- Name of the command.
		do
			Result := l_Showancestors
		end;

	title_part: STRING is
		do
			Result := l_Ancestors_of
		end;

	post_fix: STRING is "anc";

	create_structured_text (c: CLASSC_STONE): STRUCTURED_TEXT is
			-- Display parents of `c' in tree form.
		local
			cmd: E_SHOW_ANCESTORS;
		do
			!! Result.make;
			!! cmd.make (c.e_class, Result);
			cmd.execute
		end;

feature {NONE} -- Implementation

	display_temp_header (stone: STONE) is
			-- Display a temporary header during the format processing.
		do
			tool.set_title ("Searching for ancestors...")
		end;

end -- class SHOW_ANCESTORS
