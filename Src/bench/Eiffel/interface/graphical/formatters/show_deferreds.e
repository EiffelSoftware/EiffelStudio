indexing

	description:	
		"Command to display class deferred routines.";
	date: "$Date$";
	revision: "$Revision$"

class SHOW_DEFERREDS 

inherit

	FILTERABLE
		redefine
			dark_symbol, display_temp_header, post_fix
		end

creation

	make

feature -- Properties

	symbol: PIXMAP is 
		once 
			Result := Pixmaps.bm_Showdeferreds 
		end;
 
	dark_symbol: PIXMAP is 
		once 
			Result := Pixmaps.bm_Dark_showdeferreds 
		end;
 
feature {NONE} -- Properties

	name: STRING is
		do
			Result := Interface_names.f_Showdeferreds
		end;

	menu_name: STRING is
			-- Name used in menu entry
		do
			Result := Interface_names.m_Showdeferreds
		end;

	accelerator: STRING is
			-- Accelerator action for menu entry
		do
		end;

	title_part: STRING is
		do
			Result := Interface_names.t_Deferreds_of
		end;

	post_fix: STRING is "def";

	create_structured_text (c: CLASSC_STONE): STRUCTURED_TEXT is
		local
			cmd: E_SHOW_DEFERRED_ROUTINES
		do
			!! Result.make;
			!! cmd.make (c.e_class, Result);
			cmd.execute
		end;

feature {NONE} -- Implementation

	display_temp_header (stone: STONE) is
			-- Display a temporary header during the format processing.
		do
			tool.set_title ("Searching for deferred features...")
		end;

end -- class SHOW_DEFERREDS
