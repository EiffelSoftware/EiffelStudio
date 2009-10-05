class
	C [G]

create
	make

convert
	to_g: {attached G}

feature

	make (a: attached G)
		do
			item := a
		end

	to_g: attached G
		do
			Result := item
		end

	item: attached G

end
