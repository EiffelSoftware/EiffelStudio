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
			!!Result.make; 
			Result.read_from_file (bm_Showsuppliers) 
		end;
 
feature {NONE}

	command_name: STRING is do Result := l_Showsuppliers end;

	title_part: STRING is do Result := l_Suppliers_of end;

	display_info (i: INTEGER; c: CLASSC_STONE) is
			-- Display suppliers of `c' in tree form.
		local
			suppliers: SUPPLIER_LIST;
			classc_stone: CLASSC_STONE
		do
			text_window.put_string ("Suppliers of class ");
			text_window.put_clickable_string (c, c.signature);
			text_window.put_string (":%N%N");	
			from
				suppliers := c.class_c.suppliers;
				suppliers.start
			until
				suppliers.after
			loop
				!!classc_stone.make (suppliers.item.supplier);
				if (c.class_c /= classc_stone.class_c) then
					text_window.put_string (tabs (1));
					text_window.put_clickable_string (classc_stone, classc_stone.signature);
					text_window.put_string ("%N");
				end;
				suppliers.forth
			end
		end

end
