indexing
	description: "Representation of an export clause which lists to whom a feature%N%
		%will be exported."
	date: "$Date$"
	revision: "$Revision$"

class
	EXPORT_SET_I 

inherit
	EXPORT_I
		undefine
			copy, is_equal
		redefine
			is_set
		end

	LINKED_SET [CLIENT_I]
		rename
			is_subset as ll_is_subset
		end

	SHARED_WORKBENCH
		undefine
			copy, is_equal
		end

	SHARED_TEXT_ITEMS
		undefine
			copy, is_equal
		end

creation
	make

feature -- Property

	is_set: BOOLEAN is
			-- Is the current object an instance of EXPORT_SET_I ?
		do
			Result := True
		end

feature -- Access

	same_as (other: EXPORT_I): BOOLEAN is
			-- is `other' the same as Current ?
		local
			other_set: EXPORT_SET_I
			one_client: CLIENT_I
			c1, c2: CURSOR
		do
			other_set ?= other
			if other_set /= Void and then count = other_set.count then
				c1 := cursor
				c2 := other_set.cursor
				from
					Result := True
					start
				until
					after or else not Result
				loop
					one_client := item
					other_set.start
					other_set.search (one_client)
					Result :=  not other_set.after and then one_client.same_as (other_set.item)
					forth
				end
				go_to (c1)
				other_set.go_to (c2)
			end
		end

feature -- Comparison

	infix "<" (other: EXPORT_I): BOOLEAN is
			-- is Current less restrictive than other
		local
			other_set: EXPORT_SET_I
		do
			if other.is_none then
				Result := True
			elseif other.is_all then
				Result := not is_all
			else
				other_set ?= other
				check
					must_be_a_set: other_set /= Void
				end
				Result := first.less_restrictive_than (other_set.first)
			end
		end
	
feature {COMPILER_EXPORTER}

	equiv (other: EXPORT_I): BOOLEAN is
			-- Is 'other' equivalent to Current ?
			-- [Semantic: old_status.equiv (new_status) ]
		local
			other_set: EXPORT_SET_I
			old_cursor: CURSOR
			export_client, other_export_client: CLIENT_I
		do
			other_set ?= other
			if other_set /= Void then
				old_cursor := cursor
				from
					Result := True
					start
				until
					after or else not Result
				loop
					export_client := item
					other_export_client := other_set.clause (export_client.written_in)
					Result := (other_export_client /= Void)
						and then export_client.equiv (other_export_client)
					forth
				end
				go_to (old_cursor)
			else
				Result := other.is_all
			end
		end

	valid_for (client: CLASS_C): BOOLEAN is
			-- Is the export valid for client `client' when the supplier is
			-- `supplier' ?
		do
			from
				start
			until
				after or else Result
			loop
				Result := item.valid_for (client)
				forth
			end
		end

	concatenation (other: EXPORT_I): EXPORT_I is
			-- Concatenation of Current and `other'
		local
			other_set, new: EXPORT_SET_I
			old_cursor: CURSOR
		do
			if other.is_set then
					-- Duplication
				old_cursor := cursor
				start
				Result := duplicate (count)
					-- Merge
				other_set ?= other
				new ?= Result
				new.merge (other_set)
				go_to (old_cursor)
			elseif other.is_none then
				Result := Current
			else
				check
					other.is_all
				end
				Result := other
			end
		end

	is_subset (other: EXPORT_I): BOOLEAN is
			-- Is Current clients a subset or equal with  
			-- `other' clients?
		local
			other_set: EXPORT_SET_I
			l_client: CLIENT_I
			l_clients: LIST [STRING]
			current_cluster: CLUSTER_I
			l_class: CLASS_I
		do
			if other.is_none then
				Result := False
			elseif other.is_all then
				Result := True
			else
				other_set ?= other
				check
					must_be_a_set: other_set /= Void
				end
				Result := True
				from
					start
				until
					after or else not Result
				loop
					from
						l_client := item
						l_clients := l_client.clients
						current_cluster := l_client.written_class.cluster
						l_clients.start
					until
						l_clients.after or else not Result
					loop
						l_class := Universe.class_named (l_clients.item, current_cluster)
						if l_class /= Void and then l_class.compiled then
							Result := other_set.valid_for (l_class.compiled_class)
						end
						l_clients.forth
					end
					forth
				end
			end
		end
	
	clause (written_in: INTEGER): CLIENT_I is
			-- Clause of attribute `written_in' 
		local
			old_cursor: CURSOR
		do
			old_cursor := cursor
			from
				start
			until
				after or else Result /= Void
			loop
				if item.written_in = written_in then
					Result := item
				end
				forth
			end
			go_to (old_cursor)
		end

	trace is
			-- Debug purpose
		do
			from
				start
			until
				after
			loop
				item.trace
				io.error.new_line
				forth
			end
		end

	format (ctxt: FORMAT_CONTEXT) is
		do
			from
				start
			until
				after
			loop
				if not (item.clients.count = 1 and then item.clients.first.is_equal ("any")) then
					ctxt.put_text_item (Ti_l_curly)
					item.format (ctxt)
					ctxt.put_text_item_without_tabs (Ti_r_curly)
				end
				forth
			end
		end

end -- class EXPORT_SET_I
