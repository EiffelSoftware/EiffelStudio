indexing

	description: 
		"Command to display clients of `current_class'.";
	date: "$Date$";
	revision: "$Revision $"

class E_SHOW_CLIENTS

inherit

	E_CLASS_CMD

creation

	make, do_nothing

feature -- Execution

	execute is
			-- Execute Current command.
		local
			clients: LINKED_LIST [CLASS_C];
			a_client: CLASS_C
		do
			output_window.put_string ("Clients of class ");
			current_class.append_clickable_signature (output_window);
			output_window.put_string (":%N%N");
			from	
				clients := current_class.clients;
				clients.start;
			until
				clients.after
			loop
				a_client := clients.item;
				if (current_class /= a_client) then
					output_window.put_char ('%T');
					a_client.append_clickable_signature (output_window);
					output_window.new_line;
				end;
				clients.forth
			end
		end;

end -- class E_SHOW_CLIENTS
