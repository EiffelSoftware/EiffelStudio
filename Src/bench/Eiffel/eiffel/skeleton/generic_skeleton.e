-- List of attribute sorted by category or skeleton of a class

class GENERIC_SKELETON 

inherit
	LINKED_LIST [ATTR_DESC]

create
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
				create Result.make (nb)
				start
			until
				after
			loop
				Result.put (item.instantiation_in (class_type), i);
				forth;
				i := i + 1
			end;
			if i >= 1 then
				Result.sort
			end
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
				io.error.put_string (item.attribute_name);
				io.error.put_string (": ");
				item.trace;
				io.error.put_new_line;
				forth;
			end;
		end;

end
