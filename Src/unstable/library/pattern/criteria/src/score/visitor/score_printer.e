note
	description: "Summary description for {SCORE_PRINTER}."
	date: "$Date$"
	revision: "$Revision$"

class
	SCORE_PRINTER [G]

inherit
	SCORE_VISITOR [G]

create
	make_default,
	make

feature {NONE} -- Initialization

	make (a_output: STRING_32)
		do
			output := a_output
		end

	make_default
		do
			make (create {STRING_32}.make_empty)
		end

feature -- Access

	output: STRING_32

	text (a_criteria: SCORER_CRITERIA [G]): STRING_32
		local
			o: like output
		do
			o := output
			make_default
			visit (a_criteria)
			Result := output
			output := o
		end

feature -- Reset

	reset
			-- Reset Current printer
		do
			make_default
		end

feature -- Visitor

	visit (obj: SCORER_CRITERIA [G])
		do
			obj.accept (Current)
		end

	visit_and (obj: SCORER_CRITERIA_AND [G])
		do
			obj.left.accept (Current)
			output.append_string_general (" and ")
			obj.right.accept (Current)
		end

	visit_or (obj: SCORER_CRITERIA_OR [G])
		do
			output.append_character ('(')
			obj.left.accept (Current)
			output.append_string_general (" or ")
			obj.right.accept (Current)
			output.append_character (')')
		end

	visit_not (obj: SCORER_CRITERIA_NOT [G])
		do
			output.append_string_general ("not ")
			obj.criteria.accept (Current)
		end

	visit_manifest_value (obj: SCORER_CRITERIA_MANIFEST_VALUE [G])
		local
			s: STRING_32
		do
			if attached obj.name as n and attached obj.value as v then
				s := name_value_string (n,v)
				if obj.is_not then
					s.prepend_character ('-')
				end
			else
				if obj.is_not then
					s := {STRING_32} "False"
				else
					s := {STRING_32} "True"
				end
			end
			output.append_string (s)
		end

	visit_named_criteria (obj: SCORER_CRITERIA_WITH_NAME [G])
		do
			output.append (name_value_string (obj.criteria_name, obj.criteria_value))
		end

	visit_agent (obj: SCORER_CRITERIA_AGENT [G])
		do
			output.append_string (obj.string)
		end

feature {NONE} -- Helper

	name_value_string (n,v: READABLE_STRING_GENERAL): STRING_32
		do
			create Result.make (n.count + 1 + v.count + 2)
			Result.append_string_general (n)
			Result.append_character (':')
			if v.has (' ') or else v.has ('%T') then
				Result.append_character ('%"')
				Result.append_string_general (v)
				Result.append_character ('%"')
			else
				Result.append_string_general (v)
			end
		end

note
	copyright: "Copyright (c) 1984-2013, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
