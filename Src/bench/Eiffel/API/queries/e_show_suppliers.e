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

	execute is
			-- Execute Current command.
		local
			suppliers: SUPPLIER_LIST;
			a_supplier: E_CLASS;
		do
			structured_text.add_string ("Suppliers of class ");
			current_class.append_signature (structured_text);
			structured_text.add_string (":%N%N");
			from	
				suppliers := current_class.suppliers;
				suppliers.start;
			until
				suppliers.after
			loop
				a_supplier := suppliers.item.supplier;
				if (current_class /= a_supplier) then
					structured_text.add_char ('%T');
					a_supplier.append_signature (structured_text);
					structured_text.add_new_line;
				end;
				suppliers.forth
			end
		end;

end -- class E_SHOW_SUPPLIERS
