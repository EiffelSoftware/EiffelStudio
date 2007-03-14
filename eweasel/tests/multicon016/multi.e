class
		MULTI [G -> {ARRAY [H] rename item as twice end, LIST [H] rename item as twice  end}, H -> NUMERIC]

feature
	test
		local
			l_g: G
		do
			l_g.twice
		end

end
