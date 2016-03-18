note
	description: "Summary description for {CRITERIA_NULL_VISITOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CRITERIA_NULL_VISITOR [G]

inherit
	CRITERIA_VISITOR [G]

feature -- Visitor

	visit (obj: CRITERIA [G])
		do
		end

	visit_and (obj: CRITERIA_AND [G])
		do
		end

	visit_or (obj: CRITERIA_OR [G])
		do
		end

	visit_not (obj: CRITERIA_NOT [G])
		do
		end

	visit_manifest_value (obj: CRITERIA_MANIFEST_VALUE [G])
		do
		end

	visit_named_criteria (obj: CRITERIA_WITH_NAME [G])
		do
		end

	visit_agent (obj: CRITERIA_AGENT [G])
		do
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
