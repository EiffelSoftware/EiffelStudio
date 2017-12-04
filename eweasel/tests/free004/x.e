class X

feature

	h
			-- Print current class name.
		do
			;(create {X}).io.put_string ("X")
			;(create {X}).io.put_new_line
		ensure
			is_instance_free: class
		end

end