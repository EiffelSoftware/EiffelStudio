
class EWB_SENDERS 

inherit

	EWB_FEATURE
		rename
			name as callers_cmd_name,
			help_message as callers_help,
			abbreviation as callers_abb
		end;
	SHARED_SERVER

creation

	make, null

feature

	display (feature_i: FEATURE_I; class_c: CLASS_C) is
		local
			fid: INTEGER;
			clients: LINKED_LIST [CLASS_C];
			dep: CLASS_DEPENDANCE;
			fdep: FEATURE_DEPENDANCE;
			cfeat: STRING;
			client: CLASS_C;
			ftable: FEATURE_TABLE;
			first_time: BOOLEAN
			feat: FEATURE_I;
			d: DEPEND_UNIT;
		do
			fid := feature_i.feature_id;
			clients := class_c.clients;
			from
				clients.start
			until
				clients.after
			loop
				dep := Depend_server.item (clients.item.id);
				from
					dep.start
				until
					dep.after
				loop
					fdep := dep.item_for_iteration;
					cfeat := dep.key_for_iteration;
					from
						fdep.start;
						first_time := True;
					until
						fdep.after
					loop
						d := fdep.item;
						if (d.id = class_c.id) and
							(d.feature_id = fid) then
							client := clients.item;
							if first_time then
								client.append_clickable_name (output_window);
								output_window.new_line;
							end;
							first_time := False;
							output_window.put_char ('%T');
debug
	io.error.putstring ("Feature name: ");
	io.error.putstring (cfeat);
	io.error.new_line
end;
							feat := client.feature_table.item (cfeat);
							if feat = Void then
								--| Has to be an invariant
								output_window.put_string ("invariant");
							else
								feat.append_clickable_name (output_window, client);
							end;
							output_window.new_line;
						end;
						fdep.forth
					end;
					dep.forth;
				end;
				clients.forth;
			end;	
		end;

end
