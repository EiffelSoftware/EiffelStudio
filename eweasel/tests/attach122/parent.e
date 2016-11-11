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

	f: like item
		local
			x: like item
		do
			io.put_string ("- local%N")
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
			x := Current
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
			io.put_string ("- Result%N")
			put_test (7)
			if attached Result as y then
				put_fail_attached (y)
			else
				put_ok
			end
			put_test (8)
			if attached Result as y then
				put_fail_attached (Result)
			else
				put_ok
			end
			put_test (9)
			if attached Result then
				put_fail_attached (Result)
			else
				put_ok
			end
			Result := Current
			put_test (10)
			if attached Result as y then
				put_ok_attached (y)
			else
				put_fail
			end
			put_test (11)
			if attached Result as y then
				put_ok_attached (Result)
			else
				put_fail
			end
			put_test (12)
			if attached Result then
				put_ok_attached (Result)
			else
				put_fail
			end
		end

end