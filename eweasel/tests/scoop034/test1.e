class
	TEST1 [G]

create
	make

feature

	make (v: G)
		do
			storage := v
		end

	item: G
		do
			io.put_string ("TEST1")
			io.put_new_line
			Result := storage
		end

	storage: G

end
