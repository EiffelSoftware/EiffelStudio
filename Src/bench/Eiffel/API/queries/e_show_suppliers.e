indexing

	description: 
		"Command to display suppliers of `current_class'.";
	date: "$Date$";
	revision: "$Revision $"


class E_SHOW_SUPPLIERS

inherit

	E_CLASS_CMD

creation

	make, do_nothing

feature -- Output

	work is
			-- Execute Current command.
		local
			suppliers: SORTED_TWO_WAY_LIST [CLASS_I];
			a_supplier: CLASS_C
		do
			structured_text.add_string ("Suppliers of class ");
			current_class.append_signature (structured_text);
			structured_text.add_string (":");
			structured_text.add_new_line;
			structured_text.add_new_line;
			from	
				suppliers := sorted_list (current_class.suppliers.classes);
				suppliers.start
			until
				suppliers.after
			loop
				a_supplier := suppliers.item.compiled_class;
				if (current_class /= a_supplier) then
					structured_text.add_indent;
					a_supplier.append_signature (structured_text);
					structured_text.add_new_line
				end;
				suppliers.forth
			end
		end;

end -- class E_SHOW_SUPPLIERS
