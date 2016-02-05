note
	ca_only: "CA037"

class
	CAT_UNDESIRABLE_COMMENT_CONTENT

feature {NONE} -- Test

	-- Violates the default set of words of the undesirable comment content rule.
	undesirable_comments (a1: BOOLEAN; a2, a3: INTEGER)
		local
			a: INTEGER
		do
			-- fix this shit!
			if a1 then
				-- a1 is Fucking true
				a := a2
			end
		end

	-- what the fuCk is this for?
	b: INTEGER

end
