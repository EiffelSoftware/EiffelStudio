class TYPE_LIST

inherit

	LINKED_LIST [CLASS_TYPE]
		rename
			search as linked_list_search
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
			pos := position;
			search (t);
			Result := not after;
			go (pos);
		end;

end
