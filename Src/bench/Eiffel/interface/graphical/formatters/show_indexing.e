indexing

	description:	
		"Indexing clause of classes in the universe.";
	date: "$Date$";
	revision: "$Revision$"

class SHOW_INDEXING 

inherit

	LONG_FORMATTER
		redefine
			display_temp_header, post_fix
		end

creation

	make
	
feature -- Properties

	symbol: PIXMAP is 
		once 
			Result := Pixmaps.bm_Showindexing 
		end;
 
feature {NONE} -- Properties

	name: STRING is
		do
			Result := Interface_names.f_Showindexing
		end;

	menu_name: STRING is
			-- Name used in menu entry
		do
			Result := Interface_names.m_Showindexing
		end;

	accelerator: STRING is
			-- Accelerator action for menu entry
		do
		end;

	title_part: STRING is
		do
			Result := Interface_names.t_Indexing_of
		end;

	post_fix: STRING is "ind";

	create_structured_text (c: CLASSC_STONE): STRUCTURED_TEXT is
			-- Show indexing clause of classes.
		local
			cmd: E_SHOW_INDEXING_CLAUSE;
		do
			!! cmd.make;
			cmd.execute;
			Result := cmd.structured_text
		end;

feature {NONE} -- Implementation

	display_temp_header (stone: STONE) is
			-- Display a temporary header during the format processing.
		do
			tool.set_title ("Searching system for indexing clauses...")
		end;

end -- class SHOW_INDEXING
