class R

inherit

	HASH_TABLE [INTEGER, INTEGER]
		redefine
			item,
			put
		end

create

	make

feature

	put (x, y: INTEGER) is
		do
			Precursor (x, y)
		end

	item alias "[]" (x: INTEGER): INTEGER is
		do
			Result := Precursor (x)
		end

end