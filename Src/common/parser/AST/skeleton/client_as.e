indexing

	description: 
		"AST representation of an client classes for feature clause.";
	date: "$Date$";
	revision: "$Revision $"

class CLIENT_AS

inherit

	AST_EIFFEL
		redefine
			is_equivalent
		end

feature {AST_FACTORY} -- Initialization

	initialize (c: like clients) is
			-- Create a new CLIENT AST node.
		require
			c_not_void: c /= Void
			c_not_empty: not c.empty
		do
			clients := c
		ensure
			clients_set: clients = c
		end

feature {NONE} -- Initialization

	set is
			-- Yacc initialization
		do
			clients ?= yacc_arg (0);
		ensure then
			not (clients = Void or else clients.empty);
		end;

feature -- Properties

	clients: EIFFEL_LIST [ID_AS];
			-- Client list

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
				-- FIXME: use mechanism similar to `is_equiv'!!!!
				-- FIXME
				-- FIXME
				-- FIXME
				-- FIXME
				-- FIXME
				-- FIXME
			Result := equivalent (clients, other.clients)
		end

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

feature {AST_EIFFEL} -- Output

	simple_format (ctxt : FORMAT_CONTEXT) is
			-- Reconstitute text.
		local
			temp: STRING;
		do
			ctxt.put_text_item (ti_L_curly);
			ctxt.set_separator (ti_Comma);
			ctxt.set_space_between_tokens;
			if clients /= Void then
				from
					clients.start
				until
					clients.after
				loop
					temp := clone (clients.item)
					temp.to_upper
					ctxt.put_class_name (temp)
					clients.forth
					if not clients.after then
						ctxt.put_text_item_without_tabs (ti_Comma)
						ctxt.put_space
					end
				end
			end
			ctxt.put_text_item_without_tabs (ti_R_curly);
		end;

end -- class CLIENT_AS
