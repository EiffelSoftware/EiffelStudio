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
					--| `generate_poly_table' or `generate_dle_poly_table'.
				old_cursor := cursor
				item.pass4
				go_to (old_cursor)
				forth
			end
		end

	update_valid_body_ids is
			-- Proceed to the `update_valid_body_ids' on the items
			-- of the list
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
					ct.update_valid_body_ids
				end
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

	update_dispatch_table is
			-- Proceed to the `update_dispatch_table' on the items of the list
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
					ct.update_dispatch_table
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

	generate_poly_table (unit: POLY_UNIT; poly_table: POLY_TABLE [ENTRY]) is
			-- Generate the polymorphic table in final mode
		require
			unit_exits: unit /= Void
			poly_table_exists: poly_table /= Void
		do
			from
				start
			until
				after
			loop
				poly_table.extend (unit.entry (item))
				forth
			end
		end

	generate_dle_poly_table (unit: POLY_UNIT; poly_table: POLY_TABLE [ENTRY]) is
			-- Generate the polymorphic table in final mode
		require
			unit_exits: unit /= Void
			poly_table_exists: poly_table /= Void
		local
			ct: CLASS_TYPE
		do
			from
				start
			until
				after
			loop
				ct := item
				if ct.is_static then
						-- Generate only what was in the static system.
					poly_table.extend (unit.entry (ct))
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
			other_id: TYPE_ID
		do
			from
				other.start
			until
				other.after
			loop
				class_type := other.item;
				other_id := class_type.id;
				from 
					start
				until
					after or else equal (item.id, other_id)
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
