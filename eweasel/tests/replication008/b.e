class B

feature

	g
		require
			y
		do
		ensure
			y
		end

	y: BOOLEAN
		do
			Result := True
		end

end