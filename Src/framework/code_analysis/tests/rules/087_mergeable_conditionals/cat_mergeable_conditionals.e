note
	ca_only: "CA087"

class
	CAT_MERGEABLE_CONDITIONALS

feature {NONE} -- Test

	conditionals
		local
			l_b1, l_b2, l_b3: BOOLEAN
		do
				-- Should violate the rule.
			if l_b1 and l_b2 or else l_b3 then
				do_nothing
			end
			if l_b1 and l_b2 or else l_b3 then
					-- Should violate the rule.
				if l_b1 then
					do_nothing
				end
				if l_b1 then
					do_nothing
				end
			end

				-- Should not violate the rule.
			if not l_b3 and l_b2 then
			else
					-- Should violate the rule.
				if l_b1 then
					do_nothing
				end
				if l_b1 then
					do_nothing
				end
			end
			do_nothing
			if not l_b3 and l_b2 then
				do_nothing
			end

				-- Should not violate the rule.
			if l_b1 then
				l_b2 := False
			else
				l_b3 := True
				l_b1 := False
			end
			if l_b1 then
				l_b3 := False
			end

				-- Should not violate the rule.
			if b4 then
				do_nothing
			end
			if b4 then
				do_nothing
			end
		end

	b4: BOOLEAN

end
