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

feature 

	written_in: INTEGER;
			-- Id of the class where the client list is written in

	clients: FIXED_LIST [STRING];
			-- Client list

	set_written_in (i: INTEGER) is
			-- Assign `i' to `written_in'.
		do
			written_in := i;
		end;

	set_clients (c: like clients) is
			-- Assign `c' to `clients'.
		do
			clients := c;
		end;

	is_equal (other: CLIENT_I): BOOLEAN is
			-- Is `other' equal to Current ?
		do
			Result := written_in = other.written_in;
		end;

	infix "<" (other: CLIENT_I): BOOLEAN is
			-- is `other greater than Current ?
		do
			Result := written_in < other.written_in;
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
			consistency: other.written_in = written_in;
		local
			other_clients: like clients;
			pos, other_pos: INTEGER;
		do
			pos := clients.position;
			other_clients := other.clients;
			from
				Result := True;
				clients.start;
			until
				clients.after or else not Result
			loop
				other_pos := other_clients.position;
				other_clients.start;
				other_clients.search_equal (clients.item);
				Result := not other_clients.after;
				other_clients.go (other_pos);
				clients.forth;
			end;
			clients.go (pos);
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
				pos := other_clients.position;
				from
					Result := True;
					i := 1;
				until
					i > c or else not Result
				loop
					other_clients.start;
					other_clients.search_equal (clients.i_th (i));
					Result := not other_clients.after;
					i := i + 1;
				end;
				other_clients.go (pos);
			end;
		end;

feature -- Debug purpose

	trace is
			-- Debug purpose
		do
			io.error.putchar (']');
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
            other_clients: FIXED_LIST [STRING];
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
                Result := valid_for ( Universe.class_named (
                        other_clients.item, other_cluster).compiled_class);
            end;
        end;



end
