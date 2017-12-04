class Y

inherit
	X
		redefine
			h
		end

feature

	h
			-- <Precursor>
		do
			;(create {X}).io.put_string ("Y")
			;(create {X}).io.put_new_line
		ensure then
			is_instance_free: class
		end

end