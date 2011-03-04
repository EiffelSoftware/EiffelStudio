class A [G -> ANY]

feature

	f (i: G)
		do
			print (i.out)
			print ("%N")
		end

	f_bis (i: INTEGER)
		do
			print (i)
			print ("%N")
		end

	g (i: separate ANY)
		local
			s: separate STRING
		do
			s := i.out
			local_print (s)
		end

	local_print (s: separate STRING)
		local
			i, nb: INTEGER
		do
			if not s.is_empty then
				from
					i := 1
					nb := s.count
				until
					i > nb
				loop
					print (s.item (i))
					i := i + 1
				end
			end
			print ("%N")
		end

end
