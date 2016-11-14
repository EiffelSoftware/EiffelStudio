class GENERIC [G]

inherit
	REPORT

feature -- Test

	f (v: G; is_expanded: BOOLEAN): G
		local
			x: G
			put_attached: PROCEDURE [ANY]
			put_detachable: PROCEDURE
		do
			if is_expanded then
				put_attached := agent put_ok_attached
				put_detachable := agent put_fail
			else
				put_attached := agent put_fail_attached
				put_detachable := agent put_ok
			end
			io.put_string ("- local%N")
			put_test (1)
			if attached x as y then
				put_attached (y)
			else
				put_detachable.call
			end
			put_test (2)
			if attached x as y then
				put_attached (x)
			else
				put_detachable.call
			end
			put_test (3)
			if attached x then
				put_attached (x)
			else
				put_detachable.call
			end
			x := v
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
				put_attached (y)
			else
				put_detachable.call
			end
			put_test (8)
			if attached Result as y then
				put_attached (Result)
			else
				put_detachable.call
			end
			put_test (9)
			if attached Result then
				put_attached (Result)
			else
				put_detachable.call
			end
			Result := v
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