class
	TEST4 [G, H]

create
	make

feature

	make (a_value: G; a_key: H)
		local
			s: STRING
		do
			s := h.inserted (a_key, a_value)
		end

	h: TEST3 [G, H]

end
