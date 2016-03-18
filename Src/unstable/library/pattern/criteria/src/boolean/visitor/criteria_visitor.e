note
	description: "Summary description for {CRITERIA_VISITOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CRITERIA_VISITOR [G]

feature -- Visitor

	visit (obj: CRITERIA [G])
		deferred
		end

	visit_and (obj: CRITERIA_AND [G])
		deferred
		end

	visit_or (obj: CRITERIA_OR [G])
		deferred
		end

	visit_not (obj: CRITERIA_NOT [G])
		deferred
		end

	visit_manifest_value (obj: CRITERIA_MANIFEST_VALUE [G])
		deferred
		end

	visit_named_criteria (obj: CRITERIA_WITH_NAME [G])
		deferred
		end

	visit_agent (obj: CRITERIA_AGENT [G])
		deferred
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
