
class EWB_SENDERS 

inherit

	WINDOWS;
	EWB_CMD;
	SHARED_SERVER

creation

	make, null

feature -- Creation

	make (cn, fn: STRING) is
		do
			class_name := cn;
			class_name.to_lower;
			feature_name := fn;
			feature_name.to_lower
		end;

	null is do end;

	class_name, feature_name: STRING;

feature

	name: STRING is "compute the senders";

	execute is
		local
			class_c: CLASS_C;
			feature_i: FEATURE_I;
		do
			init_project;
			if not (error_occurred or project_is_new) then
				retrieve_project;
				if not error_occurred then
						-- Get the class
						-- Note: class name amiguities are not resolved.
					class_c := Universe.unique_class (class_name).compiled_class;
					feature_i := class_c.feature_table.item (feature_name);
					display_senders (error_window, class_c, feature_i);
				end;
			end;
		end;

	display_senders (display: CLICK_WINDOW; class_c: CLASS_C; feature_i: FEATURE_I) is
		local
			fid: INTEGER;
			clients: LINKED_LIST [CLASS_C];
			dep: CLASS_DEPENDANCE;
			fdep: FEATURE_DEPENDANCE;
			cfeat: STRING;
			client: CLASS_C;
			ftable: FEATURE_TABLE;
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
					dep.offright
				loop
					fdep := dep.item_for_iteration;
					cfeat := dep.key_for_iteration;
					from
						fdep.start
					until
						fdep.after
					loop
						if (fdep.item.id = class_c.id) and
							(fdep.item.feature_id = fid) then
							client := clients.item;
							client.append_clickable_name (display);
							display.put_string (".");
							client.feature_table.item (cfeat).append_clickable_name (display, client);
							display.new_line;
						end;
						fdep.forth
					end;
					dep.forth;
				end;
				clients.forth;
			end;	
		end;

end
