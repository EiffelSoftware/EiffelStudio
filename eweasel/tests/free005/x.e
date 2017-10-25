class X

feature

	h
			-- Print current class name.
		note
			option: instance_free
		do
			;(create {X}).io.put_string ("X")
			;(create {X}).io.put_new_line
		end

end