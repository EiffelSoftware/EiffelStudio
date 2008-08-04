class TEST

creation
	make

feature

	make is
		local
			e: EXAMPLE [STRING_8]
		do
			create e
			e.whatami (create {STRING_32}.make_empty)
		end


end
