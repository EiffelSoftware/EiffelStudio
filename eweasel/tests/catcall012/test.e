class TEST
create
	make

feature
	make
		local
			x, y: ANY
			test: BOOLEAN
		do
			create x
			create y
			test := x.conforms_to (y)
		end

invariant
	theorems: (agent : BOOLEAN do Result := True end).item (Void) 

end
