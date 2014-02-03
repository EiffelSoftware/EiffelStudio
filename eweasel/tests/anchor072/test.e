class
	TEST

create
	make

feature

	make
		local
			a: ANY
		do
			a := create {ARRAY [like out.item]}.make_empty
		end

	h
		local
			a: ANY
		do
			a := agent k
		end

	k (c: like out.item)
		do
		end

end
