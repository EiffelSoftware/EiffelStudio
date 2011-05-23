class TEST3 [G]

feature

	inherited_routine_causing_crash: ANY
		local
			t: like Current
			g: TEST3 [G]
		do
			Result := Current
		end

end
