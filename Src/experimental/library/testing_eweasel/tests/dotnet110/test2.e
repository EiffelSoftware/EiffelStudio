class TEST2
feature

	f (a: ANY) is
		require
			g (a)
		do
			print (a.generating_type)
			print ("%N")
		end

	g (a: ANY): BOOLEAN is
		do
			Result := True
		end

end

