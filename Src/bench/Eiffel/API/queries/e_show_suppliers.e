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
			a_supplier: CLASS_C
		do
			output_window.put_string ("Suppliers of class ");
			current_class.append_clickable_signature (output_window);
			output_window.put_string (":%N%N");
			from	
				suppliers := current_class.suppliers;
				suppliers.start;
			until
				suppliers.after
			loop
				a_supplier := suppliers.item.supplier;
				if (current_class /= a_supplier) then
					output_window.put_char ('%T');
					a_supplier.append_clickable_signature (output_window);
					output_window.new_line;
				end;
				suppliers.forth
			end
		end;

end -- class E_SHOW_SUPPLIERS
