indexing

	description: 
		"Command to display the senders of `current_feature'.";
	date: "$Date$";
	revision: "$Revision $"

class E_SHOW_CALLERS 

inherit

	E_FEATURE_CMD;
	SHARED_SERVER

creation

	make, do_nothing

feature -- Execution

	execute is
		local
			fid: INTEGER;
			clients: LINKED_LIST [CLASS_C];
			dep: CLASS_DEPENDANCE;
			fdep: FEATURE_DEPENDANCE;
			cfeat: STRING;
			client: CLASS_C;
			found, first_time: BOOLEAN
			feat: FEATURE_I;
			class_id: INTEGER;
			current_d: DEPEND_UNIT;
			classes: PART_SORTED_TWO_WAY_LIST [CLASS_I];
			list: PART_SORTED_TWO_WAY_LIST [STRING];
			ftable: FEATURE_TABLE
			table: EXTEND_TABLE [PART_SORTED_TWO_WAY_LIST [STRING], INTEGER];
		do
			fid := current_feature.feature_id;
			clients := current_class.clients;
			class_id := current_class.id;
			!! current_d.make (class_id, fid);
			!! table.make (5);
			!! classes.make;
			from
				clients.start
			until
				clients.after
			loop
				dep := Depend_server.item (clients.item.id);
				from
						-- Loop through the features of each client
						-- of current_class.
					first_time := True;
					dep.start
				until
					dep.after
				loop
					fdep := dep.item_for_iteration;
					if fdep.has (current_d) then
						client := clients.item;
						if first_time then
								-- Print out client name once.
							classes.put_front (client.lace_class);
							!! list.make;
							table.put (list, client.id);
						end;
						first_time := False;
						cfeat := dep.key_for_iteration;
						list.put_front (cfeat);
					end;
					dep.forth;
				end;
				clients.forth;
			end;
			classes.sort;
			from
				classes.start
			until
				classes.after
			loop
				client := classes.item.compiled_class;	
					-- Print out client name once.
				client.append_clickable_name (output_window);
				output_window.new_line;
				ftable := client.feature_table;
				list := table.item (client.id);
				list.sort;
				from
					list.start
				until
					list.after
				loop
					cfeat := list.item;
					feat := ftable.item (cfeat);
					output_window.put_char ('%T');
					if feat = Void then
						output_window.put_string ("invariant")
					else
						feat.append_clickable_name (output_window, client)	
					end;
					output_window.new_line;
					list.forth
				end;
				classes.forth
			end
		end;

end -- class E_SHOW_SENDERS
