-- List of attribute sorted by category or skeleton of a class

class GENERIC_SKELETON 

inherit
	SORTED_TWO_WAY_LIST [ATTR_DESC]

creation
	make

feature 

	equiv (other: like Current): BOOLEAN is
			-- Is the current skeleton equivqlent to `other' ?
		require
			good_argument: other /= Void
		local
			old_cursor, other_cursor: CURSOR;
		do
			if count = other.count then
				old_cursor := cursor;
				other_cursor := other.cursor;
				from
					Result := True;
					start;
					other.start
				until
					after or else not Result
				loop
					Result := item.same_as (other.item);
					forth;
					other.forth;
				end;
				go_to (old_cursor);
				other.go_to (other_cursor);
			end;
		end;

	instantiation_in (class_type: CLASS_TYPE): SKELETON is
			-- Instantiation of Current in `class_type'.
		require
			good_argument: class_type /= Void
		local
			old_cursor: CURSOR;
		do
			!!Result.make;
			old_cursor := cursor;
			from
				start
			until
				after
			loop
				Result.extend (item.instantiation_in (class_type));
				forth;
			end;
			go_to (old_cursor);
		end;

	trace is
			-- Debug purpose
		do
			from
				start
			until
				after
			loop
				io.error.putstring (item.attribute_name);
				io.error.putstring (": ");
				item.trace;
				io.error.new_line;
				forth;
			end;
		end;

end
