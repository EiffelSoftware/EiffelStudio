class CLIENT_I 

inherit

	COMPARABLE
		redefine
			is_equal
		end;
	SHARED_WORKBENCH
		redefine
			is_equal
		end;
	SHARED_TEXT_ITEMS
		redefine
			is_equal
		end

feature 

	written_in: INTEGER;
			-- Id of the class where the client list is written in

	clients: LIST [STRING];
			-- Client list

	set_written_in (i: INTEGER) is
			-- Assign `i' to `written_in'.
		do
			written_in := i;
		end;

	set_clients (c: like clients) is
			-- Assign `c' to `clients'.
		do
			c.compare_objects;
			clients := c;
		end;

	is_equal (other: CLIENT_I): BOOLEAN is
			-- Is `other' equal to Current ?
		do
			Result := written_in = other.written_in
		end;

	infix "<" (other: CLIENT_I): BOOLEAN is
			-- is `other greater than Current ?
		do
			Result := written_in < other.written_in;
		end;

	written_class: CLASS_C is
		do
			Result := System.class_of_id (written_in);
		end;

feature -- Query

	valid_for (client: CLASS_C): BOOLEAN is
			-- Is the client `client' valid for the current client list ?
		require
			good_argument: client /= Void;
			consistency: System.class_of_id (written_in) /= Void;
		local
			supplier_class: CLASS_I;
			cluster: CLUSTER_I;
		do
			from
				cluster := System.class_of_id (written_in).cluster;
				clients.start
			until
				clients.after or else Result
			loop
				supplier_class := Universe.class_named (clients.item, cluster);
				if 	supplier_class /= Void
					and then
					supplier_class.compiled
				then
					Result := client.conform_to (supplier_class.compiled_class);
				end;
				clients.forth;
			end;
		end;

feature -- Incrementality

	equiv (other: CLIENT_I): BOOLEAN is
			-- Is `other' equivalent to Current ?	
			-- [Result implies "`clients' is a subset of `other.clients'"]
		require
			good_argument: other /= Void;
			consistency: other.written_in = written_in
		local
			other_clients: like clients;
			cur, other_cur: CURSOR;
		do
			cur := clients.cursor;
			other_clients := other.clients;
			from
				Result := True;
				clients.start;
			until
				clients.after or else not Result
			loop
				other_cur := other_clients.cursor;
				other_clients.start;
				other_clients.search (clients.item);
				Result := not other_clients.after;
				other_clients.go_to (other_cur);
				clients.forth;
			end;
			clients.go_to (cur);
		end;

	same_as (other: CLIENT_I): BOOLEAN is
			-- Is `other' the same as Current ?
		require
			good_argument: other /= Void;
			same_written_in: written_in = other.written_in
		local
			other_clients: like clients;
			i, pos, c: INTEGER;
		do
			c := clients.count;
			other_clients := other.clients;
			if c = other_clients.count then
				pos := other_clients.index;
				from
					Result := True;
					i := 1;
				until
					i > c or else not Result
				loop
					other_clients.start;
					other_clients.search (clients.i_th (i));
					Result := not other_clients.after;
					i := i + 1;
				end;
				other_clients.go_i_th (pos);
			end;
		end;

feature -- Debug purpose

	trace is
			-- Debug purpose
		do
			io.error.putchar ('[');
			io.error.putstring (System.class_of_id (written_in).cluster.path);
			io.error.putstring ("] : ");
			from
				clients.start
			until
				clients.after
			loop
				io.error.putchar ('%T');
				io.error.putstring (clients.item);
				io.error.putchar (' ');
				clients.forth;
			end;
		end;

feature -- formatter

	less_restrictive_than (other: like Current): BOOLEAN is
		require
			good_argument: other /= void
		local
			other_clients: LIST [STRING];
			other_cluster: CLUSTER_I;
		do
			other_clients := other.clients;
			other_cluster := system.class_of_id (other.written_in).cluster;
			from
				other_clients.start ;
				Result := true;
			until
				other_clients.after or Result = false
			loop
				Result := valid_for (Universe.class_named
					(other_clients.item, other_cluster).compiled_class);
			end;
		end;


	format (ctxt: FORMAT_CONTEXT) is
		local
			temp: STRING;
			cluster: CLUSTER_I;
			client_classi: CLASS_I;
		do
			cluster := System.class_of_id (written_in).cluster;
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
					ctxt.put_text_item (ti_Comma);
					ctxt.put_space
				end
			end
		end;

end
