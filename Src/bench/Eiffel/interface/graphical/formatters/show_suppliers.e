-- Command to display class suppliers.

class SHOW_SUPPLIERS 

inherit

	FORMATTER
		redefine
			dark_symbol, display_temp_header, post_fix
		end

creation

	make

feature 

	make (c: COMPOSITE; a_text_window: CLASS_TEXT) is
		do
			init (c, a_text_window);
			indent := 4
		end;

	symbol: PIXMAP is 
		once 
			Result := bm_Showsuppliers 
		end;
 
	dark_symbol: PIXMAP is 
		once 
			Result := bm_Dark_showsuppliers 
		end;
 
feature {NONE}

	command_name: STRING is do Result := l_Showsuppliers end;

	title_part: STRING is do Result := l_Suppliers_of end;

	display_info (c: CLASSC_STONE) is
			-- Display suppliers of `c' in tree form.
		local
			cmd: E_SHOW_SUPPLIERS
		do
			!! cmd.make (c.e_class, text_window);
			cmd.execute
		end

	display_temp_header (stone: STONE) is
			-- Display a temporary header during the format processing.
		do
			text_window.display_header ("Searching for suppliers...")
		end;

	post_fix: STRING is "sup";

end
