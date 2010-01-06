class C

feature -- Basic operations

	add alias "+" (a: ANY): ANY
		do
			Result := Current
		end

	minus alias "-": ANY
		do
			Result := Current
		end

end
