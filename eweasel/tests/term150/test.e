class TEST

create
	make

feature -- Test

	make is
			-- Creation procedure.
		local
			h: HASH_TABLE [INTEGER, A [INTEGER]]
		do
			create h.make (10)
		end

end
