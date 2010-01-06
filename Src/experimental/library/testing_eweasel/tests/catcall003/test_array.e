class
	TEST_ARRAY [G, H -> ARRAY [G]]

feature

	f is
		local
			h: H
		do
			h.make_from_array (h)
		end

end
