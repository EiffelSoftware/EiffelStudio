
class EWB_SENDERS 

inherit

	EWB_CMD;
	SHARED_SERVER

creation

	make

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

	name: STRING is "compute the senders";

	execute is
		local
			class_c: CLASS_C;
			feature_i : FEATURE_I;
			fid: INTEGER;
			clients: LINKED_LIST [CLASS_C];
			dep: CLASS_DEPENDANCE;
			fdep: FEATURE_DEPENDANCE;
			cfeat: STRING
		do
			init_project;
			if not (error_occurred or project_is_new) then
				retrieve_project;
				if not error_occurred then
						-- Get the class
						-- Note: class name amiguities are not resolved.
					class_c := Universe.unique_class (class_name).compiled_class;
					clients := class_c.clients;
					fid := class_c.feature_table.item (feature_name).feature_id;
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
									io.error.putstring (clients.item.class_name);
									io.error.putstring (".");
									io.error.putstring (cfeat);
									io.error.new_line;
								end;
								fdep.forth
							end;
							dep.forth;
						end;
						clients.forth;
					end;	
				end;
			end;
		end;

end
