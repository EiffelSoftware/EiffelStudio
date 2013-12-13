class TEST

create
	make

feature

	make
		local
			n: like {ARRAY [like x.y.z]}.item
			o: like {like {TEST}.x.y.z}.z
			p: like u.y
			q: like {ARRAY [like w]}.item
			r: like w.y
			s: like {like u}.x
			t: like w
		do
			if n = o or p = q or r = s or t = u or w = x then
				do_nothing
			end
		end

feature -- Access

	x, y, z: detachable TEST


	u: like x.y.z
	w: like {like x.y.z}.x

end
