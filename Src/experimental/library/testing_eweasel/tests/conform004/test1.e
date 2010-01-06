class TEST1 [G -> ANY create default_create end]

create
	make

feature {NONE} -- Creation

	make (t: G)
		do
			io.put_string ((create {G}).generating_type)
			io.put_new_line
			if (t.conforms_to (create {G})) then
				io.put_string ("OK%N")
			end
		end

end
