class TYPE_LIST

inherit

	LINKED_LIST [CLASS_TYPE]
		rename
			search as linked_list_search,
			append as linked_list_append
		end

creation

	make

feature

	search (t: TYPE_I) is
			-- Look for the same type than `t'.
		require
			good_argument: t /= Void
		do
			from
				start
			until
				after or else item.type.same_as (t)
			loop
				forth;
			end;
		end;

	has_type (t: TYPE_I): BOOLEAN is
			-- Is the type `t' present in instances of CLASS_TYPE in the
			-- list ?
		require
			good_argument: t /= Void;
		local
			pos: INTEGER
		do
			pos := index;
			search (t);
			Result := not after;
			go_i_th (pos);
		end;

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
