-- Command to display class suppliers.

class SHOW_SUPPLIERS 

inherit

	FORMATTER

creation

	make

feature 

	make (c: COMPOSITE; a_text_window: CLASS_TEXT) is
		do
			init (c, a_text_window)
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
--			suppliers: SUPPLIER_LIST;
			d: CLASSC_STONE
		do
--			from
--				suppliers := c.suppliers;
--				suppliers.start
--			until
--				suppliers.offright
--			loop
--				d := suppliers.item.supplier;
--				if d /= c then
--					text_window.put_string ("%T");
--					text_window.put_clickable_string (d, d.signature);
--					text_window.put_string ("%N")
--				end;
--				suppliers.forth
--			end
		end

end
