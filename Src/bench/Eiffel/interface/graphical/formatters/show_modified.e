indexing

	description:	
		"Classes modified since last compilation.";
	date: "$Date$";
	revision: "$Revision$"

class SHOW_MODIFIED 

inherit

	FILTERABLE
		redefine
			dark_symbol, display_temp_header, post_fix, make
		end

creation

	make
	
feature -- Initialization

	make (a_tool: TOOL_W) is 
		do 
			tool := a_tool;
			do_format := true
		end; 

feature -- Properties

	symbol: PIXMAP is 
		once 
			Result := bm_Showmodified 
		end;
 
	dark_symbol: PIXMAP is 
		once 
			Result := bm_Dark_showmodified 
		end;
 
	
feature {NONE} -- Properties

	name: STRING is
		do
			Result := l_Showmodified
		end;

	title_part: STRING is
		do
			Result := l_Modified_of
		end;

	post_fix: STRING is "mod";

feature {NONE} -- Attributes

	create_structured_text (c: CLASSC_STONE): STRUCTURED_TEXT is
			-- Display modified classes list.
		local
			cmd: E_SHOW_MODIFIED_CLASSES
		do
			!! Result.make;
			Result.add_string ("Classes modified since last compilation:");
			Result.add_new_line;
			Result.add_new_line;
			!! cmd.make (Result);
			cmd.execute
		end;

feature {NONE} -- Implementation

	display_temp_header (stone: STONE) is
			-- Display a temporary header during the format processing.
		do
			tool.set_title ("Searching system for modified classes...")
		end;

end -- class SHOW_MODIFIED
