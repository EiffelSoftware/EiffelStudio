class CLIENT_AS

inherit
	AST_EIFFEL
		redefine
			is_equivalent, format
		end

	SHARED_EXPORT_STATUS

feature {AST_FACTORY} -- Initialization

	initialize (c: like clients) is
			-- Create a new CLIENT AST node.
		require
			c_not_void: c /= Void
			c_not_empty: not c.is_empty
		do
			clients := c
		ensure
			clients_set: clients = c
		end

feature -- Attributes

	clients: EIFFEL_LIST [ID_AS]
			-- Client list

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
				-- FIXME: use mechanism similar to `is_equiv'!!!!
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
		end

feature -- Initialization

	export_status: EXPORT_I is
			-- Associated export status
--		require
--			System.current_class /= Void
		local
			export_set: EXPORT_SET_I
			client_i: CLIENT_I
		do
			if clients.count = 1 and then ("none").is_equal (clients.first) then
			   Result := Export_none
			else
				!!client_i
				client_i.set_clients (clients)
					-- Current class in second pass...
				client_i.set_written_in (System.current_class.class_id)
				!!export_set.make
				export_set.compare_objects
				export_set.put (client_i)
				Result := export_set
			end
		end

	format (ctxt : FORMAT_CONTEXT) is
		local
			temp: STRING
			cluster: CLUSTER_I
			client_classi: CLASS_I
		do
			cluster := System.class_of_id (ctxt.class_c.class_id).cluster
			ctxt.begin
			ctxt.put_text_item (ti_L_curly)
			ctxt.set_separator (ti_Comma)
			ctxt.set_space_between_tokens
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
					client_classi := Universe.class_named (temp, cluster)
					if client_classi /= Void then
						ctxt.put_classi (client_classi)
					else
						temp.to_upper
						ctxt.put_string (temp)
					end
					clients.forth
					if not clients.after then
						ctxt.put_text_item_without_tabs (ti_Comma)
						ctxt.put_space
					end
				end
				ctxt.put_text_item_without_tabs (ti_R_curly)
				ctxt.commit
			else
				ctxt.rollback
			end
		end

feature -- Output

	dump: STRING is
			-- Dump for comparison purposes.
		do
			create Result.make (3)
			if clients /= Void then
				from
					clients.start
				until
					clients.after
				loop
					Result.append (clients.item)
					clients.forth
					if not clients.after then
						Result.append (", ")
					end
				end
			end
			if Result.is_equal ("any") then
				Result.wipe_out
			end
		end

feature {AST_EIFFEL} -- Output

	simple_format (ctxt : FORMAT_CONTEXT) is
			-- Reconstitute text.
		local
			temp: STRING
		do
			ctxt.put_text_item (ti_L_curly)
			ctxt.set_separator (ti_Comma)
			ctxt.set_space_between_tokens
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
			ctxt.put_text_item_without_tabs (ti_R_curly)
		end

end -- class CLIENT_AS
