note
	ca_only: "CA029"
class
	CAT_OBJECT_TEST_ALWAYS_SUCCEEDS

feature {NONE} -- Test

	object_tests (a_arg1: attached STRING; a_arg2: attached ANY)
		do
				-- Should violate the rule.
			if attached {STRING} a_arg1 then
				do_nothing
			end

				-- Should violate the rule.
			if attached {ANY} a_arg1 then
				do_nothing
			end

				-- Should not violate the rule.
			if attached {STRING} a_arg2 then
				do_nothing
			end

				-- Should violate the rule.
			if attached a_arg1 then
				do_nothing
			end
		end

	bin_eqs (a_arg1: attached BOOLEAN; a_arg2: detachable BOOLEAN)
		do
				-- Should violate the rule.
			if a_arg1 /= Void then
				do_nothing
			end

				-- Should not violate the rule.
			if a_arg2 /= Void then
				do_nothing
			end
		end
end
