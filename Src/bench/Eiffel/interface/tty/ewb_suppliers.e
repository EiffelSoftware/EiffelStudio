
class EWB_SUPPLIERS

inherit

	EWB_CLASS
		rename
			name as suppliers_cmd_name,
			help_message as suppliers_help,
			abbreviation as suppliers_abb
		end;

creation

	make, null

feature

	display (c: CLASS_C) is
		local
			suppliers: SUPPLIER_LIST;
			a_supplier: CLASS_C
		do
			output_window.put_string ("Suppliers of class ");
			c.append_clickable_signature (output_window);
			output_window.put_string (":%N%N");
			from	
				suppliers := c.suppliers;
				suppliers.start;
			until
				suppliers.after
			loop
				a_supplier := suppliers.item.supplier;
				if (c /= a_supplier) then
					output_window.put_string ("    ");
					a_supplier.append_clickable_signature (output_window);
					output_window.new_line;
				end;
				suppliers.forth
			end
		end;

end
