class CLIENT_AS

inherit

	AST_EIFFEL
		redefine
			format
		end;
	SHARED_EXPORT_STATUS

feature -- Attributes

	clients: EIFFEL_LIST [ID_AS];
			-- Client list

feature -- Initialization

	set is
			-- Yacc initialization
		do
			clients ?= yacc_arg (0);
		ensure then
			not (clients = Void or else clients.empty);
		end;

	export_status: EXPORT_I is
			-- Associated export status
--		require
--			System.current_class /= Void;
		local
			export_set: EXPORT_SET_I;
			client_i: CLIENT_I;
		do
			if clients.count = 1 and then ("none").is_equal (clients.first) then
			   Result := Export_none;
			else
				!!client_i;
				client_i.set_clients (clients);
					-- Current class in second pass...
				client_i.set_written_in (System.current_class.id);
				!!export_set.make;
				export_set.compare_objects;
				export_set.put (client_i);
				Result := export_set;
			end;
		end;

	format (ctxt : FORMAT_CONTEXT) is
		local
			temp: STRING;
			cluster: CLUSTER_I;
			client_classc: CLASS_C;
			client_classi: CLASS_I
		do
			cluster := System.class_of_id (ctxt.class_c.id).cluster;
			ctxt.begin;
			ctxt.put_special("{");
			ctxt.set_separator(",");
			ctxt.separator_is_special;
			ctxt.space_between_tokens;
			if 	
				ctxt.client = Void or else 
				export_status.valid_for (ctxt.client)
			then
				from
					clients.start
				until
					clients.after
				loop
					temp := clone (clients.item)
					client_classi := Universe.class_named (temp, cluster);
					if client_classi /= Void then
						client_classc := client_classi.compiled_class;
						if client_classc /= Void then
							ctxt.put_class_name (client_classc)
						else
							ctxt.put_classi_name (client_classi)
						end
					else
						temp.to_upper;
						ctxt.put_string (temp);
					end
					clients.forth;
					if not clients.after then
						ctxt.put_special (",");
						ctxt.put_string (" ");
					end
				end;
				ctxt.put_special("}");
				ctxt.commit
			else
				ctxt.rollback;
			end;
		end;

end
