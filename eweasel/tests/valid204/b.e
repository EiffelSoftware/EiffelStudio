class B

feature
	a: A

	f: ANY
		do
			Result := a.f
		ensure
			Result = a.f
		end

end
