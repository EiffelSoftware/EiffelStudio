
class EWB_CLIENTS

inherit

	EWB_CLASS
		rename
			name as clients_cmd_name,
			help_message as clients_help,
			abbreviation as clients_abb
		end

creation

	make, null

feature

	display (c: CLASS_C) is
		local
			clients: LINKED_LIST [CLASS_C];
			a_client: CLASS_C
		do
			output_window.put_string ("Clients of class ");
			c.append_clickable_signature (output_window);
			output_window.put_string (":%N%N");
			from	
				clients := c.clients;
				clients.start;
			until
				clients.after
			loop
				a_client := clients.item;
				if (c /= a_client) then
					output_window.put_string ("    ");
					a_client.append_clickable_signature (output_window);
					output_window.new_line;
				end;
				clients.forth
			end
		end;

end
