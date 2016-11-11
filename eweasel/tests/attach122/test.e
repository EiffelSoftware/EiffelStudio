class TEST

create
	default_create,
	make

feature

	make
		do
			io.put_string ("Non-generic immediate")
			io.put_new_line
			if attached (create {CHILD}).g then end

			io.put_string ("Non-generic inherited")
			io.put_new_line
			if attached (create {CHILD}).f then end

			io.put_string ("Attached generic")
			io.put_new_line
			if attached (create {GENERIC [ANY]}).f (Current, False) then end

			io.put_string ("Detachable generic")
			io.put_new_line
			if attached (create {GENERIC [detachable ANY]}).f (Current, False) then end

			io.put_string ("Expanded generic")
			io.put_new_line
			if attached (create {GENERIC [EXPANDED_TEST]}).f (create {EXPANDED_TEST}, True) then end
		end

end