class TEST

create
	make

feature {NONE} -- Creation

	make is
			-- Run tests.
		local
			a: A [ARRAYED_LIST [STRING], STRING]
			b: B
		do
			create a
			create b
		end

end
