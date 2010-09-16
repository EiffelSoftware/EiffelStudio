class
	TEST1 [G]

create
	make

feature

	make is
		local
			t: TEST2 [G]
			g: G
		do
			print (t.generating_type)
			print ("%N")
			if g /= Void then
				print (generating_type_of (g))
				print ("%N")
			end
		end

feature {NONE} -- Helper

	generating_type_of (g: G): STRING
		require
			g_attached: g /= Void
		do
			Result := g.generating_type
		ensure
			result_attached: Result /= Void
		end

end
