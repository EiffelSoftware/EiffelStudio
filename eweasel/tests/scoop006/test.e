class TEST

create
	default_create, make

feature {NONE} -- Creation

        make
		do
			f (Current)
		end

feature -- Access

	f (t: separate TEST)
		local
			a: A
		do
			a := t.w (t)
			a := t [t]
			a := t + t
			a := - t
		end

	w alias "[]" (z: separate TEST): A
		do
		end

	v alias "+" (z: separate TEST): A
		do
		end

	q alias "-": A
		do
		end

end
