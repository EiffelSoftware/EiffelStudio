class TEST

create
	make

feature

	make
			-- Run test.
		do
			create storage.make (1)
			storage.extend (tuple)
			if not attached [storage [1]] [1] as x then
				io.put_string ("Void tuple element")
			elseif not attached {like tuple} x as y then
				io.put_string ("Unexpected element type")
			elseif not attached {NATURAL_64} (y [1]) as z then
				io.put_string ("Unexpected tuple type")
			else
				io.put_natural_64 (z)
			end
			io.put_new_line
		end

feature {NONE} -- Testing

	storage: ARRAYED_LIST [like tuple]
			-- A structure with an anchored actual generic.

	tuple: TUPLE [value: NATURAL_64]
			-- An anchor with a value.
		do
			Result := [{NATURAL_64} 12345]
		end

end
