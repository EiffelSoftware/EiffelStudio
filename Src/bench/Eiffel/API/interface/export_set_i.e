class EXPORT_SET_I 

inherit

	EXPORT_I
		redefine
			is_set
		end;
	LINKED_SET [CLIENT_I];
	SHARED_WORKBENCH;

creation

	make

feature 

	valid_for (client: CLASS_C): BOOLEAN is
			-- Is the export valid for client `client' when the supplier is
			-- `supplier' ?
		local
			pos: INTEGER;
		do
			from
				pos := position;
				start
			until
				offright or else Result
			loop
				Result := item.valid_for (client);
				forth;
			end;
		end;

	is_set: BOOLEAN is
			-- Is the current object an instance of EXPORT_SET_I ?
		do
			Result := True;
		end;

	concatenation (other: EXPORT_I): EXPORT_I is
			-- Concatenation of Current and `other'
		local
			other_set, new: EXPORT_SET_I;
			pos: INTEGER;
		do
			if other.is_set then
					-- Duplication
				pos := position;
				start;
				Result := duplicate (count);
					-- Merge
				other_set ?= other;
				new ?= Result;
				new.merge (other_set);
				go (position);
			elseif other.is_none then
				Result := Current;
			else
				check
					other.is_all;
				end;
				Result := other;
			end;
		end;

	equiv (other: EXPORT_I): BOOLEAN is
			-- Is 'other' equivalent to Current ?
			-- [Semantic: old_status.equiv (new_status) ]
		local
			other_set: EXPORT_SET_I;
			pos: INTEGER;
			export_client, other_export_client: CLIENT_I;
		do
			other_set ?= other;
			if other_set /= Void then
				pos := position;
				from
					Result := True;
					start;
				until
					offright or else not Result
				loop
					export_client := item;
					other_export_client := other_set.clause
													(export_client.written_in);
					Result := 	(other_export_client /= Void)
								and then
								export_client.equiv (other_export_client);
					forth;
				end;
				go (pos);
			else
				Result := other.is_all;
			end;
		end;

	same_as (other: EXPORT_I): BOOLEAN is
			-- is `other' the same as Current ?
		local
			other_set: EXPORT_SET_I;
			one_client, other_client: CLIENT_I;
			pos: INTEGER;
			c1, c2: CURSOR;
		do
			other_set ?= other;
			if other_set /= Void and then count = other_set.count then
				c1 := cursor;
				c2 := other_set.cursor;
				from
					Result := True;
					start
				until
					after or else not Result
				loop
					one_client := item;
					other_set.start;
					other_set.search_equal (one_client);
					Result := 	(not other_set.after)
								and then
								one_client.same_as (other_set.item);
					forth
				end;
				go_to (c1);
				other_set.go_to (c2);
			end;
		end;
	
	clause (written_in: INTEGER): CLIENT_I is
			-- Clause of attribute `written_in' 
		local
			pos: INTEGER;
		do
			pos := position;
			from
				start;
			until
				offright or else Result /= Void
			loop
				if item.written_in = written_in then
					Result := item;
				end;
				forth;
			end;
			go (pos);
		end;

	trace is
			-- Debug purpose
		do
			from
				start;
			until
				offright
			loop
				item.trace;
				io.error.new_line;
				forth;
			end;
		end;

	infix "<" (other: EXPORT_I): BOOLEAN is
			-- is Current less restrictive than other
		local
			other_set: EXPORT_SET_I
		do
			if other.is_none then
				Result := true
			elseif other.is_all then
				Result := not is_all
			else
				other_set ?= other;
				check
					other_set /= void;
				end;
				Result := first.less_restrictive_than (other_set.first);
			end;
		end;
	
			
			
		

end
