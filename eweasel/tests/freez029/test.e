class TEST

creation
	make

feature

	make is
		local
			e: EXAMPLE [TEST]
			s: EXAMPLE [STRING_32]
		do
			create e
			e.whatami (create {STRING_32}.make_empty)
			create s
			s.whatami (create {STRING_32}.make_empty)
		end


end
