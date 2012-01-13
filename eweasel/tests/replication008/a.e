class A

feature

	f
		require
			x
		do
		ensure
			x
		end

	x: BOOLEAN
		do
			Result := True
		end

end