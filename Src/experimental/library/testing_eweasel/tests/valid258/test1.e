class
	TEST1

feature

	attached_a: STRING
		require
			a /= Void
		do
			Result := a
		end

	a: detachable STRING note option: stable attribute end

end
