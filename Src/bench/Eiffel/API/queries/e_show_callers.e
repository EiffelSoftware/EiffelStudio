indexing

	description: 
		"Command to display the senders of `current_feature'.";
	date: "$Date$";
	revision: "$Revision $"

class E_SHOW_CALLERS 

inherit

	E_FEATURE_CMD;

creation

	make, do_nothing

feature -- Execution

	execute is
		local
			clients: LINKED_LIST [E_CLASS];
			cfeat: STRING;
			client: E_CLASS;
			feat: E_FEATURE;
			classes: PART_SORTED_TWO_WAY_LIST [CLASS_I];
			list: SORTED_LIST [STRING];
			table: EXTEND_TABLE [SORTED_LIST [STRING], INTEGER]
		do
			clients := current_class.clients;
			!! table.make (5);
			!! classes.make;
			from
				clients.start
			until
				clients.after
			loop
				client := clients.item;
				list := current_feature.callers (current_class, client)
				if list /= Void then
					table.put (list, client.id);
					classes.put_front (client.lace_class)
				end;
				clients.forth;
			end;
			classes.sort;
			from
				classes.start
			until
				classes.after
			loop
				client := classes.item.compiled_eclass;	
					-- Print out client name once.
				client.append_name (structured_text);
				structured_text.add_new_line;
				list := table.item (client.id);
				from
					list.start
				until
					list.after
				loop
					cfeat := list.item;
					feat := client.feature_with_name (cfeat);
					structured_text.add_char ('%T');
					if feat = Void then
						structured_text.add_string ("invariant")
					else
						feat.append_name (structured_text, client)	
					end;
					structured_text.add_new_line;
					list.forth
				end;
				classes.forth
			end
		end;

end -- class E_SHOW_SENDERS
