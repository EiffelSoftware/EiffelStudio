-- List of attribute sorted by category or skeleton of a class

class GENERIC_SKELETON 

inherit
	LINKED_LIST [ATTR_DESC]

creation
	make

feature -- Creation of CLASS_TYPE skeleton

	instantiation_in (class_type: CLASS_TYPE): SKELETON is
			-- Instantiation of Current in `class_type'.
		require
			good_argument: class_type /= Void
		local
			i, nb: INTEGER
		do
			from
				i := 0
				nb := count
				!! Result.make (nb)
				start
			until
				after
			loop
				Result.put (item.instantiation_in (class_type), i);
				forth;
				i := i + 1
			end;
			Result.sort
		end;

feature -- Output

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
