class
	TEST

create
	make

feature

	make
		do
		end

feature

	f
		local
			a: ANY
		do
			a := agent g
		end

	g (c: like h.item)
		do
		end

	h: detachable ARRAY [like t]
	t: detachable TUPLE

end
