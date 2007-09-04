class TEST

create
	make

feature -- Test

	make is
			-- Creation procedure.
		local
			h: HASH_TABLE [INTEGER, A]
		do
			create h.make (10)
		end

end
