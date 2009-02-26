class A [G]

feature -- Basic operations

	add alias "+" (a: G): A [G]
		do
			Result := Current
		end

end
