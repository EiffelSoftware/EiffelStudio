-- Command to display class suppliers.

class SHOW_SUPPLIERS 

inherit

	FORMATTER

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
 
feature {NONE}

	command_name: STRING is do Result := l_Showsuppliers end;

	title_part: STRING is do Result := l_Suppliers_of end;

	display_info (i: INTEGER; c: CLASSC_STONE) is
			-- Display suppliers of `c' in tree form.
		local
			ewb_suppliers: EWB_SUPPLIERS
		do
			!! ewb_suppliers.null;
			ewb_suppliers.set_output_window (text_window);
			ewb_suppliers.display (c.class_c);
		end

end
