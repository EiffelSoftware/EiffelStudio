
class TEST

create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
		local
			a: A [INTEGER]
		do
				-- Once creation procedure can't be part of Generic classes.
			create a.make
		end

end
