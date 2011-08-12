class TEST1

feature
	new_tuple (s: like string)
		local
			l_s: like string
		do
			l_s := s
			show ([s]).do_nothing
			show ([l_s]).do_nothing
		ensure
			show ([s])
		end

	string: STRING

	show (a: ANY): BOOLEAN
		do
			Result := True
			print (a.generating_type.out)
			io.put_new_line
		end

end
