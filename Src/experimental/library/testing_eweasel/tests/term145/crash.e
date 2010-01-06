class CRASH [G -> STRING, H -> G]

feature

	f (a: H): BOOLEAN is
		do
			Result := a /= Void
		end

end
