indexing

	description:	
		"Command to display class suppliers.";
	date: "$Date$";
	revision: "$Revision$"

class SHOW_SUPPLIERS 

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
			Result := bm_Showsuppliers 
		end;
 
	dark_symbol: PIXMAP is 
		once 
			Result := bm_Dark_showsuppliers 
		end;
 
feature {NONE} -- Properties

	name: STRING is
		do
			Result := l_Showsuppliers
		end;

	title_part: STRING is
		do
			Result := l_Suppliers_of
		end;

	post_fix: STRING is "sup";

	create_structured_text (c: CLASSC_STONE): STRUCTURED_TEXT is
			-- Display suppliers fo `c'.
		local
			cmd: E_SHOW_SUPPLIERS;
		do
			!! Result.make;
			!! cmd.make (c.e_class, Result);
			cmd.execute;
		end;

feature {NONE} -- Implementation

	display_temp_header (stone: STONE) is
			-- Display a temporary header during the format processing.
		do
			tool.set_title ("Searching for suppliers...")
		end;

end -- class SHOW_SUPPLIERS
