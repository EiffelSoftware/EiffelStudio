class CLIENT_AS_B

inherit

	CLIENT_AS
		redefine
			clients
		end;

	AST_EIFFEL_B
		redefine
			format
		end;

	SHARED_EXPORT_STATUS
	
feature -- Attributes

	clients: EIFFEL_LIST_B [ID_AS_B];
			-- Client list

feature -- Initialization

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

	format (ctxt : FORMAT_CONTEXT_B) is
		local
			temp: STRING;
			cluster: CLUSTER_I;
			client_classi: CLASS_I
		do
			cluster := System.class_of_id (ctxt.class_c.id).cluster;
			ctxt.begin;
			ctxt.put_text_item (ti_L_curly);
			ctxt.set_separator (ti_Comma);
			ctxt.set_space_between_tokens;
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
						ctxt.put_classi (client_classi)
					else
						temp.to_upper;
						ctxt.put_string (temp);
					end
					clients.forth;
					if not clients.after then
						ctxt.put_text_item_without_tabs (ti_Comma);
						ctxt.put_space
					end
				end;
				ctxt.put_text_item_without_tabs (ti_R_curly);
				ctxt.commit
			else
				ctxt.rollback;
			end;
		end;

end -- class CLIENT_AS_B
