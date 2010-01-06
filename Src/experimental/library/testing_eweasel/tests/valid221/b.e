class
	B [G]

feature -- Basic operations

	frozen negation (predicate: FUNCTION [ANY, TUPLE [G], BOOLEAN]): PREDICATE --[ANY, TUPLE [G]]
			--
		require
			predicate /= Void
		do
			Result := agent (v: G; p: FUNCTION [ANY, TUPLE [G], BOOLEAN]): BOOLEAN
				do
				end (?, predicate)
		end
end
