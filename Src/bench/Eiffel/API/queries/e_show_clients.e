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
			clients: SORTED_TWO_WAY_LIST [CLASS_I];
			a_client: E_CLASS;
		do
			structured_text.add_string ("Clients of class ");
			current_class.append_signature (structured_text);
			structured_text.add_string (":%N%N");
			from	
				clients := sorted_list (current_class.clients);
				clients.start;
			until
				clients.after
			loop
				a_client := clients.item.compiled_eclass;
				if (current_class /= a_client) then
					structured_text.add_char ('%T');
					a_client.append_signature (structured_text);
					structured_text.add_new_line;
				end;
				clients.forth
			end
		end;

end -- class E_SHOW_CLIENTS
