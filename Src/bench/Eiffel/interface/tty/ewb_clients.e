
class EWB_CLIENTS

inherit

	EWB_CMD
		rename
			name as clients_cmd_name,
			help_message as clients_help
		end

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
						display_clients (error_window, class_c);
					end;
				end;
			end;
		end;

	display_clients (display: CLICK_WINDOW; c: CLASS_C) is
		local
			clients: LINKED_LIST [CLASS_C];
			a_client: CLASS_C
		do
			display.put_string ("Clients of class ");
			c.append_clickable_signature (display);
			display.put_string (":%N%N");
			from	
				clients := c.clients;
				clients.start;
			until
				clients.after
			loop
				a_client := clients.item;
				if (c /= a_client) then
					display.put_string ("    ");
					a_client.append_clickable_signature (display);
					display.new_line;
				end;
				clients.forth
			end
		end;

end
