class EXPORT_SET_I 

inherit

	EXPORT_I
		redefine
			is_set
		end;
	LINKED_SET [CLIENT_I]
		rename
			is_subset as ll_is_subset
		end;
	SHARED_WORKBENCH;
	SHARED_TEXT_ITEMS

creation

	make

feature 

	valid_for (client: CLASS_C): BOOLEAN is
			-- Is the export valid for client `client' when the supplier is
			-- `supplier' ?
		do
			from
				start
			until
				after or else Result
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
				pos := index;
				start;
				Result := duplicate (count);
					-- Merge
				other_set ?= other;
				new ?= Result;
				new.merge (other_set);
				go_i_th (pos);
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
				pos := index;
				from
					Result := True;
					start;
				until
					after or else not Result
				loop
					export_client := item;
					other_export_client := other_set.clause
													(export_client.written_in);
					Result := 	(other_export_client /= Void)
								and then
								export_client.equiv (other_export_client);
					forth;
				end;
				go_i_th (pos);
			else
				Result := other.is_all;
			end;
		end;

	is_subset (other: EXPORT_I): BOOLEAN is
			-- Is Current clients a subset or equal with  
			-- `other' clients?
		local
			other_set: EXPORT_SET_I;
			cur: CURSOR;
		do
			if other.is_none then
				Result := False
			elseif other.is_all then
				Result := True;
			else
				other_set ?= other;
				Result := True;
				from
					start
				until
					after or else not Result
				loop
					Result := True;
					--Result := other_set.valid_for (item.written_class);
					forth;
				end;
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
					other_set.search (one_client);
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
			pos := index;
			from
				start;
			until
				after or else Result /= Void
			loop
				if item.written_in = written_in then
					Result := item;
				end;
				forth;
			end;
			go_i_th (pos);
		end;

	trace is
			-- Debug purpose
		do
			from
				start;
			until
				after
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
	
	format (ctxt: FORMAT_CONTEXT_B) is
		do
			from
				start;
			until
				after
			loop
				ctxt.put_text_item (ti_L_curly);
				item.format (ctxt);
				ctxt.put_text_item_without_tabs (ti_R_curly);
				forth;
			end;
		end;

feature -- Case storage

	storage_info: S_EXPORT_I is
		do
				-- Note for the future release of eiffelcase
				-- the resulting type would be S_EXPORT_SET_I
				-- However, only have none or all. (dinov)
			if valid_for (System.any_class.compiled_class) then
				! S_EXPORT_ALL_I ! Result
			else
				! S_EXPORT_NONE_I ! Result
			end
		end

end
