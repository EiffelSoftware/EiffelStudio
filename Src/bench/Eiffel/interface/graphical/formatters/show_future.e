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
			Result := Pixmaps.bm_Showdversions 
		end;
 
	dark_symbol: PIXMAP is 
		once 
			Result := Pixmaps.bm_Dark_showdversions 
		end;
 
feature {NONE} -- Properties

	name: STRING is
		do
			Result := Interface_names.f_Showfuture
		end;

	menu_name: STRING is
			-- Name used in menu entry
		do
			Result := Interface_names.m_Showfuture
		end;

	accelerator: STRING is
			-- Accelerator action for menu entry
		do
		end;

	title_part: STRING is
		do
			Result := Interface_names.t_Future
		end;

	create_structured_text (f: FEATURE_STONE): STRUCTURED_TEXT is
			-- Display future of `f'.
		local
			cmd: E_SHOW_ROUTINE_DESCENDANTS;
		do
			!! cmd.make (f.e_feature);
			if cmd.has_valid_feature then
				cmd.execute;
				Result := cmd.structured_text
			end
		end;

feature {NONE} -- Implementation

	display_temp_header (stone: STONE) is
			-- Display a temporary header during the format processing.
		do
			tool.set_title ("Searching system for descendant versions...")
		end;

end -- class SHOW_FUTURE
