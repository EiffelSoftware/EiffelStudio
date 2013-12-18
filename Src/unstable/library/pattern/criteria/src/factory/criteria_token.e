note
	description: "Summary description for {CRITERIA_TOKEN}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CRITERIA_TOKEN

inherit
	DEBUG_OUTPUT

create
	make_operator,
	make_silent_and_operator,
	make_embedded,
	make_name_value,
	make_group

feature {NONE} -- Initialization

	make_group (a_left: detachable CRITERIA_TOKEN; a_op: CRITERIA_TOKEN; a_right: CRITERIA_TOKEN)
		do
			name := silent_group_name
			set_group ([a_left, a_op, a_right])
		end

	make_embedded (v: READABLE_STRING_GENERAL)
		do
			make_name_value (silent_embedded_name, v)
		end

	make_silent_and_operator
		do
			make_operator (silent_and_operator)
		end

	make_operator (n: READABLE_STRING_GENERAL)
		do
			create name.make_from_string_general (n)
		end

	make_name_value (n: READABLE_STRING_GENERAL; v: READABLE_STRING_GENERAL)
		do
			create name.make_from_string_general (n)
			create value.make_from_string_general (v)
		end

feature -- Access

	name: IMMUTABLE_STRING_32
	value: detachable IMMUTABLE_STRING_32

	group: detachable TUPLE [left: detachable CRITERIA_TOKEN; op: CRITERIA_TOKEN; right: CRITERIA_TOKEN]

feature -- Element change

	set_group (g: like group)
		do
			group := g
		end

feature -- Status report

	is_group: BOOLEAN
		do
			Result := group /= Void
		end

	is_incomplete_group: BOOLEAN
		do
			Result := attached group as g and then g.right = Void
		end

	is_embedded: BOOLEAN
		do
			Result := name.same_string (silent_embedded_name)
		end

	is_single: BOOLEAN
		do
			Result := value = Void and group = Void
		end

	is_known_operator: BOOLEAN
		do
			Result := is_single and is_binary_operator or is_operator_not
		end

	is_binary_operator: BOOLEAN
		do
			Result := is_operator_and or is_operator_or
		end

	is_operator_and: BOOLEAN
		do
			Result := is_single and (name.is_case_insensitive_equal_general ("and") or else name.same_string (silent_and_operator))
		ensure
			Result implies is_binary_operator
		end

	is_operator_or: BOOLEAN
		do
			Result := is_single and (name.is_case_insensitive_equal_general ("or"))
		ensure
			Result implies is_binary_operator
		end

	is_operator_not: BOOLEAN
		do
			Result := is_single and (name.is_case_insensitive_equal_general ("not"))
		end

feature {NONE} -- Implementation

	silent_and_operator: STRING_32 = " "
	silent_embedded_name: STRING_32 = "()"
	silent_group_name: IMMUTABLE_STRING_32
		once
			create Result.make_from_string_general ({STRING_32} "{group}")
		end

feature -- Status report

	debug_output: STRING_32
			-- String that should be displayed in debugger to represent `Current'.
		do
			create Result.make_empty
			Result.append (name)
		end

invariant
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
