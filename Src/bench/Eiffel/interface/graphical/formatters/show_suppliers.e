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
			class_c: CLASS_C;
			a_supplier: CLASS_C;
		do
			class_c := c.class_c;
			text_window.put_string ("Suppliers of class ");
			class_c.append_clickable_signature (text_window);
			text_window.put_string (":%N%N");	
			from
				suppliers := class_c.suppliers;
				suppliers.start
			until
				suppliers.after
			loop
				a_supplier := suppliers.item.supplier;
				if (class_c /= a_supplier) then
					text_window.put_string (tabs (1));
					a_supplier.append_clickable_signature (text_window);
					text_window.new_line;
				end;
				suppliers.forth
			end
		end

end
