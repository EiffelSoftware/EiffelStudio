
class EWB_SUPPLIERS

inherit

	EWB_CMD
		rename
			name as suppliers_cmd_name,
			help_message as suppliers_help
		end;

creation

	make, null

feature -- Creation

	make (cn: STRING) is
		do
			class_name := cn;
			class_name.to_lower;
		end;

	class_name: STRING;

feature

	loop_execute is
		do
			get_class_name;
			class_name := last_input;
			class_name.to_lower;
			execute;
		end;

	execute is
		local
			class_c: CLASS_C;
			class_i: CLASS_I
		do
			init_project;
			if not (error_occurred or project_is_new) then
				retrieve_project;
				if not error_occurred then
					class_i := Universe.unique_class (class_name);
                    if class_i /= Void then
                        class_c := class_i.compiled_class;
                    end;
					if class_c = Void then
						io.error.putstring (class_name);
						io.error.putstring (" is not in the system%N");
					else
						display_suppliers (error_window, class_c);
					end;
				end;
			end;
		end;

	display_suppliers (display: CLICK_WINDOW; c: CLASS_C) is
		local
			suppliers: SUPPLIER_LIST;
			a_supplier: CLASS_C
		do
			display.put_string ("Suppliers of class ");
			c.append_clickable_signature (display);
			display.put_string (":%N%N");
			from	
				suppliers := c.suppliers;
				suppliers.start;
			until
				suppliers.after
			loop
				a_supplier := suppliers.item.supplier;
				if (c /= a_supplier) then
					display.put_string ("%T");
					a_supplier.append_clickable_signature (display);
					display.new_line;
				end;
				suppliers.forth
			end
		end;

end
