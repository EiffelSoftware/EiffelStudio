class PARENT

inherit
	REPORT
		redefine
			default_create
		end

feature {NONE} -- Creation

	default_create
		do
			item := Current
			Precursor
		end

feature -- Access

	item: ANY

feature -- Test

	f
		local
			x: like item
		do
			put_test (7)
			if attached x as y then
				put_fail_attached (y)
			else
				put_ok
			end
			put_test (8)
			if attached x as y then
				put_fail_attached (x)
			else
				put_ok
			end
			put_test (9)
			if attached x then
				put_fail_attached (x)
			else
				put_ok
			end
			x := Current
			put_test (10)
			if attached x as y then
				put_ok_attached (y)
			else
				put_fail
			end
			put_test (11)
			if attached x as y then
				put_ok_attached (x)
			else
				put_fail
			end
			put_test (12)
			if attached x then
				put_ok_attached (x)
			else
				put_fail
			end
		end

end