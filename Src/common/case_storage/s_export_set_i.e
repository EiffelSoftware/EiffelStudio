indexing

	description: 
		"Export status for features.";
	date: "$Date$";
	revision: "$Revision $"

class
	S_EXPORT_SET_I

inherit

	LINKED_SET [STRING]
		redefine
			extend
		end

	S_EXPORT_I
		redefine
			is_all, is_none, is_set
		end

creation
	make

feature -- Properties

	is_all: BOOLEAN is
			-- Is Current exported to none?
		do
			Result := (count = 0) or else 
					((count = 1) and then Any_string.is_equal(i_th(1)))
		end

	is_none: BOOLEAN is
			-- Is Current exported to none?
		do
			Result := (count = 1) and then None_string.is_equal(i_th(1))
		end

	is_set: BOOLEAN is True;
			-- Is the current object an instance of S_EXPORT_SET_I ?
			--| Kept for compatibility.

feature -- Comparison

	same_as (other: S_EXPORT_I): BOOLEAN is
			-- Is `other' the same as Current ?
		local
			other_set: S_EXPORT_SET_I
			one_client: STRING
			pos: INTEGER
			c1, c2: CURSOR
		do
			if other.is_all then
				Result := is_all
			elseif other.is_none then
				Result := is_none
			else
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
						Result := 	(not other_set.after)
									and then
									one_client.is_equal (other_set.item)
						forth
					end
					go_to (c1)
					other_set.go_to (c2)
				end
			end
		end

feature -- Element change

	extend (v: like item) is
			-- Add `v' to end.
			-- Do not move cursor.
		local
			p: like first_element
		do
			p := new_cell (v)
			if empty then
				first_element := p
				active := p
			elseif not has (v) then
				last_element.put_right (p)
				if after then 
					active := p 
				end
			end
			count := count + 1
		end

feature {NONE} -- Implementation properties

	Any_string: STRING is "ANY"

	None_string: STRING is "NONE"

end -- class S_EXPORT_SET_I
