class Y

inherit
	X
		redefine
			h
		end

feature

	h
			-- <Precursor>
		note
			option: instance_free
		do
			;(create {X}).io.put_string ("Y")
			;(create {X}).io.put_new_line
		end

end