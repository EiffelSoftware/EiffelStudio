expanded class X

inherit
	ANY
		redefine
			out
		end

feature

	put (value: like item) is
			-- Set `item' to `value'.
		do
			item := value
		end

	item: INTEGER
			-- Current value


	out: STRING is
		do
			Result := "x = " + item.out
		end

end