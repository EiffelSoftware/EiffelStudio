class TEST

create
	make

feature {NONE} -- Creation

	make
		local
			a: A [TEST]
		do
			create a.make (Current)
		end

end
