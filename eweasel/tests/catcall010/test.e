class TEST

create
	make

feature
	 make
	 	local
			y: Y
			x: X
			w: W
			v: V
	 	do
			create y
			x := y
			create w
			create v
			x.f (w)
			x.f (v)
	 	end

end
