class TYPE_LIST

inherit
	LINKED_LIST [CLASS_TYPE]
		rename
			search as linked_list_search,
			append as linked_list_append
		end

creation
	make

feature -- Search

	has_type (t: TYPE_I): BOOLEAN is
			-- Is the type `t' present in instances of CLASS_TYPE in the
			-- list ?
			-- Does not change cursor position.
		require
			good_argument: t /= Void;
		local
			old_cursor: CURSOR
			default_value: CLASS_TYPE
		do
			old_cursor := cursor;

			from
				start
			until
				after or else item.type.same_as (t)
			loop
				forth
			end

			if not after then
				found_item := item
				Result := True
			else
				found_item := default_value
			end

			go_to (old_cursor);
		end;

	conservative_search_item (t: TYPE_I): CLASS_TYPE is
			-- Is the type `t' present in instances of CLASS_TYPE in the list?
			-- If not, return the last item found in the list.
			-- Does not change cursor position.
		local
			old_cursor: CURSOR
		do
			old_cursor := cursor

			from
				start
			until
				after or else item.type.same_as (t)
			loop
				forth
			end

				-- FIXME: the following code should make sure that we have an item
				-- but some time we don't therefore we need to take the last item
				-- but `item' has a precondition `not off' and we have to use 
				-- `active.item' to get the last item of the list. We could have used
				-- `last_element' but it adds a function call overhead.
			Result := active.item
			
			go_to (old_cursor)
		end

	search_item (t: TYPE_I): CLASS_TYPE is
			-- Is the type `t' present in instances of CLASS_TYPE in the list?
			-- If not, return the last item found in the list.
			-- Does change cursor position.
		do
			from
				start
			until
				after or else item.type.same_as (t)
			loop
				forth
			end

			Result := item
		end

feature -- Access

	found_item: CLASS_TYPE
			-- Last item found during a search.

	nb_modifiable_types: INTEGER is
			-- Number of modifiable types (i.e. precompiled or static)
			-- derived from the current class
		do
			from
				start
			until
				after
			loop
				if item.is_modifiable then
					Result := Result + 1
				end
				forth
			end
		end
feature -- Traversals

	pass4 is
			-- Proceed to the `pass4' on the items of the list.
		local
			old_cursor: CURSOR
		do
			from
				start
			until
				after
			loop
					--| We need to save the position of the cursor, because
					--| within pass4 we are also doing some traversal (like
					--| `generate_poly_table').
				old_cursor := cursor
				item.pass4
				go_to (old_cursor)
				forth
			end
		end

	melt is
			-- Proceed to the `melt' on the items of the list
		local
			ct: CLASS_TYPE
		do
			from
				start
			until
				after
			loop
				ct := item
				if not ct.is_precompiled then
					ct.melt
				end
				forth
			end
		end

	update_execution_table is
			-- Proceed to the `update_execution_table' on the items of the list
		local
			ct: CLASS_TYPE
		do
			from
				start
			until
				after
			loop
				ct := item
				if not ct.is_precompiled then
					ct.update_execution_table
				end
				forth
			end
		end

	melt_feature_table is
			-- Proceed to the `melt_feature_table' on the items of the list
		local
			ct: CLASS_TYPE
		do
			from
				start
			until
				after
			loop
				ct := item
				if ct.is_modifiable then
					ct.melt_feature_table
				end
				forth
			end
		end

feature -- Merging

	append (other: like Current) is
			-- Append types of `other' to `Current'.
			-- Used when merging precompilations.
		require
			other_not_void: other /= Void
		local
			class_type: CLASS_TYPE;
			other_id: INTEGER
		do
			from
				other.start
			until
				other.after
			loop
				class_type := other.item;
				other_id := class_type.static_type_id;
				from 
					start
				until
					after or else item.static_type_id = other_id
				loop
					forth
				end;
				if after then
					extend (class_type)
				end;
				other.forth
			end
		end

end
