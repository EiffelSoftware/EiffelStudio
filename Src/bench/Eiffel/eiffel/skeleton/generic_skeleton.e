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
			pos, other_pos, old_pos: INTEGER;
		do
			if count = other.count then
				pos := position;
				other_pos := other.position;
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
				go (pos);
				other.go (old_pos);
			end;
		end;

	instantiation_in (class_type: CLASS_TYPE): SKELETON is
			-- Instantiation of Current in `class_type'.
		require
			good_argument: class_type /= Void
		local
			pos: INTEGER;
		do
			!!Result.make;
			pos := position;
			from
				start
			until
				after
			loop
				Result.add (item.instantiation_in (class_type));
				forth;
			end;
			go (pos);
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
