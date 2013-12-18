note
	description: "Summary description for {CRITERIA_WITH_NAME}."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CRITERIA_WITH_NAME [G]

inherit
	CRITERIA [G]

feature -- Access

	criteria_name: IMMUTABLE_STRING_32
			-- Associated criteria name.

	criteria_value: READABLE_STRING_32
			-- Associated criteria value.
		deferred
		end

feature -- Element change

	set_criteria_name (n: READABLE_STRING_GENERAL)
			-- Set associated `criteria_name'
		do
			create criteria_name.make_from_string_general (n)
		ensure
			n.same_string (criteria_name)
		end

feature -- Visitor

	accept (a_visitor: CRITERIA_VISITOR [G])
			-- `accept' visitor `a_visitor'.
			-- See Visitor pattern
		do
			a_visitor.visit_named_criteria (Current)
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
