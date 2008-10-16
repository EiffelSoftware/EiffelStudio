class
	TEST2 [G]

feature

	f is
		require
			toot: side_effect (create {LINKED_LIST [G]}.make)
			titi: ({?G}) #? (" ") /= Void
		do
			io.put_string ("TEST2.f")
			io.put_new_line
		end

	side_effect (a: ANY): BOOLEAN
		require
			a_not_void: a /= Void
		do
			io.put_string (a.generating_type)
			io.put_new_line
			Result := True
		end

end
