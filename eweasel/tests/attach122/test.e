class TEST

create
	default_create,
	make

feature

	make
		do
			io.put_string ("Non-generic")
			io.put_new_line
			;(create {CHILD}).g

			io.put_string ("Attached generic")
			io.put_new_line
			;(create {GENERIC [ANY]}).f (Current, False)

			io.put_string ("Detachable generic")
			io.put_new_line
			;(create {GENERIC [detachable ANY]}).f (Current, False)

			io.put_string ("Expanded generic")
			io.put_new_line
			;(create {GENERIC [EXPANDED_TEST]}).f (create {EXPANDED_TEST}, True)
		end

end