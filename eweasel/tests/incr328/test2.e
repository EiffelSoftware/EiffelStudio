
class TEST2 [G -> TEST rename f as f alias "+" end]

feature

	h (y: G): INTEGER
		do
			Result := y + Result
		end

end
