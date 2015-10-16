note
	description: "Condition for block to be displayed."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_BLOCK_EXPRESSION_CONDITION

inherit
	CMS_BLOCK_CONDITION

create
	make,
	make_none

feature {NONE} -- Initialization

	make (a_exp: READABLE_STRING_8)
		do
			expression := a_exp
		end

	make_none
		do
			make ("<none>")
		end

feature -- Access

	description: STRING_32
		do
			create Result.make_from_string_general ("Expression: %"")
			Result.append_string_general (expression)
			Result.append_character ('%"')
		end

	expression: STRING

feature -- Evaluation

	satisfied_for_response (res: CMS_RESPONSE): BOOLEAN
		local
			exp: like expression
			l_path: READABLE_STRING_8
			kmp: KMP_WILD
		do
			exp := expression
			if exp.same_string ("is_front") then
				Result := res.is_front
			elseif exp.same_string ("*") then
				Result := True
			elseif exp.same_string ("<none>") then
				Result := False
			elseif exp.starts_with ("path:") then
				l_path := exp.substring (6, exp.count)
				if l_path.has ('*') then
					if l_path.index_of ('*', 1) = l_path.count then
						Result := res.location.starts_with_general (l_path.substring (1, l_path.count - 1))
					else
						create kmp.make (l_path, res.location)
						Result := kmp.pattern_matches
					end
				else
					Result := res.location.same_string (l_path)
				end
			end
		end

note
	copyright: "2011-2015, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
