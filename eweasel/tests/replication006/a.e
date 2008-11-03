class
	A

feature

	f
		require
			re: assert ("requ: ")
			re: print_g ("requ: ", g)
		once
			check ck: assert ("chec: ") end
			check ck: print_g ("chec: ", g) end
			print (g)
		ensure
			po: assert ("post: ")
			po: print_g ("post: ", g)
		end

	g: STRING once Result := "g%N" end

	assert (where: STRING): BOOLEAN is
			--
		do
			print (where)
			print (g)
			Result := True
		end

	print_g (where, a_g: STRING): BOOLEAN is
			--
		do
			print (where)
			print (a_g)
			Result := True
		end

invariant
	inv: assert ("invaA: ")
	inv2: print_g ("invaA: ", g)

end
