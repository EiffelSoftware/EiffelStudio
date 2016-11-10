class GENERIC [G]

inherit
	REPORT

feature -- Test

	f (v: G; is_expanded: BOOLEAN)
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
			put_test (13)
			if attached x as y then
				put_attached (y)
			else
				put_detachable.call
			end
			put_test (14)
			if attached x as y then
				put_attached (x)
			else
				put_detachable.call
			end
			put_test (15)
			if attached x then
				put_attached (x)
			else
				put_detachable.call
			end
			x := v
			put_test (16)
			if attached x as y then
				put_ok_attached (y)
			else
				put_fail
			end
			put_test (17)
			if attached x as y then
				put_ok_attached (x)
			else
				put_fail
			end
			put_test (18)
			if attached x then
				put_ok_attached (x)
			else
				put_fail
			end
		end

end