class
	TEST

inherit
	COMPARABLE

create
	make

feature

	make
		do
		end

feature
	domain: detachable TEST1 [CHARACTER]

feature -- Comparison

	is_less alias "<" (other: like Current): BOOLEAN
			-- Is current object less than `other'?
		local
			cursor: detachable like domain.new_cursor
		do
			if attached cursor as c then
				cursor := c
			end
		end

end
