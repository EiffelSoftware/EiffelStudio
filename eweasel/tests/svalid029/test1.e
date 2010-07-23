class TEST1

feature

	identity alias "+": INTEGER
		do
			Result := 47
		end

	f (other: like Current)
		require
			+ other = 47
		do
		end

end
