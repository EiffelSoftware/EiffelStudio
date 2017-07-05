expanded class A

inherit
	ANY
		redefine
			out
		end

feature -- Output

	out: STRING
			-- <Precursor>
		do
			Result := "A"
		end

end
