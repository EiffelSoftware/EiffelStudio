class CLIENT_AS

inherit

	AST_EIFFEL
		redefine
			simple_format
		end;

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

feature -- Formatting

	simple_format (ctxt : FORMAT_CONTEXT) is
		local
			temp: STRING;
		do
			ctxt.begin;
			ctxt.put_text_item (ti_L_curly);
			ctxt.set_separator (ti_Comma);
			ctxt.space_between_tokens;

			if clients /= Void then
				from
					clients.start
				until
					clients.after
				loop
					temp := clone (clients.item)
					temp.to_upper
					ctxt.put_string (temp)
					clients.forth
					if not clients.after then
						ctxt.put_text_item (ti_Comma)
						ctxt.put_space
					end -- if
				end -- loop
			end -- if

			ctxt.put_text_item (ti_R_curly);
			ctxt.commit
		end;

	is_equiv (other: like Current): BOOLEAN is
			-- Is `other' equivalent to Current?
		local
			other_clients: EIFFEL_LIST [ID_AS]
			found: BOOLEAN
		do
			Result := clients = Void and other.clients = Void or else other = Current

			if not Result then
				if clients /= Void then
					if other.clients /= Void then
						-- Both have clients.
						other_clients := other.clients
						if clients.count = other.clients.count then
							from
								found := True
								clients.start
							until
								clients.after or else not found
							loop
								from
									found := False
									other_clients.start
								until 
									other_clients.after or else found
								loop
									found := clients.item.is_equal (other_clients.item)
									other_clients.forth
								end
								clients.forth
							end
							Result := found
						end
					end
		        end
    		end
	    end;

end
