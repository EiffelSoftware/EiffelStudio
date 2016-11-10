class CHILD

inherit
	PARENT
		redefine
			item
		end

create
	default_create

feature

	g
		local
			x: ANY
		do
			put_test (1)
			if attached x as y then
				put_fail_attached (y)
			else
				put_ok
			end
			put_test (2)
			if attached x as y then
				put_fail_attached (x)
			else
				put_ok
			end
			put_test (3)
			if attached x then
				put_fail_attached (x)
			else
				put_ok
			end
			create {TEST} x
			put_test (4)
			if attached x as y then
				put_ok_attached (y)
			else
				put_fail
			end
			put_test (5)
			if attached x as y then
				put_ok_attached (x)
			else
				put_fail
			end
			put_test (6)
			if attached x then
				put_ok_attached (x)
			else
				put_fail
			end
			f
		end

feature

	item: CHILD

end