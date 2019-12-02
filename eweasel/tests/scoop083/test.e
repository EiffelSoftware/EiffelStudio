class
	TEST

create
	make

feature

	make
		local
			c: separate CELL [INTEGER]
		do
				-- Make sure the subsequent separate call is polymorphic.
			if out = "" then
				create c.put (0)
			else
				create {separate A [INTEGER]} c.put (0)
			end
				-- Make the separate polymorphic call.
			separate c as x do
				x.put (0)
			end
		end

end
