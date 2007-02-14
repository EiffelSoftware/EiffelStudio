class B[G -> {X1,X2}]

feature
	a: G

	f: ANY
		do
			Result := a.f
		ensure
			Result = a.f
		end

end
