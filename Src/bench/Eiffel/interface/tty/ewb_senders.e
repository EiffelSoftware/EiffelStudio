
class EWB_SENDERS 

inherit

	EWB_CMD
		rename
			name as callers_cmd_name,
			help_message as callers_help
		end;
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

	class_name, feature_name: STRING;

feature

	loop_execute is
		do
			get_class_name;
			class_name := last_input;
			class_name.to_lower;
			get_feature_name;
			feature_name := last_input;
			feature_name.to_lower;
			execute;
		end;

	execute is
		local
			class_c: CLASS_C;
			feature_i: FEATURE_I;
			class_i: CLASS_I
		do
			init_project;
			if not (error_occurred or project_is_new) then
				retrieve_project;
				if not error_occurred then
						-- Get the class
						-- Note: class name amiguities are not resolved.
					class_i := Universe.unique_class (class_name);
					if class_i /= Void then
						class_c := class_i.compiled_class;
					end;

					if class_c = Void then
						io.error.putstring (class_name);
						io.error.putstring (" is not in the system%N");
					else
						feature_i := class_c.feature_table.item (feature_name);
						if feature_i = Void then
							io.error.putstring (feature_name);
							io.error.putstring (" is not a feature of ");
							io.error.putstring (class_name);
							io.error.new_line
						else
							display_senders (error_window, class_c, feature_i);
						end;
					end;
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
			first_time: BOOLEAN
			feat: FEATURE_I
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
						if (fdep.item.id = class_c.id) and
							(fdep.item.feature_id = fid) then
							client := clients.item;
							if first_time then
								client.append_clickable_name (display);
								display.new_line;
							end;
							first_time := False;
							display.put_string ("   ");
debug
	io.error.putstring ("Feature name: ");
	io.error.putstring (cfeat);
	io.error.new_line
end;
							feat := client.feature_table.item (cfeat);
							if feat = Void then
								--| Has to be an invariant
								display.put_string ("invariant");
							else
								feat.append_clickable_name (display, client);
							end;
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
