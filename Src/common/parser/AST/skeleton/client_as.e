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
		require
			System.current_class /= Void;
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
				export_set.put (client_i);
				Result := export_set;
			end;
		end;

	format (ctxt : FORMAT_CONTEXT) is
		do
			ctxt.begin;
			ctxt.put_special("{");
			ctxt.set_separator(", ");
			ctxt.separator_is_special;
			ctxt.no_new_line_between_tokens;
			if export_status.valid_for (ctxt.definition.client) then
				clients.format(ctxt);
				ctxt.put_special("}");
				ctxt.commit
			else
				ctxt.rollback;
			end;
		end;

end
