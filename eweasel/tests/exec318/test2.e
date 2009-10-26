class TEST2
feature

	f (a: like x) is
		require
			g (a)
		do
			print (a.generating_type)
			print ("%N")
		end

	g (a: like x): BOOLEAN is
		do
			Result := True
		end

	x: ANY
		do
		end

end

