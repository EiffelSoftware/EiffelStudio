indexing
	description: "List of conditions."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_CONDITION_LIST

inherit
	ARRAYED_LIST [CONF_CONDITION]
		redefine
			make,
			out
		end

create
	make

feature {NONE} -- Initialization

	make (n: INTEGER) is
			-- Create.
		do
			Precursor {ARRAYED_LIST} (n)
			compare_objects
		end


feature -- Output

	out: STRING is
			-- Text representation of the conditions.
		local
			l_cursor: ARRAYED_LIST_CURSOR
		do
			l_cursor := cursor
			create Result.make_empty
			from
				start
			until
				after
			loop
				Result.append ("(")
				Result.append (item.out)
				Result.append (") or ")
				forth
			end
			if not Result.is_empty then
				Result.remove_tail (4)
			end
			if valid_cursor (l_cursor) then
				go_to (l_cursor)
			end
		ensure then
			Result_not_void: Result /= Void
		end

end
